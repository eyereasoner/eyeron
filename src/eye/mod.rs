//! Eyelang ("eye") front end: a small Prolog/Datalog-style logic
//! programming language, file extension `.eye`. Unlike the N3 and
//! SPARQL-RL front ends, Eyelang is not an RDF triple language — see
//! `term` for its value domain and `docs/eyelang.md`'s implementation
//! notes for how this module relates to the others.

pub mod analyze;
pub mod ast;
pub mod builtins;
pub mod engine;
pub mod lexer;
pub mod output;
pub mod parser;
pub mod reify;
pub mod rdf;
pub mod term;

use crate::error::Result;

pub use ast::{Goal, Query, Rule};
pub use engine::{Limits, ProofEntry, Stats};
pub use term::{Term, VarCounter};

/// One binding of a query variable's source name to its final value.
pub type Binding = (String, Term);

#[derive(Debug, Clone)]
pub struct Answer {
    pub bindings: Vec<Binding>,
    pub proof: usize,
}

#[derive(Debug, Clone)]
pub struct QueryResult {
    pub body: Vec<Goal>,
    pub variables: Vec<Term>,
    pub answers: Vec<Answer>,
}

#[derive(Debug, Clone)]
pub struct RunResult {
    pub queries: Vec<QueryResult>,
    pub proofs: Vec<ProofEntry>,
    pub stats: Stats,
}

#[derive(Debug, Clone)]
pub struct CheckResult {
    pub rules: usize,
    pub queries: usize,
    /// One `(relation signature, stratum level)` pair per relation, in
    /// first-declaration order (matches `--check`'s `stratum/2` fact order).
    pub strata: Vec<(String, usize)>,
}

/// Parse `source`, run every embedded `ask` statement to completion, and
/// return the full result (mirrors `index.js`'s `run`).
pub fn run(source: &str, limits: Limits) -> Result<RunResult> {
    let mut counter = VarCounter::new();
    let program = parser::parse(source, &mut counter)?;
    let analyzed = analyze::analyze(program.rules)?;
    let run_ctx = engine::RunContext::new(limits);
    let mut queries = Vec::new();
    for query in program.queries {
        let solutions = engine::solve_query(&analyzed, query.body.clone(), query.variables.clone(), &run_ctx)?;
        let answers = solutions
            .into_iter()
            .map(|solution| {
                let args = match solution.term {
                    Term::Struct(_, args) => args,
                    _ => unreachable!("query answers are always $query(...) structs"),
                };
                let bindings = query
                    .variables
                    .iter()
                    .zip(args)
                    .map(|(var, value)| {
                        let name = match var {
                            Term::Var(_, name) => name.clone(),
                            _ => unreachable!("query projection is always a list of variables"),
                        };
                        (name, value)
                    })
                    .collect();
                Answer { bindings, proof: solution.proof }
            })
            .collect();
        queries.push(QueryResult { body: query.body, variables: query.variables, answers });
    }
    let stats = run_ctx.stats();
    let proofs = run_ctx.into_proofs();
    Ok(RunResult { queries, proofs, stats })
}

/// Parse and validate `source` (stratification, undefined-relation and
/// query-dependency checks) without evaluating it (mirrors `index.js`'s
/// `check`).
pub fn check(source: &str) -> Result<CheckResult> {
    let mut counter = VarCounter::new();
    let program = parser::parse(source, &mut counter)?;
    let rules = program.rules.len();
    let queries = program.queries.len();
    let analyzed = analyze::analyze(program.rules)?;
    for query in &program.queries {
        analyze::check_query(&query.body, &analyzed)?;
    }
    let strata = analyzed.predicate_order.iter().map(|name| (name.clone(), *analyzed.strata.get(name).unwrap())).collect();
    Ok(CheckResult { rules, queries, strata })
}

/// Content-sniff whether `input` looks like an Eyelang program, mirroring
/// `crate::srl::is_sparql_rl`'s approach: skip leading comments/blank
/// lines, then check the first substantive line's shape. Every Eyelang
/// statement is either `ask ...` or `identifier(...) [if ...] .` — an
/// identifier immediately followed by `(`, with no space, which N3
/// (`@prefix`/a subject followed by whitespace) and SPARQL-RL (uppercase
/// `PREFIX`/`RULE`/`DATA` keywords, or a bare `{`) never produce as their
/// first substantive line.
pub fn is_eyelang(input: &str) -> bool {
    for line in input.lines() {
        let trimmed = line.trim();
        if trimmed.is_empty() || trimmed.starts_with('#') {
            continue;
        }
        if trimmed == "ask" || trimmed.starts_with("ask ") || trimmed.starts_with("ask(") {
            return true;
        }
        let first_word: String = trimmed.chars().take_while(|c| c.is_ascii_alphanumeric() || *c == '_').collect();
        return !first_word.is_empty() && trimmed[first_word.len()..].starts_with('(');
    }
    false
}
