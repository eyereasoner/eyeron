//! Prolog front end, file extension `.pl`: the pure, tabled subset of
//! ISO/IEC 13211-1 described in `docs/prolog-specification.md`. Unlike the
//! N3 and SPARQL-RL front ends, this is not an RDF triple language — see
//! `term` for its value domain and `rdf` for the one explicit bridge.

pub mod analyze;
pub mod ast;
pub mod builtins;
pub mod engine;
pub mod lexer;
pub mod ops;
pub mod output;
pub mod parser;
pub mod rdf;
pub mod term;

use crate::error::Result;

pub use ast::{Query, Rule};
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
    pub body: Vec<Term>,
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
    /// One `(predicate indicator, stratum level)` pair per predicate, in
    /// first-declaration order (matches `--check`'s `stratum/2` fact
    /// order).
    pub strata: Vec<(String, usize)>,
}

/// Parse `source`, run every `?-` directive in it to completion, and
/// return the full result.
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
                    _ => unreachable!("query answers are always '$query'(...) terms"),
                };
                let bindings = query
                    .variables
                    .iter()
                    .zip(args)
                    .map(|(var, value)| {
                        let name = match var {
                            Term::Var(_, name) => name.clone(),
                            _ => unreachable!("a query projection is always a list of variables"),
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

/// Parse and validate `source` (stratification, undefined-predicate and
/// query-dependency checks) without evaluating it.
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

/// Content-sniff whether `input` looks like Prolog, mirroring
/// `crate::srl::is_sparql_rl`'s approach: skip leading comments and blank
/// lines, then check the first substantive line's shape. Every clause is
/// either a `?-` directive or a head — an identifier immediately followed
/// by `(`, or one standing alone before `:-` or the terminating `.` —
/// which N3 (`@prefix`, or a subject followed by whitespace) and SPARQL-RL
/// (uppercase `PREFIX`/`RULE`/`DATA` keywords, or a bare `{`) never
/// produce as their first substantive line.
pub fn is_prolog(input: &str) -> bool {
    let mut in_block_comment = false;
    for line in input.lines() {
        let mut trimmed = line.trim();
        if in_block_comment {
            match trimmed.find("*/") {
                Some(end) => {
                    in_block_comment = false;
                    trimmed = trimmed[end + 2..].trim();
                }
                None => continue,
            }
        }
        if trimmed.starts_with("/*") && !trimmed.contains("*/") {
            in_block_comment = true;
            continue;
        }
        if trimmed.is_empty() || trimmed.starts_with('%') {
            continue;
        }
        if trimmed.starts_with("?-") {
            return true;
        }
        let first_word: String = trimmed.chars().take_while(|c| c.is_ascii_alphanumeric() || *c == '_').collect();
        if first_word.is_empty() || !first_word.starts_with(|c: char| c.is_ascii_lowercase()) {
            return false;
        }
        let rest = trimmed[first_word.len()..].trim_start();
        return rest.starts_with('(') || rest.starts_with(":-") || rest == ".";
    }
    false
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn recognizes_prolog_but_not_the_other_front_ends() {
        assert!(is_prolog("parent(alice, bob).\n?- parent(X, Y)."));
        assert!(is_prolog("% a comment\n\nancestor(X, Y) :- parent(X, Y)."));
        assert!(is_prolog("/* a block\n   comment */\nready.\n?- ready."));
        assert!(is_prolog("?- between(1, 3, N)."));
        assert!(!is_prolog("@prefix : <http://example.org/> .\n:a :b :c ."));
        assert!(!is_prolog("PREFIX : <http://example.org/>\nRULE { ?s :p ?o } WHERE { ?s :q ?o }"));
        assert!(!is_prolog(":a :b :c ."));
    }
}
