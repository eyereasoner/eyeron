//! Integration tests for the Eyelang ("eye") front end: every packaged
//! `examples/*.eye` program is run and its output compared, byte for
//! byte, against the golden files ported from the upstream `eyelang`
//! project (`examples/output/*.eye`, `examples/proof/*.eye`). Unlike the
//! SPARQL-RL/N3 RDF-triple goldens, Eyelang's "result format 2" output is
//! fully deterministic and order-independent, so exact string match is
//! appropriate (no graph isomorphism needed).

use eyeron::eye;
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

fn run_source(source: &str) -> eye::RunResult {
    eye::run(source, eye::Limits::default()).unwrap_or_else(|err| panic!("run failed: {err}\nsource:\n{source}"))
}

#[test]
fn every_error_example_fails_with_its_expected_message() {
    for (name, expected_substring) in ERROR_EXAMPLES {
        let source = source_for(name);
        let err = eye::run(&source, eye::Limits::default()).expect_err(&format!("{name} was expected to fail but succeeded"));
        assert!(err.message.contains(expected_substring), "{name}: error {:?} did not contain {:?}", err.message, expected_substring);
    }
}

#[test]
fn every_example_with_a_plain_golden_matches_exactly() {
    let mut checked = 0;
    for name in example_names() {
        if ERROR_EXAMPLES.iter().any(|(n, _)| *n == name) {
            continue;
        }
        let golden_path = manifest_dir().join("examples/output").join(format!("{name}.eye"));
        if !golden_path.exists() {
            continue;
        }
        let source = effective_source(&name);
        let result = run_source(&source);
        let actual = eye::output::format_result(&result, false);
        let expected = read(&golden_path);
        assert_eq!(actual, expected, "example {name} (plain) did not match its golden");
        checked += 1;
    }
    assert!(checked >= 70, "expected at least 70 plain-output goldens to be checked, got {checked}");
}

#[test]
fn every_example_with_a_proof_golden_matches_exactly() {
    let mut checked = 0;
    for name in example_names() {
        if ERROR_EXAMPLES.iter().any(|(n, _)| *n == name) {
            continue;
        }
        let golden_path = manifest_dir().join("examples/proof").join(format!("{name}.eye"));
        if !golden_path.exists() {
            continue;
        }
        let source = effective_source(&name);
        let result = run_source(&source);
        let actual = eye::output::format_result(&result, true);
        let expected = read(&golden_path);
        assert_eq!(actual, expected, "example {name} (proof) did not match its golden");
        checked += 1;
    }
    assert!(checked >= 70, "expected at least 70 proof goldens to be checked, got {checked}");
}

#[test]
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

#[test]
fn cli_runs_a_dot_eye_file_and_matches_the_golden() {
    let path = manifest_dir().join("examples/ancestor.eye");
    let output = run_cli(&[path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let golden = read(&manifest_dir().join("examples/output/ancestor.eye"));
    assert_eq!(String::from_utf8_lossy(&output.stdout), golden);
}

#[test]
fn cli_check_flag_reports_stratification() {
    let path = manifest_dir().join("examples/ancestor.eye");
    let output = run_cli(&["--check", path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(stdout.contains("checked(rules("), "unexpected --check output: {stdout}");
}

#[test]
fn cli_json_flag_produces_parseable_json() {
    let path = manifest_dir().join("examples/ancestor.eye");
    let output = run_cli(&["--json", path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(stdout.trim_start().starts_with('{'), "expected JSON object, got: {stdout}");
    assert!(stdout.contains("\"status\":\"complete\""));
}

#[test]
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

#[test]
fn cli_rejects_oversized_limits_and_reports_exit_code_two() {
    let path = manifest_dir().join("examples/hanoi.eye");
    let output = run_cli(&["--max-steps", "1", path.to_str().unwrap()]);
    assert!(!output.status.success());
    assert_eq!(output.status.code(), Some(2));
    let stderr = String::from_utf8_lossy(&output.stderr);
    assert!(stderr.contains("Evaluation incomplete"), "unexpected stderr: {stderr}");
}

#[test]
fn cli_query_flag_appends_an_ask_statement() {
    let path = manifest_dir().join("examples/ancestor.eye");
    let output = run_cli(&["--query", "ancestor(alice, bob)", path.to_str().unwrap()]);
    assert!(output.status.success(), "stderr: {}", String::from_utf8_lossy(&output.stderr));
    let stdout = String::from_utf8_lossy(&output.stdout);
    assert!(stdout.contains("result(2, complete, 1)"), "unexpected output: {stdout}");
}
