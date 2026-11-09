//! Checks every packaged `.n3` example against its output golden,
//! `examples/output/<name>.n3` (or `.md`), for what it derives. How it is
//! derived is the concern of `tests/proof_checking.rs`, which requires each
//! generated proof to be the saved one, and `tests/artifacts.rs`, which
//! checks the saved proofs.
//!
//! Uses a custom harness (`harness = false`) so each example prints its own
//! line as it runs.

#[path = "support/examples.rs"]
mod examples;
#[path = "support/golden_n3.rs"]
mod golden_n3;
#[path = "support/report.rs"]
mod report;

use eyeron::{fuse_report, reason_document, result_to_string, ReasonerOptions};
use examples::{manifest_dir, parse_document, read, run_with_timeout, sorted_n3_files, PARSE_ONLY_EXAMPLES};
use golden_n3::compare_output_golden;
use report::{green, progress_line, red};
use std::collections::BTreeMap;
use std::fs;
use std::path::{Path, PathBuf};

/// One example and the golden describing it.
struct Case {
    name: String,
    source_path: PathBuf,
    output_golden: PathBuf,
}

fn main() {
    let started = std::time::Instant::now();
    let cases = collect_cases();
    every_n3_example_is_accounted_for(cases.len());

    progress_line(&format!("running {} example{}", cases.len(), if cases.len() == 1 { "" } else { "s" }));
    for case in &cases {
        run_case(case);
    }
    every_parse_only_example_parses();

    let parse_only = PARSE_ONLY_EXAMPLES.len();
    let total = cases.len() + parse_only;
    let elapsed = started.elapsed().as_secs_f64();
    progress_line(&format!(
        "\nn3 result: {}. {total} passed; 0 failed; finished in {elapsed:.2}s ({} output goldens, {parse_only} parse-only)",
        green("ok"),
        cases.len(),
    ));
}

/// Pairs each example that has an output golden with that golden. A `.md`
/// golden wins over a `.n3` one when both are present.
fn collect_cases() -> Vec<Case> {
    let root = manifest_dir();
    let output_dir = root.join("examples/output");
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
        .map(|(name, output_golden)| Case {
            source_path: root.join("examples").join(format!("{name}.n3")),
            name,
            output_golden,
        })
        .collect();
    assert!(!cases.is_empty(), "no example/golden pairs found");
    cases
}

/// Guards against a top-level `.n3` example silently getting neither a
/// golden check nor a documented reason why not, by requiring every file to
/// be exactly one or the other.
fn every_n3_example_is_accounted_for(golden_checked: usize) {
    let total = sorted_n3_files(&manifest_dir().join("examples")).len();
    assert_eq!(
        total,
        golden_checked + PARSE_ONLY_EXAMPLES.len(),
        "expected every one of the {total} top-level .n3 examples to either match a golden ({golden_checked} did) or be listed in PARSE_ONLY_EXAMPLES ({} are); update whichever list is out of date",
        PARSE_ONLY_EXAMPLES.len()
    );
}

/// The two examples no golden covers are still required to be valid N3.
fn every_parse_only_example_parses() {
    for name in PARSE_ONLY_EXAMPLES {
        let path = manifest_dir().join("examples").join(format!("{name}.n3"));
        parse_document(&path, name);
        progress_line(&format!("example examples/{name}.n3 ... {} (parse only)", green("ok")));
    }
}

/// Whether this run rewrites the output goldens that no longer match, as
/// asked for with `EYERON_UPDATE_GOLDENS=1` after an intentional change.
/// Ordinary runs only read them. Markdown output goldens are never
/// rewritten.
fn updating_goldens() -> bool {
    std::env::var_os("EYERON_UPDATE_GOLDENS").is_some_and(|value| value == "1")
}

fn update_golden(path: &Path, text: &str) -> Result<(), String> {
    fs::write(path, text).map_err(|err| format!("cannot update {}: {err}", path.display()))?;
    eprintln!("updated {}", path.display());
    Ok(())
}

/// Parses, reasons, and checks the output golden.
fn run_case(case: &Case) {
    let started = std::time::Instant::now();
    let name = case.name.clone();
    let source_path = case.source_path.clone();
    let output_golden = read(&case.output_golden);
    let output_is_n3 = case.output_golden.extension().and_then(|ext| ext.to_str()) == Some("n3");
    let output_golden_path = case.output_golden.clone();

    let worker_name = name.clone();
    let outcome = run_with_timeout(&name, move || {
        let doc = parse_document(&source_path, &worker_name);
        let result = reason_document(&doc, &ReasonerOptions::default());
        // An example that trips an inference fuse has no derived output:
        // what it produces, and what its golden records, is the report of
        // which rule fired. Every line of that report is a comment, which
        // both graph and report-line comparison would read as nothing at
        // all, so it is compared as the text it is.
        match &result.fuse {
            Some(fuse) => {
                let report = fuse_report(&doc.prefixes, fuse);
                if report.trim() == output_golden.trim() {
                    Ok(())
                } else {
                    Err(format!("{worker_name} fuse report does not match its golden\nactual:\n{report}"))
                }
            }
            None => {
                let output = result_to_string(&doc.prefixes, &result.derived);
                let compared = compare_output_golden(&worker_name, &output, &output_golden, output_is_n3);
                if compared.is_err() && output_is_n3 && updating_goldens() {
                    update_golden(&output_golden_path, &output)
                } else {
                    compared
                }
            }
        }
    });

    let status = if outcome.is_ok() { green("ok") } else { red("fail") };
    progress_line(&format!("example examples/{name}.n3 ... {status} ({:.3}s)", started.elapsed().as_secs_f64()));
    if let Err(message) = outcome {
        panic!("{message}");
    }
}
