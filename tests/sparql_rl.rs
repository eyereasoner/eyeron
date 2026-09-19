//! Integration tests for the SPARQL 1.2 RL front end: parses each packaged
//! `.srl` example, runs it forward to a fixpoint through the same CLI-facing
//! entry points `main.rs` uses, and checks the derived triples against a
//! golden file in `examples/output/`, following the same
//! examples-with-goldens convention `tests/examples.rs` uses for N3.

use eyeron::srl::{parse_sparql_rl, reason};
use eyeron::{parse_n3, result_to_string, ReasonerOptions, Triple};
use std::collections::HashSet;
use std::fs;
use std::path::Path;

fn manifest_dir() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

/// Parse `n3_text` (plain triples, no rules) and return its fact set. Used
/// to compare actual vs. golden output without needing full graph
/// isomorphism, since none of the packaged SRL examples produce blank
/// nodes.
fn fact_set(n3_text: &str) -> HashSet<Triple> {
    parse_n3(n3_text, None).unwrap_or_else(|err| panic!("invalid N3: {err}\n{n3_text}")).facts.into_iter().collect()
}

fn run_example(name: &str) -> String {
    let source_path = manifest_dir().join("examples").join(name);
    let source = fs::read_to_string(&source_path).unwrap_or_else(|err| panic!("reading {}: {err}", source_path.display()));
    let program = parse_sparql_rl(&source, None).unwrap_or_else(|err| panic!("parsing {}: {err}", source_path.display()));
    let result = reason(&program, &[], &ReasonerOptions::default()).unwrap_or_else(|err| panic!("reasoning over {}: {err}", source_path.display()));
    assert!(result.incomplete_summary().is_none(), "{}: {:?}", name, result.incomplete_summary());
    result_to_string(&program.prefixes, &result.derived)
}

fn assert_matches_golden(name: &str) {
    let golden_path = manifest_dir().join("examples/output").join(name);
    let golden = fs::read_to_string(&golden_path).unwrap_or_else(|err| panic!("reading golden {}: {err}", golden_path.display()));
    let actual = run_example(name);
    assert_eq!(fact_set(&actual), fact_set(&golden), "{name}: derived facts do not match the golden\nactual:\n{actual}\nexpected:\n{golden}");
}

#[test]
fn family_forward_chaining_matches_golden() {
    assert_matches_golden("family.srl");
}

#[test]
fn filter_town_matches_golden() {
    assert_matches_golden("filter-town.srl");
}

#[test]
fn negation_orphan_matches_golden() {
    assert_matches_golden("negation-orphan.srl");
}

#[test]
fn property_paths_matches_golden() {
    assert_matches_golden("property-paths.srl");
}

#[test]
fn every_packaged_srl_example_parses_and_reasons_without_error() {
    let dir = manifest_dir().join("examples");
    let mut checked = 0;
    for entry in fs::read_dir(&dir).unwrap() {
        let path = entry.unwrap().path();
        if path.extension().and_then(|e| e.to_str()) != Some("srl") {
            continue;
        }
        let name = path.file_name().unwrap().to_str().unwrap();
        let source = fs::read_to_string(&path).unwrap();
        let program = parse_sparql_rl(&source, None).unwrap_or_else(|err| panic!("parsing {name}: {err}"));
        let result = reason(&program, &[], &ReasonerOptions::default()).unwrap_or_else(|err| panic!("reasoning over {name}: {err}"));
        assert!(result.incomplete_summary().is_none(), "{name}: {:?}", result.incomplete_summary());
        checked += 1;
    }
    assert!(checked >= 4, "expected at least 4 packaged .srl examples, found {checked}");
}

#[test]
fn well_formed_rule_set_is_content_sniffed_as_sparql_rl() {
    let source = fs::read_to_string(manifest_dir().join("examples/family.srl")).unwrap();
    assert!(eyeron::srl::is_sparql_rl(&source));
    assert!(!eyeron::srl::is_sparql_rl("@prefix : <http://example.org/> .\n:a :b :c ."));
}

#[test]
fn select_query_syntax_is_rejected_with_a_clear_error() {
    let err = parse_sparql_rl("SELECT * WHERE { ?s ?p ?o }", None).unwrap_err();
    assert!(err.message.to_ascii_lowercase().contains("sparql-rl"), "{}", err.message);
}

#[test]
fn unstratifiable_negation_is_rejected() {
    let source = "PREFIX : <http://example/>\n\
                  RULE { ?x :p true } WHERE { ?x a :Thing . NOT { ?x :q true } }\n\
                  RULE { ?x :q true } WHERE { ?x a :Thing . NOT { ?x :p true } }";
    let program = parse_sparql_rl(source, None).unwrap();
    let err = reason(&program, &[], &ReasonerOptions::default()).unwrap_err();
    assert!(err.message.contains("stratification"), "{}", err.message);
}

fn run_cli(args: &[&str]) -> std::process::Output {
    std::process::Command::new(env!("CARGO_BIN_EXE_eyeron")).args(args).output().expect("run eyeron")
}

#[test]
fn cli_query_forward_mode_matches_backward_mode() {
    let family = manifest_dir().join("examples/family.srl").to_str().unwrap().to_string();

    let forward = run_cli(&["--query", "{ ?x :descendedFrom :C }", &family]);
    assert!(forward.status.success(), "{}", String::from_utf8_lossy(&forward.stderr));
    let forward_out = String::from_utf8_lossy(&forward.stdout);

    let backward = run_cli(&["--query-mode", "backward", "--query", "{ ?x :descendedFrom :C }", &family]);
    assert!(backward.status.success(), "{}", String::from_utf8_lossy(&backward.stderr));
    let backward_out = String::from_utf8_lossy(&backward.stdout);

    // Both query modes should report exactly the two people descended from
    // :C, and — this is a regression check for a real bug caught during
    // development — never leak an internal renamed rule variable
    // (`__bw_...`) into the reported solution.
    for out in [&forward_out, &backward_out] {
        assert!(out.contains(":A"), "{out}");
        assert!(out.contains(":X"), "{out}");
        assert!(!out.contains("__bw_"), "{out}");
        assert_eq!(out.lines().filter(|l| l.starts_with("?x")).count(), 2, "{out}");
    }
}

#[test]
fn cli_query_file_reads_pattern_from_a_file() {
    let family = manifest_dir().join("examples/family.srl").to_str().unwrap().to_string();
    let query_path = std::env::temp_dir().join("eyeron-sparql-rl-query-test.txt");
    fs::write(&query_path, "{ :X :childOf ?p }").unwrap();

    let output = run_cli(&["--query-file", query_path.to_str().unwrap(), &family]);
    assert!(output.status.success(), "{}", String::from_utf8_lossy(&output.stderr));
    let out = String::from_utf8_lossy(&output.stdout);
    assert!(out.contains(":A"), "{out}");
    assert!(out.contains(":B"), "{out}");

    let _ = fs::remove_file(&query_path);
}
