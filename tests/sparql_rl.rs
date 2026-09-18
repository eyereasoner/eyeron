//! Integration tests for the SPARQL 1.2 RL front end: parses each packaged
//! `.srl` example, runs it forward to a fixpoint through the same CLI-facing
//! entry points `main.rs` uses, and checks the derived triples against a
//! golden file in `examples/output/`, following the same
//! examples-with-goldens convention `tests/examples.rs` uses for N3.

use eyeron::sparql_rl::{parse_sparql_rl, reason};
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
    assert!(eyeron::sparql_rl::is_sparql_rl(&source));
    assert!(!eyeron::sparql_rl::is_sparql_rl("@prefix : <http://example.org/> .\n:a :b :c ."));
}

#[test]
fn select_query_syntax_is_rejected_with_a_clear_error() {
    let err = parse_sparql_rl("SELECT * WHERE { ?s ?p ?o }", None).unwrap_err();
    assert!(err.message.to_ascii_lowercase().contains("sparql-rl"), "{}", err.message);
}

#[test]
fn unstratifiable_negation_is_rejected() {
    let source = "PREFIX : <http://example/>\n\
                  RULE { ?x :p true } WHERE { NOT { ?x :q true } }\n\
                  RULE { ?x :q true } WHERE { NOT { ?x :p true } }";
    let program = parse_sparql_rl(source, None).unwrap();
    let err = reason(&program, &[], &ReasonerOptions::default()).unwrap_err();
    assert!(err.message.contains("stratification"), "{}", err.message);
}
