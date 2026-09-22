//! Program structure: clauses and queries.
//!
//! There is no separate goal or expression syntax tree. A goal *is* a term
//! (`\+ blocked(X)` is `\+(blocked(X))`, `X is A + 1` is `is(X, +(A, 1))`),
//! which is what makes the language homoiconic: `clause/2` hands a clause
//! body back as the very term the parser built, and `call/1` runs a term
//! the program assembled itself. A clause body is kept here as the flat
//! left-to-right sequence the evaluator joins; `body_term` and `goals_of`
//! convert between that and the `','/2` chain a program sees.

use super::term::{self, Term};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Location {
    pub line: usize,
    pub column: usize,
}

/// A `Head :- Body.` or `Head.` clause. `fact` is true iff the clause has
/// an empty body and a fully ground head (a non-ground unit clause such as
/// `append([], Ys, Ys)` is a relational definition, not a simple fact, so
/// it still goes through the usual clause-matching path — this flag is
/// informational only).
#[derive(Debug, Clone, PartialEq)]
pub struct Rule {
    pub id: usize,
    pub head: Term,
    pub body: Vec<Term>,
    pub location: Location,
    pub fact: bool,
}

/// A `?- Body.` directive.
#[derive(Debug, Clone, PartialEq)]
pub struct Query {
    pub body: Vec<Term>,
    pub variables: Vec<Term>,
    pub location: Location,
}

#[derive(Debug, Clone, Default, PartialEq)]
pub struct Program {
    pub rules: Vec<Rule>,
    pub queries: Vec<Query>,
}

/// The goal term for a body: `true` when empty, otherwise the `','/2`
/// chain the standard's `,` operator (xfy) builds, right-associated.
pub fn body_term(goals: &[Term]) -> Term {
    match goals.split_first() {
        None => term::atom("true"),
        Some((first, [])) => first.clone(),
        Some((first, rest)) => term::struct_(",", vec![first.clone(), body_term(rest)]),
    }
}

/// Flatten a goal term's `','/2` chain into the sequence the evaluator
/// joins. `true` flattens to no goals at all, so a fact's body and an
/// empty conjunction are the same thing.
pub fn goals_of(goal: &Term) -> Vec<Term> {
    let mut out = Vec::new();
    collect_goals(goal, &mut out);
    out
}

fn collect_goals(goal: &Term, out: &mut Vec<Term>) {
    match goal {
        Term::Struct(name, args) if name == "," && args.len() == 2 => {
            collect_goals(&args[0], out);
            collect_goals(&args[1], out);
        }
        Term::Struct(name, args) if name == "true" && args.is_empty() => {}
        other => out.push(other.clone()),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_body_round_trips_through_its_goal_term() {
        let goals = vec![term::atom("a"), term::atom("b"), term::atom("c")];
        let chain = body_term(&goals);
        assert_eq!(term::format(&chain), "a, b, c");
        assert_eq!(goals_of(&chain), goals);
    }

    #[test]
    fn an_empty_body_is_true() {
        assert_eq!(body_term(&[]), term::atom("true"));
        assert!(goals_of(&term::atom("true")).is_empty());
    }

    #[test]
    fn a_left_associated_conjunction_flattens_the_same_way() {
        let left = term::struct_(",", vec![term::struct_(",", vec![term::atom("a"), term::atom("b")]), term::atom("c")]);
        assert_eq!(goals_of(&left), vec![term::atom("a"), term::atom("b"), term::atom("c")]);
    }
}
