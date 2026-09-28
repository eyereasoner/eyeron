//! Checks every packaged `.n3` example against its goldens.
//!
//! Each example is parsed once and reasoned once, and that single run is
//! checked against both of its goldens: `examples/output/<name>.n3` (or
//! `.md`) for what it derives, and `examples/proof/<name>.n3` for how. The
//! two goldens describe one run, so running the reasoner twice to check
//! them would only be asking the same question twice; that proof collection
//! does not change what is derived is established once, by
//! `tests/regressions.rs::proof_mode_derives_exactly_what_plain_mode_derives`,
//! rather than re-established per example.
//!
//! Uses a custom harness (`harness = false`) so each example prints its own
//! line as it runs.

#[path = "support/golden_n3.rs"]
mod golden_n3;
#[path = "support/report.rs"]
mod report;

use eyeron::{fuse_report, parse_n3_with_source, proof_to_n3, reason_document, result_to_string, Document, ReasonerOptions};
use golden_n3::compare_output_golden;
use report::{green, progress_line, red};
use std::collections::BTreeMap;
use std::fs;
use std::path::{Path, PathBuf};

/// Top-level `.n3` examples with no golden to check output against, and
/// why: `alma-rdf-messages.n3` needs a remote, 9GB+ RDF Message Log its own
/// header comment says is deliberately not checked into the repo;
/// `collection.n3`'s entire derived output is `log:outputString` Markdown
/// decoration (headers and file links), which `support::stable_report_lines`
/// strips as noise before comparing a `.md` golden, leaving nothing
/// substantive a golden could check. Both are still parsed, below.
const PARSE_ONLY_EXAMPLES: &[&str] = &["alma-rdf-messages", "collection"];

/// Top-level `.n3` examples that get neither an `examples/proof/` golden
/// nor a documented reason from `PARSE_ONLY_EXAMPLES`, and why not.
///
/// Every example that derives anything has a proof golden, including
/// `deep-taxonomy-100000` and the ones whose whole printed result comes
/// from a `log:query` goal. A proof is linear in the size of the derivation
/// it explains — one walk across every claim, each step written once — so
/// none of them is left out for size. These three derive nothing at all,
/// which leaves a proof nothing to record.
const NO_PROOF_EXAMPLES: &[(&str, &str)] = &[
    ("check-unsafe", "deliberately derives nothing: its head variable is unsafe/unbound by design"),
    ("fuse", "it trips an inference fuse, so the run stops with nothing derived and nothing to prove"),
    ("liar", "it trips an inference fuse, so the run stops with nothing derived and nothing to prove"),
];

/// verifiable-decision-audit.n3 audits the proof of verifiable-decision.n3,
/// which it reads as a companion input. That copy has to be the engine's
/// current output and not a stale one, or the audit would be of a decision
/// the program no longer makes -- and would keep passing while saying
/// nothing.
fn the_audited_proof_is_the_current_one() {
    let root = manifest_dir();
    let written = read(&root.join("examples/proof/verifiable-decision.n3"));
    let audited = read(&root.join("examples/input/verifiable-decision-audit.n3"));
    assert_eq!(
        written, audited,
        "examples/input/verifiable-decision-audit.n3 is not examples/proof/verifiable-decision.n3; \
         copy the proof over it so the audit is of the decision this program makes now"
    );
}

/// One example and the goldens describing it.
struct Case {
    name: String,
    source_path: PathBuf,
    output_golden: PathBuf,
    proof_golden: Option<PathBuf>,
}

fn main() {
    let started = std::time::Instant::now();
    let cases = collect_cases();
    every_n3_example_is_accounted_for(cases.len());
    every_eligible_n3_example_has_a_proof_golden();
    the_audited_proof_is_the_current_one();

    let proof_checked = cases.iter().filter(|case| case.proof_golden.is_some()).count();
    progress_line(&format!(
        "running {} example{} ({proof_checked} with a proof golden)",
        cases.len(),
        if cases.len() == 1 { "" } else { "s" },
    ));
    for case in &cases {
        run_case(case);
    }
    every_parse_only_example_parses();

    let parse_only = PARSE_ONLY_EXAMPLES.len();
    let total = cases.len() + parse_only;
    let elapsed = started.elapsed().as_secs_f64();
    progress_line(&format!(
        "\nn3 result: {}. {total} passed; 0 failed; finished in {elapsed:.2}s ({} output goldens, {proof_checked} proof goldens, {parse_only} parse-only)",
        green("ok"),
        cases.len(),
    ));
}

/// Pairs each example that has an output golden with that golden and, when
/// one exists, its proof golden. A `.md` golden wins over a `.n3` one when
/// both are present.
fn collect_cases() -> Vec<Case> {
    let root = manifest_dir();
    let output_dir = root.join("examples/output");
    let proof_dir = root.join("examples/proof");
    let mut by_name: BTreeMap<String, PathBuf> = BTreeMap::new();

    for entry in fs::read_dir(&output_dir).expect("examples/output directory exists") {
        let path = entry.expect("read examples/output entry").path();
        let ext = path.extension().and_then(|ext| ext.to_str());
        if !matches!(ext, Some("n3") | Some("md")) {
            continue;
        }
        let name = path.file_stem().and_then(|stem| stem.to_str()).expect("utf8 example name").to_string();
        if !root.join("examples").join(format!("{name}.n3")).exists() {
            continue;
        }
        match by_name.get(&name) {
            Some(existing)
                if existing.extension().and_then(|ext| ext.to_str()) == Some("n3") && ext == Some("md") =>
            {
                by_name.insert(name, path);
            }
            None => {
                by_name.insert(name, path);
            }
            _ => {}
        }
    }

    let cases: Vec<Case> = by_name
        .into_iter()
        .map(|(name, output_golden)| {
            let proof_golden = proof_dir.join(format!("{name}.n3"));
            Case {
                source_path: root.join("examples").join(format!("{name}.n3")),
                name,
                output_golden,
                proof_golden: proof_golden.exists().then_some(proof_golden),
            }
        })
        .collect();
    assert!(!cases.is_empty(), "no example/golden pairs found");
    cases
}

/// Guards against a top-level `.n3` example silently getting neither a
/// golden check nor a documented reason why not, by requiring every file to
/// be exactly one or the other.
fn every_n3_example_is_accounted_for(golden_checked: usize) {
    let total = sorted_n3_files(&manifest_dir().join("examples"), "examples").len();
    assert_eq!(
        total,
        golden_checked + PARSE_ONLY_EXAMPLES.len(),
        "expected every one of the {total} top-level .n3 examples to either match a golden ({golden_checked} did) or be listed in PARSE_ONLY_EXAMPLES ({} are); update whichever list is out of date",
        PARSE_ONLY_EXAMPLES.len()
    );
}

/// Guards against a top-level `.n3` example silently getting no
/// `examples/proof/` golden and no documented reason why not (mirroring
/// `every_n3_example_is_accounted_for`'s guard for output goldens), and
/// against a stale `NO_PROOF_EXAMPLES` entry naming a file that no longer
/// exists.
fn every_eligible_n3_example_has_a_proof_golden() {
    let root = manifest_dir();
    let proof_dir = root.join("examples/proof");
    let all = sorted_n3_files(&root.join("examples"), "examples");

    for (name, _) in NO_PROOF_EXAMPLES {
        assert!(
            all.iter().any(|p| p.file_stem().and_then(|s| s.to_str()) == Some(*name)),
            "NO_PROOF_EXAMPLES names {name:?}, which does not exist under examples/"
        );
    }

    let missing: Vec<String> = all
        .iter()
        .filter_map(|path| {
            let name = path.file_stem().and_then(|s| s.to_str()).expect("utf8 example name");
            if PARSE_ONLY_EXAMPLES.contains(&name) || NO_PROOF_EXAMPLES.iter().any(|(n, _)| *n == name) {
                return None;
            }
            (!proof_dir.join(format!("{name}.n3")).exists()).then(|| name.to_string())
        })
        .collect();
    assert!(missing.is_empty(), "packaged .n3 examples with no proof golden, PARSE_ONLY, or NO_PROOF_EXAMPLES entry: {missing:?}");
}

/// The two examples no golden covers are still required to be valid N3.
fn every_parse_only_example_parses() {
    for name in PARSE_ONLY_EXAMPLES {
        let path = manifest_dir().join("examples").join(format!("{name}.n3"));
        parse_document(&path, name);
        progress_line(&format!("example examples/{name}.n3 ... {} (parse only)", green("ok")));
    }
}

/// Parses an example together with its `examples/input/<name>.trig`
/// companion, when it has one, into the document the reasoner sees.
fn parse_document(source_path: &Path, name: &str) -> Document {
    let source = read(source_path);
    let label = source_path.to_string_lossy();
    let mut doc = parse_n3_with_source(&source, None, Some(label.as_ref()))
        .unwrap_or_else(|err| panic!("example {} is not valid N3: {}", source_path.display(), err));

    // A companion input is N3 when it is named `.n3` -- an eyeron proof
    // document is one, and reading it as RDF would reject its quoted formulas
    // -- and otherwise a `.trig` the reader below works out.
    let mut input_path = manifest_dir().join("examples/input").join(format!("{name}.n3"));
    if !input_path.exists() {
        input_path = manifest_dir().join("examples/input").join(format!("{name}.trig"));
    }
    if input_path.exists() {
        let input = read(&input_path);
        // An `examples/input/*.trig` companion is either an RDF Message Log,
        // an N3 document (`proof-audit.trig` is an N3 proof, quoted formulas
        // and all), or real TriG with named graphs. Try N3 before TriG, the
        // way the CLI's own N3-first reading does, so both kinds load.
        let input_label = input_path.to_string_lossy();
        let parsed = if eyeron::is_rdf_message_log(&input) {
            eyeron::parse_rdf_message_log(&input, None)
        } else {
            parse_n3_with_source(&input, None, Some(input_label.as_ref()))
                .or_else(|_| eyeron::parse_rdf12(&input, None, eyeron::RdfFormat::Trig))
        }
        .unwrap_or_else(|err| panic!("failed to parse {}: {}", input_path.display(), err));
        doc.merge(parsed);
    }
    doc
}

/// Parses, reasons, and checks both goldens — all off one run. Runs on a
/// worker thread so a rule set that stops making progress fails on a
/// timeout instead of hanging the suite.
fn run_case(case: &Case) {
    let started = std::time::Instant::now();
    let name = case.name.clone();
    let source_path = case.source_path.clone();
    let output_golden = read(&case.output_golden);
    let output_is_n3 = case.output_golden.extension().and_then(|ext| ext.to_str()) == Some("n3");
    let proof_golden = case.proof_golden.as_ref().map(|path| read(path));

    let (tx, rx) = std::sync::mpsc::channel();
    let thread_name = name.clone();
    std::thread::Builder::new()
        .name(format!("example-{name}"))
        .stack_size(16 * 1024 * 1024)
        .spawn(move || {
            let doc = parse_document(&source_path, &thread_name);
            let result = reason_document(
                &doc,
                &ReasonerOptions { proof: proof_golden.is_some(), ..ReasonerOptions::default() },
            );
            // An example that trips an inference fuse has no derived output:
            // what it produces, and what its golden records, is the report of
            // which rule fired. Every line of that report is a comment, which
            // both graph and report-line comparison would read as nothing at
            // all, so it is compared as the text it is.
            let mut outcome = match &result.fuse {
                Some(fuse) => {
                    let report = fuse_report(&doc.prefixes, fuse);
                    if report.trim() == output_golden.trim() {
                        Ok(())
                    } else {
                        Err(format!("{thread_name} fuse report does not match its golden\nactual:\n{report}"))
                    }
                }
                None => {
                    let output = result_to_string(&doc.prefixes, &result.derived);
                    compare_output_golden(&thread_name, &output, &output_golden, output_is_n3)
                }
            };
            if outcome.is_ok() {
                if let Some(expected) = &proof_golden {
                    let proof = proof_to_n3(&doc.prefixes, &result);
                    outcome = compare_proof_golden(&thread_name, &proof, expected);
                }
            }
            let _ = tx.send(outcome);
        })
        .expect("spawn example golden-test worker");

    // A CI runner measures about four times slower than a developer machine
    // here, so an example needs its limit set against that, not against the
    // local number.
    let timeout = if name == "kaprekar-6174" {
        // Searches every 4-digit number for its Kaprekar chain, and writes a
        // proof of all 10,000 of them: about 16s here against eyeling's 3.6s.
        // The remaining gap is the seven unrolled chain rules, each re-joined
        // by the agenda for every one of the 10,000 kap:step facts; that is
        // worth closing, not a reason to leave the example out.
        std::time::Duration::from_secs(240)
    } else if name.starts_with("deep-taxonomy-")
        || name.starts_with("rdf-message-")
        || name == "dining-philosophers"
        // Takeuchi's function, checked with a proof: about 1.5s here.
        || name == "takeuchi"
        // Proving its answer means re-deriving it: the fact comes from a
        // backward rule with 2,000 premises, and nothing forward-chained it,
        // so the proof walk has to run that search again. About 7.7s here.
        || name == "relational-cube-lookup"
    {
        std::time::Duration::from_secs(90)
    } else {
        std::time::Duration::from_secs(30)
    };

    match rx.recv_timeout(timeout) {
        Ok(Ok(())) => report_case(&name, &green("ok"), started, case.proof_golden.is_some()),
        Ok(Err(msg)) => {
            report_case(&name, &red("fail"), started, case.proof_golden.is_some());
            panic!("{msg}");
        }
        Err(std::sync::mpsc::RecvTimeoutError::Timeout) => {
            report_case(&name, &red("fail"), started, case.proof_golden.is_some());
            panic!(
                "{name} exceeded the {:.0}s per-example golden-test limit after {:.3}s",
                timeout.as_secs_f64(),
                started.elapsed().as_secs_f64()
            );
        }
        Err(std::sync::mpsc::RecvTimeoutError::Disconnected) => {
            report_case(&name, &red("fail"), started, case.proof_golden.is_some());
            panic!("{name} golden-test worker terminated without reporting a result");
        }
    }
}

fn compare_proof_golden(name: &str, proof: &str, expected: &str) -> Result<(), String> {
    if proof.trim().is_empty() {
        return Err(format!("{name} generated an empty proof"));
    }
    if normalize_proof_golden(name, expected) == normalize_proof_golden(name, proof) {
        return Ok(());
    }
    Err(format!("{name} proof does not match examples/proof/{name}.n3\nactual:\n{proof}"))
}

fn report_case(name: &str, status: &str, started: std::time::Instant, with_proof: bool) {
    progress_line(&format!(
        "example examples/{name}.n3 ... {status} ({:.3}s{})",
        started.elapsed().as_secs_f64(),
        if with_proof { ", output + proof" } else { ", output" },
    ));
}

fn manifest_dir() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

fn sorted_n3_files(directory: &Path, label: &str) -> Vec<PathBuf> {
    let mut files = fs::read_dir(directory)
        .unwrap_or_else(|err| panic!("failed to read {label}: {err}"))
        .map(|entry| {
            entry
                .unwrap_or_else(|err| panic!("failed to read {label} entry: {err}"))
                .path()
        })
        .filter(|path| {
            path.is_file() && path.extension().and_then(|ext| ext.to_str()) == Some("n3")
        })
        .collect::<Vec<_>>();
    files.sort();
    files
}

fn read(path: &Path) -> String {
    fs::read_to_string(path)
        .unwrap_or_else(|err| panic!("failed to read {}: {}", path.display(), err))
}

fn normalize_proof_golden(name: &str, text: &str) -> String {
    let normalized = text.replace("\r\n", "\n");
    if name != "age" {
        return normalized.trim().to_string();
    }
    // age.n3 reads the current clock and derives a duration from it. Keep
    // the rest of the proof byte-for-byte comparable to its saved golden.
    let clock = regex::Regex::new(r#""\d{4}-\d{2}-\d{2}T[^"]+"\^\^xsd:dateTime"#).unwrap();
    let duration = regex::Regex::new(r#""PT[0-9.]+S"\^\^xsd:duration"#).unwrap();
    let without_clock = clock.replace_all(&normalized, "\"<clock>\"^^xsd:dateTime");
    duration.replace_all(&without_clock, "\"<elapsed>\"^^xsd:duration").trim().to_string()
}
