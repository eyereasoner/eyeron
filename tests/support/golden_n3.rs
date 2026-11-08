//! N3-specific golden-document comparison for the example and saved-artifact
//! harnesses via `#[path = "support/golden_n3.rs"] mod golden_n3;`. Kept in its own
//! file rather than a shared `tests/support/mod.rs` so other `harness =
//! false` test binaries that only need `tests/support/report.rs`'s
//! progress-printing helpers can `#[path = "support/report.rs"] mod
//! report;` without also compiling — and getting "never used" warnings
//! for — this N3-only comparison logic.

use eyeron::{parse_n3, Document, Name, Rule, Term, Triple};
use std::collections::BTreeMap;

const LOG_IMPLIES: &str = "http://www.w3.org/2000/10/swap/log#implies";
const LOG_IMPLIED_BY: &str = "http://www.w3.org/2000/10/swap/log#impliedBy";

/// Compares what an example derived against its golden. An `.n3` golden is
/// compared as a graph, so triple order and blank-node labels may differ
/// while a missing or extra triple fails; an `.md` golden is compared by
/// its stable report lines.
pub fn compare_output_golden(name: &str, out: &str, golden: &str, golden_is_n3: bool) -> Result<(), String> {
    if !golden_is_n3 {
        for expected in stable_report_lines(golden) {
            if !out.contains(expected) {
                return Err(format!("{name} missing report line `{expected}`\nactual:\n{out}"));
            }
        }
        return Ok(());
    }

    let actual = parse_n3(out, None).map_err(|err| format!("{name} generated invalid N3: {err}\nactual:\n{out}"))?;
    let expected = parse_n3(golden, None).map_err(|err| format!("{name} golden is invalid N3: {err}"))?;
    let actual_triples = document_triples(&actual);
    let expected_triples = document_triples(&expected);
    if graphs_isomorphic(&actual_triples, &expected_triples) {
        return Ok(());
    }

    Err(format!(
        "{name} output is not isomorphic with its golden (actual {} triples, expected {})\nactual:\n{out}",
        actual_triples.len(),
        expected_triples.len(),
    ))
}

fn stable_report_lines(text: &str) -> impl Iterator<Item = &str> {
    text.lines().map(str::trim).filter(|line| !line.is_empty() && !line.starts_with('#') && !line.starts_with("- ["))
}

pub fn document_triples(doc: &Document) -> Vec<Triple> {
    let mut triples = doc.facts.clone();
    triples.extend(doc.rules.iter().map(rule_triple));
    triples
}

fn rule_triple(rule: &Rule) -> Triple {
    if rule.is_forward {
        Triple::new(Term::Formula(rule.premise.clone()), Term::iri(LOG_IMPLIES), Term::Formula(rule.conclusion.clone()))
    } else {
        Triple::new(Term::Formula(rule.conclusion.clone()), Term::iri(LOG_IMPLIED_BY), Term::Formula(rule.premise.clone()))
    }
}

fn graphs_isomorphic(actual: &[Triple], expected: &[Triple]) -> bool {
    if actual.len() != expected.len() {
        return false;
    }
    let mut used = vec![false; expected.len()];
    match_triples(actual, expected, 0, &mut used, &mut BTreeMap::new(), &mut BTreeMap::new())
}

fn match_triples(actual: &[Triple], expected: &[Triple], index: usize, used: &mut [bool], blanks: &mut BTreeMap<Name, Name>, reverse_blanks: &mut BTreeMap<Name, Name>) -> bool {
    if index == actual.len() {
        return true;
    }
    for candidate in 0..expected.len() {
        if used[candidate] {
            continue;
        }
        let mut next_blanks = blanks.clone();
        let mut next_reverse = reverse_blanks.clone();
        if triple_matches(&actual[index], &expected[candidate], &mut next_blanks, &mut next_reverse) {
            used[candidate] = true;
            if match_triples(actual, expected, index + 1, used, &mut next_blanks, &mut next_reverse) {
                return true;
            }
            used[candidate] = false;
        }
    }
    false
}

fn triple_matches(actual: &Triple, expected: &Triple, blanks: &mut BTreeMap<Name, Name>, reverse_blanks: &mut BTreeMap<Name, Name>) -> bool {
    term_matches(&actual.s, &expected.s, blanks, reverse_blanks) && term_matches(&actual.p, &expected.p, blanks, reverse_blanks) && term_matches(&actual.o, &expected.o, blanks, reverse_blanks)
}

fn term_matches(actual: &Term, expected: &Term, blanks: &mut BTreeMap<Name, Name>, reverse_blanks: &mut BTreeMap<Name, Name>) -> bool {
    match (actual, expected) {
        (Term::Blank(a), Term::Blank(e)) => match (blanks.get(a), reverse_blanks.get(e)) {
            (Some(mapped), _) => mapped == e,
            (_, Some(mapped)) => mapped == a,
            (None, None) => {
                blanks.insert(a.clone(), e.clone());
                reverse_blanks.insert(e.clone(), a.clone());
                true
            }
        },
        (Term::List(a), Term::List(e)) => a.len() == e.len() && a.iter().zip(e).all(|(a, e)| term_matches(a, e, blanks, reverse_blanks)),
        (Term::Formula(a), Term::Formula(e)) => {
            if a.len() != e.len() {
                return false;
            }
            let mut used = vec![false; e.len()];
            match_triples(a, e, 0, &mut used, blanks, reverse_blanks)
        }
        _ => actual == expected,
    }
}
