//! Forward-chaining entry point for SPARQL 1.2 RL rule sets.
//!
//! Ties together the pieces built so far: `super::stratify` computes a safe
//! rule execution order, `super::eval` evaluates each rule's body against
//! the current graphs, and `crate::n3::reasoner::instantiate_triple` reuses
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
//! it safe to skip rules on later passes purely based on whether a body
//! *positive* pattern could match one of the previous pass's new facts
//! (see `RuleActivation` below): a `NOT` clause's truth value can never
//! change within a stratum's own loop, so it never needs to gate retries.
//!
//! Each stratum's first pass always runs every rule in it unconditionally
//! (there is no "previous pass" yet to have activated anything). From the
//! second pass on, only rules whose `RuleActivation` entry says the
//! previous pass's new facts could feed one of their own body patterns are
//! retried — the same "which rule could this new fact possibly help"
//! rule-activation index `crate::n3::reasoner`'s own agenda-based fixpoint
//! already uses for N3, adapted here to whole-rule (not per-premise)
//! granularity because SPARQL-RL bodies are re-solved as a unit rather than
//! incrementally per premise. Combined with maintaining the matching graph
//! (base graph ∪ inference facts) as one persistent, incrementally-indexed
//! `Vec`/`FactIndex` instead of cloning and fully re-indexing it every
//! pass, this turns what was an O(passes × rules) rescan plus an
//! O(passes × facts) reindex — quadratic in the number of rules/facts for
//! a long single-premise rule chain such as `deep-taxonomy-100000.srl` —
//! into work roughly proportional to the number of rule firings and facts
//! actually produced. It is still not full semi-naive evaluation: an
//! activated rule's body is re-solved from scratch against the whole
//! current graph rather than joined incrementally against just the new
//! delta, so a rule with several body patterns that fires on a large,
//! slowly-growing relation can still cost more than strict semi-naive
//! would. That remaining gap is a performance simplification, not a
//! correctness one — already-seen facts are still deduplicated via `seen`
//! before being added to `new_facts`.

use std::collections::{BTreeMap, BTreeSet, HashMap, HashSet};

use crate::ast::{Rule, Term, Triple};
use crate::error::Result;
use crate::n3::reasoner::{
    instantiate_triple, resolve_pattern, Bindings, CompletionStatus, DerivedFact, FactIndex, ReasonerOptions, ReasonerResult, ReasonerStatistics,
};

use super::ast::{SparqlRlProgram, SparqlRlRule};
use super::eval::{solve_body, solve_body_scoped, BodyCtx, Graph};
use super::expr::EvalCtx;
use super::stratify::{rule_positive_patterns, stratify};

/// Run a parsed SPARQL 1.2 RL program forward to a fixpoint.
///
/// `base_graph` is the immutable base graph (e.g. from `--data`). `WHERE
/// DATA`/`NOT DATA` clauses read *only* this graph. Ordinary body clauses
/// read the union of it and the inference graph: rules are meant to
/// reason *over* `--data` input, not merely alongside it, so `WHERE
/// DATA`/`NOT DATA` narrow a clause to the immutable subset rather than
/// excluding the base graph from ordinary matching. That union is purely
/// a *matching* view, though — the base graph's own facts are never added
/// to the inference graph itself. `program.data` (the rule set's own
/// `DATA { ... }` facts) seeds the inference graph, which also grows with
/// rule conclusions; `ReasonerResult::closure` is exactly this inference
/// graph (`program.data` plus everything derived, but never the base
/// graph), matching SPARQL 1.2 RL's two-graph model (see
/// `super::eval::BodyCtx`) and the W3C SPARQL-RL test suite's `mf:result`
/// convention (`src/bin/w3c_sparql_rl.rs` compares against `closure`, not
/// `derived`, for exactly this reason).
pub fn reason(program: &SparqlRlProgram, base_graph: &[Triple], options: &ReasonerOptions) -> Result<ReasonerResult> {
    for (index, rule) in program.rules.iter().enumerate() {
        super::wellformed::check_rule(rule, index)?;
    }
    let layers = stratify(&program.rules)?;
    let activation = RuleActivation::build(&program.rules);

    // Each SparqlRlRule's own positive body patterns (already computed for
    // the activation index above) double as an N3-shaped `Rule.premise` for
    // proof purposes: `crate::n3::proof::proof_to_n3` and `DerivedFact` are
    // format-agnostic over `Triple`/`Bindings`, so SRL reuses them as-is
    // rather than growing its own parallel proof representation. This does
    // not (and structurally cannot) reify a FILTER/NOT/SET clause as a
    // premise triple -- proof_var_source_names is left empty and the trace
    // shows only the positive patterns that fed the rule -- but `pe:by`
    // still points back to the rule's own source line, so the full body
    // (FILTER included) is always one click away in the source file.
    let proof_rules: Vec<Rule> = if options.proof { program.rules.iter().map(build_proof_rule).collect() } else { Vec::new() };
    let mut proofs: Vec<DerivedFact> = Vec::new();

    let base_index = build_index(base_graph);
    let explicit_seen: HashSet<Triple> = program.data.iter().cloned().collect();

    let mut inference_facts: Vec<Triple> = program.data.clone();
    let mut seen: HashSet<Triple> = inference_facts.iter().cloned().chain(base_graph.iter().cloned()).collect();
    let mut fired_once: HashSet<usize> = HashSet::new();
    let eval_ctx = EvalCtx::new();
    let mut statistics = ReasonerStatistics::default();
    let mut status = CompletionStatus::Complete;

    // Ordinary clauses match against the union of the base graph and the
    // inference graph; `WHERE DATA`/`NOT DATA` clauses still route to
    // `base` alone via `BodyCtx`. Unlike the base graph (fixed), this view
    // grows every pass, but it is grown by *inserting* each pass's new
    // facts into a persistent index rather than rebuilding one from
    // scratch, so its maintenance cost is proportional to the number of
    // facts ever added, not to (passes × facts-so-far).
    let mut match_facts: Vec<Triple> = base_graph.to_vec();
    match_facts.extend(inference_facts.iter().cloned());
    let mut match_index = build_index(&match_facts);

    'strata: for layer in &layers {
        let layer_members: HashSet<usize> = layer.iter().copied().collect();
        let always_in_layer: BTreeSet<usize> = activation.always.iter().copied().filter(|idx| layer_members.contains(idx)).collect();
        let mut previous_new_facts: Vec<Triple> = Vec::new();
        let mut first_pass = true;

        loop {
            let base = Graph { facts: base_graph, index: &base_index };
            let inference = Graph { facts: &match_facts, index: &match_index };
            let ctx = BodyCtx::new(inference, base, &eval_ctx);

            let rules_to_try: Vec<usize> = if first_pass {
                layer.clone()
            } else {
                let mut triggered = always_in_layer.clone();
                for fact in &previous_new_facts {
                    activation.triggered_by(fact, &mut triggered);
                }
                triggered.retain(|idx| layer_members.contains(idx));
                triggered.into_iter().collect()
            };

            let mut new_facts: Vec<Triple> = Vec::new();
            for rule_idx in rules_to_try {
                let rule = &program.rules[rule_idx];
                if rule.run_once && fired_once.contains(&rule_idx) {
                    continue;
                }
                let proof_rule = proof_rules.get(rule_idx);
                let fired = fire_rule(rule, proof_rule, &ctx, &mut seen, &mut new_facts, &mut proofs);
                if rule.run_once && fired {
                    fired_once.insert(rule_idx);
                }
            }

            statistics.iterations += 1;
            first_pass = false;
            if new_facts.is_empty() {
                break;
            }
            for fact in &new_facts {
                match_index.insert(match_facts.len(), fact);
                match_facts.push(fact.clone());
            }
            inference_facts.extend(new_facts.iter().cloned());
            previous_new_facts = new_facts;
            if statistics.iterations >= options.max_iterations {
                status = CompletionStatus::Incomplete;
                break 'strata;
            }
        }
    }

    let derived: Vec<Triple> = inference_facts.iter().filter(|t| !explicit_seen.contains(t)).cloned().collect();

    Ok(ReasonerResult {
        status,
        limits_reached: if status == CompletionStatus::Incomplete { vec![crate::n3::reasoner::ReasonerLimit::Iterations] } else { Vec::new() },
        errors: Vec::new(),
        statistics,
        explicit: program.data.clone(),
        explicit_sources: program.data_sources.clone(),
        derived,
        closure: inference_facts,
        proofs,
        rules: proof_rules,
    })
}

/// Indexes each rule's own positive top-level body patterns by shape
/// (ground predicate, plus whichever of subject/object are also ground) so
/// that a newly derived fact can cheaply look up exactly which rules it
/// might newly satisfy, mirroring `crate::n3::reasoner::AgendaIndex` (which
/// solves the same problem per-premise for the N3 forward fixpoint).
#[derive(Default)]
struct RuleActivation {
    /// Rules with a body pattern whose predicate is itself a variable: any
    /// new fact of any shape might satisfy it, so it is always retried.
    always: BTreeSet<usize>,
    by_p: HashMap<Term, BTreeSet<usize>>,
    by_sp: HashMap<(Term, Term), BTreeSet<usize>>,
    by_po: HashMap<(Term, Term), BTreeSet<usize>>,
}

impl RuleActivation {
    fn build(rules: &[SparqlRlRule]) -> Self {
        let mut out = RuleActivation::default();
        for (rule_idx, rule) in rules.iter().enumerate() {
            for pattern in rule_positive_patterns(rule) {
                if !pattern.p.is_ground() {
                    out.always.insert(rule_idx);
                    continue;
                }
                let s_ground = pattern.s.is_ground();
                let o_ground = pattern.o.is_ground();
                if !s_ground && !o_ground {
                    out.by_p.entry(pattern.p.clone()).or_default().insert(rule_idx);
                }
                if s_ground {
                    out.by_sp.entry((pattern.s.clone(), pattern.p.clone())).or_default().insert(rule_idx);
                }
                if o_ground {
                    out.by_po.entry((pattern.p.clone(), pattern.o.clone())).or_default().insert(rule_idx);
                }
            }
        }
        out
    }

    /// Extends `out` with every rule (besides the always-retried set,
    /// tracked separately by the caller) whose body pattern shape matches
    /// `fact`.
    fn triggered_by(&self, fact: &Triple, out: &mut BTreeSet<usize>) {
        if let Some(rules) = self.by_p.get(&fact.p) {
            out.extend(rules.iter().copied());
        }
        if let Some(rules) = self.by_sp.get(&(fact.s.clone(), fact.p.clone())) {
            out.extend(rules.iter().copied());
        }
        if let Some(rules) = self.by_po.get(&(fact.p.clone(), fact.o.clone())) {
            out.extend(rules.iter().copied());
        }
    }
}

/// Evaluate one rule's body once against the current graphs, materializing
/// its head for *every* solution found. `rule.run_once` (SPARQL 1.2 RL
/// §4.4: a `SET`/blank-node-head rule) does not mean "stop after the
/// first solution" — the W3C eval suite's `eval-bnodes-03` expects a
/// two-solution blank-node-head rule to still produce two distinct blank
/// nodes. What "run once" actually governs is the *caller*'s bookkeeping
/// (`forward_once` in `reason`): such a rule's body is evaluated exactly
/// once across the whole run rather than being re-scanned on every
/// fixpoint pass, which is safe because each solution's blank node is
/// already a deterministic function of its bindings
/// (`crate::n3::reasoner::instantiate_triple`), so re-scanning could not have
/// produced any solution this pass missed.
/// Returns whether the rule fired at least once this call. When
/// `proof_rule` is `Some` (i.e. `--proof` was requested), records one
/// `DerivedFact` per genuinely new fact -- not per solution -- matching
/// `reason`'s own doc comment ("alternative derivations of an already
/// known answer need not be retained") and N3's forward fixpoint's own
/// practice of keeping the first derivation found.
fn fire_rule(rule: &SparqlRlRule, proof_rule: Option<&Rule>, ctx: &BodyCtx, seen: &mut HashSet<Triple>, new_facts: &mut Vec<Triple>, proofs: &mut Vec<DerivedFact>) -> bool {
    let mut fired = false;
    let mut materialize = |bindings: &Bindings| {
        let mut blank_map = BTreeMap::new();
        for head in &rule.head {
            if let Some(t) = instantiate_triple(head, bindings, &mut blank_map) {
                if seen.insert(t.clone()) {
                    if let Some(proof_rule) = proof_rule {
                        let premises = proof_rule.premise.iter().map(|p| resolve_premise_triple(p, bindings)).collect();
                        proofs.push(DerivedFact { fact: t.clone(), rule: proof_rule.clone(), premises, bindings: bindings.clone() });
                    }
                    new_facts.push(t);
                }
            }
        }
        fired = true;
        true
    };

    if rule.ground_data {
        solve_body_scoped(&rule.body, Bindings::new(), true, ctx, &mut materialize);
    } else {
        solve_body(&rule.body, Bindings::new(), ctx, &mut materialize);
    }
    fired
}

/// An N3-shaped `Rule` standing in for one `SparqlRlRule`, for
/// `DerivedFact`/`proof_to_n3` purposes (see the comment in `reason`).
fn build_proof_rule(rule: &SparqlRlRule) -> Rule {
    Rule {
        premise: rule_positive_patterns(rule),
        conclusion: rule.head.clone(),
        is_forward: true,
        is_query: false,
        source: rule.source.clone(),
        proof_var_source_names: BTreeMap::new(),
    }
}

fn resolve_premise_triple(pattern: &Triple, bindings: &Bindings) -> Triple {
    Triple::new(resolve_pattern(&pattern.s, bindings), resolve_pattern(&pattern.p, bindings), resolve_pattern(&pattern.o, bindings))
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
    use crate::srl::parser::parse_sparql_rl;

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
        assert!(result.status == crate::n3::reasoner::CompletionStatus::Complete);
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
    fn run_once_rule_still_materializes_every_solution() {
        // "run once" (SPARQL 1.2 RL §4.4) governs how many times the rule's
        // *body* is scanned across the fixpoint (once, not re-scanned every
        // pass), not how many of its solutions get materialized — a
        // two-solution SET/blank-node-head rule still produces two facts.
        // (Regression: an earlier implementation incorrectly stopped after
        // the first solution; the W3C suite's eval-bnodes-03, "two data
        // triples - four blank nodes", is what caught this.)
        let result = run(
            "PREFIX : <http://example/>\n\
             DATA {\n  :a :n 1 .\n  :b :n 2 .\n}\n\
             RULE { :counter :value ?n } WHERE { ?x :n ?n . SET(?tag := 1) }",
        );
        let values: std::collections::BTreeSet<Triple> = result.closure.iter().filter(|t| t.s == iri("counter") && t.p == iri("value")).cloned().collect();
        assert_eq!(values.len(), 2, "{:?}", result.closure);
    }

    #[test]
    fn run_once_rule_with_blank_head_gets_a_distinct_blank_per_solution() {
        let result = run(
            "PREFIX : <http://example/>\n\
             DATA {\n  :s :p :o1 .\n  :s :p :o2 .\n}\n\
             RULE { [] :q \"Rule\" } WHERE { ?s :p ?o }",
        );
        let blanks: std::collections::BTreeSet<&crate::ast::Term> = result.closure.iter().filter(|t| t.p == iri("q")).map(|t| &t.s).collect();
        assert_eq!(blanks.len(), 2, "{:?}", result.closure);
    }
}
