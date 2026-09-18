//! Forward-chaining entry point for SPARQL 1.2 RL rule sets.
//!
//! Ties together the pieces built so far: `super::stratify` computes a safe
//! rule execution order, `super::eval` evaluates each rule's body against
//! the current graphs, and `crate::reasoner::instantiate_triple` reuses
//! eyeron's existing deterministic per-firing blank-node/skolemization
//! logic to materialize rule heads — the same helper the N3 forward
//! fixpoint uses for `{...} => {...}` conclusions.
//!
//! Execution is staged one stratum at a time (`super::stratify::stratify`'s
//! output): every rule in a stratum is run to a local fixpoint (repeated
//! passes until no pass adds an unseen fact, or `options.max_iterations` is
//! reached) before moving to the next stratum. Because closed (negated, or
//! `run_once`-sourced) dependencies always point to a strictly earlier
//! stratum, a `NOT`/`NOT DATA` clause evaluated in a later stratum always
//! sees a fully-resolved view of whatever it negates — this is what makes
//! the ordinary (not semi-naive) re-evaluate-every-pass loop below safe for
//! negation, at the cost of re-discovering already-known solutions each
//! pass (a known, documented performance simplification, not a
//! correctness one).

use std::collections::{BTreeMap, HashSet};

use crate::ast::Triple;
use crate::error::Result;
use crate::reasoner::{instantiate_triple, Bindings, CompletionStatus, FactIndex, ReasonerOptions, ReasonerResult, ReasonerStatistics};

use super::ast::{SparqlRlProgram, SparqlRlRule};
use super::eval::{solve_body, solve_body_scoped, BodyCtx, Graph};
use super::expr::EvalCtx;
use super::stratify::stratify;

/// Run a parsed SPARQL 1.2 RL program forward to a fixpoint.
///
/// `base_graph` is the immutable base graph (e.g. from `--data`); `WHERE
/// DATA`/`NOT DATA` clauses read only this graph. `program.data` (the
/// rule set's own `DATA { ... }` facts) seeds the inference graph instead,
/// matching SPARQL 1.2 RL's two-graph model (see `super::eval::BodyCtx`).
pub fn reason(program: &SparqlRlProgram, base_graph: &[Triple], options: &ReasonerOptions) -> Result<ReasonerResult> {
    let layers = stratify(&program.rules)?;

    let base_index = build_index(base_graph);

    let mut inference_facts: Vec<Triple> = program.data.clone();
    let mut seen: HashSet<Triple> = inference_facts.iter().cloned().collect();
    let explicit_seen = seen.clone();
    let mut fired_once: HashSet<usize> = HashSet::new();
    let eval_ctx = EvalCtx::new();
    let mut statistics = ReasonerStatistics::default();
    let mut status = CompletionStatus::Complete;

    'strata: for layer in &layers {
        loop {
            let inference_index = build_index(&inference_facts);
            let base = Graph { facts: base_graph, index: &base_index };
            let inference = Graph { facts: &inference_facts, index: &inference_index };
            let ctx = BodyCtx::new(inference, base, &eval_ctx);

            let mut new_facts: Vec<Triple> = Vec::new();
            for &rule_idx in layer {
                let rule = &program.rules[rule_idx];
                if rule.run_once && fired_once.contains(&rule_idx) {
                    continue;
                }
                let fired = fire_rule(rule, &ctx, &mut seen, &mut new_facts);
                if rule.run_once && fired {
                    fired_once.insert(rule_idx);
                }
            }

            statistics.iterations += 1;
            if new_facts.is_empty() {
                break;
            }
            inference_facts.extend(new_facts);
            if statistics.iterations >= options.max_iterations {
                status = CompletionStatus::Incomplete;
                break 'strata;
            }
        }
    }

    let derived: Vec<Triple> = inference_facts.iter().filter(|t| !explicit_seen.contains(*t)).cloned().collect();

    Ok(ReasonerResult {
        status,
        limits_reached: if status == CompletionStatus::Incomplete { vec![crate::reasoner::ReasonerLimit::Iterations] } else { Vec::new() },
        errors: Vec::new(),
        statistics,
        explicit: program.data.clone(),
        explicit_sources: BTreeMap::new(),
        derived,
        closure: inference_facts,
        proofs: Vec::new(),
        rules: Vec::new(),
    })
}

/// Evaluate one rule's body once against the current graphs, materializing
/// its head for every solution found (or only the first, for a `run_once`
/// rule). Returns whether the rule fired at least once this call.
fn fire_rule(rule: &SparqlRlRule, ctx: &BodyCtx, seen: &mut HashSet<Triple>, new_facts: &mut Vec<Triple>) -> bool {
    let mut fired = false;
    let mut materialize = |bindings: &Bindings| {
        let mut blank_map = BTreeMap::new();
        for head in &rule.head {
            if let Some(t) = instantiate_triple(head, bindings, &mut blank_map) {
                if seen.insert(t.clone()) {
                    new_facts.push(t);
                }
            }
        }
        fired = true;
        !rule.run_once
    };

    if rule.ground_data {
        solve_body_scoped(&rule.body, Bindings::new(), true, ctx, &mut materialize);
    } else {
        solve_body(&rule.body, Bindings::new(), ctx, &mut materialize);
    }
    fired
}

fn build_index(facts: &[Triple]) -> FactIndex {
    let mut index = FactIndex::default();
    for (i, t) in facts.iter().enumerate() {
        index.insert(i, t);
    }
    index
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::sparql_rl::parser::parse_sparql_rl;

    fn run(src: &str) -> ReasonerResult {
        let program = parse_sparql_rl(src, None).unwrap();
        reason(&program, &[], &ReasonerOptions::default()).unwrap()
    }

    fn iri(s: &str) -> crate::ast::Term {
        crate::ast::Term::iri(format!("http://example/{}", s))
    }

    #[test]
    fn family_example_forward_chains() {
        let result = run(
            "PREFIX : <http://example/>\n\
             DATA {\n  :A :fatherOf :X .\n  :B :motherOf :X .\n  :C :motherOf :A .\n}\n\
             RULE { ?x :childOf ?y } WHERE { ?y :fatherOf ?x }\n\
             RULE { ?x :childOf ?y } WHERE { ?y :motherOf ?x }\n\
             RULE { ?x :descendedFrom ?y } WHERE { ?x :childOf ?y }\n\
             RULE { ?x :descendedFrom ?y } WHERE { ?x :childOf ?z . ?z :descendedFrom ?y }",
        );
        assert!(result.status == crate::reasoner::CompletionStatus::Complete);
        assert!(result.closure.contains(&Triple::new(iri("X"), iri("childOf"), iri("A"))));
        assert!(result.closure.contains(&Triple::new(iri("A"), iri("descendedFrom"), iri("C"))));
        assert!(result.closure.contains(&Triple::new(iri("X"), iri("descendedFrom"), iri("C"))));
    }

    #[test]
    fn filter_prunes_town_population() {
        let result = run(
            "PREFIX : <http://example.com/>\n\
             DATA {\n  :town1 :population 1000 .\n  :town2 :population 2000 .\n}\n\
             RULE { ?x a :largeTown } WHERE { ?x :population ?p . FILTER(?p > 1500) }",
        );
        let large = crate::ast::Term::iri("http://example.com/largeTown");
        let rdf_type = crate::ast::Term::iri(crate::ast::RDF_TYPE);
        assert!(result.closure.contains(&Triple::new(crate::ast::Term::iri("http://example.com/town2"), rdf_type.clone(), large.clone())));
        assert!(!result.closure.contains(&Triple::new(crate::ast::Term::iri("http://example.com/town1"), rdf_type, large)));
    }

    #[test]
    fn stratified_negation_computes_orphans() {
        let result = run(
            "PREFIX : <http://example/>\n\
             DATA {\n  :alice a :Person .\n  :bob a :Person .\n  :alice :childOf :carol .\n}\n\
             RULE { ?x a :Orphan } WHERE { ?x a :Person . NOT { ?x :childOf ?y } }",
        );
        assert!(result.closure.contains(&Triple::new(iri("bob"), crate::ast::Term::iri(crate::ast::RDF_TYPE), iri("Orphan"))));
        assert!(!result.closure.contains(&Triple::new(iri("alice"), crate::ast::Term::iri(crate::ast::RDF_TYPE), iri("Orphan"))));
    }

    #[test]
    fn where_data_reads_base_graph_not_inference_data() {
        let program = parse_sparql_rl(
            "PREFIX : <http://example/>\n\
             DATA {\n  :alice a :Person .\n}\n\
             RULE { ?x a :Known } WHERE DATA { ?x a :Person }",
            None,
        )
        .unwrap();
        // `:alice a :Person` lives in the inference graph (from `DATA{}`),
        // not the base graph, so a `WHERE DATA` rule must not see it.
        let result = reason(&program, &[], &ReasonerOptions::default()).unwrap();
        assert!(!result.closure.iter().any(|t| t.p == crate::ast::Term::iri(crate::ast::RDF_TYPE) && t.o == iri("Known")));

        let base = vec![Triple::new(iri("bob"), crate::ast::Term::iri(crate::ast::RDF_TYPE), iri("Person"))];
        let result_with_base = reason(&program, &base, &ReasonerOptions::default()).unwrap();
        assert!(result_with_base.closure.contains(&Triple::new(iri("bob"), crate::ast::Term::iri(crate::ast::RDF_TYPE), iri("Known"))));
    }

    #[test]
    fn run_once_rule_fires_at_most_once() {
        let result = run(
            "PREFIX : <http://example/>\n\
             DATA {\n  :a :n 1 .\n  :b :n 2 .\n}\n\
             RULE { :counter :value ?n } WHERE { ?x :n ?n . SET(?tag := 1) }",
        );
        let count = result.closure.iter().filter(|t| t.s == iri("counter") && t.p == iri("value")).count();
        assert_eq!(count, 1);
    }
}
