//! Strictly-ordered evaluator for SPARQL 1.2 RL rule bodies.
//!
//! SPARQL-RL's `FILTER`/`SET`/`NOT` clauses require their variables to
//! already be bound by *preceding* clauses in source order (SPARQL
//! evaluation order is sequential; eyeleng enforces and relies on this via
//! `evaluateBodyStream` in `src/engine.js`). eyeron's existing N3 premise
//! matcher (`crate::reasoner::match_premise_remaining`) instead reorders
//! premises by selectivity, which is correct for monotonic Horn-triple
//! matching but would be unsound here. This module is therefore a
//! separate, small, non-reordering backtracking search, implemented as
//! continuation-passing recursion (Rust has no generators) rather than
//! JS's generator-based `evaluateBodyStream`. It calls directly into
//! eyeron's existing `FactIndex`/`match_triple`/`resolve_pattern` for the
//! actual triple lookups, so indexing and unification are fully reused.

use std::cell::Cell;

use crate::ast::{Term, Triple};
use crate::reasoner::{match_triple, resolve_pattern, terms_equal_semantic, Bindings, FactIndex};

use super::ast::{Clause, PathExpr};
use super::expr::{boolean_value, eval_expr, EvalCtx};

/// A queryable graph: a fact slice plus its selectivity index, matching the
/// (facts, FactIndex) pairing eyeron's own reasoner threads through
/// `candidates`/`match_triple`.
pub(crate) struct Graph<'a> {
    pub(crate) facts: &'a [Triple],
    pub(crate) index: &'a FactIndex,
}

/// Evaluation context for one body search: the inference graph (grows with
/// `DATA { ... }` facts and prior derivations), the immutable base graph
/// (`--data` input; `WHERE DATA`/`NOT DATA` clauses read this instead), and
/// the expression evaluator's per-run context (fixed `NOW()`, fresh
/// blank/UUID counters).
pub(crate) struct BodyCtx<'a> {
    pub(crate) inference: Graph<'a>,
    pub(crate) base: Graph<'a>,
    pub(crate) eval_ctx: &'a EvalCtx,
    fresh_path_var: Cell<usize>,
}

impl<'a> BodyCtx<'a> {
    pub(crate) fn new(inference: Graph<'a>, base: Graph<'a>, eval_ctx: &'a EvalCtx) -> Self {
        Self { inference, base, eval_ctx, fresh_path_var: Cell::new(0) }
    }

    fn graph(&self, use_base: bool) -> &Graph<'a> {
        if use_base {
            &self.base
        } else {
            &self.inference
        }
    }

    fn fresh_var(&self) -> Term {
        let n = self.fresh_path_var.get() + 1;
        self.fresh_path_var.set(n);
        Term::var(format!("__path{}", n))
    }
}

/// Run `clauses` against `ctx`, calling `on_solution` for every complete
/// binding found, left to right, with backtracking. `on_solution` returns
/// `true` to keep searching for further solutions, `false` to stop early
/// (used by `NOT`/`NOT DATA`, which only need to know whether *any*
/// solution exists).
pub(crate) fn solve_body(clauses: &[Clause], bindings: Bindings, ctx: &BodyCtx, on_solution: &mut dyn FnMut(&Bindings) -> bool) -> bool {
    solve_from(clauses, 0, false, bindings, ctx, on_solution)
}

/// True iff `clauses` has at least one solution under `bindings` (SPARQL-RL
/// negation as failure: `NOT { ... }` / `NOT DATA { ... }`).
fn has_any_solution(clauses: &[Clause], bindings: Bindings, use_base: bool, ctx: &BodyCtx) -> bool {
    let mut found = false;
    solve_from(clauses, 0, use_base, bindings, ctx, &mut |_| {
        found = true;
        false
    });
    found
}

fn solve_from(clauses: &[Clause], idx: usize, use_base: bool, bindings: Bindings, ctx: &BodyCtx, on_solution: &mut dyn FnMut(&Bindings) -> bool) -> bool {
    let Some(clause) = clauses.get(idx) else {
        return on_solution(&bindings);
    };

    match clause {
        Clause::Triple(pattern) => solve_triple(pattern, clauses, idx, use_base, bindings, ctx, on_solution),
        Clause::Path { s, p, o } => {
            let expanded = expand_path(s, p, o, &mut || ctx.fresh_var());
            let mut combined: Vec<Clause> = expanded.into_iter().map(Clause::Triple).collect();
            combined.extend(clauses[idx + 1..].iter().cloned());
            solve_from(&combined, 0, use_base, bindings, ctx, on_solution)
        }
        Clause::Filter(expr) => match eval_expr(expr, &bindings, ctx.eval_ctx) {
            Ok(v) if boolean_value(&v) => solve_from(clauses, idx + 1, use_base, bindings, ctx, on_solution),
            _ => true,
        },
        Clause::Set { var, expr } => match eval_expr(expr, &bindings, ctx.eval_ctx) {
            Ok(value) => {
                let mut next = bindings.clone();
                match next.get(var) {
                    Some(existing) if !terms_equal_semantic(existing, &value) => true,
                    Some(_) => solve_from(clauses, idx + 1, use_base, next, ctx, on_solution),
                    None => {
                        next.insert(var.clone(), value);
                        solve_from(clauses, idx + 1, use_base, next, ctx, on_solution)
                    }
                }
            }
            Err(_) => true,
        },
        Clause::Not { body, ground_data } => {
            if has_any_solution(body, bindings.clone(), *ground_data || use_base, ctx) {
                true
            } else {
                solve_from(clauses, idx + 1, use_base, bindings, ctx, on_solution)
            }
        }
    }
}

fn solve_triple(pattern: &Triple, clauses: &[Clause], idx: usize, use_base: bool, bindings: Bindings, ctx: &BodyCtx, on_solution: &mut dyn FnMut(&Bindings) -> bool) -> bool {
    let graph = ctx.graph(use_base);
    let resolved = Triple::new(
        resolve_pattern(&pattern.s, &bindings),
        resolve_pattern(&pattern.p, &bindings),
        resolve_pattern(&pattern.o, &bindings),
    );
    for fact in graph.index.candidates(graph.facts, &resolved, &bindings) {
        let mut next = bindings.clone();
        if match_triple(pattern, fact, &mut next) && !solve_from(clauses, idx + 1, use_base, next, ctx, on_solution) {
            return false;
        }
    }
    true
}

/// Expand a property path between `s` and `o` into an equivalent chain of
/// ordinary triple patterns, introducing fresh intermediate variables for
/// each join point. SRL's current path grammar is restricted to sequence
/// (`/`) and inverse (`^`) — no Kleene star/plus/alternation — so this
/// expansion has no choice points of its own; all backtracking still
/// happens at the leaf triple matches via `solve_triple`.
fn expand_path(s: &Term, path: &PathExpr, o: &Term, fresh: &mut dyn FnMut() -> Term) -> Vec<Triple> {
    match path {
        PathExpr::Iri(iri) => vec![Triple::new(s.clone(), Term::iri(iri.clone()), o.clone())],
        PathExpr::Inverse(inner) => expand_path(o, inner, s, fresh),
        PathExpr::Sequence(parts) => {
            let mut triples = Vec::new();
            let mut current = s.clone();
            for (i, part) in parts.iter().enumerate() {
                let next = if i + 1 == parts.len() { o.clone() } else { fresh() };
                triples.extend(expand_path(&current, part, &next, fresh));
                current = next;
            }
            triples
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::sparql_rl::parser::parse_sparql_rl;
    use std::collections::BTreeMap;

    fn index_of(facts: &[Triple]) -> FactIndex {
        let mut index = FactIndex::default();
        for (i, t) in facts.iter().enumerate() {
            index.insert(i, t);
        }
        index
    }

    fn solutions(body_src: &str, facts: &[Triple]) -> Vec<Bindings> {
        let program = parse_sparql_rl(&format!("PREFIX : <http://example/>\nRULE {{}} WHERE {}", body_src), None).unwrap();
        let body = &program.rules[0].body;
        let index = index_of(facts);
        let empty: Vec<Triple> = Vec::new();
        let empty_index = FactIndex::default();
        let eval_ctx = EvalCtx::new();
        let ctx = BodyCtx::new(Graph { facts, index: &index }, Graph { facts: &empty, index: &empty_index }, &eval_ctx);
        let mut out = Vec::new();
        solve_body(body, BTreeMap::new(), &ctx, &mut |b| {
            out.push(b.clone());
            true
        });
        out
    }

    fn iri(s: &str) -> Term {
        Term::iri(format!("http://example/{}", s))
    }

    #[test]
    fn conjunction_of_triples() {
        let facts = vec![
            Triple::new(iri("a"), iri("parentOf"), iri("b")),
            Triple::new(iri("b"), iri("parentOf"), iri("c")),
        ];
        let sols = solutions("{ ?x :parentOf ?y . ?y :parentOf ?z }", &facts);
        assert_eq!(sols.len(), 1);
        assert_eq!(sols[0].get("x"), Some(&iri("a")));
        assert_eq!(sols[0].get("z"), Some(&iri("c")));
    }

    #[test]
    fn filter_restricts_solutions() {
        let facts = vec![
            Triple::new(iri("town1"), iri("population"), crate::reasoner::numeric_literal(1000.0, true)),
            Triple::new(iri("town2"), iri("population"), crate::reasoner::numeric_literal(2000.0, true)),
        ];
        let sols = solutions("{ ?x :population ?p . FILTER(?p > 1500) }", &facts);
        assert_eq!(sols.len(), 1);
        assert_eq!(sols[0].get("x"), Some(&iri("town2")));
    }

    #[test]
    fn set_binds_and_checks_equality() {
        let facts = vec![Triple::new(iri("x"), iri("n"), crate::reasoner::numeric_literal(3.0, true))];
        let sols = solutions("{ ?x :n ?n . SET(?y := ?n * 2) }", &facts);
        assert_eq!(sols.len(), 1);
        assert_eq!(sols[0].get("y"), Some(&crate::reasoner::numeric_literal(6.0, true)));
    }

    #[test]
    fn not_excludes_matching_solutions() {
        let facts = vec![
            Triple::new(iri("alice"), iri("type"), iri("Person")),
            Triple::new(iri("bob"), iri("type"), iri("Person")),
            Triple::new(iri("alice"), iri("childOf"), iri("carol")),
        ];
        let sols = solutions("{ ?x :type :Person . NOT { ?x :childOf ?y } }", &facts);
        assert_eq!(sols.len(), 1);
        assert_eq!(sols[0].get("x"), Some(&iri("bob")));
    }

    #[test]
    fn sequence_path_matches_transitively() {
        let facts = vec![
            Triple::new(iri("a"), iri("parentOf"), iri("b")),
            Triple::new(iri("b"), iri("parentOf"), iri("c")),
        ];
        let sols = solutions("{ ?x :parentOf/:parentOf ?z }", &facts);
        assert_eq!(sols.len(), 1);
        assert_eq!(sols[0].get("x"), Some(&iri("a")));
        assert_eq!(sols[0].get("z"), Some(&iri("c")));
    }

    #[test]
    fn inverse_path_flips_direction() {
        let facts = vec![Triple::new(iri("a"), iri("parentOf"), iri("b"))];
        let sols = solutions("{ ?x ^:parentOf ?y }", &facts);
        assert_eq!(sols.len(), 1);
        assert_eq!(sols[0].get("x"), Some(&iri("b")));
        assert_eq!(sols[0].get("y"), Some(&iri("a")));
    }

    #[test]
    fn not_data_reads_base_graph_only() {
        let program = parse_sparql_rl("PREFIX : <http://example/>\nRULE {} WHERE { ?x :type :Person . NOT DATA { ?x :blocked true } }", None).unwrap();
        let body = &program.rules[0].body;
        let inference_facts = vec![Triple::new(iri("alice"), iri("type"), iri("Person")), Triple::new(iri("alice"), iri("blocked"), crate::parser::boolean_literal(true))];
        let base_facts: Vec<Triple> = Vec::new();
        let inference_index = index_of(&inference_facts);
        let base_index = FactIndex::default();
        let eval_ctx = EvalCtx::new();
        let ctx = BodyCtx::new(
            Graph { facts: &inference_facts, index: &inference_index },
            Graph { facts: &base_facts, index: &base_index },
            &eval_ctx,
        );
        // `:alice :blocked true` lives only in the inference graph; `NOT
        // DATA` only ever consults the (empty) base graph here, so it must
        // still succeed even though an inference-graph fact would have
        // made an ordinary (non-DATA) `NOT` fail.
        let mut out = Vec::new();
        solve_body(body, BTreeMap::new(), &ctx, &mut |b| {
            out.push(b.clone());
            true
        });
        assert_eq!(out.len(), 1);
    }
}
