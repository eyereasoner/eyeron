//! Integration tests for the Eyelang ("eye") front end: every packaged
//! `examples/*.eye` program is run and its output compared, byte for
//! byte, against the golden files ported from the upstream `eyelang`
//! project (`examples/output/*.eye`, `examples/proof/*.eye`). Unlike the
//! SPARQL-RL/N3 RDF-triple goldens, Eyelang's "result format 2" output is
//! fully deterministic and order-independent, so exact string match is
//! appropriate (no graph isomorphism needed).
//!
//! This uses a custom harness (`harness = false` in `Cargo.toml`, matching
//! `tests/examples.rs`/`tests/sparql_rl_examples.rs`) so each example
//! prints its own progress line, instead of being folded into one opaque
//! `#[test] ... ok` line under the default libtest harness. CLI-flag tests
//! that are not tied to a specific packaged example run silently and only
//! affect the final pass/fail count.

#[path = "support/report.rs"]
mod report;

use eyeron::eye;
use report::{green, progress_line, red};
use std::fs;
use std::path::Path;
use std::process::Command;

fn manifest_dir() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

fn read(path: &Path) -> String {
    fs::read_to_string(path).unwrap_or_else(|err| panic!("failed to read {}: {}", path.display(), err))
}

/// The three packaged examples that deliberately exercise rejection
/// (`examples/README.md`/`suite.json` in the upstream project), and the
/// substring their error message must contain.
const ERROR_EXAMPLES: &[(&str, &str)] = &[
    ("unstratified-negation", "Recursion through not or collect is not stratified"),
    ("variable-predicate-dependency", "Recursion through not or collect is not stratified"),
    ("well-formedness-error", "needs bound inputs"),
];

fn example_names() -> Vec<String> {
    let dir = manifest_dir().join("examples");
    let mut names: Vec<String> = fs::read_dir(&dir)
        .unwrap_or_else(|err| panic!("failed to read {}: {}", dir.display(), err))
        .filter_map(|entry| entry.ok())
        .map(|entry| entry.path())
        .filter(|path| path.extension().and_then(|ext| ext.to_str()) == Some("eye"))
        .map(|path| path.file_stem().and_then(|s| s.to_str()).expect("utf8 example name").to_string())
        .collect();
    names.sort();
    names
}

fn source_for(name: &str) -> String {
    read(&manifest_dir().join("examples").join(format!("{name}.eye")))
}

/// Two packaged examples need extra input assembled before running, per
/// `examples/README.md`: `proof-audit.eye` replays `socrates.eye`'s own
/// golden proof document as input, and `rdf12-interoperability.eye` reads
/// an RDF 1.2 N-Quads file via the `--rdf-input` bridge.
fn effective_source(name: &str) -> String {
    match name {
        "proof-audit" => {
            let socrates_proof = read(&manifest_dir().join("examples/proof/socrates.eye"));
            format!("{}\n{}", socrates_proof, source_for(name))
        }
        "rdf12-interoperability" => {
            let nquads = read(&manifest_dir().join("examples/rdf12-interoperability.nq"));
            let facts = eye::rdf::parse_nquads(&nquads, "d0_").unwrap_or_else(|err| panic!("failed to parse rdf12-interoperability.nq: {err}"));
            format!("{}{}", eye::rdf::facts_to_eyelang(&facts), source_for(name))
        }
        _ => source_for(name),
    }
}

fn run_source(source: &str) -> Result<eye::RunResult, String> {
    eye::run(source, eye::Limits::default()).map_err(|err| format!("run failed: {err}\nsource:\n{source}"))
}

fn main() {
    let started = std::time::Instant::now();
    every_error_example_fails_with_its_expected_message();
    let golden_checked = every_example_matches_its_plain_and_proof_goldens();
    every_proof_golden_reparses_as_a_valid_eyelang_program();
    cli_behavior_checks();

    let expected_error = ERROR_EXAMPLES.len();
    let total = golden_checked + expected_error;
    let elapsed = started.elapsed().as_secs_f64();
    progress_line(&format!(
        "\neye result: {}. {total} passed; 0 failed; finished in {elapsed:.2}s ({golden_checked} by golden match, {expected_error} expected-error)",
        green("ok"),
    ));
}

fn report_case(name: &str, status: &str, started: std::time::Instant) {
    progress_line(&format!("example examples/{name}.eye ... {status} ({:.3}s)", started.elapsed().as_secs_f64()));
}

fn run_reported<F: FnOnce() -> Result<(), String>>(name: &str, check: F) {
    let started = std::time::Instant::now();
    match check() {
        Ok(()) => report_case(name, &green("ok"), started),
        Err(msg) => {
            report_case(name, &red("fail"), started);
            panic!("{msg}");
        }
    }
}

fn check_error_example(name: &str, expected_substring: &str) -> Result<(), String> {
    let source = source_for(name);
    match eye::run(&source, eye::Limits::default()) {
        Ok(_) => Err(format!("{name} was expected to fail but succeeded")),
        Err(err) if err.message.contains(expected_substring) => Ok(()),
        Err(err) => Err(format!("{name}: error {:?} did not contain {:?}", err.message, expected_substring)),
    }
}

fn every_error_example_fails_with_its_expected_message() {
    for (name, expected_substring) in ERROR_EXAMPLES {
        run_reported(name, || check_error_example(name, expected_substring));
    }
}

fn check_example(name: &str) -> Result<(), String> {
    let plain_golden = manifest_dir().join("examples/output").join(format!("{name}.eye"));
    if !plain_golden.exists() {
        return Err(format!("{name}: every non-error .eye example must have a plain golden, missing {}", plain_golden.display()));
    }
    let proof_golden = manifest_dir().join("examples/proof").join(format!("{name}.eye"));
    if !proof_golden.exists() {
        return Err(format!("{name}: every non-error .eye example must have a proof golden, missing {}", proof_golden.display()));
    }

    let source = effective_source(name);
    let result = run_source(&source)?;

    let actual_plain = eye::output::format_result(&result, false);
    let expected_plain = read(&plain_golden);
    if actual_plain != expected_plain {
        return Err(format!("example {name} (plain) did not match its golden"));
    }

    let actual_proof = eye::output::format_result(&result, true);
    let expected_proof = read(&proof_golden);
    if actual_proof != expected_proof {
        return Err(format!("example {name} (proof) did not match its golden"));
    }
    Ok(())
}

fn every_example_matches_its_plain_and_proof_goldens() -> usize {
    let mut checked = 0;
    for name in example_names() {
        if ERROR_EXAMPLES.iter().any(|(n, _)| *n == name) {
            continue;
        }
        run_reported(&name, || check_example(&name));
        checked += 1;
    }
    let total = example_names().len();
    let expected = total - ERROR_EXAMPLES.len();
    assert_eq!(checked, expected, "expected every non-error .eye example ({expected} of {total}) to have matching goldens, got {checked}");
    checked
}

fn every_proof_golden_reparses_as_a_valid_eyelang_program() {
    let proof_dir = manifest_dir().join("examples/proof");
    for entry in fs::read_dir(&proof_dir).unwrap() {
        let path = entry.unwrap().path();
        if path.extension().and_then(|e| e.to_str()) != Some("eye") {
            continue;
        }
        let text = read(&path);
        eye::check(&text).unwrap_or_else(|err| panic!("golden {} does not reparse as valid Eyelang: {err}", path.display()));
    }
}

fn run_cli(args: &[&str]) -> std::process::Output {
    Command::new(env!("CARGO_BIN_EXE_eyeron")).args(args).output().expect("run eyeron CLI")
}

fn cli_behavior_checks() {
    cli_runs_a_dot_eye_file_and_matches_the_golden();
    cli_check_flag_reports_stratification();
    cli_json_flag_produces_parseable_json();
    cli_rdf_input_and_rdf_output_round_trip();
    cli_rejects_oversized_limits_and_reports_exit_code_two();
    cli_query_flag_appends_an_ask_statement();
}

fn cli_runs_a_dot_eye_file_and_matches_the_golden() {
    let path = manifest_dir().join("examples/ancestor.eye");
    let output = run_cli(&[path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let golden = read(&manifest_dir().join("examples/output/ancestor.eye"));
    assert_eq!(String::from_utf8_lossy(&output.stdout), golden);
}

fn cli_check_flag_reports_stratification() {
    let path = manifest_dir().join("examples/ancestor.eye");
    let output = run_cli(&["--check", path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(stdout.contains("checked(rules("), "unexpected --check output: {stdout}");
}

fn cli_json_flag_produces_parseable_json() {
    let path = manifest_dir().join("examples/ancestor.eye");
    let output = run_cli(&["--json", path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(stdout.trim_start().starts_with('{'), "expected JSON object, got: {stdout}");
    assert!(stdout.contains("\"status\":\"complete\""));
}

fn cli_rdf_input_and_rdf_output_round_trip() {
    let nq_path = manifest_dir().join("examples/rdf12-interoperability.nq");
    let eye_path = manifest_dir().join("examples/rdf12-interoperability.eye");
    let output = run_cli(&["--rdf-input", nq_path.to_str().unwrap(), eye_path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let golden = read(&manifest_dir().join("examples/output/rdf12-interoperability.eye"));
    assert_eq!(String::from_utf8_lossy(&output.stdout), golden);

    let round_trip = run_cli(&["--rdf-input", nq_path.to_str().unwrap(), "--rdf-output", eye_path.to_str().unwrap()]);
    assert!(round_trip.status.success(), "stderr: {}", String::from_utf8_lossy(&round_trip.stderr));
    let quads = String::from_utf8_lossy(&round_trip.stdout);
    assert!(quads.starts_with("VERSION \"1.2\"\n"), "unexpected --rdf-output: {quads}");
}

fn cli_rejects_oversized_limits_and_reports_exit_code_two() {
    let path = manifest_dir().join("examples/hanoi.eye");
    let output = run_cli(&["--max-steps", "1", path.to_str().unwrap()]);
    assert!(!output.status.success());
    assert_eq!(output.status.code(), Some(2));
    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(stderr.contains("Evaluation incomplete"), "unexpected stderr: {stderr}");
}

fn cli_query_flag_appends_an_ask_statement() {
    let path = manifest_dir().join("examples/ancestor.eye");
    let output = run_cli(&["--query", "ancestor(alice, bob)", path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(stdout.contains("result(2, complete, 1)"), "unexpected output: {stdout}");
}
