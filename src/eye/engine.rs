//! The tabled (memoized) evaluator, mirroring `engine.js`.
//!
//! This is a demand-driven fixpoint, not plain backward SLD search: each
//! distinct call gets a memo table; evaluating a table tries each matching
//! clause, joins its body left to right, and newly-found answers wake up
//! (re-enqueue) subscribing tables. `not`/`collect` each run a fresh,
//! independent, nested evaluation over the whole program for their one
//! sub-query — simple and correct, not performance-optimal, matching the
//! JS reference's own stated design.
//!
//! Rust has no generators, and — unlike `crate::srl::eval` — this
//! algorithm has no early-exit shortcut to build continuation-passing
//! search around (`not` always runs its nested query to completion; there
//! is no equivalent of "stop at the first solution"). So instead of a
//! `&mut dyn FnMut(...) -> bool` callback style, every search function
//! here just returns a `Vec` of its solutions eagerly. The one piece of
//! genuinely shared, cross-call mutable state (step/table/answer counters,
//! the growing proof list, the negation-completion cache, and the global
//! variable counter) lives behind `RefCell`s reached through the `Ctx`
//! handle below, so that handle can be freely copied into nested calls
//! without fighting the borrow checker over a `&mut Engine`.

use std::cell::RefCell;
use std::collections::{BTreeMap, HashMap};

use crate::error::{EyeronError, Result};

use super::analyze::{self, Analyzed};
use super::ast::{Expr, Goal, Rule};
use super::builtins;
use super::term::{self, ground, instantiate, term_key, unify, variables_in, Bindings, Term, VarCounter};

#[derive(Debug, Clone, Copy)]
pub struct Limits {
    pub max_steps: u64,
    pub max_tables: u64,
    pub max_answers: u64,
}

impl Default for Limits {
    fn default() -> Self {
        Self { max_steps: 1_000_000, max_tables: 100_000, max_answers: 100_000 }
    }
}

#[derive(Debug, Clone, Copy)]
pub struct Stats {
    pub steps: u64,
    pub tables: u64,
    pub answers: u64,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum RuleTag {
    Query,
    Rule(usize),
}

#[derive(Debug, Clone)]
pub enum Premise {
    Answer { proof: usize, call_term: Term },
    Builtin { call_term: Term },
    Not { call_term: Term },
    Collect { value_term: Term, template: Term, body: Vec<Goal>, proofs: Vec<usize> },
    Let { value_term: Term, expr: Expr },
    Compare { op: String, left_term: Term, right_term: Term },
}

#[derive(Debug, Clone)]
pub struct ProofEntry {
    pub id: usize,
    pub conclusion_term: Term,
    pub rule: RuleTag,
    pub rule_head: Option<Term>,
    pub rule_body: Option<Vec<Goal>>,
    pub substitution: Vec<(String, Term)>,
    pub premises: Vec<Premise>,
}

#[derive(Debug, Clone)]
pub struct AnswerEntry {
    pub term: Term,
    pub proof: usize,
}

struct Shared {
    limits: Limits,
    steps: u64,
    tables: u64,
    answers: u64,
    proofs: Vec<ProofEntry>,
    completed: HashMap<String, bool>,
    counter: VarCounter,
}

/// Holds every counter/cache/proof list that is shared across one whole
/// `run`/`check` invocation, including every nested `not`/`collect`
/// sub-evaluation spawned along the way (mirrors `createContext` in
/// `engine.js`).
pub struct RunContext(RefCell<Shared>);

impl RunContext {
    pub fn new(limits: Limits) -> Self {
        Self(RefCell::new(Shared { limits, steps: 0, tables: 0, answers: 0, proofs: Vec::new(), completed: HashMap::new(), counter: VarCounter::new() }))
    }

    pub fn stats(&self) -> Stats {
        let s = self.0.borrow();
        Stats { steps: s.steps, tables: s.tables, answers: s.answers }
    }

    pub fn into_proofs(self) -> Vec<ProofEntry> {
        self.0.into_inner().proofs
    }
}

fn limit_error(which: &str) -> EyeronError {
    EyeronError::new(format!("Evaluation incomplete: {} limit reached", which))
}

type TableId = usize;

struct Table {
    call: Term,
    answers: Vec<(String, AnswerEntry)>,
    subscribers: Vec<TableId>,
    queued: bool,
}

struct Arena {
    tables: Vec<Table>,
    index: HashMap<String, TableId>,
    queue: Vec<TableId>,
    cursor: usize,
    root_head: Term,
    root_body: Vec<Goal>,
}

/// A cheap, `Copy` handle to the two pieces of state one `solve()` call (and
/// everything it recurses into) needs: the cross-call `Shared` counters and
/// this call's own local table arena. Being `Copy`, it can be captured by
/// value wherever needed with no borrow-checker aliasing concerns.
#[derive(Clone, Copy)]
struct Ctx<'a> {
    shared: &'a RefCell<Shared>,
    arena: &'a RefCell<Arena>,
}

fn tick(ctx: Ctx) -> Result<()> {
    let mut s = ctx.shared.borrow_mut();
    s.steps += 1;
    if s.steps > s.limits.max_steps {
        return Err(limit_error("steps"));
    }
    Ok(())
}

fn enqueue(arena: &mut Arena, id: TableId) {
    if !arena.tables[id].queued {
        arena.tables[id].queued = true;
        arena.queue.push(id);
    }
}

fn get_or_create_table(ctx: Ctx, call: &Term) -> Result<TableId> {
    let key = term_key(call);
    if let Some(&id) = ctx.arena.borrow().index.get(&key) {
        return Ok(id);
    }
    let fresh_call = {
        let mut s = ctx.shared.borrow_mut();
        s.tables += 1;
        if s.tables > s.limits.max_tables {
            return Err(limit_error("tables"));
        }
        let mut vars = BTreeMap::new();
        term::fresh(call, &mut vars, &mut s.counter)
    };
    let mut arena = ctx.arena.borrow_mut();
    let id = arena.tables.len();
    arena.tables.push(Table { call: fresh_call, answers: Vec::new(), subscribers: Vec::new(), queued: false });
    arena.index.insert(key, id);
    enqueue(&mut arena, id);
    Ok(id)
}

fn fresh_expr(expr: &Expr, vars: &mut BTreeMap<u64, Term>, counter: &mut VarCounter) -> Expr {
    match expr {
        Expr::Value(t) => Expr::Value(term::fresh(t, vars, counter)),
        Expr::Unary { arg } => Expr::Unary { arg: Box::new(fresh_expr(arg, vars, counter)) },
        Expr::Binary { op, left, right } => {
            Expr::Binary { op: op.clone(), left: Box::new(fresh_expr(left, vars, counter)), right: Box::new(fresh_expr(right, vars, counter)) }
        }
        Expr::Function { name, args } => Expr::Function { name: name.clone(), args: args.iter().map(|a| fresh_expr(a, vars, counter)).collect() },
    }
}

fn fresh_goals(body: &[Goal], vars: &mut BTreeMap<u64, Term>, counter: &mut VarCounter) -> Vec<Goal> {
    body.iter()
        .map(|g| match g {
            Goal::Call(t) => Goal::Call(term::fresh(t, vars, counter)),
            Goal::Not(t) => Goal::Not(term::fresh(t, vars, counter)),
            Goal::Compare { op, left, right } => Goal::Compare { op: op.clone(), left: term::fresh(left, vars, counter), right: term::fresh(right, vars, counter) },
            Goal::Let { target, expr } => Goal::Let { target: term::fresh(target, vars, counter), expr: fresh_expr(expr, vars, counter) },
            Goal::Collect { target, template, body } => Goal::Collect {
                target: term::fresh(target, vars, counter),
                template: term::fresh(template, vars, counter),
                body: fresh_goals(body, vars, counter),
            },
        })
        .collect()
}

fn bind_expr(expr: &Expr, env: &Bindings) -> Expr {
    match expr {
        Expr::Value(t) => Expr::Value(instantiate(t, env)),
        Expr::Unary { arg } => Expr::Unary { arg: Box::new(bind_expr(arg, env)) },
        Expr::Binary { op, left, right } => Expr::Binary { op: op.clone(), left: Box::new(bind_expr(left, env)), right: Box::new(bind_expr(right, env)) },
        Expr::Function { name, args } => Expr::Function { name: name.clone(), args: args.iter().map(|a| bind_expr(a, env)).collect() },
    }
}

fn bind_goals(body: &[Goal], env: &Bindings) -> Vec<Goal> {
    body.iter()
        .map(|g| match g {
            Goal::Call(t) => Goal::Call(instantiate(t, env)),
            Goal::Not(t) => Goal::Not(instantiate(t, env)),
            Goal::Compare { op, left, right } => Goal::Compare { op: op.clone(), left: instantiate(left, env), right: instantiate(right, env) },
            Goal::Let { target, expr } => Goal::Let { target: instantiate(target, env), expr: bind_expr(expr, env) },
            Goal::Collect { target, template, body } => {
                Goal::Collect { target: instantiate(target, env), template: instantiate(template, env), body: bind_goals(body, env) }
            }
        })
        .collect()
}

fn bind_premise(premise: Premise, env: &Bindings) -> Premise {
    match premise {
        Premise::Answer { proof, call_term } => Premise::Answer { proof, call_term: instantiate(&call_term, env) },
        Premise::Builtin { call_term } => Premise::Builtin { call_term: instantiate(&call_term, env) },
        Premise::Not { call_term } => Premise::Not { call_term: instantiate(&call_term, env) },
        Premise::Collect { value_term, template, body, proofs } => {
            Premise::Collect { value_term: instantiate(&value_term, env), template: instantiate(&template, env), body: bind_goals(&body, env), proofs }
        }
        Premise::Let { value_term, expr } => Premise::Let { value_term: instantiate(&value_term, env), expr: bind_expr(&expr, env) },
        Premise::Compare { op, left_term, right_term } => {
            Premise::Compare { op, left_term: instantiate(&left_term, env), right_term: instantiate(&right_term, env) }
        }
    }
}

fn step(ctx: Ctx, program: &Analyzed, goal: &Goal, env: &Bindings, owner: TableId) -> Result<Vec<(Bindings, Premise)>> {
    match goal {
        Goal::Call(goal_term) => {
            let call = instantiate(goal_term, env);
            let signature = analyze::signature(&call);
            if builtins::is_builtin_relation(&signature) {
                let branches = builtins::call_builtin(&call, env, &mut || tick(ctx))?;
                return Ok(branches.into_iter().map(|b| (b, Premise::Builtin { call_term: goal_term.clone() })).collect());
            }
            let dependency = get_or_create_table(ctx, &call)?;
            {
                let mut arena = ctx.arena.borrow_mut();
                if !arena.tables[dependency].subscribers.contains(&owner) {
                    arena.tables[dependency].subscribers.push(owner);
                }
            }
            let snapshot: Vec<AnswerEntry> = {
                let arena = ctx.arena.borrow();
                arena.tables[dependency].answers.iter().map(|(_, e)| AnswerEntry { term: e.term.clone(), proof: e.proof }).collect()
            };
            let mut out = Vec::new();
            for answer in snapshot {
                tick(ctx)?;
                let fresh_answer = {
                    let mut s = ctx.shared.borrow_mut();
                    let mut vars = BTreeMap::new();
                    term::fresh(&answer.term, &mut vars, &mut s.counter)
                };
                let mut branch = env.clone();
                if unify(goal_term, &fresh_answer, &mut branch) {
                    out.push((branch, Premise::Answer { proof: answer.proof, call_term: goal_term.clone() }));
                }
            }
            Ok(out)
        }
        Goal::Not(term) => {
            let call = builtins::require_ground(instantiate(term, env), "not")?;
            let key = term_key(&call);
            let cached = ctx.shared.borrow().completed.get(&key).copied();
            let has_answer = match cached {
                Some(v) => v,
                None => {
                    let answers = solve(program, vec![Goal::Call(call.clone())], Vec::new(), ctx.shared)?;
                    let v = !answers.is_empty();
                    ctx.shared.borrow_mut().completed.insert(key, v);
                    v
                }
            };
            if has_answer {
                Ok(Vec::new())
            } else {
                Ok(vec![(env.clone(), Premise::Not { call_term: call })])
            }
        }
        Goal::Compare { op, left, right } => {
            let mut branch = env.clone();
            if builtins::compare(op, left, right, &mut branch)? {
                Ok(vec![(branch, Premise::Compare { op: op.clone(), left_term: left.clone(), right_term: right.clone() })])
            } else {
                Ok(Vec::new())
            }
        }
        Goal::Let { target, expr } => {
            let value = builtins::evaluate(expr, env)?;
            let mut branch = env.clone();
            if unify(target, &value, &mut branch) {
                Ok(vec![(branch, Premise::Let { value_term: value, expr: expr.clone() })])
            } else {
                Ok(Vec::new())
            }
        }
        Goal::Collect { target, template, body } => {
            let bound_body = bind_goals(body, env);
            let bound_template = instantiate(template, env);
            let (fresh_body, fresh_template) = {
                let mut s = ctx.shared.borrow_mut();
                let mut locals = BTreeMap::new();
                let fresh_body = fresh_goals(&bound_body, &mut locals, &mut s.counter);
                let fresh_template = term::fresh(&bound_template, &mut locals, &mut s.counter);
                (fresh_body, fresh_template)
            };
            let answers = solve(program, fresh_body.clone(), vec![fresh_template.clone()], ctx.shared)?;
            let mut unique: BTreeMap<String, Term> = BTreeMap::new();
            let mut proofs = Vec::new();
            for answer in &answers {
                let value = match &answer.term {
                    Term::Struct(_, args) => args[0].clone(),
                    _ => unreachable!(),
                };
                if !ground(&value) {
                    return Err(EyeronError::new("collect template must be ground in every answer"));
                }
                unique.entry(term_key(&value)).or_insert_with(|| value.clone());
                proofs.push(answer.proof);
            }
            let values: Vec<Term> = unique.into_values().collect();
            let list_term = term::list(values);
            let mut branch = env.clone();
            if unify(target, &list_term, &mut branch) {
                Ok(vec![(branch, Premise::Collect { value_term: list_term, template: fresh_template, body: fresh_body, proofs })])
            } else {
                Ok(Vec::new())
            }
        }
    }
}

/// Explores `body` from `index` onward, calling `on_solution` for each
/// complete solution *as soon as it is found* — not after the whole body
/// has been exhaustively searched. This matters beyond performance: it
/// mirrors JS's generator-based `join`/`evaluateTable` (`for (const
/// solution of this.join(...))` records each yielded solution immediately,
/// including allocating its proof id, before resuming the search for the
/// next one), so that proof-id allocation order matches the reference
/// implementation's rather than batching every solution before recording
/// any of them.
#[allow(clippy::too_many_arguments)]
fn join(
    ctx: Ctx,
    program: &Analyzed,
    body: &[Goal],
    env: Bindings,
    premises: Vec<Premise>,
    owner: TableId,
    index: usize,
    on_solution: &mut dyn FnMut(Bindings, Vec<Premise>) -> Result<()>,
) -> Result<()> {
    tick(ctx)?;
    if index == body.len() {
        return on_solution(env, premises);
    }
    let branches = step(ctx, program, &body[index], &env, owner)?;
    for (next_env, premise) in branches {
        let mut next_premises = premises.clone();
        next_premises.push(premise);
        join(ctx, program, body, next_env, next_premises, owner, index + 1, on_solution)?;
    }
    Ok(())
}

#[allow(clippy::too_many_arguments)]
fn record_answer(
    ctx: Ctx,
    table_id: TableId,
    call: &Term,
    tag: RuleTag,
    rule_head: &Term,
    rule_body: &[Goal],
    variables: &BTreeMap<u64, Term>,
    solution_env: &Bindings,
    premises: Vec<Premise>,
) -> Result<()> {
    let answer = instantiate(call, solution_env);
    let key = term_key(&answer);
    let already = ctx.arena.borrow().tables[table_id].answers.iter().any(|(k, _)| k == &key);
    if already {
        return Ok(());
    }
    let proof_id = {
        let mut s = ctx.shared.borrow_mut();
        s.answers += 1;
        if s.answers > s.limits.max_answers {
            return Err(limit_error("answers"));
        }
        s.proofs.len() + 1
    };
    let substitution_vars: Vec<Term> = match tag {
        RuleTag::Rule(_) => variables.values().cloned().collect(),
        RuleTag::Query => {
            let mut head_vars = Vec::new();
            variables_in(rule_head, &mut head_vars);
            head_vars.into_iter().filter_map(|(old_id, _)| variables.get(&old_id).cloned()).collect()
        }
    };
    let substitution: Vec<(String, Term)> = substitution_vars
        .into_iter()
        .filter(|v| !matches!(v, Term::Var(_, name) if name == "_"))
        .map(|v| {
            let name = match &v {
                Term::Var(_, n) => n.clone(),
                _ => unreachable!(),
            };
            (name, instantiate(&v, solution_env))
        })
        .collect();
    let proof = ProofEntry {
        id: proof_id,
        conclusion_term: answer.clone(),
        rule: tag,
        rule_head: matches!(tag, RuleTag::Rule(_)).then(|| rule_head.clone()),
        rule_body: matches!(tag, RuleTag::Rule(_)).then(|| rule_body.to_vec()),
        substitution,
        premises: premises.into_iter().map(|p| bind_premise(p, solution_env)).collect(),
    };
    let subscribers = {
        let mut arena = ctx.arena.borrow_mut();
        arena.tables[table_id].answers.push((key, AnswerEntry { term: answer, proof: proof_id }));
        arena.tables[table_id].subscribers.clone()
    };
    {
        let mut s = ctx.shared.borrow_mut();
        s.proofs.push(proof);
    }
    {
        let mut arena = ctx.arena.borrow_mut();
        for subscriber in subscribers {
            enqueue(&mut arena, subscriber);
        }
    }
    Ok(())
}

fn try_rule(ctx: Ctx, program: &Analyzed, table_id: TableId, call: &Term, rule_head: &Term, rule_body: &[Goal], tag: RuleTag) -> Result<()> {
    tick(ctx)?;
    let mut variables = BTreeMap::new();
    let (head, body) = {
        let mut s = ctx.shared.borrow_mut();
        let head = term::fresh(rule_head, &mut variables, &mut s.counter);
        let body = fresh_goals(rule_body, &mut variables, &mut s.counter);
        (head, body)
    };
    let mut env = Bindings::new();
    if !unify(call, &head, &mut env) {
        return Ok(());
    }
    join(ctx, program, &body, env, Vec::new(), table_id, 0, &mut |solution_env, premises| {
        record_answer(ctx, table_id, call, tag, rule_head, rule_body, &variables, &solution_env, premises)
    })
}

fn evaluate_table(ctx: Ctx, program: &Analyzed, table_id: TableId) -> Result<()> {
    let call = ctx.arena.borrow().tables[table_id].call.clone();
    let is_query = matches!(&call, Term::Struct(name, _) if name == "$query");
    if is_query {
        let (root_head, root_body) = {
            let arena = ctx.arena.borrow();
            (arena.root_head.clone(), arena.root_body.clone())
        };
        try_rule(ctx, program, table_id, &call, &root_head, &root_body, RuleTag::Query)?;
    } else {
        let signature = analyze::signature(&call);
        let rules: Vec<Rule> = program.predicates.get(&signature).cloned().unwrap_or_default();
        for rule in &rules {
            try_rule(ctx, program, table_id, &call, &rule.head, &rule.body, RuleTag::Rule(rule.id))?;
        }
    }
    Ok(())
}

/// The one shared entry point for both top-level queries and every nested
/// `not`/`collect` sub-evaluation (mirrors the free function `solve` in
/// `engine.js`). Builds a fresh, local table arena; `shared` (steps/tables/
/// answers counters, the growing proof list, the negation-completion
/// cache, and the variable counter) is reused across every nested call
/// within one `run`/`check` invocation.
fn solve(program: &Analyzed, body: Vec<Goal>, projection: Vec<Term>, shared: &RefCell<Shared>) -> Result<Vec<AnswerEntry>> {
    analyze::check_query(&body, program)?;
    let root_head = term::struct_("$query", projection);
    let arena = RefCell::new(Arena { tables: Vec::new(), index: HashMap::new(), queue: Vec::new(), cursor: 0, root_head: root_head.clone(), root_body: body });
    let ctx = Ctx { shared, arena: &arena };
    let root_id = get_or_create_table(ctx, &root_head)?;
    loop {
        let next = {
            let mut a = ctx.arena.borrow_mut();
            if a.cursor >= a.queue.len() {
                None
            } else {
                let id = a.queue[a.cursor];
                a.cursor += 1;
                a.tables[id].queued = false;
                Some(id)
            }
        };
        match next {
            Some(table_id) => evaluate_table(ctx, program, table_id)?,
            None => break,
        }
    }
    let answers = ctx.arena.borrow().tables[root_id].answers.iter().map(|(_, e)| AnswerEntry { term: e.term.clone(), proof: e.proof }).collect();
    Ok(answers)
}

/// Run a top-level query against `program`, using and extending `run_ctx`'s
/// shared counters/proof list (see `solve` above).
pub fn solve_query(program: &Analyzed, body: Vec<Goal>, projection: Vec<Term>, run_ctx: &RunContext) -> Result<Vec<AnswerEntry>> {
    solve(program, body, projection, &run_ctx.0)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::eye::analyze::analyze;
    use crate::eye::parser::parse;

    fn run_query(source: &str) -> (Vec<AnswerEntry>, Vec<Term>) {
        let mut counter = VarCounter::new();
        let program = parse(source, &mut counter).unwrap();
        let query = program.queries[0].clone();
        let analyzed = analyze(program.rules).unwrap();
        let run_ctx = RunContext::new(Limits::default());
        let answers = solve_query(&analyzed, query.body, query.variables.clone(), &run_ctx).unwrap();
        (answers, query.variables)
    }

    #[test]
    fn recursive_ancestor_query() {
        let (answers, _) = run_query(
            "parent(alice, bob). parent(bob, carol). ancestor(?x, ?y) if parent(?x, ?y). ancestor(?x, ?y) if parent(?x, ?z), ancestor(?z, ?y). ask ancestor(alice, ?who).",
        );
        assert_eq!(answers.len(), 2);
    }

    #[test]
    fn negation_as_failure() {
        let (answers, _) = run_query("person(alice). person(bob). married(alice). single(?x) if person(?x), not married(?x). ask single(?x).");
        assert_eq!(answers.len(), 1);
        match &answers[0].term {
            Term::Struct(_, args) => assert_eq!(args[0], term::atom("bob")),
            _ => panic!(),
        }
    }

    #[test]
    fn collect_builds_a_sorted_deduped_list() {
        let (answers, _) = run_query("likes(alice, apples). likes(bob, apples). likes(alice, pears). ask collect ?xs = ?food where { likes(?_, ?food) }.");
        assert_eq!(answers.len(), 1);
        match &answers[0].term {
            Term::Struct(_, args) => {
                let list = term::array(&args[0]).unwrap();
                assert_eq!(list, vec![term::atom("apples"), term::atom("pears")]);
            }
            _ => panic!(),
        }
    }

    #[test]
    fn builtin_range_enumerates() {
        let (answers, _) = run_query("ask range(1, 3, ?n).");
        assert_eq!(answers.len(), 3);
    }
}
