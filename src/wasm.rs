use wasm_bindgen::prelude::*;

use crate::error::{EyeronError, Result};
use crate::n3::parser::{is_rdf_message_log, parse_n3, parse_n3_with_source, parse_rdf_message_log};
use crate::n3::printing::{rdf_result_to_string, result_to_string, term_to_n3_object};
use crate::n3::proof::proof_to_n3;
use crate::n3::rdf_compat::{parse_rdf12, RdfFormat};
use crate::n3::reasoner::{
    reason as reason_document, PreparedReasoner, ReasonerError, ReasonerOptions, ReasonerResult,
};

#[wasm_bindgen(js_name = version)]
pub fn version() -> String {
    env!("CARGO_PKG_VERSION").to_string()
}

#[wasm_bindgen(js_name = reasonWithOptions)]
pub fn reason_with_options(input: &str, proof: bool, rdf: bool, rdf_format: &str) -> std::result::Result<String, JsValue> {
    run(input, "", proof, rdf, rdf_format).map_err(|err| JsValue::from_str(&err.to_string()))
}

#[wasm_bindgen(js_name = reason)]
pub fn reason(input: &str) -> std::result::Result<String, JsValue> {
    run(input, "", false, false, "n3").map_err(|err| JsValue::from_str(&err.to_string()))
}

#[wasm_bindgen(js_name = reasonWithData)]
pub fn reason_with_data(program: &str, data: &str, proof: bool, rdf: bool, rdf_format: &str) -> std::result::Result<String, JsValue> {
    run(program, data, proof, rdf, rdf_format).map_err(|err| JsValue::from_str(&err.to_string()))
}

#[wasm_bindgen(js_name = reasonWithDataReport)]
pub fn reason_with_data_report(program: &str, data: &str, proof: bool, rdf: bool, rdf_format: &str) -> String {
    match run_report(program, data, proof, rdf, rdf_format) {
        Ok(output) => format!("{{\"ok\":true,\"output\":{}}}", json_string(&output)),
        Err(err) => err.to_json(),
    }
}

/// A reusable Wasm reasoner. The N3 program is parsed and its forward-rule
/// agenda is built once in the constructor; each call receives a fresh,
/// independent RDF data batch.
#[wasm_bindgen(js_name = EyeronSession)]
pub struct EyeronSession {
    prepared: PreparedReasoner,
    proof: bool,
}

#[wasm_bindgen(js_class = EyeronSession)]
impl EyeronSession {
    #[wasm_bindgen(constructor)]
    pub fn new(program: &str, proof: bool) -> std::result::Result<EyeronSession, JsValue> {
        let doc = parse_source(program, proof, false, "n3", "session-program")
            .map_err(|err| JsValue::from_str(&err.with_source_location(program, "program")))?;
        Ok(Self { prepared: PreparedReasoner::new(doc), proof })
    }

    /// Reason over a single independent data batch.
    pub fn reason(
        &self,
        data: &str,
        rdf: bool,
        rdf_format: &str,
    ) -> std::result::Result<String, JsValue> {
        self.run(data, rdf, rdf_format)
            .map(|run| run.output)
            .map_err(|err| JsValue::from_str(&err.display))
    }

    /// Like `reason`, but returns the same structured JSON error envelope as
    /// `reasonWithDataReport`, plus per-run reasoner statistics.
    #[wasm_bindgen(js_name = reasonReport)]
    pub fn reason_report(&self, data: &str, rdf: bool, rdf_format: &str) -> String {
        match self.run(data, rdf, rdf_format) {
            Ok(run) => format!(
                "{{\"ok\":true,\"output\":{},\"statistics\":{{\"iterations\":{},\"matchSteps\":{},\"explicitFacts\":{},\"derivedFacts\":{},\"rules\":{}}}}}",
                json_string(&run.output),
                run.result.statistics.iterations,
                run.result.statistics.match_steps,
                run.result.explicit.len(),
                run.result.derived.len(),
                run.result.rules.len(),
            ),
            Err(err) => err.to_json(),
        }
    }

    #[wasm_bindgen(getter, js_name = programRules)]
    pub fn program_rules(&self) -> usize {
        self.prepared.program().rules.len()
    }

    #[wasm_bindgen(getter, js_name = programFacts)]
    pub fn program_facts(&self) -> usize {
        self.prepared.program().facts.len()
    }
}

/// Run a SPARQL 1.2 RL rule set (`.srl` syntax) and return its inference
/// graph (SPARQL 1.2 RL §6.5's `GI`), or — when `query` is non-blank —
/// the bindings for that query body pattern matched against the completed
/// closure (forward query mode; there is no browser-side backward mode
/// yet).
#[wasm_bindgen(js_name = reasonSrl)]
pub fn reason_srl(input: &str, query: &str) -> std::result::Result<String, JsValue> {
    run_srl(input, query).map_err(|err| JsValue::from_str(&err))
}

/// `input`'s own `IMPORTS <iri>` targets, resolved against `base` (an
/// absolute URL the playground can `fetch()` each one from directly, e.g.
/// the page's own URL for the example being loaded) — lets the playground
/// discover what a rule set like `import-main.srl` needs before running
/// it, the same CLI capability `resolve_sparql_rl_imports` (`main.rs`)
/// otherwise has no browser-side counterpart for (`ureq`/`fs` are not
/// available in Wasm). Returns an empty list on a parse error rather than
/// surfacing it here; the real parse error resurfaces from
/// `reasonSrlWithImports` once the caller actually runs the program.
#[wasm_bindgen(js_name = srlImportTargets)]
pub fn srl_import_targets(input: &str, base: &str) -> Vec<JsValue> {
    let base = if base.is_empty() { None } else { Some(base) };
    match crate::srl::parse_sparql_rl(input, base) {
        Ok(program) => program.imports.into_iter().map(|iri| JsValue::from_str(&iri)).collect(),
        Err(_) => Vec::new(),
    }
}

/// As `reasonSrl`, but also merges in `imported_source` (the playground's
/// own concatenation of every `IMPORTS` target's fetched text — see
/// `srlImportTargets`), loads `data` as a `--data` base graph (content-
/// sniffed exactly like a `.n3`/RDF-message-log input, so `rdf-messages.srl`
/// can load `rdf-messages.trig` as-is), and — when `proof` is set — returns
/// proof output instead of the inference graph, matching `--proof`'s CLI
/// behavior. `imported_source`/`data` are the empty string when an example
/// needs neither, so the playground can call this unconditionally instead
/// of choosing between it and `reasonSrl`.
#[wasm_bindgen(js_name = reasonSrlWithImports)]
pub fn reason_srl_with_imports(main_source: &str, imported_source: &str, data: &str, proof: bool, query: &str) -> std::result::Result<String, JsValue> {
    run_srl_with_imports(main_source, imported_source, data, proof, query).map_err(|err| JsValue::from_str(&err))
}

fn run_srl_with_imports(main_source: &str, imported_source: &str, data: &str, proof: bool, query: &str) -> std::result::Result<String, String> {
    let mut program = if proof {
        crate::srl::parse_sparql_rl_with_source(main_source, None, Some("program"))
    } else {
        crate::srl::parse_sparql_rl(main_source, None)
    }
    .map_err(|err| err.with_source_location(main_source, "program"))?;
    if !imported_source.trim().is_empty() {
        let imported = if proof {
            crate::srl::parse_sparql_rl_with_source(imported_source, None, Some("import"))
        } else {
            crate::srl::parse_sparql_rl(imported_source, None)
        }
        .map_err(|err| err.with_source_location(imported_source, "import"))?;
        crate::srl::merge_programs(&mut program, imported);
    }
    let base_graph: Vec<crate::ast::Triple> = if data.trim().is_empty() {
        Vec::new()
    } else {
        parse_source(data, false, true, "auto", "data").map_err(|err| err.with_source_location(data, "data"))?.facts
    };
    let options = ReasonerOptions { proof, ..ReasonerOptions::default() };
    let result = crate::srl::reason(&program, &base_graph, &options).map_err(|err| err.to_string())?;
    if let Some(summary) = result.incomplete_summary() {
        return Err(summary);
    }
    if proof {
        return Ok(crate::srl::proof_to_srl(&program.prefixes, &result));
    }
    let trimmed_query = query.trim();
    if trimmed_query.is_empty() {
        // §6.5's result is the inference graph GI, i.e. `closure`.
        return Ok(crate::srl::result_to_srl(&program.prefixes, &result.closure));
    }
    let (query_body, _) =
        crate::srl::parse_query_body(trimmed_query, None, &program.prefixes).map_err(|err| err.with_source_location(trimmed_query, "query"))?;
    let solutions = crate::srl::query_facts(&result.closure, &base_graph, &query_body);
    Ok(format_sparql_rl_solutions(&program.prefixes, &solutions))
}

fn run_srl(input: &str, query: &str) -> std::result::Result<String, String> {
    let program = crate::srl::parse_sparql_rl(input, None).map_err(|err| err.with_source_location(input, "program"))?;
    let base_graph: Vec<crate::ast::Triple> = Vec::new();
    let options = ReasonerOptions::default();
    let result = crate::srl::reason(&program, &base_graph, &options).map_err(|err| err.to_string())?;
    if let Some(summary) = result.incomplete_summary() {
        return Err(summary);
    }
    let trimmed_query = query.trim();
    if trimmed_query.is_empty() {
        // §6.5's result is the inference graph GI, i.e. `closure`.
        return Ok(crate::srl::result_to_srl(&program.prefixes, &result.closure));
    }
    let (query_body, _) =
        crate::srl::parse_query_body(trimmed_query, None, &program.prefixes).map_err(|err| err.with_source_location(trimmed_query, "query"))?;
    let solutions = crate::srl::query_facts(&result.closure, &base_graph, &query_body);
    Ok(format_sparql_rl_solutions(&program.prefixes, &solutions))
}

fn format_sparql_rl_solutions(prefixes: &std::collections::BTreeMap<String, String>, solutions: &[crate::n3::reasoner::Bindings]) -> String {
    if solutions.is_empty() {
        return "(no solutions)\n".to_string();
    }
    let mut out = String::new();
    for (i, solution) in solutions.iter().enumerate() {
        if i > 0 {
            out.push('\n');
        }
        for (var, value) in solution {
            out.push_str(&format!("?{} {}\n", var, term_to_n3_object(value, prefixes)));
        }
    }
    out
}

/// Run a Prolog (`.pl`) program and return its result document
/// output — or a JSON rendering when `json` is set. `query`, when
/// non-blank, is appended as an extra `?-` directive before running
/// (matching the `--query` CLI flag).
#[wasm_bindgen(js_name = reasonProlog)]
pub fn reason_prolog(input: &str, proof: bool, json: bool, query: &str) -> std::result::Result<String, JsValue> {
    run_prolog(input, proof, json, query).map_err(|err| JsValue::from_str(&err))
}

fn run_prolog(input: &str, proof: bool, json: bool, query: &str) -> std::result::Result<String, String> {
    let mut source = input.to_string();
    let trimmed_query = query.trim();
    if !trimmed_query.is_empty() {
        source.push_str(&format!("\n?- {}.\n", trimmed_query.trim_end_matches('.')));
    }
    let result = crate::prolog::run(&source, crate::prolog::Limits::default()).map_err(|err| err.with_source_location(&source, "program"))?;
    if json {
        Ok(crate::prolog::output::run_result_json(&result))
    } else {
        Ok(crate::prolog::output::format_result(&result, proof))
    }
}

struct SessionRun {
    output: String,
    result: ReasonerResult,
}

impl EyeronSession {
    fn run(
        &self,
        data: &str,
        rdf: bool,
        rdf_format: &str,
    ) -> std::result::Result<SessionRun, PlaygroundError> {
        let data_doc = if data.trim().is_empty() {
            crate::Document::new()
        } else {
            parse_source(data, false, rdf, rdf_format, "session-data")
                .map_err(|err| PlaygroundError::from_error(err, data, "data", "session-data"))?
        };
        let mut prefixes = data_doc.prefixes.clone();
        prefixes.extend(self.prepared.program().prefixes.clone());
        let result = self.prepared.reason(
            &data_doc,
            &ReasonerOptions { proof: self.proof, ..ReasonerOptions::default() },
        );
        if !result.is_complete() {
            return Err(PlaygroundError::from_reasoner(&result));
        }
        let output = if self.proof {
            proof_to_n3(&prefixes, &result)
        } else if rdf {
            rdf_result_to_string(&prefixes, &result.derived)
        } else {
            result_to_string(&prefixes, &result.derived)
        };
        Ok(SessionRun { output, result })
    }
}

fn run(program: &str, data: &str, proof: bool, rdf: bool, rdf_format: &str) -> Result<String> {
    run_report(program, data, proof, rdf, rdf_format).map_err(|err| EyeronError::new(err.display))
}

fn run_report(program: &str, data: &str, proof: bool, rdf: bool, rdf_format: &str) -> std::result::Result<String, PlaygroundError> {
    let mut doc = crate::Document::new();
    if data.trim().is_empty() {
        let parsed = parse_source(program, proof, rdf, rdf_format, "playground")
            .map_err(|err| PlaygroundError::from_error(err, program, "program", "playground"))?;
        doc.merge(parsed);
    } else {
        let data_doc = parse_source(data, false, rdf, rdf_format, "playground-data")
            .map_err(|err| PlaygroundError::from_error(err, data, "data", "playground-data"))?;
        doc.merge(data_doc);
        let program_doc = parse_source(program, proof, false, "n3", "playground")
            .map_err(|err| PlaygroundError::from_error(err, program, "program", "playground"))?;
        doc.merge(program_doc);
    }

    let result = reason_document(&doc, &ReasonerOptions { proof, ..ReasonerOptions::default() });
    if !result.is_complete() {
        return Err(PlaygroundError::from_reasoner(&result));
    }
    if proof {
        Ok(proof_to_n3(&doc.prefixes, &result))
    } else if rdf {
        Ok(rdf_result_to_string(&doc.prefixes, &result.derived))
    } else {
        Ok(result_to_string(&doc.prefixes, &result.derived))
    }
}

#[derive(Debug)]
struct PlaygroundError {
    code: &'static str,
    display: String,
    message: String,
    editor: &'static str,
    line: Option<usize>,
    column: Option<usize>,
    details: Option<String>,
}

impl PlaygroundError {
    fn from_error(err: EyeronError, source: &str, editor: &'static str, label: &str) -> Self {
        let (line, column) = err.offset.map(|offset| line_col(source, offset)).unwrap_or((0, 0));
        Self {
            code: "parse_error",
            display: err.with_source_location(source, label),
            message: err.message,
            editor,
            line: (line > 0).then_some(line),
            column: (column > 0).then_some(column),
            details: None,
        }
    }

    fn from_reasoner(result: &ReasonerResult) -> Self {
        let message = result.incomplete_summary().unwrap_or_else(|| "reasoning incomplete".to_string());
        let limits = result
            .limits_reached
            .iter()
            .map(|limit| json_string(&limit.to_string()))
            .collect::<Vec<_>>()
            .join(",");
        let errors = result
            .errors
            .iter()
            .map(|error| match error {
                ReasonerError::UnsupportedBuiltin { builtin, detail, .. } => format!(
                    "{{\"code\":\"unsupported_builtin\",\"builtin\":{},\"detail\":{}}}",
                    json_string(builtin),
                    json_string(detail),
                ),
            })
            .collect::<Vec<_>>()
            .join(",");
        Self {
            code: "reasoning_incomplete",
            display: message.clone(),
            message,
            editor: "program",
            line: None,
            column: None,
            details: Some(format!("{{\"limitsReached\":[{}],\"errors\":[{}]}}", limits, errors)),
        }
    }

    fn to_json(&self) -> String {
        let line = self.line.map(|value| value.to_string()).unwrap_or_else(|| "null".to_string());
        let column = self.column.map(|value| value.to_string()).unwrap_or_else(|| "null".to_string());
        let details = self.details.as_deref().unwrap_or("null");
        format!(
            "{{\"ok\":false,\"error\":{{\"code\":{},\"message\":{},\"display\":{},\"editor\":{},\"line\":{},\"column\":{},\"details\":{}}}}}",
            json_string(self.code),
            json_string(&self.message),
            json_string(&self.display),
            json_string(self.editor),
            line,
            column,
            details,
        )
    }
}

fn line_col(source: &str, offset: usize) -> (usize, usize) {
    let mut line = 1usize;
    let mut col = 1usize;
    for (i, ch) in source.char_indices() {
        if i >= offset { break; }
        if ch == '\n' {
            line += 1;
            col = 1;
        } else {
            col += 1;
        }
    }
    (line, col)
}

fn json_string(value: &str) -> String {
    let mut out = String::with_capacity(value.len() + 2);
    out.push('\"');
    for ch in value.chars() {
        match ch {
            '\\' => out.push_str("\\\\"),
            '\"' => out.push_str("\\\""),
            '\n' => out.push_str("\\n"),
            '\r' => out.push_str("\\r"),
            '\t' => out.push_str("\\t"),
            ch if ch <= '\u{1f}' => out.push_str(&format!("\\u{:04x}", ch as u32)),
            ch => out.push(ch),
        }
    }
    out.push('\"');
    out
}

fn parse_source(input: &str, proof: bool, rdf: bool, rdf_format: &str, label: &str) -> Result<crate::Document> {
    if is_rdf_message_log(input) {
        parse_rdf_message_log(input, None)
    } else if rdf {
        let format = rdf_format_from_playground(rdf_format, input)?;
        parse_rdf12(input, None, format)
    } else if proof {
        parse_n3_with_source(input, None, Some(label))
    } else {
        parse_n3(input, None)
    }
}

fn rdf_format_from_playground(format: &str, input: &str) -> Result<RdfFormat> {
    match format.trim().to_ascii_lowercase().as_str() {
        "" | "auto" => Ok(guess_rdf_format(input)),
        "ttl" | "turtle" => Ok(RdfFormat::Turtle),
        "trig" => Ok(RdfFormat::Trig),
        "nt" | "n-triples" | "ntriples" => Ok(RdfFormat::NTriples),
        "nq" | "n-quads" | "nquads" => Ok(RdfFormat::NQuads),
        other => Err(EyeronError::new(format!("unknown RDF format for playground: {}", other))),
    }
}

fn guess_rdf_format(input: &str) -> RdfFormat {
    let trimmed = input.trim_start();
    if trimmed.lines().all(|line| {
        let line = line.trim();
        line.is_empty() || line.starts_with('#') || (line.starts_with('<') && line.ends_with(" .") && line.matches('<').count() >= 4)
    }) {
        return RdfFormat::NTriples;
    }

    if looks_like_trig(trimmed) {
        RdfFormat::Trig
    } else {
        RdfFormat::Turtle
    }
}

fn looks_like_trig(input: &str) -> bool {
    let mut depth = 0usize;
    let mut in_string = false;
    let mut escaped = false;
    let mut prev_non_ws: Option<char> = None;
    for ch in input.chars() {
        if in_string {
            if escaped {
                escaped = false;
            } else if ch == '\\' {
                escaped = true;
            } else if ch == '"' {
                in_string = false;
            }
            continue;
        }
        if ch == '"' {
            in_string = true;
            continue;
        }
        match ch {
            '{' if depth == 0 => {
                if !matches!(prev_non_ws, Some('=') | Some('>') | Some('<')) {
                    return true;
                }
                depth += 1;
            }
            '{' => depth += 1,
            '}' => depth = depth.saturating_sub(1),
            _ => {}
        }
        if !ch.is_whitespace() {
            prev_non_ws = Some(ch);
        }
    }
    false
}
