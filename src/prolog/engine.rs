//! The tabled (memoized) evaluator.
//!
//! This is a demand-driven fixpoint, not plain backward SLD search: each
//! distinct call gets a memo table; evaluating a table tries each matching
//! clause, joins its body left to right, and newly-found answers wake up
//! (re-enqueue) subscribing tables. `\+/1` and `findall/3` each run a
//! fresh, independent, nested evaluation over the whole program for their
//! one sub-query — simple and correct, not performance-optimal.
//!
//! Rust has no generators, and — unlike `crate::srl::eval` — this
//! algorithm has no early-exit shortcut to build continuation-passing
//! search around (`\+` always runs its nested query to completion; there
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
use super::ast::{body_term, goals_of};
use super::builtins;
use super::term::{self, instantiate, is_callable, term_key, unify, variables_in, Bindings, Term, VarCounter};

#[derive(Debug, Clone, Copy)]
pub struct Limits {
    pub max_steps: u64,
    pub max_tables: u64,
    pub max_answers: u64,
}

impl Default for Limits {
    fn default() -> Self {
        // High enough that a long backward-chained derivation (e.g.
        // `deep-taxonomy-100000.pl`, which tables one call per taxonomy
        // level: ~1.6M steps, ~200K tables, ~200K answers) can finish
        // without tripping these safety nets, with headroom to spare;
        // each table/step is now O(1) thanks to `analyze::ArgIndex`, so
        // raising these only lengthens how long a genuinely
        // non-terminating program runs before being reported incomplete,
        // not how much work a terminating one does.
        Self { max_steps: 5_000_000, max_tables: 1_000_000, max_answers: 1_000_000 }
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

/// Why one body goal held. Four kinds is all the proof format needs, now
/// that a goal is a term: a built-in premise carries the goal itself, so
/// `3 is 1 + 2` and `1 < 2` explain themselves without a separate
/// calculation or comparison record.
#[derive(Debug, Clone)]
pub enum Premise {
    /// A derived answer of a user predicate, and the proof that found it.
    Answer { proof: usize, call_term: Term },
    /// A built-in goal that succeeded, instantiated.
    Builtin { call_term: Term },
    /// A `\+` goal whose argument completed with no answer.
    Absent { call_term: Term },
    /// A `findall/3` that completed, with the proofs of what it collected.
    Collected { value_term: Term, template: Term, goal: Term, proofs: Vec<usize> },
}

#[derive(Debug, Clone)]
pub struct ProofEntry {
    pub id: usize,
    pub conclusion_term: Term,
    pub rule: RuleTag,
    pub rule_head: Option<Term>,
    pub rule_body: Option<Vec<Term>>,
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
/// `run`/`check` invocation, including every nested `\+`/`findall`
/// sub-evaluation spawned along the way.
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
    root_body: Vec<Term>,
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

fn fresh_goals(body: &[Term], vars: &mut BTreeMap<u64, Term>, counter: &mut VarCounter) -> Vec<Term> {
    body.iter().map(|g| term::fresh(g, vars, counter)).collect()
}

fn bind_premise(premise: Premise, env: &Bindings) -> Premise {
    match premise {
        Premise::Answer { proof, call_term } => Premise::Answer { proof, call_term: instantiate(&call_term, env) },
        Premise::Builtin { call_term } => Premise::Builtin { call_term: instantiate(&call_term, env) },
        Premise::Absent { call_term } => Premise::Absent { call_term: instantiate(&call_term, env) },
        Premise::Collected { value_term, template, goal, proofs } => {
            Premise::Collected { value_term: instantiate(&value_term, env), template: instantiate(&template, env), goal: instantiate(&goal, env), proofs }
        }
    }
}

/// One goal's solutions, each with the premises that explain it. Most
/// goals contribute exactly one premise; `call/1` splices in the premises
/// of whatever it ran, so a proof shows the real steps rather than the
/// wrapper.
type Branches = Vec<(Bindings, Vec<Premise>)>;

fn step(ctx: Ctx, program: &Analyzed, goal_term: &Term, env: &Bindings, owner: TableId) -> Result<Branches> {
    let call = instantiate(goal_term, env);
    if !is_callable(&call) {
        return Err(EyeronError::new(format!("Expected a callable goal; got {}", term::format(&call))));
    }
    let signature = analyze::signature(&call);
    match signature.as_str() {
        // `\+/1`, `call/1`, `findall/3` and `clause/2` each need the
        // program or a nested evaluation, so they are dispatched here
        // rather than in `builtins`, which sees neither.
        "\\+/1" => negation(ctx, program, &call, env),
        "call/1" => meta_call(ctx, program, &call, env, owner),
        "findall/3" => findall(ctx, program, &call, env),
        "clause/2" => clause_answers(ctx, program, goal_term, &call, env),
        _ if builtins::is_builtin_relation(&signature) => {
            let branches = builtins::call_builtin(&call, env, &mut || tick(ctx))?;
            Ok(branches.into_iter().map(|b| (b, vec![Premise::Builtin { call_term: goal_term.clone() }])).collect())
        }
        _ => user_predicate(ctx, goal_term, &call, env, owner),
    }
}

fn user_predicate(ctx: Ctx, goal_term: &Term, call: &Term, env: &Bindings, owner: TableId) -> Result<Branches> {
    let dependency = get_or_create_table(ctx, call)?;
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
            out.push((branch, vec![Premise::Answer { proof: answer.proof, call_term: goal_term.clone() }]));
        }
    }
    Ok(out)
}

/// `\+ Goal` — completed closed-world negation. The argument must be
/// ground, so the absence it reports is the absence of an answer to that
/// one question rather than to some instance of it (§6).
fn negation(ctx: Ctx, program: &Analyzed, call: &Term, env: &Bindings) -> Result<Branches> {
    let Term::Struct(_, args) = call else { unreachable!("step checked callability") };
    let inner = builtins::require_ground(args[0].clone(), "\\+")?;
    let key = term_key(&inner);
    let cached = ctx.shared.borrow().completed.get(&key).copied();
    let has_answer = match cached {
        Some(v) => v,
        None => {
            let answers = solve(program, goals_of(&inner), Vec::new(), ctx.shared)?;
            let v = !answers.is_empty();
            ctx.shared.borrow_mut().completed.insert(key, v);
            v
        }
    };
    if has_answer {
        Ok(Vec::new())
    } else {
        Ok(vec![(env.clone(), vec![Premise::Absent { call_term: inner }])])
    }
}

/// `call(Goal)` — run a term the program itself assembled. The goal's
/// *shape* has to be known when the goal is selected, the same groundness
/// requirement §6 places on every other operation that needs its input;
/// the terms inside it may be as unbound as any ordinary call's arguments.
fn meta_call(ctx: Ctx, program: &Analyzed, call: &Term, env: &Bindings, owner: TableId) -> Result<Branches> {
    let Term::Struct(_, args) = call else { unreachable!("step checked callability") };
    if let Term::Var(..) = args[0] {
        return Err(EyeronError::new("call needs a goal term, but its argument is still unbound"));
    }
    let goals = goals_of(&args[0]);
    let mut out = Vec::new();
    join(ctx, program, &goals, env.clone(), Vec::new(), owner, 0, &mut |solution_env, premises| {
        out.push((solution_env, premises));
        Ok(())
    })?;
    Ok(out)
}

/// `findall(Template, Goal, List)` — every solution of `Goal`, as an
/// instance of `Template` each, in the order the evaluator found them.
/// No answers gives `[]`.
///
/// Because evaluation is tabled, equal solutions are already one answer,
/// so this collects the *distinct* solutions rather than a true bag — the
/// same thing `findall/3` over a tabled predicate does in XSB, and the
/// one place the specification's conformance section records a difference
/// from a resolution-order processor. `sort/2` then only reorders.
fn findall(ctx: Ctx, program: &Analyzed, call: &Term, env: &Bindings) -> Result<Branches> {
    let Term::Struct(_, args) = call else { unreachable!("step checked callability") };
    if let Term::Var(..) = args[1] {
        return Err(EyeronError::new("findall needs a goal term, but its second argument is still unbound"));
    }
    // Rename the template and goal apart together, so their shared
    // variables stay shared but neither can bind anything outside.
    let (fresh_template, fresh_goal) = {
        let mut s = ctx.shared.borrow_mut();
        let mut locals = BTreeMap::new();
        let template = term::fresh(&args[0], &mut locals, &mut s.counter);
        let goal = term::fresh(&args[1], &mut locals, &mut s.counter);
        (template, goal)
    };
    let answers = solve(program, goals_of(&fresh_goal), vec![fresh_template.clone()], ctx.shared)?;
    let mut values = Vec::new();
    let mut proofs = Vec::new();
    for answer in &answers {
        let Term::Struct(_, projected) = &answer.term else { unreachable!("query answers are always '$query'(...) terms") };
        values.push(projected[0].clone());
        proofs.push(answer.proof);
    }
    let list_term = term::list(values);
    let mut branch = env.clone();
    if unify(&args[2], &list_term, &mut branch) {
        let premise = Premise::Collected { value_term: list_term, template: fresh_template, goal: fresh_goal, proofs };
        Ok(vec![(branch, vec![premise])])
    } else {
        Ok(Vec::new())
    }
}

/// `clause(Head, Body)` — every clause of the program as a term pair, with
/// `Body` the goal term the reader built (`true` for a fact). Clauses are
/// standardized apart on the way out, exactly as the evaluator does when
/// it uses one, so a program that inspects itself cannot capture a
/// clause's variables.
fn clause_answers(ctx: Ctx, program: &Analyzed, goal_term: &Term, call: &Term, env: &Bindings) -> Result<Branches> {
    let Term::Struct(_, call_args) = call else { unreachable!("step checked callability") };
    let mut out = Vec::new();
    for signature in &program.predicate_order {
        let Some(rules) = program.predicates.get(signature) else { continue };
        for rule in rules {
            tick(ctx)?;
            let (head, body) = {
                let mut s = ctx.shared.borrow_mut();
                let mut vars = BTreeMap::new();
                let head = term::fresh(&rule.head, &mut vars, &mut s.counter);
                let body = fresh_goals(&rule.body, &mut vars, &mut s.counter);
                (head, body)
            };
            let mut branch = env.clone();
            if unify(&call_args[0], &head, &mut branch) && unify(&call_args[1], &body_term(&body), &mut branch) {
                out.push((branch, vec![Premise::Builtin { call_term: goal_term.clone() }]));
            }
        }
    }
    Ok(out)
}

/// Explores `body` from `index` onward, calling `on_solution` for each
/// complete solution *as soon as it is found* — not after the whole body
/// has been exhaustively searched, so that proof-id allocation order
/// follows the order solutions are actually produced.
#[allow(clippy::too_many_arguments)]
fn join(
    ctx: Ctx,
    program: &Analyzed,
    body: &[Term],
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
    for (next_env, goal_premises) in branches {
        let mut next_premises = premises.clone();
        next_premises.extend(goal_premises);
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
    rule_body: &[Term],
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

fn try_rule(ctx: Ctx, program: &Analyzed, table_id: TableId, call: &Term, rule_head: &Term, rule_body: &[Term], tag: RuleTag) -> Result<()> {
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
        let Some(rules) = program.predicates.get(&signature) else { return Ok(()) };
        let call_args = match &call {
            Term::Struct(_, args) => args.as_slice(),
            _ => &[],
        };
        let candidate_indices: Vec<usize> = match program.predicate_index.get(&signature) {
            Some(index) => index.candidates(call_args),
            None => (0..rules.len()).collect(),
        };
        for i in candidate_indices {
            let rule = &rules[i];
            try_rule(ctx, program, table_id, &call, &rule.head, &rule.body, RuleTag::Rule(rule.id))?;
        }
    }
    Ok(())
}

/// The one shared entry point for both top-level queries and every nested
/// `\+`/`findall` sub-evaluation. Builds a fresh, local table arena;
/// `shared` (steps/tables/answers counters, the growing proof list, the
/// negation-completion cache, and the variable counter) is reused across
/// every nested call within one `run`/`check` invocation.
fn solve(program: &Analyzed, body: Vec<Term>, projection: Vec<Term>, shared: &RefCell<Shared>) -> Result<Vec<AnswerEntry>> {
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
pub fn solve_query(program: &Analyzed, body: Vec<Term>, projection: Vec<Term>, run_ctx: &RunContext) -> Result<Vec<AnswerEntry>> {
    solve(program, body, projection, &run_ctx.0)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::prolog::analyze::analyze;
    use crate::prolog::parser::parse;

    fn run_query(source: &str) -> Vec<AnswerEntry> {
        let mut counter = VarCounter::new();
        let program = parse(source, &mut counter).unwrap_or_else(|err| panic!("{source}: {err}"));
        let query = program.queries[0].clone();
        let analyzed = analyze(program.rules).unwrap();
        let run_ctx = RunContext::new(Limits::default());
        solve_query(&analyzed, query.body, query.variables.clone(), &run_ctx).unwrap_or_else(|err| panic!("{source}: {err}"))
    }

    fn answer_args(entry: &AnswerEntry) -> Vec<Term> {
        match &entry.term {
            Term::Struct(_, args) => args.clone(),
            _ => panic!("a query answer is always a '$query'(...) term"),
        }
    }

    #[test]
    fn left_recursion_terminates() {
        let answers = run_query(
            "parent(alice, bob). parent(bob, carol).\n\
             ancestor(X, Y) :- parent(X, Y).\n\
             ancestor(X, Z) :- ancestor(X, Y), parent(Y, Z).\n\
             ?- ancestor(alice, Who).",
        );
        assert_eq!(answers.len(), 2);
    }

    #[test]
    fn negation_as_failure() {
        let answers = run_query("person(alice). person(bob). married(alice).\nsingle(X) :- person(X), \\+ married(X).\n?- single(X).");
        assert_eq!(answers.len(), 1);
        assert_eq!(answer_args(&answers[0])[0], term::atom("bob"));
    }

    #[test]
    fn findall_collects_distinct_solutions_and_sort_orders_them() {
        let answers = run_query("likes(alice, pears). likes(bob, apples). likes(alice, apples).\n?- findall(F, likes(_, F), Bag), sort(Bag, Set).");
        assert_eq!(answers.len(), 1);
        let args = answer_args(&answers[0]);
        // Table order, with the two `apples` solutions already one answer.
        assert_eq!(term::format(&args[0]), "[pears, apples]");
        assert_eq!(term::format(&args[1]), "[apples, pears]");
    }

    #[test]
    fn between_enumerates() {
        assert_eq!(run_query("?- between(1, 3, N).").len(), 3);
    }

    #[test]
    fn the_vanilla_meta_interpreter_runs_the_program_it_reads() {
        let answers = run_query(
            "parent(alice, bob). parent(bob, carol).\n\
             ancestor(X, Y) :- parent(X, Y).\n\
             ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).\n\
             solve(true).\n\
             solve((A, B)) :- solve(A), solve(B).\n\
             solve(G) :- clause(G, Body), solve(Body).\n\
             ?- solve(ancestor(alice, Who)).",
        );
        assert_eq!(answers.len(), 2);
    }

    #[test]
    fn call_runs_a_goal_the_program_built() {
        let answers = run_query("p(1). p(2).\ngoal(p(X), X).\n?- goal(G, V), call(G).");
        assert_eq!(answers.len(), 2);
    }
}
