//! Recursive-descent parser for Eyelang, mirroring `parser.js` closely.
//!
//! Each top-level statement (a `head [if body].` clause, or an
//! `ask [body].` query) gets its own fresh variable scope: `?name` maps to
//! the same `Term::Var` everywhere within one statement, and to unrelated
//! variables in the next one. `?_` is always a brand-new, unshared
//! anonymous variable, even when repeated within one statement.

use std::collections::HashMap;

use crate::error::{EyeronError, Result};

use super::ast::{Expr, Goal, Location, Program, Query, Rule};
use super::lexer::{tokenize, Token, TokenKind};
use super::term::{self, ground, variables_in, Term, VarCounter};

/// Byte offsets where each line begins (`line_starts[0]` is always `0`,
/// for line 1). Computed once per source document and reused by every
/// `line_col` call, instead of each call rescanning from the start of the
/// file: `Parser::location` runs once per top-level statement, and a
/// from-the-start scan there made parsing a large, one-fact-per-line
/// program (such as a full port of `deep-taxonomy-100000.n3`'s scale)
/// quadratic in the source length.
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

const BINARY_PRECEDENCE: &[(&str, u8)] = &[("+", 10), ("-", 10), ("*", 20), ("/", 20), ("//", 20), ("%", 20)];

fn precedence(op: &str) -> Option<u8> {
    BINARY_PRECEDENCE.iter().find(|(name, _)| *name == op).map(|(_, p)| *p)
}

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

    fn is_punct(&self, kind: &TokenKind) -> bool {
        &self.peek().kind == kind
    }

    fn accept_punct(&mut self, kind: TokenKind) -> bool {
        if self.is_punct(&kind) {
            self.take();
            true
        } else {
            false
        }
    }

    fn expect_punct(&mut self, kind: TokenKind, text: &str) -> Result<()> {
        if !self.accept_punct(kind) {
            return Err(self.error(format!("Expected {:?}", text)));
        }
        Ok(())
    }

    fn peek_word(&self) -> Option<&str> {
        match &self.peek().kind {
            TokenKind::Word(w) => Some(w.as_str()),
            _ => None,
        }
    }

    fn accept_word(&mut self, word: &str) -> bool {
        if self.peek_word() == Some(word) {
            self.take();
            true
        } else {
            false
        }
    }

    fn location(&self) -> Location {
        let (line, column) = line_col(self.source, &self.line_starts, self.peek().offset);
        Location { line, column }
    }

    fn compare_op(&self) -> Option<&'static str> {
        match &self.peek().kind {
            TokenKind::Eq => Some("="),
            TokenKind::NotEq => Some("!="),
            TokenKind::Lt => Some("<"),
            TokenKind::Gt => Some(">"),
            TokenKind::Le => Some("<="),
            TokenKind::Ge => Some(">="),
            _ => None,
        }
    }

    fn binary_op_text(&self) -> Option<&'static str> {
        match &self.peek().kind {
            TokenKind::Plus => Some("+"),
            TokenKind::Minus => Some("-"),
            TokenKind::Star => Some("*"),
            TokenKind::Slash => Some("/"),
            TokenKind::SlashSlash => Some("//"),
            TokenKind::Percent => Some("%"),
            _ => None,
        }
    }

    fn term(&mut self) -> Result<Term> {
        let token = self.take();
        match token.kind {
            TokenKind::Var(name) => {
                if name == "_" {
                    return Ok(self.counter.fresh("_"));
                }
                if let Some(existing) = self.scope.get(&name) {
                    return Ok(existing.clone());
                }
                let fresh = self.counter.fresh(name.clone());
                self.scope.insert(name, fresh.clone());
                Ok(fresh)
            }
            TokenKind::Str(raw) => decode_string(&raw).map(term::str_).map_err(|e| self.error_at(e, token.offset)),
            TokenKind::Number(text) => parse_number(&text).map_err(|e| self.error_at(e, token.offset)),
            TokenKind::Minus => {
                let number = self.term()?;
                match number {
                    Term::Int(v) => Ok(Term::Int(-v)),
                    Term::Float(v) => Ok(Term::Float(-v)),
                    _ => Err(self.error_at("Expected a number after minus in a term", token.offset)),
                }
            }
            TokenKind::LBracket => {
                if self.accept_punct(TokenKind::RBracket) {
                    return Ok(term::nil());
                }
                let mut items = vec![self.term()?];
                while self.accept_punct(TokenKind::Comma) {
                    items.push(self.term()?);
                }
                let tail = if self.accept_punct(TokenKind::Pipe) { self.term()? } else { term::nil() };
                self.expect_punct(TokenKind::RBracket, "]")?;
                Ok(items.into_iter().rev().fold(tail, |rest, item| term::cons(item, rest)))
            }
            TokenKind::Word(name) => {
                if name == "true" || name == "false" {
                    return Ok(term::boolean(name == "true"));
                }
                if !self.accept_punct(TokenKind::LParen) {
                    return Ok(term::atom(name));
                }
                let mut args = Vec::new();
                if !self.accept_punct(TokenKind::RParen) {
                    args.push(self.term()?);
                    while self.accept_punct(TokenKind::Comma) {
                        args.push(self.term()?);
                    }
                    self.expect_punct(TokenKind::RParen, ")")?;
                }
                Ok(term::struct_(name, args))
            }
            _ => Err(self.error_at("Expected a value or variable", token.offset)),
        }
    }

    fn expression(&mut self, min: u8) -> Result<Expr> {
        let mut left = if self.accept_punct(TokenKind::Minus) {
            Expr::Unary { arg: Box::new(self.expression(30)?) }
        } else if self.accept_punct(TokenKind::LParen) {
            let inner = self.expression(0)?;
            self.expect_punct(TokenKind::RParen, ")")?;
            inner
        } else if matches!(self.peek().kind, TokenKind::Word(_)) && matches!(self.tokens[self.pos + 1].kind, TokenKind::LParen) {
            let name = match self.take().kind {
                TokenKind::Word(w) => w,
                _ => unreachable!(),
            };
            self.expect_punct(TokenKind::LParen, "(")?;
            let mut args = Vec::new();
            if !self.accept_punct(TokenKind::RParen) {
                args.push(self.expression(0)?);
                while self.accept_punct(TokenKind::Comma) {
                    args.push(self.expression(0)?);
                }
                self.expect_punct(TokenKind::RParen, ")")?;
            }
            Expr::Function { name, args }
        } else {
            Expr::Value(self.term()?)
        };
        while let Some(op) = self.binary_op_text() {
            let prec = precedence(op).unwrap();
            if prec < min {
                break;
            }
            self.take();
            let right = self.expression(prec + 1)?;
            left = Expr::Binary { op: op.to_string(), left: Box::new(left), right: Box::new(right) };
        }
        Ok(left)
    }

    fn callable(&self, value: Term, offset: usize) -> Result<Term> {
        match value {
            Term::Atom(name) => Ok(term::struct_(name, Vec::new())),
            Term::Struct(name, args) if name != "cons" && name != "nil" => Ok(Term::Struct(name, args)),
            _ => Err(self.error_at("Expected a relation call", offset)),
        }
    }

    fn goal(&mut self) -> Result<Goal> {
        if self.accept_word("not") {
            let offset = self.peek().offset;
            let value = self.term()?;
            let call = self.callable(value, offset)?;
            return Ok(Goal::Not(call));
        }
        if self.accept_word("let") {
            let target = self.term()?;
            self.expect_punct(TokenKind::Eq, "=")?;
            let expr = self.expression(0)?;
            return Ok(Goal::Let { target, expr });
        }
        if self.accept_word("collect") {
            let target = self.term()?;
            self.expect_punct(TokenKind::Eq, "=")?;
            let template = self.term()?;
            if !self.accept_word("where") {
                return Err(self.error("Expected \"where\""));
            }
            self.expect_punct(TokenKind::LBrace, "{")?;
            let body = self.goals(&TokenKind::RBrace)?;
            self.expect_punct(TokenKind::RBrace, "}")?;
            return Ok(Goal::Collect { target, template, body });
        }
        let offset = self.peek().offset;
        let left = self.term()?;
        if let Some(op) = self.compare_op() {
            self.take();
            let right = self.term()?;
            return Ok(Goal::Compare { op: op.to_string(), left, right });
        }
        let call = self.callable(left, offset)?;
        Ok(Goal::Call(call))
    }

    fn goals(&mut self, end: &TokenKind) -> Result<Vec<Goal>> {
        if self.is_punct(end) {
            return Ok(Vec::new());
        }
        let mut body = vec![self.goal()?];
        while self.accept_punct(TokenKind::Comma) {
            body.push(self.goal()?);
        }
        Ok(body)
    }

    fn parse_program(&mut self) -> Result<Program> {
        let mut rules = Vec::new();
        let mut queries = Vec::new();
        while !matches!(self.peek().kind, TokenKind::Eof) {
            self.scope = HashMap::new();
            let location = self.location();
            if self.accept_word("ask") {
                let body = self.goals(&TokenKind::Dot)?;
                let variables = query_variables(&body);
                queries.push(Query { body, variables, location });
            } else {
                let offset = self.peek().offset;
                let head_value = self.term()?;
                let head = self.callable(head_value, offset)?;
                let body = if self.accept_word("if") { self.goals(&TokenKind::Dot)? } else { Vec::new() };
                let fact = body.is_empty() && ground(&head);
                rules.push(Rule { id: rules.len() + 1, head, body, location, fact });
            }
            self.expect_punct(TokenKind::Dot, ".")?;
        }
        Ok(Program { rules, queries })
    }
}

fn expr_variables(expr: &Expr, out: &mut Vec<(u64, Term)>) {
    match expr {
        Expr::Value(t) => variables_in(t, out),
        Expr::Unary { arg } => expr_variables(arg, out),
        Expr::Binary { left, right, .. } => {
            expr_variables(left, out);
            expr_variables(right, out);
        }
        Expr::Function { args, .. } => {
            for a in args {
                expr_variables(a, out);
            }
        }
    }
}

/// Variables referenced by a query body's own goals. Collection-local
/// variables do not escape into query results (mirrors `queryVariables` in
/// `parser.js`).
pub fn query_variables(body: &[Goal]) -> Vec<Term> {
    let mut vars: Vec<(u64, Term)> = Vec::new();
    for goal in body {
        match goal {
            Goal::Call(t) | Goal::Not(t) => variables_in(t, &mut vars),
            Goal::Compare { left, right, .. } => {
                variables_in(left, &mut vars);
                variables_in(right, &mut vars);
            }
            Goal::Let { target, expr } => {
                variables_in(target, &mut vars);
                expr_variables(expr, &mut vars);
            }
            Goal::Collect { target, .. } => variables_in(target, &mut vars),
        }
    }
    vars.into_iter().map(|(_, t)| t).collect()
}

/// Decode a `"..."` token's JSON string escapes by hand rather than via
/// `serde_json` (unavailable on the `wasm32` target — the same constraint
/// `output.rs`'s `--json` rendering works around).
fn decode_string(raw: &str) -> std::result::Result<String, String> {
    let inner = raw.strip_prefix('"').and_then(|s| s.strip_suffix('"')).ok_or_else(|| "Invalid string escape".to_string())?;
    let mut out = String::with_capacity(inner.len());
    let mut chars = inner.chars().peekable();
    while let Some(ch) = chars.next() {
        if ch != '\\' {
            out.push(ch);
            continue;
        }
        match chars.next() {
            Some('"') => out.push('"'),
            Some('\\') => out.push('\\'),
            Some('/') => out.push('/'),
            Some('b') => out.push('\u{8}'),
            Some('f') => out.push('\u{c}'),
            Some('n') => out.push('\n'),
            Some('r') => out.push('\r'),
            Some('t') => out.push('\t'),
            Some('u') => {
                let high = read_hex4(&mut chars)?;
                if (0xD800..=0xDBFF).contains(&high) {
                    if chars.next() != Some('\\') || chars.next() != Some('u') {
                        return Err("Invalid surrogate pair escape".to_string());
                    }
                    let low = read_hex4(&mut chars)?;
                    if !(0xDC00..=0xDFFF).contains(&low) {
                        return Err("Invalid surrogate pair escape".to_string());
                    }
                    let code = 0x10000 + ((high - 0xD800) << 10) + (low - 0xDC00);
                    out.push(char::from_u32(code).ok_or_else(|| "Invalid \\u escape".to_string())?);
                } else {
                    out.push(char::from_u32(high).ok_or_else(|| "Invalid \\u escape".to_string())?);
                }
            }
            _ => return Err("Invalid string escape".to_string()),
        }
    }
    Ok(out)
}

fn read_hex4(chars: &mut std::iter::Peekable<std::str::Chars>) -> std::result::Result<u32, String> {
    let mut value = 0u32;
    for _ in 0..4 {
        let digit = chars.next().and_then(|c| c.to_digit(16)).ok_or_else(|| "Invalid \\u escape".to_string())?;
        value = value * 16 + digit;
    }
    Ok(value)
}

fn parse_number(text: &str) -> std::result::Result<Term, String> {
    if text.contains('.') || text.contains('e') || text.contains('E') {
        let value: f64 = text.parse().map_err(|_| "Invalid number".to_string())?;
        if !value.is_finite() {
            return Err("Number must be finite".to_string());
        }
        Ok(term::float(value))
    } else {
        let value: num_bigint::BigInt = text.parse().map_err(|_| "Invalid integer".to_string())?;
        Ok(Term::Int(value))
    }
}

/// Parse a whole Eyelang source document, using and advancing `counter` for
/// every variable minted while parsing (both `?name` occurrences and `?_`
/// anonymous variables), so that later evaluation-time fresh variables
/// never collide with parse-time ones.
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
        parse(source, &mut counter).unwrap()
    }

    #[test]
    fn parses_a_fact() {
        let program = parse_ok("parent(alice, bob).");
        assert_eq!(program.rules.len(), 1);
        assert!(program.rules[0].fact);
        assert_eq!(program.rules[0].head, term::struct_("parent", vec![term::atom("alice"), term::atom("bob")]));
    }

    #[test]
    fn parses_a_rule_with_body() {
        let program = parse_ok("ancestor(?x, ?y) if parent(?x, ?y).");
        assert_eq!(program.rules.len(), 1);
        assert!(!program.rules[0].fact);
        assert_eq!(program.rules[0].body.len(), 1);
    }

    #[test]
    fn shares_variables_within_one_statement() {
        let program = parse_ok("ancestor(?x, ?y) if parent(?x, ?z), ancestor(?z, ?y).");
        let head_x = match &program.rules[0].head {
            Term::Struct(_, args) => args[0].clone(),
            _ => panic!(),
        };
        let Goal::Call(first_body) = &program.rules[0].body[0] else { panic!() };
        let Term::Struct(_, first_args) = first_body else { panic!() };
        assert_eq!(&first_args[0], &head_x);
    }

    #[test]
    fn parses_a_query_with_ask() {
        let program = parse_ok("ask parent(?x, bob).");
        assert_eq!(program.queries.len(), 1);
        assert_eq!(program.queries[0].variables.len(), 1);
    }

    #[test]
    fn parses_negative_number_literal() {
        let program = parse_ok("value(-3).");
        assert_eq!(program.rules[0].head, term::struct_("value", vec![Term::Int(num_bigint::BigInt::from(-3))]));
    }

    #[test]
    fn parses_let_and_expression_precedence() {
        let program = parse_ok("ask let ?x = 1 + 2 * 3.");
        assert_eq!(program.queries[0].body.len(), 1);
        let Goal::Let { expr, .. } = &program.queries[0].body[0] else { panic!() };
        match expr {
            Expr::Binary { op, right, .. } => {
                assert_eq!(op, "+");
                assert!(matches!(**right, Expr::Binary { .. }));
            }
            _ => panic!("expected binary"),
        }
    }

    #[test]
    fn parses_list_sugar() {
        let program = parse_ok("value([1, 2 | ?rest]).");
        match &program.rules[0].head {
            Term::Struct(_, args) => match &args[0] {
                Term::Struct(name, cons_args) => {
                    assert_eq!(name, "cons");
                    assert_eq!(cons_args.len(), 2);
                }
                _ => panic!(),
            },
            _ => panic!(),
        }
    }

    #[test]
    fn rejects_cons_as_a_relation_call() {
        let mut counter = VarCounter::new();
        assert!(parse("cons(1, 2).", &mut counter).is_err());
    }

    #[test]
    fn parses_collect() {
        let program = parse_ok("ask collect ?xs = ?x where { parent(?x, ?y) }.");
        let Goal::Collect { body, .. } = &program.queries[0].body[0] else { panic!() };
        assert_eq!(body.len(), 1);
    }
}
