//! The reader: Prolog text in, clauses and queries out.
//!
//! This is the standard's operator-precedence term reader over the fixed
//! table in `super::ops`, with a maximum priority of 1200 for a whole term
//! and 999 for an argument or list element (which is why a `,` inside
//! `f(a, b)` separates arguments instead of building a conjunction).
//!
//! Each clause gets its own fresh variable scope: a name denotes the same
//! variable everywhere within one clause and an unrelated one in the next.
//! `_` is always a brand-new, unshared variable, even when repeated.

use std::collections::HashMap;

use crate::error::{EyeronError, Result};

use super::ast::{goals_of, Location, Program, Query, Rule};
use super::lexer::{tokenize, Token, TokenKind};
use super::ops;
use super::term::{self, ground, variables_in, Term, VarCounter};

/// Byte offsets where each line begins (`line_starts[0]` is always `0`,
/// for line 1). Computed once per source document and reused by every
/// `line_col` call, instead of each call rescanning from the start of the
/// file: `Parser::location` runs once per clause, and a from-the-start
/// scan there made parsing a large, one-fact-per-line program quadratic in
/// the source length.
fn line_starts(source: &str) -> Vec<usize> {
    let mut starts = vec![0usize];
    starts.extend(source.char_indices().filter(|(_, ch)| *ch == '\n').map(|(i, _)| i + 1));
    starts
}

/// `line_starts` must be `line_starts(source)`'s own result for `source`.
/// Finds `offset`'s line via binary search, then counts characters from
/// that line's start to `offset` for the column -- bounded by one line's
/// length rather than the whole file.
fn line_col(source: &str, line_starts: &[usize], offset: usize) -> (usize, usize) {
    let line_index = line_starts.partition_point(|&start| start <= offset) - 1;
    let column = source[line_starts[line_index]..offset].chars().count() + 1;
    (line_index + 1, column)
}

/// The maximum priority of an argument or list element: one below `,`'s,
/// so a bare `,` there separates rather than conjoins.
const ARGUMENT: u16 = 999;

struct Parser<'a> {
    source: &'a str,
    line_starts: Vec<usize>,
    tokens: Vec<Token>,
    pos: usize,
    scope: HashMap<String, Term>,
    counter: &'a mut VarCounter,
}

impl<'a> Parser<'a> {
    fn peek(&self) -> &Token {
        &self.tokens[self.pos]
    }

    fn peek_at(&self, ahead: usize) -> &Token {
        self.tokens.get(self.pos + ahead).unwrap_or_else(|| self.tokens.last().expect("the token list always ends with Eof"))
    }

    fn take(&mut self) -> Token {
        let t = self.tokens[self.pos].clone();
        self.pos += 1;
        t
    }

    fn error(&self, message: impl Into<String>) -> EyeronError {
        EyeronError::at(message.into(), self.peek().offset)
    }

    fn error_at(&self, message: impl Into<String>, offset: usize) -> EyeronError {
        EyeronError::at(message.into(), offset)
    }

    fn accept(&mut self, kind: &TokenKind) -> bool {
        if &self.peek().kind == kind {
            self.take();
            true
        } else {
            false
        }
    }

    fn expect(&mut self, kind: TokenKind, text: &str) -> Result<()> {
        if !self.accept(&kind) {
            return Err(self.error(format!("Expected {:?}", text)));
        }
        Ok(())
    }

    fn location(&self) -> Location {
        let (line, column) = line_col(self.source, &self.line_starts, self.peek().offset);
        Location { line, column }
    }

    fn variable(&mut self, name: String) -> Term {
        if name == "_" {
            return self.counter.fresh("_");
        }
        if let Some(existing) = self.scope.get(&name) {
            return existing.clone();
        }
        let fresh = self.counter.fresh(name.clone());
        self.scope.insert(name, fresh.clone());
        fresh
    }

    /// True iff the token `ahead` of the cursor could begin a term, which
    /// is what decides whether a prefix operator is being applied or is
    /// standing on its own as an atom (`f(-, 1)` has no operand for `-`).
    fn starts_term(&self, ahead: usize) -> bool {
        matches!(
            self.peek_at(ahead).kind,
            TokenKind::Var(_) | TokenKind::Atom(_) | TokenKind::Str(_) | TokenKind::Int(_) | TokenKind::Float(_) | TokenKind::LParen | TokenKind::LBracket
        )
    }

    fn arguments(&mut self) -> Result<Vec<Term>> {
        let mut args = vec![self.term(ARGUMENT)?.0];
        while self.accept(&TokenKind::Comma) {
            args.push(self.term(ARGUMENT)?.0);
        }
        self.expect(TokenKind::RParen, ")")?;
        Ok(args)
    }

    fn list(&mut self) -> Result<Term> {
        if self.accept(&TokenKind::RBracket) {
            return Ok(term::nil());
        }
        let mut items = vec![self.term(ARGUMENT)?.0];
        while self.accept(&TokenKind::Comma) {
            items.push(self.term(ARGUMENT)?.0);
        }
        let tail = if self.accept(&TokenKind::Bar) { self.term(ARGUMENT)?.0 } else { term::nil() };
        self.expect(TokenKind::RBracket, "]")?;
        Ok(items.into_iter().rev().fold(tail, |rest, item| term::cons(item, rest)))
    }

    /// Read a term with no infix operator applied to it yet, returning it
    /// and its own priority (0 for everything but a prefix-operator term).
    fn primary(&mut self, max: u16) -> Result<(Term, u16)> {
        let token = self.take();
        match token.kind {
            TokenKind::Var(name) => Ok((self.variable(name), 0)),
            TokenKind::Str(value) => Ok((term::str_(value), 0)),
            TokenKind::Int(value) => Ok((Term::Int(value), 0)),
            TokenKind::Float(value) => Ok((term::float(value), 0)),
            TokenKind::LParen => {
                let (inner, _) = self.term(1200)?;
                self.expect(TokenKind::RParen, ")")?;
                Ok((inner, 0))
            }
            TokenKind::LBracket => Ok((self.list()?, 0)),
            TokenKind::LBrace => Err(self.error_at("Curly-bracketed terms are not in the accepted subset", token.offset)),
            TokenKind::Atom(name) => {
                // `f(...)` with no layout before the bracket is functional
                // notation; `f (...)` is not.
                if self.peek().kind == TokenKind::LParen && !self.peek().spaced {
                    self.take();
                    return Ok((term::struct_(name, self.arguments()?), 0));
                }
                // A sign written directly against a numeric literal is
                // part of that literal, per §6.3.1.2 of the standard.
                if (name == "-" || name == "+") && !self.peek().spaced {
                    let negate = name == "-";
                    match self.peek().kind.clone() {
                        TokenKind::Int(value) => {
                            self.take();
                            return Ok((Term::Int(if negate { -value } else { value }), 0));
                        }
                        TokenKind::Float(value) => {
                            self.take();
                            return Ok((term::float(if negate { -value } else { value }), 0));
                        }
                        _ => {}
                    }
                }
                if let Some((prec, arg_max)) = ops::prefix(&name) {
                    if prec <= max && self.starts_term(0) {
                        let (arg, _) = self.term(arg_max)?;
                        return Ok((term::struct_(name, vec![arg]), prec));
                    }
                }
                Ok((term::atom(name), 0))
            }
            _ => Err(self.error_at("Expected a term", token.offset)),
        }
    }

    /// Read a term of priority at most `max`, applying infix operators for
    /// as long as their own priority and their left argument's allow.
    fn term(&mut self, max: u16) -> Result<(Term, u16)> {
        let (mut left, mut left_prec) = self.primary(max)?;
        loop {
            let name = match &self.peek().kind {
                TokenKind::Atom(name) => name.clone(),
                TokenKind::Comma => ",".to_string(),
                _ => break,
            };
            let Some((prec, left_max, right_max)) = ops::infix(&name) else { break };
            if prec > max || left_prec > left_max {
                break;
            }
            self.take();
            let (right, _) = self.term(right_max)?;
            left = term::struct_(name, vec![left, right]);
            left_prec = prec;
        }
        Ok((left, left_prec))
    }

    /// Check that `value` can be a clause head or a goal. `'.'/2` is
    /// excluded because it is list structure, never a relation.
    fn callable(&self, value: Term, offset: usize) -> Result<Term> {
        match &value {
            Term::Struct(name, args) if name == "." && args.len() == 2 => Err(self.error_at("A list is not a callable term", offset)),
            Term::Struct(..) => Ok(value),
            _ => Err(self.error_at("Expected a callable term", offset)),
        }
    }

    fn parse_program(&mut self) -> Result<Program> {
        let mut rules = Vec::new();
        let mut queries = Vec::new();
        while !matches!(self.peek().kind, TokenKind::Eof) {
            self.scope = HashMap::new();
            let location = self.location();
            let offset = self.peek().offset;
            let (statement, _) = self.term(1200)?;
            self.expect(TokenKind::End, ".")?;
            match &statement {
                Term::Struct(name, args) if name == "?-" && args.len() == 1 => {
                    let body = goals_of(&args[0]);
                    for goal in &body {
                        self.callable(goal.clone(), offset)?;
                    }
                    let variables = query_variables(&body);
                    queries.push(Query { body, variables, location });
                }
                Term::Struct(name, args) if name == ":-" && args.len() == 1 => {
                    return Err(self.error_at("Only the ?- directive is in the accepted subset", offset));
                }
                Term::Struct(name, args) if name == ":-" && args.len() == 2 => {
                    let head = self.callable(args[0].clone(), offset)?;
                    let body = goals_of(&args[1]);
                    for goal in &body {
                        self.callable(goal.clone(), offset)?;
                    }
                    let fact = body.is_empty() && ground(&head);
                    rules.push(Rule { id: rules.len() + 1, head, body, location, fact });
                }
                _ => {
                    let head = self.callable(statement.clone(), offset)?;
                    let fact = ground(&head);
                    rules.push(Rule { id: rules.len() + 1, head, body: Vec::new(), location, fact });
                }
            }
        }
        Ok(Program { rules, queries })
    }
}

/// Variables an answer reports. A `findall/3` goal's template and goal run
/// in a nested evaluation whose bindings do not escape, so only its result
/// list contributes — otherwise every answer would carry variables that
/// are unbound by construction.
pub fn query_variables(body: &[Term]) -> Vec<Term> {
    let mut vars: Vec<(u64, Term)> = Vec::new();
    for goal in body {
        match goal {
            Term::Struct(name, args) if name == "findall" && args.len() == 3 => variables_in(&args[2], &mut vars),
            other => variables_in(other, &mut vars),
        }
    }
    vars.into_iter().map(|(_, t)| t).collect()
}

/// Parse a whole Prolog source document, using and advancing `counter` for
/// every variable minted while parsing, so that later evaluation-time
/// fresh variables never collide with parse-time ones.
pub fn parse(source: &str, counter: &mut VarCounter) -> Result<Program> {
    let tokens = tokenize(source)?;
    let mut parser = Parser { source, line_starts: line_starts(source), tokens, pos: 0, scope: HashMap::new(), counter };
    parser.parse_program()
}

#[cfg(test)]
mod tests {
    use super::*;

    fn parse_ok(source: &str) -> Program {
        let mut counter = VarCounter::new();
        parse(source, &mut counter).unwrap_or_else(|err| panic!("{}: {err}", source))
    }

    fn read(source: &str) -> Term {
        parse_ok(&format!("p({}).", source)).rules[0].head.clone()
    }

    #[test]
    fn parses_a_fact() {
        let program = parse_ok("parent(alice, bob).");
        assert_eq!(program.rules.len(), 1);
        assert!(program.rules[0].fact);
        assert_eq!(program.rules[0].head, term::struct_("parent", vec![term::atom("alice"), term::atom("bob")]));
    }

    #[test]
    fn parses_a_rule_with_a_conjunctive_body() {
        let program = parse_ok("ancestor(X, Z) :- parent(X, Y), ancestor(Y, Z).");
        assert_eq!(program.rules.len(), 1);
        assert_eq!(program.rules[0].body.len(), 2);
    }

    #[test]
    fn shares_variables_within_one_clause_only() {
        let program = parse_ok("a(X) :- b(X).\nc(X) :- d(X).");
        let Term::Struct(_, first) = &program.rules[0].head else { panic!() };
        let Term::Struct(_, second) = &program.rules[1].head else { panic!() };
        assert_ne!(first[0], second[0]);
    }

    #[test]
    fn parses_a_query_directive() {
        let program = parse_ok("p(a). ?- p(X).");
        assert_eq!(program.queries.len(), 1);
        assert_eq!(program.queries[0].variables.len(), 1);
    }

    #[test]
    fn applies_operator_priorities() {
        assert_eq!(term::format(&read("1 + 2 * 3")), "p(1 + 2 * 3)");
        assert_eq!(read("1 + 2 * 3"), term::struct_("p", vec![term::struct_("+", vec![term::int(1), term::struct_("*", vec![term::int(2), term::int(3)])])]));
        assert_eq!(read("1 - 2 - 3"), term::struct_("p", vec![term::struct_("-", vec![term::struct_("-", vec![term::int(1), term::int(2)]), term::int(3)])]));
    }

    #[test]
    fn a_comma_separates_arguments_but_conjoins_in_a_body() {
        let program = parse_ok("p(a, b).\nq :- a, b.");
        let Term::Struct(_, args) = &program.rules[0].head else { panic!() };
        assert_eq!(args.len(), 2);
        assert_eq!(program.rules[1].body.len(), 2);
    }

    #[test]
    fn parses_signed_numbers_and_prefix_minus_differently() {
        assert_eq!(read("-3"), term::struct_("p", vec![term::int(-3)]));
        assert_eq!(read("- 3"), term::struct_("p", vec![term::struct_("-", vec![term::int(3)])]));
    }

    #[test]
    fn parses_list_notation() {
        assert_eq!(read("[1, 2]"), term::struct_("p", vec![term::list(vec![term::int(1), term::int(2)])]));
        assert_eq!(term::format(&read("[1 | T]")), "p([1|_0])");
    }

    #[test]
    fn rejects_a_list_as_a_clause_head() {
        let mut counter = VarCounter::new();
        assert!(parse("'.'(1, 2).", &mut counter).is_err());
    }

    #[test]
    fn a_fact_body_is_empty_and_a_true_body_is_too() {
        assert!(parse_ok("p.").rules[0].body.is_empty());
        assert!(parse_ok("p :- true.").rules[0].body.is_empty());
    }

    #[test]
    fn parses_negation_and_arithmetic_goals() {
        let program = parse_ok("p(X) :- \\+ q(X), X is 1 + 2.");
        assert_eq!(term::format(&program.rules[0].body[0]), "\\+q(_0)");
        assert_eq!(term::format(&program.rules[0].body[1]), "_0 is 1 + 2");
    }

    #[test]
    fn rejects_directives_other_than_queries() {
        let mut counter = VarCounter::new();
        assert!(parse(":- dynamic(p/1).", &mut counter).is_err());
    }
}
