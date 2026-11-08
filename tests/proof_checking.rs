//! Generates every packaged example's proof and checks it against the
//! program it was produced from, using the specification's reference
//! implementation of the validity conditions C1–C10.
//!
//! This is the suite that says what a proof is worth. Each proof is checked
//! as the document it is, read back from its N3 text: every recorded
//! inference re-performed against the source rule, every premise resolved,
//! the derivation graph tested for cycles, and every claim accounted for.
//! Each proof and its N3 check report are goldens, `examples/proof/` and
//! `examples/check/`: an ordinary run only reads them, and
//! `EYERON_UPDATE_GOLDENS=1` rewrites those that changed.
//!
//! Uses a custom harness (`harness = false`), like the other example
//! suites, so each example prints its own line.

#[path = "support/examples.rs"]
mod examples;
#[path = "support/report.rs"]
mod report;

use eyeron::proof_check::Report;
use eyeron::{proof_to_n3, reason_document, ReasonerOptions};
use examples::{example_jobs, manifest_dir, parse_document, read, run_cases, sorted_n3_files, source_labels, CLOCK_EXAMPLES, NO_PROOF_EXAMPLES, PARSE_ONLY_EXAMPLES};
use report::{green, progress_line, red};

/// verifiable-decision-audit.n3 audits the proof of verifiable-decision.n3,
/// which it reads as a companion input. That copy has to be the engine's
/// current proof and not a stale one, or the audit would be of a decision
/// the program no longer makes -- and would keep passing while saying
/// nothing.
const AUDITED: &str = "verifiable-decision";

fn updating_goldens() -> bool {
    std::env::var_os("EYERON_UPDATE_GOLDENS").is_some_and(|value| value == "1")
}

/// Compare `text` with the golden at `relative`, or rewrite it when asked.
fn golden(relative: &str, text: &str) -> Result<(), String> {
    let path = manifest_dir().join(relative);
    if std::fs::read_to_string(&path).is_ok_and(|saved| saved == text) {
        return Ok(());
    }
    if updating_goldens() {
        std::fs::create_dir_all(path.parent().expect("a golden has a directory")).map_err(|err| err.to_string())?;
        std::fs::write(&path, text).map_err(|err| format!("cannot update {relative}: {err}"))?;
        eprintln!("updated {relative}");
        return Ok(());
    }
    Err(format!("{relative} {}; review the change, then run EYERON_UPDATE_GOLDENS=1 cargo test --release --test proof_checking",
        if path.exists() { "changed" } else { "is missing" }))
}

enum Outcome {
    Checked(Report),
    NothingToProve,
}

/// Reasons over example `name` with proof capture, and checks the proof
/// it writes.
fn check(name: &str) -> Result<Outcome, String> {
    let source_path = manifest_dir().join("examples").join(format!("{name}.n3"));
    let doc = parse_document(&source_path, name);
    let result = reason_document(&doc, &ReasonerOptions { proof: true, ..ReasonerOptions::default() });
    let proof = proof_to_n3(&doc.prefixes, &result);
    if NO_PROOF_EXAMPLES.iter().any(|(listed, _)| *listed == name) {
        return if result.derived.is_empty() {
            Ok(Outcome::NothingToProve)
        } else {
            Err(format!("{name} is listed in NO_PROOF_EXAMPLES but derives {} statement(s)", result.derived.len()))
        };
    }
    if proof.trim().is_empty() {
        return Err(format!("{name} generated an empty proof"));
    }
    if name == AUDITED {
        let audited = read(&manifest_dir().join(format!("examples/input/{AUDITED}-audit.n3")));
        if audited != proof {
            return Err(format!("examples/input/{AUDITED}-audit.n3 is not the current proof of examples/{AUDITED}.n3; \
                write `eyeron -p examples/{AUDITED}.n3` over it so the audit is of the decision this program makes now"));
        }
    }
    let clock = CLOCK_EXAMPLES.iter().any(|(listed, _)| *listed == name);
    if !clock { golden(&format!("examples/proof/{name}.n3"), &proof)?; }
    let (report, text) = eyeron::proof_check_n3::check_proof_report(&doc, &proof, Some(&format!("examples/proof/{name}.n3")), &source_labels(name))
        .map_err(|e| e.message)?;
    if !clock { golden(&format!("examples/check/{name}.n3"), &text)?; }
    Ok(Outcome::Checked(report))
}

fn main() {
    let started = std::time::Instant::now();
    let mut passed = 0usize;
    let mut failed = 0usize;
    let mut proofs = 0usize;
    let mut steps = 0usize;
    let mut verified = 0usize;
    let mut trusted = 0usize;

    for (name, _) in NO_PROOF_EXAMPLES.iter().chain(CLOCK_EXAMPLES) {
        assert!(manifest_dir().join(format!("examples/{name}.n3")).exists(),
            "{name:?} is listed as an exception but does not exist under examples/");
    }
    // Every golden belongs to an example that has a proof to keep.
    for kind in ["proof", "check"] {
        let Ok(entries) = std::fs::read_dir(manifest_dir().join("examples").join(kind)) else { continue };
        for entry in entries {
            let file = entry.expect("read a golden").file_name().to_string_lossy().into_owned();
            let name = file.strip_suffix(".n3").unwrap_or(&file).to_string();
            let kept = manifest_dir().join(format!("examples/{name}.n3")).exists()
                && !PARSE_ONLY_EXAMPLES.contains(&name.as_str())
                && !NO_PROOF_EXAMPLES.iter().chain(CLOCK_EXAMPLES).any(|(listed, _)| *listed == name);
            assert!(kept, "examples/{kind}/{file} belongs to no example with a proof to keep");
        }
    }

    let names = sorted_n3_files(&manifest_dir().join("examples")).into_iter()
        .map(|path| path.file_stem().and_then(|s| s.to_str()).expect("utf8 name").to_string())
        .filter(|name| !PARSE_ONLY_EXAMPLES.contains(&name.as_str())).collect();
    run_cases(names, example_jobs(), check, |name, outcome, elapsed| {
        let (valid, summary) = match &outcome {
            Ok(Outcome::Checked(report)) => {
                proofs += 1;
                steps += report.steps;
                verified += report.verified;
                trusted += report.obligations.len();
                (report.valid(), report.verdict())
            }
            Ok(Outcome::NothingToProve) => (true, "derives nothing to prove".to_string()),
            Err(message) => (false, message.clone()),
        };

        if valid {
            passed += 1;
            progress_line(&format!("proof examples/{name}.n3 ... {} ({summary}; {:.3}s)", green("ok"), elapsed.as_secs_f64()));
        } else {
            failed += 1;
            progress_line(&format!("proof examples/{name}.n3 ... {} ({summary}; {:.3}s)", red("fail"), elapsed.as_secs_f64()));
            if let Ok(Outcome::Checked(report)) = &outcome {
                for failure in report.failures.iter().take(2) {
                    progress_line(&format!("    [{}] {} -- {}", failure.condition, failure.conclusion, failure.detail));
                }
            }
        }
    });

    let elapsed = started.elapsed().as_secs_f64();
    progress_line(&format!(
        "\nproof_checking result: {}. {passed} passed; {failed} failed; finished in {elapsed:.2}s \
         ({proofs} proofs; {steps} steps, {verified} verified, {trusted} trusted)",
        if failed == 0 { green("ok") } else { red("FAILED") },
    ));
    assert_eq!(failed, 0, "{failed} proof(s) did not check");
}
