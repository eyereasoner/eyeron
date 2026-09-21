//! SRL-flavoured serialization of a result graph.
//!
//! `n3::printing` cannot be reused verbatim for SPARQL-RL output because
//! the two dialects disagree on one term shape. Both this front end and
//! the N3/RDF-1.2 parser represent an RDF 1.2 triple term as
//! `Term::Formula(vec![triple])` (see `super::parser`'s module doc), but
//! N3 also uses `Term::Formula` for a genuine quoted graph, and that is
//! how `n3::printing` renders it: `{ s p o . }`. SRL's grammar has no
//! such term — a triple term is written `<<( s p o )>>` ([80] `TripleTerm`
//! in SPARQL 1.2 RL §7.6) — so an SRL result containing a reifier would
//! otherwise print in a syntax neither SRL nor Turtle can read back, and
//! would disagree with eyeleng's own output.

use std::collections::BTreeMap;

use crate::ast::{Term, Triple, LOG_OUTPUT_STRING};
use crate::n3::printing::{term_to_n3_object, term_to_n3_predicate, used_prefixes};

/// Render a SPARQL-RL result graph: `@prefix` header plus one line per
/// triple. As in `n3::printing::result_to_string`, a `log:outputString`
/// fact collapses the whole result to its own text, which is how the
/// packaged examples print a human-readable report instead of triples.
pub fn result_to_srl(prefixes: &BTreeMap<String, String>, triples: &[Triple]) -> String {
    let reports: Vec<&str> = triples
        .iter()
        .filter_map(|t| match (&t.p, &t.o) {
            (Term::Iri(p), Term::Literal(l)) if p.as_str() == LOG_OUTPUT_STRING => Some(l.value.as_str()),
            _ => None,
        })
        .collect();
    if !reports.is_empty() {
        return reports.concat();
    }
    triples_to_srl(prefixes, triples)
}

pub fn triples_to_srl(prefixes: &BTreeMap<String, String>, triples: &[Triple]) -> String {
    if triples.is_empty() {
        return String::new();
    }
    let used = used_prefixes(prefixes, triples);
    let mut out = String::new();
    if used.contains("") {
        if let Some(base) = prefixes.get("") {
            out.push_str(&format!("@prefix : <{}> .\n", base));
        }
    }
    for prefix in &used {
        if prefix.is_empty() {
            continue;
        }
        if let Some(base) = prefixes.get(prefix) {
            out.push_str(&format!("@prefix {}: <{}> .\n", prefix, base));
        }
    }
    if !used.is_empty() {
        out.push('\n');
    }
    for triple in triples {
        out.push_str(&triple_to_srl(triple, prefixes));
        out.push('\n');
    }
    out
}

/// `<<(s p o)>>` — SPARQL 1.2 RL [80] `TripleTerm`, spelled the way
/// eyeleng spells it so the two implementations' output matches.
pub(crate) fn triple_term(triple: &Triple, prefixes: &BTreeMap<String, String>) -> String {
    format!(
        "<<({} {} {})>>",
        term_to_srl(&triple.s, prefixes, false),
        term_to_srl(&triple.p, prefixes, true),
        term_to_srl(&triple.o, prefixes, false),
    )
}

pub(crate) fn triple_to_srl(triple: &Triple, prefixes: &BTreeMap<String, String>) -> String {
    format!(
        "{} {} {} .",
        term_to_srl(&triple.s, prefixes, false),
        term_to_srl(&triple.p, prefixes, true),
        term_to_srl(&triple.o, prefixes, false),
    )
}

/// As `n3::printing::term_to_n3_object`/`term_to_n3_predicate`, except a
/// single-triple `Term::Formula` renders as a triple term rather than as a
/// quoted graph.
pub(crate) fn term_to_srl(term: &Term, prefixes: &BTreeMap<String, String>, predicate_position: bool) -> String {
    if let Term::Formula(triples) = term {
        if triples.len() == 1 {
            return triple_term(&triples[0], prefixes);
        }
    }
    if predicate_position {
        term_to_n3_predicate(term, prefixes)
    } else {
        term_to_n3_object(term, prefixes)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ast::RDF_TYPE;

    fn prefixes() -> BTreeMap<String, String> {
        BTreeMap::from([
            ("".to_string(), "http://example/".to_string()),
            ("rdf".to_string(), "http://www.w3.org/1999/02/22-rdf-syntax-ns#".to_string()),
        ])
    }

    #[test]
    fn a_triple_term_prints_as_a_triple_term_not_a_quoted_graph() {
        let inner = Triple::new(Term::iri("http://example/alice"), Term::iri("http://example/says"), Term::iri("http://example/hello"));
        let fact = Triple::new(
            Term::iri("http://example/claim1"),
            Term::iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"),
            Term::Formula(vec![inner]),
        );
        let out = triples_to_srl(&prefixes(), &[fact]);
        assert!(out.contains(":claim1 rdf:reifies <<(:alice :says :hello)>> ."), "{out}");
        assert!(!out.contains('{'), "no quoted-graph syntax: {out}");
    }

    #[test]
    fn rdf_type_still_abbreviates_to_a() {
        let fact = Triple::new(Term::iri("http://example/s"), Term::iri(RDF_TYPE), Term::iri("http://example/C"));
        assert!(triples_to_srl(&prefixes(), &[fact]).contains(":s a :C ."));
    }

    #[test]
    fn an_output_string_collapses_the_result_to_its_report() {
        let fact = Triple::new(
            Term::iri("http://example/s"),
            Term::iri(LOG_OUTPUT_STRING),
            Term::Literal(crate::ast::Literal::plain("report text")),
        );
        assert_eq!(result_to_srl(&prefixes(), &[fact]), "report text");
    }
}
