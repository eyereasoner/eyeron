//! Strictly-ordered evaluator for SPARQL 1.2 RL rule bodies.
//!
//! SPARQL-RL's `FILTER`/`SET`/`NOT` clauses require their variables to
//! already be bound by *preceding* clauses in source order (SPARQL
//! evaluation order is sequential; eyeleng enforces and relies on this via
//! `evaluateBodyStream` in `src/engine.js`). eyeron's existing N3 premise
//! matcher (`crate::n3::reasoner::match_premise_remaining`) instead reorders
//! premises by selectivity, which is correct for monotonic Horn-triple
//! matching but would be unsound here. This module is therefore a
//! separate, small, non-reordering backtracking search, implemented as
//! continuation-passing recursion (Rust has no generators) rather than
//! JS's generator-based `evaluateBodyStream`. It calls directly into
//! eyeron's existing `FactIndex`/`match_triple`/`resolve_pattern` for the
//! actual triple lookups, so indexing and unification are fully reused.

use std::cell::Cell;
use std::collections::HashSet;

use crate::ast::{Term, Triple};
use crate::n3::reasoner::{match_triple, resolve_pattern, terms_equal_semantic, Bindings, FactIndex};

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

/// Match `query_body` directly against a fixed set of facts (typically a
/// forward reasoner's completed closure) with no rule recursion — the
/// `--query-mode forward` reading of `--query`: "find everything matching
/// this pattern in the fully-reasoned graph," as opposed to
/// `super::backward::solve_query`'s goal-directed SLD resolution.
pub fn query_facts(facts: &[Triple], base_graph: &[Triple], query_body: &[Clause]) -> Vec<Bindings> {
    let index = build_index(facts);
    let base_index = build_index(base_graph);
    let eval_ctx = EvalCtx::new();
    let ctx = BodyCtx::new(Graph { facts, index: &index }, Graph { facts: base_graph, index: &base_index }, &eval_ctx);
    let mut out = Vec::new();
    solve_body(query_body, Bindings::new(), &ctx, &mut |b| {
        out.push(b.clone());
        true
    });
    out
}

fn build_index(facts: &[Triple]) -> FactIndex {
    let mut index = FactIndex::default();
    for (i, t) in facts.iter().enumerate() {
        index.insert(i, t);
    }
    index
}

/// Like `solve_body`, but for a `WHERE DATA { ... }` rule whose entire body
/// reads the immutable base graph instead of the inference graph.
pub(crate) fn solve_body_scoped(clauses: &[Clause], bindings: Bindings, use_base: bool, ctx: &BodyCtx, on_solution: &mut dyn FnMut(&Bindings) -> bool) -> bool {
    solve_from(clauses, 0, use_base, bindings, ctx, on_solution)
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
            let graph = ctx.graph(use_base);
            let step = |pattern: &Triple, bindings: Bindings, k: &mut dyn FnMut(Bindings) -> bool| -> bool {
                let resolved = Triple::new(
                    resolve_pattern(&pattern.s, &bindings),
                    resolve_pattern(&pattern.p, &bindings),
                    resolve_pattern(&pattern.o, &bindings),
                );
                for fact in graph.index.candidates(graph.facts, &resolved, &bindings) {
                    let mut next = bindings.clone();
                    if match_triple(pattern, fact, &mut next) && !k(next) {
                        return false;
                    }
                }
                true
            };
            let nodes = || graph_nodes(graph.facts);
            let fresh = || ctx.fresh_var();
            let env = PathEnv { step: &step, nodes: &nodes, fresh: &fresh };
            solve_path_clause(s, p, o, bindings, &env, &mut |next| solve_from(clauses, idx + 1, use_base, next, ctx, on_solution))
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

/// How a property path takes one step, and what it may take it over. A
/// path cannot be expanded into a fixed chain of triple patterns once
/// `*`/`+`/`?`/`|` are in the grammar (a chain is a conjunction; those are
/// choice points and fixpoints), so `solve_path` walks the path itself and
/// defers each individual step to `step`. The forward engine matches a
/// step against its graph index; the backward engine proves it as a goal,
/// so rule-derived edges count there too.
#[allow(clippy::type_complexity)]
pub(crate) struct PathEnv<'a> {
    pub(crate) step: &'a dyn Fn(&Triple, Bindings, &mut dyn FnMut(Bindings) -> bool) -> bool,
    /// Every node of the graph being walked, needed only for a zero-length
    /// match (`p?`/`p*`) whose endpoints are both still unbound — SPARQL's
    /// `ZeroLengthPath` relates every node to itself.
    pub(crate) nodes: &'a dyn Fn() -> Vec<Term>,
    pub(crate) fresh: &'a dyn Fn() -> Term,
}

/// Called once per solution of a path, or of one step of one.
pub(crate) type PathSink<'a> = dyn FnMut(Bindings) -> bool + 'a;

/// Solve a whole path clause, reporting each pair of endpoints once
/// however many distinct routes connect them — a path relates two nodes
/// rather than enumerating its own witnesses, so two `|` branches, two
/// routes through a `/` sequence, or a `?` whose zero-length and one-step
/// matches coincide all yield one solution.
pub(crate) fn solve_path_clause(s: &Term, path: &PathExpr, o: &Term, bindings: Bindings, env: &PathEnv, k: &mut PathSink) -> bool {
    let mut seen = HashSet::new();
    solve_path(s, path, o, bindings, env, &mut |b| {
        let pair = (resolve_pattern(s, &b), resolve_pattern(o, &b));
        if seen.insert(pair) {
            k(b)
        } else {
            true
        }
    })
}

/// Solve the property path `s path o` under `bindings`, calling `k` per
/// route found. Intermediate join nodes are never reported, so `k` only
/// ever sees `s`/`o` bound (plus whatever `bindings` already held);
/// `solve_path_clause` is what collapses several routes to one solution.
pub(crate) fn solve_path(s: &Term, path: &PathExpr, o: &Term, bindings: Bindings, env: &PathEnv, k: &mut PathSink) -> bool {
    match path {
        PathExpr::Iri(iri) => (env.step)(&Triple::new(s.clone(), Term::iri(iri.clone()), o.clone()), bindings, k),
        PathExpr::Inverse(inner) => solve_path(o, inner, s, bindings, env, k),
        PathExpr::Sequence(parts) => solve_sequence(parts, s, o, bindings, env, k),
        PathExpr::Alternative(branches) => {
            for branch in branches {
                if !solve_path(s, branch, o, bindings.clone(), env, k) {
                    return false;
                }
            }
            true
        }
        PathExpr::ZeroOrOne(inner) => {
            if !solve_zero_length(s, o, &bindings, env, k) {
                return false;
            }
            solve_path(s, inner, o, bindings.clone(), env, k)
        }
        PathExpr::OneOrMore(inner) => solve_closure(s, inner, o, false, bindings, env, k),
        PathExpr::ZeroOrMore(inner) => solve_closure(s, inner, o, true, bindings, env, k),
    }
}

fn solve_sequence(parts: &[PathExpr], s: &Term, o: &Term, bindings: Bindings, env: &PathEnv, k: &mut PathSink) -> bool {
    match parts {
        [] => match unify_terms(s, o, &bindings) {
            Some(next) => k(next),
            None => true,
        },
        [only] => solve_path(s, only, o, bindings, env, k),
        [first, rest @ ..] => {
            let mid = (env.fresh)();
            solve_path(s, first, &mid, bindings, env, &mut |b| solve_sequence(rest, &mid, o, b, env, k))
        }
    }
}

fn solve_zero_length(s: &Term, o: &Term, bindings: &Bindings, env: &PathEnv, k: &mut PathSink) -> bool {
    if is_open(s, bindings) && is_open(o, bindings) {
        for node in (env.nodes)() {
            let Some(next) = unify_terms(s, &node, bindings).and_then(|b| unify_terms(o, &node, &b)) else {
                continue;
            };
            if !k(next) {
                return false;
            }
        }
        return true;
    }
    match unify_terms(s, o, bindings) {
        Some(next) => k(next),
        None => true,
    }
}

/// `p+` (and, with `include_zero`, `p*`): walk the transitive closure of
/// `inner` from whichever endpoint is already bound, tracking visited
/// nodes so a cyclic graph terminates and each reachable node is reported
/// exactly once.
fn solve_closure(s: &Term, inner: &PathExpr, o: &Term, include_zero: bool, bindings: Bindings, env: &PathEnv, k: &mut PathSink) -> bool {
    if !is_open(s, &bindings) {
        let start = resolve_pattern(s, &bindings);
        return emit_reachable(&start, inner, o, Walk { include_zero, reverse: false }, &bindings, env, k);
    }
    if !is_open(o, &bindings) {
        let start = resolve_pattern(o, &bindings);
        return emit_reachable(&start, inner, s, Walk { include_zero, reverse: true }, &bindings, env, k);
    }

    // Both endpoints open. Every node with an outgoing step can start a
    // `p+` match; `p*` additionally matches every node to itself, so it
    // has to consider every node in the graph as a start.
    let mut starts = Vec::new();
    let mut seen = HashSet::new();
    if include_zero {
        for node in (env.nodes)() {
            if seen.insert(node.clone()) {
                starts.push(node);
            }
        }
    } else {
        let from = (env.fresh)();
        let to = (env.fresh)();
        solve_path(&from, inner, &to, bindings.clone(), env, &mut |b| {
            let node = resolve_pattern(&from, &b);
            if !matches!(node, Term::Var(_)) && seen.insert(node.clone()) {
                starts.push(node);
            }
            true
        });
    }

    for start in starts {
        let Some(base) = unify_terms(s, &start, &bindings) else {
            continue;
        };
        if !emit_reachable(&start, inner, o, Walk { include_zero, reverse: false }, &base, env, k) {
            return false;
        }
    }
    true
}

/// Breadth-first walk of `inner` from the ground node `start` (backwards
/// when `reverse`), binding `target` to each node reached.
/// Which way `emit_reachable` walks, and whether the node it starts from
/// counts as reached without taking a step (`p*` rather than `p+`).
#[derive(Clone, Copy)]
struct Walk {
    include_zero: bool,
    reverse: bool,
}

fn emit_reachable(start: &Term, inner: &PathExpr, target: &Term, walk: Walk, bindings: &Bindings, env: &PathEnv, k: &mut PathSink) -> bool {
    let Walk { include_zero, reverse } = walk;
    // `reported` keeps each reachable node to one solution; `expanded`
    // makes the walk terminate on a cyclic graph. They are separate sets
    // because `start` is expanded from the outset but is only *reported*
    // when a cycle leads back to it (or, for `p*`, by the zero-length
    // match) — `:a :next+ :a` does hold when `:a` sits on a cycle.
    let mut reported: HashSet<Term> = HashSet::new();
    let mut expanded: HashSet<Term> = HashSet::new();
    let mut reached: Vec<Term> = Vec::new();
    if include_zero {
        reported.insert(start.clone());
        reached.push(start.clone());
    }
    let mut frontier = vec![start.clone()];

    while let Some(node) = frontier.pop() {
        if !expanded.insert(node.clone()) {
            continue;
        }
        let next = (env.fresh)();
        let (from, to) = if reverse { (&next, &node) } else { (&node, &next) };
        let mut found = Vec::new();
        solve_path(from, inner, to, bindings.clone(), env, &mut |b| {
            let value = resolve_pattern(&next, &b);
            if !matches!(value, Term::Var(_)) {
                found.push(value);
            }
            true
        });
        for value in found {
            if reported.insert(value.clone()) {
                reached.push(value.clone());
            }
            frontier.push(value);
        }
    }

    for value in reached {
        let Some(next) = unify_terms(target, &value, bindings) else {
            continue;
        };
        if !k(next) {
            return false;
        }
    }
    true
}

fn is_open(term: &Term, bindings: &Bindings) -> bool {
    matches!(resolve_pattern(term, bindings), Term::Var(_))
}

/// Bind whichever side is still an unbound variable to the other, or check
/// equality when both are already fixed.
fn unify_terms(a: &Term, b: &Term, bindings: &Bindings) -> Option<Bindings> {
    let left = resolve_pattern(a, bindings);
    let right = resolve_pattern(b, bindings);
    match (&left, &right) {
        (Term::Var(x), Term::Var(y)) if x == y => Some(bindings.clone()),
        (Term::Var(x), _) => {
            let mut next = bindings.clone();
            next.insert(x.clone(), right);
            Some(next)
        }
        (_, Term::Var(y)) => {
            let mut next = bindings.clone();
            next.insert(y.clone(), left);
            Some(next)
        }
        _ if terms_equal_semantic(&left, &right) => Some(bindings.clone()),
        _ => None,
    }
}

/// Every distinct subject and object of `facts`, in first-seen order.
pub(crate) fn graph_nodes<'t>(facts: impl IntoIterator<Item = &'t Triple>) -> Vec<Term> {
    let mut seen = HashSet::new();
    let mut out = Vec::new();
    for fact in facts {
        for term in [&fact.s, &fact.o] {
            if seen.insert(term.clone()) {
                out.push(term.clone());
            }
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::srl::parser::parse_sparql_rl;
    use std::collections::{BTreeMap, BTreeSet};

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
            Triple::new(iri("town1"), iri("population"), crate::n3::reasoner::numeric_literal(1000.0, true)),
            Triple::new(iri("town2"), iri("population"), crate::n3::reasoner::numeric_literal(2000.0, true)),
        ];
        let sols = solutions("{ ?x :population ?p . FILTER(?p > 1500) }", &facts);
        assert_eq!(sols.len(), 1);
        assert_eq!(sols[0].get("x"), Some(&iri("town2")));
    }

    #[test]
    fn set_binds_and_checks_equality() {
        let facts = vec![Triple::new(iri("x"), iri("n"), crate::n3::reasoner::numeric_literal(3.0, true))];
        let sols = solutions("{ ?x :n ?n . SET(?y := ?n * 2) }", &facts);
        assert_eq!(sols.len(), 1);
        assert_eq!(sols[0].get("y"), Some(&crate::n3::reasoner::numeric_literal(6.0, true)));
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

    /// `:a -> :b -> :c -> :a` plus the spur `:c -> :d` on another predicate.
    fn cyclic_chain() -> Vec<Triple> {
        vec![
            Triple::new(iri("a"), iri("next"), iri("b")),
            Triple::new(iri("b"), iri("next"), iri("c")),
            Triple::new(iri("c"), iri("next"), iri("a")),
            Triple::new(iri("c"), iri("alt"), iri("d")),
        ]
    }

    fn pairs(sols: &[Bindings], from: &str, to: &str) -> BTreeSet<(Term, Term)> {
        sols.iter().map(|b| (b.get(from).unwrap().clone(), b.get(to).unwrap().clone())).collect()
    }

    #[test]
    fn one_or_more_path_walks_the_transitive_closure() {
        let facts = vec![
            Triple::new(iri("a"), iri("next"), iri("b")),
            Triple::new(iri("b"), iri("next"), iri("c")),
        ];
        let sols = solutions("{ ?x :next+ ?y }", &facts);
        assert_eq!(
            pairs(&sols, "x", "y"),
            BTreeSet::from([(iri("a"), iri("b")), (iri("a"), iri("c")), (iri("b"), iri("c"))])
        );
    }

    #[test]
    fn one_or_more_path_terminates_on_a_cycle_and_reports_the_start() {
        // Every node of a 3-cycle reaches every node, itself included.
        let sols = solutions("{ ?x :next+ ?y }", &cyclic_chain());
        let nodes = [iri("a"), iri("b"), iri("c")];
        let expected: BTreeSet<(Term, Term)> =
            nodes.iter().flat_map(|x| nodes.iter().map(move |y| (x.clone(), y.clone()))).collect();
        assert_eq!(pairs(&sols, "x", "y"), expected);
    }

    #[test]
    fn zero_or_more_path_adds_every_node_to_itself_once() {
        let sols = solutions("{ :a :next* ?y }", &cyclic_chain());
        let reached: Vec<&Term> = sols.iter().map(|b| b.get("y").unwrap()).collect();
        assert_eq!(reached.len(), 3, "each reachable node is reported once: {reached:?}");
        assert_eq!(reached.iter().copied().cloned().collect::<BTreeSet<_>>(), BTreeSet::from([iri("a"), iri("b"), iri("c")]));
    }

    #[test]
    fn zero_or_one_path_matches_the_node_itself_and_one_step() {
        let facts = vec![Triple::new(iri("a"), iri("next"), iri("b"))];
        let sols = solutions("{ :a :next? ?y }", &facts);
        assert_eq!(sols.iter().map(|b| b.get("y").unwrap().clone()).collect::<BTreeSet<_>>(), BTreeSet::from([iri("a"), iri("b")]));
    }

    #[test]
    fn alternative_path_takes_either_branch_without_duplicates() {
        let facts = vec![
            Triple::new(iri("a"), iri("next"), iri("b")),
            Triple::new(iri("a"), iri("alt"), iri("b")),
            Triple::new(iri("a"), iri("alt"), iri("c")),
        ];
        let sols = solutions("{ :a :next|:alt ?y }", &facts);
        assert_eq!(sols.len(), 2, "the doubly-connected :b is reported once: {sols:?}");
        assert_eq!(sols.iter().map(|b| b.get("y").unwrap().clone()).collect::<BTreeSet<_>>(), BTreeSet::from([iri("b"), iri("c")]));
    }

    #[test]
    fn grouped_alternative_under_a_closure() {
        let sols = solutions("{ :a (:next|:alt)+ ?y }", &cyclic_chain());
        assert_eq!(
            sols.iter().map(|b| b.get("y").unwrap().clone()).collect::<BTreeSet<_>>(),
            BTreeSet::from([iri("a"), iri("b"), iri("c"), iri("d")])
        );
    }

    #[test]
    fn closure_with_a_bound_target_walks_backwards() {
        let facts = vec![
            Triple::new(iri("a"), iri("next"), iri("b")),
            Triple::new(iri("b"), iri("next"), iri("c")),
            Triple::new(iri("x"), iri("next"), iri("y")),
        ];
        let sols = solutions("{ ?x :next+ :c }", &facts);
        assert_eq!(sols.iter().map(|b| b.get("x").unwrap().clone()).collect::<BTreeSet<_>>(), BTreeSet::from([iri("a"), iri("b")]));
    }

    #[test]
    fn closure_between_two_bound_endpoints_is_a_reachability_test() {
        let facts = vec![
            Triple::new(iri("a"), iri("next"), iri("b")),
            Triple::new(iri("b"), iri("next"), iri("c")),
        ];
        assert_eq!(solutions("{ :a :next+ :c }", &facts).len(), 1);
        assert!(solutions("{ :c :next+ :a }", &facts).is_empty());
    }

    #[test]
    fn a_pair_joined_by_two_routes_is_reported_once() {
        // :a reaches :d through both :b and :c.
        let facts = vec![
            Triple::new(iri("a"), iri("next"), iri("b")),
            Triple::new(iri("a"), iri("next"), iri("c")),
            Triple::new(iri("b"), iri("next"), iri("d")),
            Triple::new(iri("c"), iri("next"), iri("d")),
        ];
        assert_eq!(solutions("{ :a :next/:next ?y }", &facts).len(), 1);
        assert_eq!(solutions("{ :a :next/:next :d }", &facts).len(), 1);
        assert_eq!(solutions("{ :a :next+ :d }", &facts).len(), 1);
    }

    #[test]
    fn path_does_not_leak_its_intermediate_join_nodes() {
        let facts = vec![
            Triple::new(iri("a"), iri("next"), iri("b")),
            Triple::new(iri("b"), iri("next"), iri("c")),
        ];
        let sols = solutions("{ :a :next+ ?y }", &facts);
        assert!(sols.iter().all(|b| b.keys().eq(["y"].iter())), "only the endpoint is reported: {sols:?}");
    }

    #[test]
    fn not_data_reads_base_graph_only() {
        let program = parse_sparql_rl("PREFIX : <http://example/>\nRULE {} WHERE { ?x :type :Person . NOT DATA { ?x :blocked true } }", None).unwrap();
        let body = &program.rules[0].body;
        let inference_facts = vec![Triple::new(iri("alice"), iri("type"), iri("Person")), Triple::new(iri("alice"), iri("blocked"), crate::n3::parser::boolean_literal(true))];
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
