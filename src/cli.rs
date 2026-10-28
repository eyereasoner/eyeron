//! Command-line behavior shared by the native executable and the playground.

use crate::error::{EyeronError, Result};
use crate::printing::{document_debug, rdf_result_to_string, result_to_string};
use crate::proof_writer::proof_to_n3;
use crate::reasoner::{reason, PreparedReasoner, ReasonerOptions};
use crate::{Document, RdfFormat, fuse_report, is_rdf_message_log, parse_n3, parse_n3_with_source, parse_rdf12, parse_rdf_message_log};
use std::collections::BTreeMap;
use std::fmt::Write as _;
use std::io::BufRead;
use std::path::Path;

const VERSION: &str = env!("CARGO_PKG_VERSION");

#[derive(Debug, Default)]
pub struct CliOptions {
    pub help: bool,
    pub version: bool,
    pub ast: bool,
    pub proof: bool,
    pub prove_and_check: bool,
    pub rdf: bool,
    pub stream: bool,
    pub stream_messages: bool,
    pub base_iri: Option<String>,
    pub max_backward_depth: Option<usize>,
    pub files: Vec<String>,
    /// `--check-proof FILE`: check that proof document against the program
    /// given as the positional arguments (`SPEC.md` Section 9).
    pub check_proof: Option<String>,
}


/// One already-read positional input. Its base comes from the native path or
/// fetched URL; an explicit --base-iri takes precedence in either interface.
#[derive(Debug, Clone)]
pub struct Source {
    pub name: String,
    pub text: String,
    pub base_iri: Option<String>,
}

impl Source {
    pub fn label(&self) -> &str {
        if self.name == "-" { "<stdin>" } else { &self.name }
    }
}

pub const STREAM_WARNING: &str = "warning: --stream is accepted; Eyeron currently emits after the fixpoint is reached";

/// Browser inputs have already been read by file upload or fetch. Resolve the
/// positional arguments against those inputs, then use the native CLI runner.
pub fn run_browser_request(request: &str, emit: &mut dyn FnMut(&str) -> Result<()>) -> serde_json::Value {
    let mut stderr = String::new();
    let result = (|| -> Result<i32> {
        let request: serde_json::Value = serde_json::from_str(request)
            .map_err(|err| EyeronError::new(format!("invalid playground request: {err}")))?;
        let args = request["args"].as_array()
            .ok_or_else(|| EyeronError::new("missing command-line arguments"))?
            .iter().map(|arg| arg.as_str().map(str::to_string)
                .ok_or_else(|| EyeronError::new("command-line arguments must be strings")))
            .collect::<Result<Vec<_>>>()?;
        if args.is_empty() {
            emit(&help())?;
            return Ok(0);
        }
        let opt = parse_args(args, &mut |warning| { writeln!(stderr, "{warning}").unwrap(); })?;
        if opt.help {
            emit(&help())?;
            return Ok(0);
        }
        if opt.version {
            emit(&format!("{VERSION}\n"))?;
            return Ok(0);
        }
        validate_options(&opt)?;
        if opt.stream { writeln!(stderr, "{STREAM_WARNING}").unwrap(); }
        if opt.stream_messages { validate_stream_options(&opt)?; }

        let supplied = request["sources"].as_array()
            .ok_or_else(|| EyeronError::new("missing source inputs"))?;
        let names = if opt.files.is_empty() { vec!["-".to_string()] } else { opt.files.clone() };
        let sources = names.iter().map(|name| {
            let source = supplied.iter().find(|source| source["name"].as_str() == Some(name))
                .ok_or_else(|| EyeronError::new(format!("input not loaded: {name}")))?;
            let text = source["text"].as_str()
                .ok_or_else(|| EyeronError::new(format!("missing input text: {name}")))?;
            Ok(Source {
                name: name.clone(), text: text.to_string(),
                base_iri: source["baseIri"].as_str().map(str::to_string),
            })
        }).collect::<Result<Vec<_>>>()?;

        if opt.stream_messages {
            let mut program = Document::new();
            let mut logs = Vec::new();
            for source in &sources {
                if source.name.starts_with("http://") || source.name.starts_with("https://") || is_rdf_message_log(&source.text) {
                    logs.push(source);
                } else {
                    let parsed = parse_n3_with_source(&source.text, opt.base_iri.as_deref(), Some(&source.name))
                        .map_err(|err| EyeronError::new(err.with_source_location(&source.text, &source.name)))?;
                    program.merge(parsed);
                }
            }
            if logs.is_empty() {
                return Err(EyeronError::new("--stream-messages did not find any RDF Message Log input"));
            }
            let prepared = PreparedReasoner::new(program);
            let options = cli_reasoner_options(&opt, false);
            for source in logs {
                if source.name == "-" {
                    return Err(EyeronError::new("stdin RDF Message Logs cannot follow another stdin read"));
                }
                stream_message_reader(
                    source.text.as_bytes(), &source.name,
                    opt.base_iri.as_deref().or(source.base_iri.as_deref()),
                    &prepared, &options, emit,
                )?;
            }
            return Ok(0);
        }
        run_sources(&opt, &sources, |path| {
            let proof = &request["proof"];
            if proof["name"].as_str() != Some(path) {
                return Err(EyeronError::new(format!("proof not loaded: {path}")));
            }
            proof["text"].as_str().map(str::to_string)
                .ok_or_else(|| EyeronError::new(format!("missing proof text: {path}")))
        }, emit)
    })();
    let exit_code = match result {
        Ok(code) => code,
        Err(err) => {
            writeln!(stderr, "eyeron: {err}").unwrap();
            1
        }
    };
    serde_json::json!({ "ok": exit_code == 0, "exitCode": exit_code, "stderr": stderr })
}

/// Run the same parsed inputs and modes in native and browser front ends.
/// The output callback also preserves partial reports when a check fails.
pub fn run_sources(
    opt: &CliOptions,
    sources: &[Source],
    load_proof: impl FnOnce(&str) -> Result<String>,
    emit: &mut dyn FnMut(&str) -> Result<()>,
) -> Result<i32> {
    let capture_proof = opt.proof || opt.prove_and_check || opt.check_proof.is_some();
    let merged = parse_sources(opt, sources, capture_proof)?;
    if let Some(path) = &opt.check_proof {
        let proof = load_proof(path)?;
        let report = crate::proof_check_n3::check_proof_document(&merged, &proof)
            .map_err(|err| EyeronError::new(err.with_source_location(&proof, path)))?;
        emit(&proof_check_report(path, sources, &report))?;
        if !report.valid() {
            return Err(EyeronError::new(format!("{} is not a valid proof for the given program", path)));
        }
        return Ok(0);
    }
    if opt.ast {
        emit(&document_debug(&merged))?;
        return Ok(0);
    }
    let result = reason(&merged, &cli_reasoner_options(opt, capture_proof));
    if let Some(fuse) = &result.fuse {
        emit(&fuse_report(&merged.prefixes, fuse))?;
        return Ok(65);
    }
    if let Some(summary) = result.incomplete_summary() {
        return Err(EyeronError::new(summary));
    }
    if opt.prove_and_check {
        let proof = proof_to_n3(&merged.prefixes, &result);
        let report = crate::proof_check_n3::check_proof_document(&merged, &proof)?;
        emit(&proof_check_report("<generated>", sources, &report))?;
        if !report.valid() {
            return Err(EyeronError::new("<generated> is not a valid proof for the given program"));
        }
    } else if opt.proof {
        emit(&proof_to_n3(&merged.prefixes, &result))?;
    } else if opt.rdf {
        emit(&rdf_result_to_string(&merged.prefixes, &result.derived))?;
    } else {
        emit(&result_to_string(&merged.prefixes, &result.derived))?;
    }
    Ok(0)
}

pub fn validate_options(opt: &CliOptions) -> Result<()> {
    if opt.prove_and_check && (opt.ast || opt.proof || opt.check_proof.is_some() || opt.stream_messages) {
        return Err(EyeronError::new(
            "--prove-and-check cannot be combined with --ast, --proof, --check-proof, or --stream-messages",
        ));
    }

    if opt.check_proof.is_some() && (opt.ast || opt.proof || opt.stream_messages) {
        return Err(EyeronError::new("--check-proof cannot be combined with --ast, --proof, or --stream-messages"));
    }
    if opt.check_proof.as_deref() == Some("-") && (opt.files.is_empty() || opt.files.iter().any(|file| file == "-")) {
        return Err(EyeronError::new("stdin cannot supply both the source program and the proof"));
    }
    Ok(())
}

pub fn validate_stream_options(opt: &CliOptions) -> Result<()> {
    if !opt.rdf {
        return Err(EyeronError::new("--stream-messages requires -r/--rdf"));
    }
    if opt.ast || opt.proof || opt.stream {
        return Err(EyeronError::new(
            "--stream-messages cannot be combined with --ast, --proof, or --stream",
        ));
    }

    Ok(())
}

pub fn parse_sources(opt: &CliOptions, sources: &[Source], capture_proof: bool) -> Result<Document> {
    let mut merged = Document::new();
    for source in sources {
        let label = source.label();
        let text = source.text.as_str();
        let base = opt.base_iri.as_deref().or(source.base_iri.as_deref());
        let parsed = if is_rdf_message_log(text) {
            parse_rdf_message_log(text, base)
        } else if let Some(format) = rdf_format_for_source(label, opt.rdf)? {
            parse_rdf12(text, base, format)
        } else if capture_proof {
            parse_n3_with_source(text, base, Some(label))
        } else {
            parse_n3(text, base)
        };
        match parsed {
            Ok(doc) => merged.merge(doc),
            Err(err) => return Err(EyeronError::new(err.with_source_location(text, label))),
        }
    }

    Ok(merged)
}

pub fn parse_args(args: Vec<String>, warning: &mut dyn FnMut(&str)) -> Result<CliOptions> {
    let mut opt = CliOptions::default();
    let mut i = 0usize;
    while i < args.len() {
        match args[i].as_str() {
            "-h" | "--help" => {
                opt.help = true;
                return Ok(opt);
            }
            "-v" | "--version" => {
                opt.version = true;
                return Ok(opt);
            }
            "-a" | "--ast" => opt.ast = true,
            "-p" | "--proof" | "--proof-comments" => opt.proof = true,
            "-c" | "--prove-and-check" => opt.prove_and_check = true,
            "-r" | "--rdf" => opt.rdf = true,
            "-s" | "--stream" => opt.stream = true,
            "--max-backward-depth" => {
                let flag = args[i].clone();
                i += 1;
                if i >= args.len() {
                    return Err(EyeronError::new(format!("{} requires a value", flag)));
                }
                opt.max_backward_depth = Some(args[i].parse::<usize>().map_err(|_| {
                    EyeronError::new(format!(
                        "{} requires a non-negative integer, got {}",
                        flag, args[i]
                    ))
                })?);
            }
            "--builtin" | "--store" | "--store-path" => {
                let flag = args[i].clone();
                i += 1;
                if i >= args.len() {
                    return Err(EyeronError::new(format!("{} requires a value", flag)));
                }
                warning(&format!(
                    "warning: {} is accepted for CLI compatibility but not implemented in Eyeron",
                    flag
                ));
            }
            "--stream-messages" => opt.stream_messages = true,
            "--check-proof" => {
                let flag = args[i].clone();
                i += 1;
                if i >= args.len() {
                    return Err(EyeronError::new(format!("{} requires a value", flag)));
                }
                opt.check_proof = Some(args[i].clone());
            }
            "--base-iri" | "--base" => {
                i += 1;
                if i >= args.len() {
                    return Err(EyeronError::new(format!(
                        "{} requires a value",
                        args[i - 1]
                    )));
                }
                opt.base_iri = Some(args[i].clone());
            }
            "--store-clear" | "--enforce-https" => {
                warning(&format!(
                    "warning: {} is accepted for CLI compatibility but not implemented in Eyeron",
                    args[i]
                ));
            }
            other if other.starts_with('-') && other != "-" => {
                return Err(EyeronError::new(format!("unknown option {}", other)));
            }
            file => opt.files.push(file.to_string()),
        }
        i += 1;
    }
    Ok(opt)
}

pub fn rdf_format_for_source(label: &str, rdf_mode: bool) -> Result<Option<RdfFormat>> {
    if label == "<stdin>" {
        return Ok(if rdf_mode {
            Some(RdfFormat::Turtle)
        } else {
            None
        });
    }

    let source_path = label.split(['?', '#']).next().unwrap_or(label);
    let extension = Path::new(source_path)
        .extension()
        .and_then(|ext| ext.to_str())
        .map(str::to_ascii_lowercase);
    let format = extension.as_deref().and_then(RdfFormat::parse);

    match (format, extension.as_deref(), rdf_mode) {
        (Some(format), _, _) => Ok(Some(format)),
        (None, Some("n3"), _) => Ok(None),
        (None, _, true) => Err(EyeronError::new(format!(
            "cannot infer RDF format for {}; use .ttl, .nt, .nq, .trig, or .n3",
            label
        ))),
        (None, _, false) => Ok(None),
    }
}

pub fn cli_reasoner_options(opt: &CliOptions, proof: bool) -> ReasonerOptions {
    let mut options = ReasonerOptions {
        proof,
        ..ReasonerOptions::default()
    };
    if let Some(max_backward_depth) = opt.max_backward_depth {
        options.max_backward_depth = max_backward_depth;
    }
    options
}

pub fn stream_message_reader<R: BufRead>(
    mut reader: R,
    label: &str,
    base: Option<&str>,
    prepared: &PreparedReasoner,
    reasoner_options: &ReasonerOptions,
    emit: &mut dyn FnMut(&str) -> Result<()>,
) -> Result<()> {
    let mut directives = String::new();
    let mut message = String::new();
    let mut line = String::new();
    let mut saw_version = false;
    let mut saw_delimiter = false;
    let mut message_index = 1usize;

    loop {
        line.clear();
        let bytes = reader.read_line(&mut line).map_err(|err| {
            EyeronError::new(format!("failed to read response from {label}: {err}"))
        })?;
        if bytes == 0 {
            break;
        }
        let trimmed = line.trim();
        let lower = trimmed.to_ascii_lowercase();
        if (lower.starts_with("version ") || lower.starts_with("@version "))
            && lower.contains("-messages")
        {
            saw_version = true;
        } else if trimmed.eq_ignore_ascii_case("MESSAGE")
            || trimmed.eq_ignore_ascii_case("@message .")
        {
            run_one_message(
                prepared,
                &directives,
                &message,
                (label, message_index),
                base,
                reasoner_options,
                emit,
            )?;
            message.clear();
            message_index += 1;
            saw_delimiter = true;
        } else if trimmed.starts_with("PREFIX ")
            || trimmed.starts_with("prefix ")
            || trimmed.starts_with("BASE ")
            || trimmed.starts_with("base ")
        {
            if !directives.contains(&line) {
                directives.push_str(&line);
            }
        } else {
            message.push_str(&line);
        }
    }
    if !saw_version {
        return Err(EyeronError::new(format!(
            "not an RDF Message Log: missing VERSION \"*-messages\" directive in {label}"
        )));
    }
    if saw_delimiter || !message.trim().is_empty() {
        run_one_message(
            prepared,
            &directives,
            &message,
            (label, message_index),
            base,
            reasoner_options,
            emit,
        )?;
    }
    Ok(())
}

fn run_one_message(
    prepared: &PreparedReasoner,
    directives: &str,
    message: &str,
    source: (&str, usize),
    base: Option<&str>,
    reasoner_options: &ReasonerOptions,
    emit: &mut dyn FnMut(&str) -> Result<()>,
) -> Result<()> {
    let (label, index) = source;
    let replay = format!("{directives}\nVERSION \"1.2-messages\"\n{message}");
    let message_label = format!("{label}#message-{index}");
    let parsed = parse_rdf_message_log(&replay, base)
        .map_err(|err| EyeronError::new(err.with_source_location(&replay, &message_label)))?;
    let result = prepared.reason(&parsed, reasoner_options);
    if let Some(fuse) = &result.fuse {
        return Err(EyeronError::new(fuse_report(&BTreeMap::new(), fuse)));
    }
    if let Some(summary) = result.incomplete_summary() {
        return Err(EyeronError::new(summary));
    }
    emit(&rdf_result_to_string(&BTreeMap::new(), &result.derived))?;
    Ok(())
}

pub fn proof_check_report(path: &str, sources: &[Source], report: &crate::proof_check::Report) -> String {
    let mut out = String::new();
    writeln!(out, "Proof: {}", path).unwrap();
    writeln!(out, "Source program: {}", sources.iter().map(Source::label).collect::<Vec<_>>().join(", ")).unwrap();
    writeln!(out, "{}", report.verdict()).unwrap();
    if !report.counts.is_empty() {
        writeln!(out, "Step kinds:").unwrap();
    }
    for (kind, count) in &report.counts {
        let description = match *kind {
            "rule" => "rule applications",
            "fact" => "source facts",
            "builtin" => "built-ins",
            "absent" => "absence checks",
            "collected" => "collections",
            "unproven" => "unproven steps",
            other => other,
        };
        writeln!(out, "  {}: {}", description, count).unwrap();
    }
    writeln!(out, "Conditions:").unwrap();
    for (id, name, checked, failed) in report.conditions() {
        writeln!(out, "  {} {}: {} checked, {} failed", id, name, checked, failed).unwrap();
    }
    if !report.obligations.is_empty() {
        writeln!(out, "Trust obligations (accepted without verifying their truth):").unwrap();
    }
    for obligation in &report.obligations {
        writeln!(out, "  {}:", obligation.kind).unwrap();
        for line in obligation.conclusion.lines() {
            writeln!(out, "    {}", line).unwrap();
        }
    }
    if !report.failures.is_empty() {
        writeln!(out, "Failures:").unwrap();
    }
    for failure in &report.failures {
        let name = crate::proof_check::CONDITIONS.iter().find(|(id, _)| *id == failure.condition).map_or("", |(_, name)| name);
        writeln!(out, "  [{}: {}]", failure.condition, name).unwrap();
        for line in failure.conclusion.lines() {
            writeln!(out, "    {}", line).unwrap();
        }
        writeln!(out, "    {}", failure.detail).unwrap();
    }
    out
}

pub fn help() -> String {
    let mut out = String::new();
    writeln!(out, "eyeron {}", VERSION).unwrap();
    writeln!(out).unwrap();
    writeln!(out, "Usage: eyeron [options] [file-or-url|- ...]").unwrap();
    writeln!(out).unwrap();
    writeln!(out, "Options:").unwrap();
    writeln!(out, "  -a, --ast                     Print parsed AST/debug form and exit").unwrap();
    writeln!(out, "  -p, --proof                   Enable N3 proof explanations").unwrap();
    writeln!(out, "  -c, --prove-and-check         Generate a proof and check it against the input program").unwrap();
    writeln!(out, "  -r, --rdf                     Enable RDF/TriG input/output compatibility").unwrap();
    writeln!(out, "  -s, --stream                  Output is emitted after fixpoint").unwrap();
    writeln!(out,
        "      --stream-messages         RDF Message Log input with VERSION/MESSAGE delimiters"
    ).unwrap();
    writeln!(out,
        "      --base-iri IRI            Base IRI used by parser modes that resolve relative IRIs"
    ).unwrap();
    writeln!(out,
        "      --max-backward-depth N    Maximum recursive backward-rule depth (default: {})",
        ReasonerOptions::default().max_backward_depth
    ).unwrap();
    writeln!(out, "      --check-proof FILE        Check that proof document against the program").unwrap();
    writeln!(out, "  -v, --version                 Print version").unwrap();
    writeln!(out, "  -h, --help                    Show this help").unwrap();
    out
}
