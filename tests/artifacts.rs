//! Check the saved proofs and reports directly, without generating a new
//! derivation. `tests/proof_checking.rs` requires each generated proof to
//! be the saved one, so this is where every packaged proof is checked under
//! C1–C10. Each proof must check, an extra unsupported claim must be
//! rejected, its report must be reproduced, and its reported answers must
//! agree with the example's output golden. Directory coverage includes the
//! documented exceptions for clock readings, fuses and external inputs.

#[path = "support/examples.rs"]
mod examples;
#[path = "support/golden_n3.rs"]
mod golden_n3;
#[path = "support/report.rs"]
mod report;

use examples::{example_filters, example_jobs, manifest_dir, parse_document, read, run_cases, sorted_n3_files, source_labels, CLOCK_EXAMPLES, NO_PROOF_EXAMPLES, PARSE_ONLY_EXAMPLES};
use golden_n3::{compare_output_golden, document_triples};
use report::{green, progress_line, red};
use std::collections::BTreeSet;

// Large proofs already get a complete saved-file check. Avoid making a
// second copy and repeating that work just to add one unsupported claim.
const LARGE: usize = 1_000_000;

fn kept(name: &str) -> bool {
    !PARSE_ONLY_EXAMPLES.contains(&name)
        && !NO_PROOF_EXAMPLES.iter().chain(CLOCK_EXAMPLES).any(|(listed, _)| *listed == name)
}

fn coverage(names: &[String]) {
    let expected: BTreeSet<_> = names.iter().map(|name| format!("{name}.n3")).collect();
    for kind in ["proof", "check"] {
        let actual: BTreeSet<_> = std::fs::read_dir(manifest_dir().join("examples").join(kind))
            .unwrap_or_else(|err| panic!("cannot read examples/{kind}: {err}"))
            .map(|entry| entry.expect("read an artifact").file_name().to_string_lossy().into_owned()).collect();
        assert_eq!(actual, expected, "examples/{kind} must contain exactly one file per example with a saved proof");
    }
}

struct Outcome {
    report: eyeron::proof_check::Report,
    proof: Result<(), String>,
    check: Result<(), String>,
}

fn check(name: &str) -> Result<Outcome, String> {
    let root = manifest_dir().join("examples");
    let program = parse_document(&root.join(format!("{name}.n3")), name);
    let proof = read(&root.join(format!("proof/{name}.n3")));
    let saved_report = read(&root.join(format!("check/{name}.n3")));
    let label = format!("examples/proof/{name}.n3");
    let (report, reproduced) = eyeron::proof_check_n3::check_proof_report(&program, &proof, Some(&label), &source_labels(name))
        .map_err(|err| err.message)?;
    let proof_check = if !report.valid() {
        Err(format!("saved proof is invalid: {:?}", report.failures.first()))
    } else if proof.len() < LARGE {
        let forged = format!("{proof}\n<urn:eyeron:forged-claim> <urn:eyeron:unsupported> <urn:eyeron:missing-evidence> .\n");
        match eyeron::proof_check_n3::check_proof_document(&program, &forged) {
            Ok(report) if report.valid() => Err("accepted an extra unsupported claim in the saved proof".into()),
            _ => Ok(()),
        }
    } else {
        Ok(())
    };
    let report_check = if reproduced != saved_report {
        Err("saved report differs from checking the saved proof; review examples/check/".into())
    } else {
        check_answers(name, &saved_report)
    };
    Ok(Outcome { report, proof: proof_check, check: report_check })
}

fn check_answers(name: &str, saved_report: &str) -> Result<(), String> {
    // Section 9.9 puts the plain answer statements before this comment;
    // pe:Check metadata and quoted obligation statements are not answers.
    let (answers, _) = saved_report.split_once("\n# The check of these answers against the source program.")
        .ok_or("the report does not separate its answers from the check metadata")?;
    let parsed = eyeron::parse_n3(answers, None).map_err(|err| err.message)?;
    let output = eyeron::result_to_string(&parsed.prefixes, &document_triples(&parsed));
    let root = manifest_dir().join("examples/output");
    let n3 = root.join(format!("{name}.n3"));
    let markdown = root.join(format!("{name}.md"));
    let path = if markdown.exists() { &markdown } else { &n3 };
    compare_output_golden(name, &output, &read(path), path == &n3)
}

fn main() {
    let started = std::time::Instant::now();
    let names: Vec<String> = sorted_n3_files(&manifest_dir().join("examples")).iter()
        .map(|path| path.file_stem().expect("example stem").to_string_lossy().into_owned())
        .filter(|name| kept(name)).collect();
    coverage(&names);
    let mut passed = 1;
    let mut failed = 0;
    let (mut steps, mut verified, mut trusted) = (0, 0, 0);
    progress_line(&format!("artifact directories examples/proof/ and examples/check/ ... {}", green("ok")));
    let wanted = example_filters();
    let names = names.into_iter().filter(|name| wanted.is_empty() || wanted.contains(name)).collect();
    run_cases(names, example_jobs(), check, |name, outcome, elapsed| {
        let (results, verdict) = match outcome {
            Ok(outcome) => {
                steps += outcome.report.steps;
                verified += outcome.report.verified;
                trusted += outcome.report.obligations.len();
                ([outcome.proof, outcome.check], outcome.report.verdict())
            }
            Err(message) => ([Err(message.clone()), Err(message)], String::new()),
        };
        for (kind, result) in ["proof", "check"].into_iter().zip(results) {
            match result {
                Ok(()) => {
                    passed += 1;
                    let detail = if kind == "proof" { format!("{verdict}; ") } else { String::new() };
                    progress_line(&format!("artifact examples/{kind}/{name}.n3 ... {} ({detail}{:.3}s per pair)", green("ok"), elapsed.as_secs_f64()));
                }
                Err(message) => {
                    failed += 1;
                    progress_line(&format!("artifact examples/{kind}/{name}.n3 ... {} ({message})", red("fail")));
                }
            }
        }
    });
    progress_line(&format!("\nartifacts result: {}. {passed} passed; {failed} failed; finished in {:.2}s \
         ({steps} steps, {verified} verified, {trusted} trusted)",
        if failed == 0 { green("ok") } else { red("FAILED") }, started.elapsed().as_secs_f64()));
    assert_eq!(failed, 0, "{failed} saved artifact check(s) failed");
}
