//! Eyelang's reified syntax (spec §12.3), in both directions.
//!
//! A goal is an ordinary Eyelang term: `call(T)`, `absent(T)`,
//! `compare("op", L, R)`, `calculate(Target, Expr)`, and
//! `collect(Target, Template, Goals)`, with expressions as `value(T)`,
//! `unary("-", E)`, `binary("op", L, R)` and `function("name", Args)`.
//! Proof records have always been written in this vocabulary, and
//! `clause/2` and `prove/1` (spec §9) make it executable: a program can
//! read its own clauses as terms and run a term as a goal. Eyelang is
//! therefore homoiconic — its code, its proofs, and its data are one
//! notation.
//!
//! Encoding and decoding live together because they must stay exact
//! inverses: `decode_goal(encode_goal(g)) == g` for every goal, which
//! `round_trips_every_goal_shape` below checks shape by shape. A
//! reification that lost anything would make a proof record unreplayable
//! and `prove/1` unsound.

use super::ast::{Expr, Goal};
use super::term::{self, Term};

pub(crate) fn encode_expr(expr: &Expr) -> Term {
    match expr {
        Expr::Value(t) => term::struct_("value", vec![t.clone()]),
        Expr::Unary { arg } => term::struct_("unary", vec![term::str_("-"), encode_expr(arg)]),
        Expr::Binary { op, left, right } => term::struct_("binary", vec![term::str_(op.clone()), encode_expr(left), encode_expr(right)]),
        Expr::Function { name, args } => {
            term::struct_("function", vec![term::str_(name.clone()), term::list(args.iter().map(encode_expr).collect())])
        }
    }
}

pub(crate) fn encode_goal(goal: &Goal) -> Term {
    match goal {
        Goal::Call(t) => term::struct_("call", vec![t.clone()]),
        Goal::Not(t) => term::struct_("absent", vec![t.clone()]),
        Goal::Compare { op, left, right } => term::struct_("compare", vec![term::str_(op.clone()), left.clone(), right.clone()]),
        Goal::Let { target, expr } => term::struct_("calculate", vec![target.clone(), encode_expr(expr)]),
        Goal::Collect { target, template, body } => term::struct_("collect", vec![target.clone(), template.clone(), encode_goals(body)]),
    }
}

pub(crate) fn encode_goals(body: &[Goal]) -> Term {
    term::list(body.iter().map(encode_goal).collect())
}

/// Why a term is not a goal. Reported as an ordinary Eyelang runtime
/// error, the same way a mode violation is (§6, §11) — a malformed goal
/// term is a programming mistake, not an absence of answers, so failing
/// silently would hide it.
pub(crate) type Malformed = String;

pub(crate) fn decode_goal(term: &Term) -> Result<Goal, Malformed> {
    let Term::Struct(name, args) = term else {
        return Err(format!("{} is not a goal term", term::format(term)));
    };
    match (name.as_str(), args.len()) {
        ("call", 1) => Ok(Goal::Call(args[0].clone())),
        ("absent", 1) => Ok(Goal::Not(args[0].clone())),
        ("compare", 3) => Ok(Goal::Compare { op: operator(&args[0])?, left: args[1].clone(), right: args[2].clone() }),
        ("calculate", 2) => Ok(Goal::Let { target: args[0].clone(), expr: decode_expr(&args[1])? }),
        ("collect", 3) => Ok(Goal::Collect { target: args[0].clone(), template: args[1].clone(), body: decode_goals(&args[2])? }),
        _ => Err(format!("{}/{} is not a goal term", name, args.len())),
    }
}

pub(crate) fn decode_goals(term: &Term) -> Result<Vec<Goal>, Malformed> {
    let items = term::array(term).map_err(|_| format!("{} is not a list of goal terms", term::format(term)))?;
    items.iter().map(decode_goal).collect()
}

pub(crate) fn decode_expr(term: &Term) -> Result<Expr, Malformed> {
    let Term::Struct(name, args) = term else {
        return Err(format!("{} is not an expression term", term::format(term)));
    };
    match (name.as_str(), args.len()) {
        ("value", 1) => Ok(Expr::Value(args[0].clone())),
        ("unary", 2) => Ok(Expr::Unary { arg: Box::new(decode_expr(&args[1])?) }),
        ("binary", 3) => Ok(Expr::Binary { op: operator(&args[0])?, left: Box::new(decode_expr(&args[1])?), right: Box::new(decode_expr(&args[2])?) }),
        ("function", 2) => {
            let items = term::array(&args[1]).map_err(|_| "function arguments must be a list".to_string())?;
            Ok(Expr::Function { name: operator(&args[0])?, args: items.iter().map(decode_expr).collect::<Result<_, _>>()? })
        }
        _ => Err(format!("{}/{} is not an expression term", name, args.len())),
    }
}

/// The operator and function names in a reified goal are strings, so that
/// `compare("<", 1, 2)` reads the same whether it was written by hand or
/// printed by a proof.
fn operator(term: &Term) -> Result<String, Malformed> {
    match term {
        Term::Str(value) => Ok(value.clone()),
        other => Err(format!("expected an operator string, found {}", term::format(other))),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn var(name: &str) -> Term {
        Term::Var(1, name.to_string())
    }

    #[test]
    fn round_trips_every_goal_shape() {
        let goals = vec![
            Goal::Call(term::struct_("parent", vec![term::atom("ann"), var("c")])),
            Goal::Not(term::struct_("blocked", vec![var("x")])),
            Goal::Compare { op: "<".to_string(), left: term::int(1), right: var("n") },
            Goal::Let {
                target: var("total"),
                expr: Expr::Binary {
                    op: "+".to_string(),
                    left: Box::new(Expr::Value(var("a"))),
                    right: Box::new(Expr::Unary { arg: Box::new(Expr::Function { name: "abs".to_string(), args: vec![Expr::Value(term::int(-2))] }) }),
                },
            },
            Goal::Collect {
                target: var("all"),
                template: var("v"),
                body: vec![Goal::Call(term::struct_("reading", vec![var("s"), var("v")]))],
            },
        ];
        for goal in &goals {
            let encoded = encode_goal(goal);
            let decoded = decode_goal(&encoded).unwrap_or_else(|err| panic!("{}: {err}", term::format(&encoded)));
            assert_eq!(&decoded, goal, "round trip through {}", term::format(&encoded));
        }
    }

    #[test]
    fn a_list_of_goals_round_trips() {
        let body = vec![Goal::Call(term::atom("a")), Goal::Not(term::atom("b"))];
        assert_eq!(decode_goals(&encode_goals(&body)).unwrap(), body);
    }

    #[test]
    fn a_term_that_is_not_a_goal_is_reported_not_ignored() {
        assert!(decode_goal(&term::atom("parent")).is_err());
        assert!(decode_goal(&term::struct_("call", vec![term::atom("a"), term::atom("b")])).is_err());
        assert!(decode_goals(&term::atom("nope")).is_err());
    }
}
