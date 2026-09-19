//! CLI-flag and rule-set-level behavior tests for the SPARQL 1.2 RL front
//! end: content-sniffing, malformed/rejected input, and `--query`/
//! `--query-file`/`--query-mode`. Every packaged `.srl` example (including
//! eyeron's own `family.srl`/`filter-town.srl`/`negation-orphan.srl`/
//! `property-paths.srl` fixtures) is covered instead by
//! `tests/sparql_rl_examples.rs`, which is also where to add a test for a
//! new packaged example.

use eyeron::srl::{parse_sparql_rl, reason};
use eyeron::ReasonerOptions;
use std::fs;
use std::path::Path;

fn manifest_dir() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
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
