//! Backward, goal-directed query evaluation for SPARQL 1.2 RL rule sets.
//!
//! This mirrors `crate::n3::reasoner::solve_backward_goal`'s core ideas —
//! standardizing a candidate rule apart (renaming its variables so two
//! concurrent applications of the same rule cannot collide), a
//! depth-bounded recursive search, and a stack-based cycle guard — but
//! implements them independently rather than reusing that function
//! directly, since it is written against `crate::ast::Rule`'s flat
//! `Vec<Triple>` premise and its selectivity-reordering join, neither of
//! which fit `SparqlRlRule`'s ordered `Vec<Clause>` body (see
//! `super::eval`'s module doc for why order matters here). Instead, this
//! module extends `super::eval`'s own clause dispatch: proving a `Triple`
//! subgoal tries known facts first (exactly as forward evaluation does),
//! then — new for backward mode — tries unifying the goal against every
//! rule head that could produce it, recursing into that rule's body.
//! `FILTER`/`SET`/`NOT`/`Path` clauses are handled the same way forward
//! evaluation handles them, via the same ordering rules.
//!
//! Unlike forward reasoning, backward evaluation never runs rules to
//! materialize a closure; it proves one query directly against the
//! rule set's own `DATA { ... }` facts (and the immutable base graph for
//! `WHERE DATA`/`NOT DATA` subgoals), the classical SLD-resolution
//! reading of a Datalog/Prolog-style program.

use std::collections::{BTreeMap, HashSet};

use crate::ast::{Term, Triple};
use crate::n3::reasoner::{match_triple, resolve_pattern, unify_term, Bindings, FactIndex};

use super::ast::{Clause, SparqlRlProgram, SparqlRlRule};
use super::eval::{graph_nodes, solve_path_clause, PathEnv};
use super::expr::{boolean_value, eval_expr, EvalCtx};

#[derive(Debug, Clone)]
pub struct BackwardOptions {
    /// Maximum recursive rule-application depth (mirrors
    /// `ReasonerOptions::max_backward_depth`).
    pub max_depth: usize,
    /// Stop collecting once this many solutions have been found.
    pub max_solutions: usize,
}

impl Default for BackwardOptions {
    fn default() -> Self {
        Self { max_depth: 32, max_solutions: 10_000 }
    }
}

struct BackwardCtx<'a> {
    program: &'a SparqlRlProgram,
    base_graph: &'a [Triple],
    base_index: FactIndex,
    data_index: FactIndex,
    eval_ctx: EvalCtx,
    options: BackwardOptions,
    scope_counter: std::cell::Cell<usize>,
}

impl<'a> BackwardCtx<'a> {
    fn graph(&self, use_base: bool) -> (&'a [Triple], &FactIndex) {
        if use_base {
            (self.base_graph, &self.base_index)
        } else {
            (self.program.data.as_slice(), &self.data_index)
        }
    }

    fn next_scope(&self) -> usize {
        let n = self.scope_counter.get() + 1;
        self.scope_counter.set(n);
        n
    }
}

/// Solve `query_body` (an ordinary SRL rule body, parsed the same way a
/// rule's `WHERE { ... }` is — see `super::parser::parse_query_body`)
/// against `program`/`base_graph`, returning every solution found (up to
/// `options.max_solutions`).
pub fn solve_query(program: &SparqlRlProgram, base_graph: &[Triple], query_body: &[Clause], options: BackwardOptions) -> Vec<Bindings> {
    let ctx = BackwardCtx {
        program,
        base_graph,
        base_index: build_index(base_graph),
        data_index: build_index(&program.data),
        eval_ctx: EvalCtx::new(),
        options,
        scope_counter: std::cell::Cell::new(0),
    };
    let query_vars = query_body_variables(query_body);
    let mut solutions = Vec::new();
    let stack = Stack::new(HashSet::new());
    solve_clauses(query_body, 0, false, Bindings::new(), &ctx, 0, &stack, &mut |bindings| {
        solutions.push(canonicalize(bindings, &query_vars));
        solutions.len() < ctx.options.max_solutions
    });
    solutions
}

/// Fully resolve every binding's value (chasing variable-to-variable
/// chains introduced when a caller's variable unifies with a *renamed*
/// rule-head variable rather than a ground term directly, matching
/// `crate::reasoner`'s own `canonicalize_bindings`), then keep only the
/// entries for variables the caller's own query text mentions — proving a
/// goal via a rule introduces bindings for that rule's *own* (uniquely
/// renamed) variables too, which are internal and would otherwise leak
/// into the reported solution.
fn canonicalize(bindings: &Bindings, query_vars: &HashSet<String>) -> Bindings {
    bindings.iter().filter(|(k, _)| query_vars.contains(*k)).map(|(k, v)| (k.clone(), resolve_pattern(v, bindings))).collect()
}

fn query_body_variables(clauses: &[Clause]) -> HashSet<String> {
    let mut out = std::collections::BTreeSet::new();
    for clause in clauses {
        match clause {
            Clause::Triple(t) => {
                super::ast::term_variables(&t.s, &mut out);
                super::ast::term_variables(&t.p, &mut out);
                super::ast::term_variables(&t.o, &mut out);
            }
            Clause::Path { s, o, .. } => {
                super::ast::term_variables(s, &mut out);
                super::ast::term_variables(o, &mut out);
            }
            Clause::Filter(expr) => super::ast::expr_variables(expr, &mut out),
            Clause::Set { var, expr } => {
                out.insert(var.clone());
                super::ast::expr_variables(expr, &mut out);
            }
            Clause::Not { body, .. } => out.extend(query_body_variables(body)),
        }
    }
    out.into_iter().collect()
}

fn build_index(facts: &[Triple]) -> FactIndex {
    let mut index = FactIndex::default();
    for (i, t) in facts.iter().enumerate() {
        index.insert(i, t);
    }
    index
}

/// Cycle guard for rule-goal recursion, keyed by resolved goal. Shared via
/// `RefCell` (rather than threaded as `&mut`) because the CPS-style search
/// below needs simultaneous access to it both directly and from inside a
/// continuation closure — a standard pattern for backtracking search
/// written this way in Rust, and safe here because access is always
/// sequential, never concurrent.
type Stack = std::cell::RefCell<HashSet<String>>;
type OnSolution<'a> = dyn FnMut(&Bindings) -> bool + 'a;

#[allow(clippy::too_many_arguments)]
fn solve_clauses(clauses: &[Clause], idx: usize, use_base: bool, bindings: Bindings, ctx: &BackwardCtx, depth: usize, stack: &Stack, on_solution: &mut OnSolution) -> bool {
    let Some(clause) = clauses.get(idx) else {
        return on_solution(&bindings);
    };

    match clause {
        Clause::Triple(pattern) => solve_triple_goal(pattern, clauses, idx, use_base, bindings, ctx, depth, stack, on_solution),
        Clause::Path { s, p, o } => {
            // Each step is proved as an ordinary goal, so a path may run
            // over rule-derived edges as well as stored facts.
            let step = |pattern: &Triple, bindings: Bindings, k: &mut dyn FnMut(Bindings) -> bool| -> bool {
                let goal = [Clause::Triple(pattern.clone())];
                solve_clauses(&goal, 0, use_base, bindings, ctx, depth, stack, &mut |solution| k(solution.clone()))
            };
            let nodes = || {
                let (facts, _) = ctx.graph(use_base);
                graph_nodes(facts.iter().chain(ctx.program.data.iter()))
            };
            let fresh = || Term::var(format!("__bwpath{}", ctx.next_scope()));
            let env = PathEnv { step: &step, nodes: &nodes, fresh: &fresh };
            solve_path_clause(s, p, o, bindings, &env, &mut |next| {
                solve_clauses(clauses, idx + 1, use_base, next, ctx, depth, stack, on_solution)
            })
        }
        Clause::Filter(expr) => match eval_expr(expr, &bindings, &ctx.eval_ctx) {
            Ok(v) if boolean_value(&v) => solve_clauses(clauses, idx + 1, use_base, bindings, ctx, depth, stack, on_solution),
            _ => true,
        },
        Clause::Set { var, expr } => match eval_expr(expr, &bindings, &ctx.eval_ctx) {
            Ok(value) => {
                let mut next = bindings.clone();
                match next.get(var) {
                    Some(existing) if !crate::n3::reasoner::terms_equal_semantic(existing, &value) => true,
                    Some(_) => solve_clauses(clauses, idx + 1, use_base, next, ctx, depth, stack, on_solution),
                    None => {
                        next.insert(var.clone(), value);
                        solve_clauses(clauses, idx + 1, use_base, next, ctx, depth, stack, on_solution)
                    }
                }
            }
            Err(_) => true,
        },
        Clause::Not { body, ground_data } => {
            let negated_use_base = *ground_data || use_base;
            let mut found = false;
            let inner_stack = Stack::new(stack.borrow().clone());
            solve_clauses(body, 0, negated_use_base, bindings.clone(), ctx, depth, &inner_stack, &mut |_| {
                found = true;
                false
            });
            if found {
                true
            } else {
                solve_clauses(clauses, idx + 1, use_base, bindings, ctx, depth, stack, on_solution)
            }
        }
    }
}

#[allow(clippy::too_many_arguments)]
fn solve_triple_goal(pattern: &Triple, clauses: &[Clause], idx: usize, use_base: bool, bindings: Bindings, ctx: &BackwardCtx, depth: usize, stack: &Stack, on_solution: &mut OnSolution) -> bool {
    let (facts, index) = ctx.graph(use_base);
    let resolved = Triple::new(resolve_pattern(&pattern.s, &bindings), resolve_pattern(&pattern.p, &bindings), resolve_pattern(&pattern.o, &bindings));

    for fact in index.candidates(facts, &resolved, &bindings) {
        let mut next = bindings.clone();
        if match_triple(pattern, fact, &mut next) && !solve_clauses(clauses, idx + 1, use_base, next, ctx, depth, stack, on_solution) {
            return false;
        }
    }

    // `WHERE DATA`/`NOT DATA` subgoals read the immutable base graph only —
    // no rule head can ever write to it (SPARQL 1.2 RL Sec 4.3), so there is
    // nothing further to try there.
    if use_base || depth >= ctx.options.max_depth {
        return true;
    }

    let goal_key = format!("{:?}", resolved);
    if !stack.borrow_mut().insert(goal_key.clone()) {
        // Already proving this exact goal higher up the call stack: a
        // recursive rule dependency. Stop this branch rather than looping
        // forever; other branches (and the forward reasoner, for programs
        // that need full materialization) are unaffected.
        return true;
    }

    let mut keep_going = true;
    for (rule_idx, rule) in ctx.program.rules.iter().enumerate() {
        if !head_may_prove(rule, &resolved) {
            continue;
        }
        let scope = format!("__bw_{}_{}_{}_", depth, rule_idx, ctx.next_scope());
        let renamed = standardize_apart(rule, &scope);
        for head in &renamed.head {
            let mut extended = bindings.clone();
            if !unify_triple_terms(pattern, head, &mut extended) {
                continue;
            }
            let still_going = solve_clauses(&renamed.body, 0, renamed.ground_data, extended, ctx, depth + 1, stack, &mut |sub_bindings| {
                solve_clauses(clauses, idx + 1, use_base, sub_bindings.clone(), ctx, depth, stack, on_solution)
            });
            if !still_going {
                keep_going = false;
                break;
            }
        }
        if !keep_going {
            break;
        }
    }
    stack.borrow_mut().remove(&goal_key);
    keep_going
}

/// Cheap pre-filter: skip rules whose head predicate cannot possibly equal
/// the goal's predicate, mirroring `crate::n3::reasoner::rule_may_prove_goal`.
fn head_may_prove(rule: &SparqlRlRule, goal: &Triple) -> bool {
    let Term::Iri(goal_predicate) = &goal.p else { return true };
    rule.head.iter().any(|head| match &head.p {
        Term::Iri(head_predicate) => head_predicate == goal_predicate,
        Term::Var(_) => true,
        _ => false,
    })
}

fn unify_triple_terms(a: &Triple, b: &Triple, bindings: &mut Bindings) -> bool {
    unify_term(&a.s, &b.s, bindings) && unify_term(&a.p, &b.p, bindings) && unify_term(&a.o, &b.o, bindings)
}

/// Rename every variable (and, since SRL rule bodies never contain a blank
/// node — parsing turns `_:x` in a body into a fresh body-scoped variable
/// already — every head blank node, treated here as a fresh existential
/// per rule application) with a unique prefix, so two concurrent
/// applications of the same rule cannot collide.
fn standardize_apart(rule: &SparqlRlRule, prefix: &str) -> SparqlRlRule {
    let mut blank_renames: BTreeMap<String, String> = BTreeMap::new();
    SparqlRlRule {
        name: rule.name.clone(),
        head: rule.head.iter().map(|t| rename_triple(t, prefix, &mut blank_renames)).collect(),
        body: rule.body.iter().map(|c| rename_clause(c, prefix, &mut blank_renames)).collect(),
        ground_data: rule.ground_data,
        run_once: rule.run_once,
        source: rule.source.clone(),
    }
}

fn rename_clause(clause: &Clause, prefix: &str, blanks: &mut BTreeMap<String, String>) -> Clause {
    match clause {
        Clause::Triple(t) => Clause::Triple(rename_triple(t, prefix, blanks)),
        // `PathExpr` holds only literal predicate IRIs, never variables, so
        // it needs no renaming.
        Clause::Path { s, p, o } => Clause::Path { s: rename_term(s, prefix, blanks), p: p.clone(), o: rename_term(o, prefix, blanks) },
        Clause::Filter(expr) => Clause::Filter(rename_expr(expr, prefix, blanks)),
        Clause::Set { var, expr } => Clause::Set { var: format!("{}{}", prefix, var), expr: rename_expr(expr, prefix, blanks) },
        Clause::Not { body, ground_data } => Clause::Not { body: body.iter().map(|c| rename_clause(c, prefix, blanks)).collect(), ground_data: *ground_data },
    }
}

fn rename_expr(expr: &super::ast::Expr, prefix: &str, blanks: &mut BTreeMap<String, String>) -> super::ast::Expr {
    use super::ast::Expr;
    match expr {
        Expr::Var(name) => Expr::Var(format!("{}{}", prefix, name)),
        Expr::Term(term) => Expr::Term(rename_term(term, prefix, blanks)),
        Expr::Unary { op, expr } => Expr::Unary { op: *op, expr: Box::new(rename_expr(expr, prefix, blanks)) },
        Expr::Binary { op, left, right } => Expr::Binary { op: *op, left: Box::new(rename_expr(left, prefix, blanks)), right: Box::new(rename_expr(right, prefix, blanks)) },
        Expr::Call { name, args } => Expr::Call { name: name.clone(), args: args.iter().map(|a| rename_expr(a, prefix, blanks)).collect() },
        Expr::List(items) => Expr::List(items.iter().map(|i| rename_expr(i, prefix, blanks)).collect()),
    }
}

fn rename_triple(t: &Triple, prefix: &str, blanks: &mut BTreeMap<String, String>) -> Triple {
    Triple::new(rename_term(&t.s, prefix, blanks), rename_term(&t.p, prefix, blanks), rename_term(&t.o, prefix, blanks))
}

fn rename_term(term: &Term, prefix: &str, blanks: &mut BTreeMap<String, String>) -> Term {
    match term {
        Term::Var(name) => Term::Var(format!("{}{}", prefix, name)),
        Term::Blank(label) => {
            let renamed = blanks.entry(label.clone()).or_insert_with(|| format!("{}{}", prefix, label)).clone();
            Term::Var(renamed)
        }
        Term::List(items) => Term::List(items.iter().map(|i| rename_term(i, prefix, blanks)).collect()),
        Term::Formula(triples) => Term::Formula(triples.iter().map(|t| rename_triple(t, prefix, blanks)).collect()),
        other => other.clone(),
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::srl::parser::{parse_query_body, parse_sparql_rl};

    fn program_of(src: &str) -> SparqlRlProgram {
        parse_sparql_rl(src, None).unwrap()
    }

    fn iri(s: &str) -> Term {
        Term::iri(format!("http://example/{}", s))
    }

    #[test]
    fn proves_a_fact_directly() {
        let program = program_of("PREFIX : <http://example/>\nDATA { :a :p :b . }");
        let (body, _) = parse_query_body("{ :a :p ?x }", None, &program.prefixes).unwrap();
        let solutions = solve_query(&program, &[], &body, BackwardOptions::default());
        assert_eq!(solutions.len(), 1);
        assert_eq!(solutions[0].get("x"), Some(&iri("b")));
    }

    #[test]
    fn proves_a_goal_via_a_rule_recursively() {
        let program = program_of(
            "PREFIX : <http://example/>\n\
             DATA {\n  :a :parentOf :b .\n  :b :parentOf :c .\n}\n\
             RULE { ?x :ancestorOf ?y } WHERE { ?x :parentOf ?y }\n\
             RULE { ?x :ancestorOf ?y } WHERE { ?x :parentOf ?z . ?z :ancestorOf ?y }",
        );
        let (body, _) = parse_query_body("{ :a :ancestorOf ?who }", None, &program.prefixes).unwrap();
        let mut solutions = solve_query(&program, &[], &body, BackwardOptions::default());
        solutions.sort_by_key(|b| format!("{:?}", b.get("who")));
        let who: Vec<Term> = solutions.iter().map(|b| b.get("who").unwrap().clone()).collect();
        assert_eq!(who, vec![iri("b"), iri("c")]);
        // Regression: proving `?who` via the second (recursive) rule
        // introduces that rule's own renamed variables (`?x`, `?y`, `?z`)
        // into the bindings map internally; only the query's own `?who`
        // should ever be reported back to the caller.
        for solution in &solutions {
            assert_eq!(solution.keys().collect::<Vec<_>>(), vec!["who"], "{:?}", solution);
        }
    }

    #[test]
    fn respects_not_during_backward_proof() {
        let program = program_of(
            "PREFIX : <http://example/>\n\
             DATA {\n  :alice a :Person .\n  :bob a :Person .\n  :alice :childOf :carol .\n}\n\
             RULE { ?x a :Orphan } WHERE { ?x a :Person . NOT { ?x :childOf ?y } }",
        );
        let (body, _) = parse_query_body("{ ?x a :Orphan }", None, &program.prefixes).unwrap();
        let solutions = solve_query(&program, &[], &body, BackwardOptions::default());
        assert_eq!(solutions.len(), 1);
        assert_eq!(solutions[0].get("x"), Some(&iri("bob")));
    }

    #[test]
    fn recursive_cycle_terminates() {
        let program = program_of(
            "PREFIX : <http://example/>\n\
             RULE { ?x :loop ?y } WHERE { ?y :loop ?x }",
        );
        let (body, _) = parse_query_body("{ :a :loop ?x }", None, &program.prefixes).unwrap();
        // Must terminate (the cycle guard stops re-entering the same goal)
        // rather than hang; a genuinely unfounded goal simply has no
        // solutions.
        let solutions = solve_query(&program, &[], &body, BackwardOptions::default());
        assert!(solutions.is_empty());
    }
}
