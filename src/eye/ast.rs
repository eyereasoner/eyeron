//! Abstract syntax for Eyelang programs: rules, queries, goals, and
//! arithmetic expressions (`docs/specification.md` §3 in the sibling
//! `eyelang` project). Mirrors `parser.js`'s node shapes closely enough to
//! keep the port mechanical.

use super::term::Term;

#[derive(Debug, Clone, PartialEq)]
pub enum Expr {
    Value(Term),
    Unary { arg: Box<Expr> },
    Binary { op: String, left: Box<Expr>, right: Box<Expr> },
    Function { name: String, args: Vec<Expr> },
}

#[derive(Debug, Clone, PartialEq)]
pub enum Goal {
    Call(Term),
    Not(Term),
    Compare { op: String, left: Term, right: Term },
    Let { target: Term, expr: Expr },
    Collect { target: Term, template: Term, body: Vec<Goal> },
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Location {
    pub line: usize,
    pub column: usize,
}

/// A `head [if body].` statement. `fact` is true iff the rule has an empty
/// body and a fully ground head (`analyze.js`'s comment: non-ground unit
/// clauses like `append([], ?ys, ?ys)` are relational definitions, not
/// simple facts, so they still go through the tabled evaluator's usual
/// clause-matching path — this flag is informational only).
#[derive(Debug, Clone, PartialEq)]
pub struct Rule {
    pub id: usize,
    pub head: Term,
    pub body: Vec<Goal>,
    pub location: Location,
    pub fact: bool,
}

/// An `ask [body].` statement.
#[derive(Debug, Clone, PartialEq)]
pub struct Query {
    pub body: Vec<Goal>,
    pub variables: Vec<Term>,
    pub location: Location,
}

#[derive(Debug, Clone, Default, PartialEq)]
pub struct Program {
    pub rules: Vec<Rule>,
    pub queries: Vec<Query>,
}
