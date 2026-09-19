//! SPARQL 1.2 RL expression evaluator (`FILTER`/`SET` right-hand sides).
//!
//! Ported from eyeleng's `src/builtins.js`/`src/term.js`. eyeron's existing
//! built-ins (`crate::n3::reasoner::eval_builtin`) are all binary triple
//! relations dispatched by predicate IRI (e.g. `(?a ?b) math:sum ?c`);
//! SPARQL-RL's `FILTER`/`SET` expressions are genuinely nested (`(?v1 = 0)
//! || (?v2 = 0)`, `YEAR(?when)`), so this module implements a small
//! tree-walking expression evaluator instead of reusing that dispatch
//! table directly. It does reuse eyeron's numeric-literal and
//! value-equality helpers (`crate::n3::reasoner::{numeric_value,
//! numeric_literal, terms_equal_semantic}`) so a `FILTER(?p > 1500)` in an
//! SRL rule and a `?p math:greaterThan 1500` premise in an N3 rule agree on
//! what "numeric" and "equal" mean.
//!
//! Every evaluated result is represented uniformly as a `crate::ast::Term`
//! (booleans and numbers become `Literal`s) rather than mixing raw
//! primitives and terms the way the JS reference implementation does; this
//! is a Rust-idiomatic simplification, not a semantic change.

use std::cell::Cell;
use std::cmp::Ordering;

use crate::ast::{Literal, Term, Triple};
use crate::n3::parser::boolean_literal;
use crate::n3::reasoner::{numeric_literal, numeric_value, terms_equal_semantic, Bindings, Numeric};

use super::ast::{BinaryOp, Expr, UnaryOp};

const XSD_NS: &str = "http://www.w3.org/2001/XMLSchema#";
const XSD_STRING: &str = "http://www.w3.org/2001/XMLSchema#string";
const XSD_BOOLEAN: &str = "http://www.w3.org/2001/XMLSchema#boolean";
const XSD_INTEGER: &str = "http://www.w3.org/2001/XMLSchema#integer";
const XSD_DECIMAL: &str = "http://www.w3.org/2001/XMLSchema#decimal";
const XSD_DOUBLE: &str = "http://www.w3.org/2001/XMLSchema#double";
const RDF_LANG_STRING: &str = "http://www.w3.org/1999/02/22-rdf-syntax-ns#langString";
const RDF_DIR_LANG_STRING: &str = "http://www.w3.org/1999/02/22-rdf-syntax-ns#dirLangString";
const XSD_DAY_TIME_DURATION: &str = "http://www.w3.org/2001/XMLSchema#dayTimeDuration";
const XSD_DATE_TIME: &str = "http://www.w3.org/2001/XMLSchema#dateTime";

/// The exact set of built-in function names the SPARQL 1.2 RL grammar
/// recognizes as unprefixed calls (`CONCAT(...)`, `isNUMERIC(...)`, ...).
/// Case-insensitive at the call site; stored upper-case here.
const BUILTIN_NAMES: &[&str] = &[
    "STR", "LANG", "LANGMATCHES", "LANGDIR", "DATATYPE", "IRI", "URI", "BNODE", "ABS", "CEIL",
    "FLOOR", "ROUND", "CONCAT", "SUBSTR", "STRLEN", "REPLACE", "UCASE", "LCASE", "ENCODE_FOR_URI",
    "CONTAINS", "STRSTARTS", "STRENDS", "STRBEFORE", "STRAFTER", "YEAR", "MONTH", "DAY", "HOURS",
    "MINUTES", "SECONDS", "TIMEZONE", "TZ", "NOW", "UUID", "STRUUID", "IF", "STRLANG",
    "STRLANGDIR", "STRDT", "SAMETERM", "ISIRI", "ISURI", "ISBLANK", "ISLITERAL", "ISNUMERIC",
    "HASLANG", "HASLANGDIR", "REGEX", "ISTRIPLE", "TRIPLE", "SUBJECT", "PREDICATE", "OBJECT",
];

pub fn is_builtin_name(name: &str) -> bool {
    BUILTIN_NAMES.contains(&name.to_ascii_uppercase().as_str())
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct EvalError(pub String);

impl std::fmt::Display for EvalError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.0)
    }
}

pub type EvalResult = Result<Term, EvalError>;

fn err(msg: impl Into<String>) -> EvalError {
    EvalError(msg.into())
}

/// Per-rule-evaluation context for the non-deterministic/time-sensitive
/// built-ins (`NOW`, `UUID`, `STRUUID`, `BNODE()` with no arguments). `now`
/// is fixed once per reasoning run (SPARQL's `NOW()` is stable within one
/// query execution), matching eyeleng's `options.now || new Date()`.
pub struct EvalCtx {
    pub now: String,
    uuid_counter: Cell<u64>,
    blank_counter: Cell<u64>,
}

impl EvalCtx {
    pub fn new() -> Self {
        Self { now: now_iso8601(), uuid_counter: Cell::new(0), blank_counter: Cell::new(0) }
    }

    fn next_uuid(&self) -> String {
        let n = self.uuid_counter.get() + 1;
        self.uuid_counter.set(n);
        format!("00000000-0000-4000-8000-{:012}", n)
    }

    fn next_blank(&self) -> String {
        let n = self.blank_counter.get() + 1;
        self.blank_counter.set(n);
        format!("srl{}", n)
    }
}

impl Default for EvalCtx {
    fn default() -> Self {
        Self::new()
    }
}

fn now_iso8601() -> String {
    // `SystemTime::now()` panics unconditionally on wasm32-unknown-unknown;
    // `current_unix_time` already handles that (see its doc comment).
    let (secs, _millis) = crate::n3::reasoner::current_unix_time().unwrap_or((0, 0));
    let (year, month, day, hour, minute, second) = civil_from_unix(secs);
    format!("{:04}-{:02}-{:02}T{:02}:{:02}:{:02}Z", year, month, day, hour, minute, second)
}

/// Civil calendar date/time from a Unix timestamp (UTC), using Howard
/// Hinnant's days-from-civil algorithm. Self-contained so this module does
/// not need a date/time crate dependency.
fn civil_from_unix(unix_secs: i64) -> (i64, u32, u32, u32, u32, u32) {
    let days = unix_secs.div_euclid(86400);
    let secs_of_day = unix_secs.rem_euclid(86400);
    let hour = (secs_of_day / 3600) as u32;
    let minute = ((secs_of_day % 3600) / 60) as u32;
    let second = (secs_of_day % 60) as u32;

    let z = days + 719468;
    let era = if z >= 0 { z } else { z - 146096 } / 146097;
    let doe = (z - era * 146097) as u64;
    let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
    let y = yoe as i64 + era * 400;
    let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    let mp = (5 * doy + 2) / 153;
    let d = (doy - (153 * mp + 2) / 5 + 1) as u32;
    let m = if mp < 10 { mp + 3 } else { mp - 9 } as u32;
    let year = if m <= 2 { y + 1 } else { y };
    (year, m, d, hour, minute, second)
}

pub fn eval_expr(expr: &Expr, bindings: &Bindings, ctx: &EvalCtx) -> EvalResult {
    match expr {
        Expr::Var(name) => bindings.get(name).cloned().ok_or_else(|| err(format!("unbound variable ?{}", name))),
        Expr::Term(term) => Ok(term.clone()),
        Expr::List(_) => Err(err("a term list may only appear on the right-hand side of IN/NOT IN")),
        Expr::Unary { op, expr } => {
            let v = eval_expr(expr, bindings, ctx)?;
            match op {
                UnaryOp::Not => Ok(boolean_literal(!boolean_value(&v))),
                UnaryOp::Neg => {
                    let n = numeric_of(&v)?;
                    Ok(numeric_literal(-n.value, n.integer))
                }
                UnaryOp::Plus => {
                    let n = numeric_of(&v)?;
                    Ok(numeric_literal(n.value, n.integer))
                }
            }
        }
        Expr::Binary { op: BinaryOp::And, left, right } => {
            let l = eval_expr(left, bindings, ctx)?;
            if !boolean_value(&l) {
                return Ok(boolean_literal(false));
            }
            let r = eval_expr(right, bindings, ctx)?;
            Ok(boolean_literal(boolean_value(&r)))
        }
        Expr::Binary { op: BinaryOp::Or, left, right } => {
            let l = eval_expr(left, bindings, ctx)?;
            if boolean_value(&l) {
                return Ok(boolean_literal(true));
            }
            let r = eval_expr(right, bindings, ctx)?;
            Ok(boolean_literal(boolean_value(&r)))
        }
        Expr::Binary { op: op @ (BinaryOp::In | BinaryOp::NotIn), left, right } => {
            let l = eval_expr(left, bindings, ctx)?;
            let Expr::List(items) = right.as_ref() else { return Err(err("IN/NOT IN expects a parenthesized list")) };
            let mut found = false;
            for item in items {
                let v = eval_expr(item, bindings, ctx)?;
                if terms_equal_semantic(&l, &v) {
                    found = true;
                    break;
                }
            }
            Ok(boolean_literal(if *op == BinaryOp::In { found } else { !found }))
        }
        Expr::Binary { op, left, right } => {
            let l = eval_expr(left, bindings, ctx)?;
            let r = eval_expr(right, bindings, ctx)?;
            eval_binary(*op, &l, &r)
        }
        Expr::Call { name, args } => eval_call(name, args, bindings, ctx),
    }
}

fn eval_binary(op: BinaryOp, l: &Term, r: &Term) -> EvalResult {
    match op {
        BinaryOp::Eq => Ok(boolean_literal(terms_equal_semantic(l, r))),
        BinaryOp::NotEq => Ok(boolean_literal(!terms_equal_semantic(l, r))),
        BinaryOp::Lt => Ok(boolean_literal(compare_primitives(l, r)? == Ordering::Less)),
        BinaryOp::Le => Ok(boolean_literal(compare_primitives(l, r)? != Ordering::Greater)),
        BinaryOp::Gt => Ok(boolean_literal(compare_primitives(l, r)? == Ordering::Greater)),
        BinaryOp::Ge => Ok(boolean_literal(compare_primitives(l, r)? != Ordering::Less)),
        BinaryOp::Add => match (numeric_value(l), numeric_value(r)) {
            (Some(a), Some(b)) => Ok(numeric_result(a.value + b.value)),
            _ => Ok(str_literal(format!("{}{}", string_value(l), string_value(r)))),
        },
        BinaryOp::Sub => {
            let a = numeric_of(l)?;
            let b = numeric_of(r)?;
            Ok(numeric_result(a.value - b.value))
        }
        BinaryOp::Mul => {
            let a = numeric_of(l)?;
            let b = numeric_of(r)?;
            Ok(numeric_result(a.value * b.value))
        }
        BinaryOp::Div => {
            let a = numeric_of(l)?;
            let b = numeric_of(r)?;
            if b.value == 0.0 {
                return Err(err("division by zero"));
            }
            Ok(numeric_result(a.value / b.value))
        }
        BinaryOp::In | BinaryOp::NotIn | BinaryOp::And | BinaryOp::Or => unreachable!("handled in eval_expr"),
    }
}

fn numeric_result(value: f64) -> Term {
    numeric_literal(value, value.fract() == 0.0)
}

fn numeric_of(term: &Term) -> Result<Numeric, EvalError> {
    numeric_value(term).ok_or_else(|| err(format!("expected a numeric value, got {:?}", term)))
}

fn compare_primitives(a: &Term, b: &Term) -> Result<Ordering, EvalError> {
    if let (Some(na), Some(nb)) = (numeric_value(a), numeric_value(b)) {
        return na.value.partial_cmp(&nb.value).ok_or_else(|| err("cannot compare NaN"));
    }
    Ok(string_value(a).cmp(&string_value(b)))
}

pub fn boolean_value(term: &Term) -> bool {
    match term {
        Term::Literal(lit) => {
            if lit.datatype.as_deref() == Some(XSD_BOOLEAN) {
                return lit.value == "true" || lit.value == "1";
            }
            if let Some(n) = numeric_value(term) {
                return n.value != 0.0 && !n.value.is_nan();
            }
            if lit.datatype.is_none() || lit.datatype.as_deref() == Some(XSD_STRING) {
                return !lit.value.is_empty() && lit.value != "false";
            }
            // A literal with an unrecognized datatype: eyeleng's reference
            // implementation falls through to a generic truthy check here
            // rather than raising a type error, and this port matches that
            // pragmatic (if not fully SPARQL-EBV-formal) behavior.
            true
        }
        _ => true,
    }
}

fn str_literal(value: impl Into<String>) -> Term {
    Term::Literal(Literal::plain(value))
}

fn string_value(term: &Term) -> String {
    match term {
        Term::Literal(lit) => lit.value.clone(),
        Term::Iri(iri) => iri.clone(),
        Term::Blank(label) => format!("_:{}", label),
        Term::Var(name) => format!("?{}", name),
        Term::Formula(triples) if triples.len() == 1 => format_triple(&triples[0]),
        _ => format!("{:?}", term),
    }
}

fn format_triple(triple: &Triple) -> String {
    format!("<<( {} {} {} )>>", format_term_compact(&triple.s), format_term_compact(&triple.p), format_term_compact(&triple.o))
}

fn format_term_compact(term: &Term) -> String {
    match term {
        Term::Iri(iri) => format!("<{}>", iri),
        Term::Literal(lit) => format!("\"{}\"", lit.value),
        Term::Blank(label) => format!("_:{}", label),
        Term::Var(name) => format!("?{}", name),
        Term::Formula(triples) if triples.len() == 1 => format_triple(&triples[0]),
        other => format!("{:?}", other),
    }
}

fn is_triple_term(term: &Term) -> bool {
    matches!(term, Term::Formula(triples) if triples.len() == 1)
}

fn triple_component(term: &Term, index: usize) -> EvalResult {
    match term {
        Term::Formula(triples) if triples.len() == 1 => {
            let t = &triples[0];
            Ok(match index {
                0 => t.s.clone(),
                1 => t.p.clone(),
                _ => t.o.clone(),
            })
        }
        _ => Err(err("expected a triple term")),
    }
}

fn lang_of(term: &Term) -> String {
    match term {
        Term::Literal(lit) => lit.language.as_deref().map(base_lang).unwrap_or_default(),
        _ => String::new(),
    }
}

fn langdir_of(term: &Term) -> String {
    match term {
        Term::Literal(lit) => lit.language.as_deref().and_then(base_dir).unwrap_or_default(),
        _ => String::new(),
    }
}

fn has_lang(term: &Term) -> bool {
    matches!(term, Term::Literal(lit) if lit.language.is_some())
}

fn has_langdir(term: &Term) -> bool {
    matches!(term, Term::Literal(lit) if lit.language.as_deref().and_then(base_dir).is_some())
}

/// eyeron folds RDF 1.2 base direction into `Literal.language` as
/// `"en--ltr"`; split that back into the plain language tag.
fn base_lang(language: &str) -> String {
    match language.find("--") {
        Some(idx) => language[..idx].to_string(),
        None => language.to_string(),
    }
}

fn base_dir(language: &str) -> Option<String> {
    language.find("--").map(|idx| language[idx + 2..].to_string())
}

fn lang_matches(lang: &str, range: &str) -> bool {
    if range == "*" {
        return !lang.is_empty();
    }
    lang.eq_ignore_ascii_case(range) || lang.to_ascii_lowercase().starts_with(&format!("{}-", range.to_ascii_lowercase()))
}

fn datatype_of(term: &Term) -> EvalResult {
    match term {
        Term::Literal(lit) => {
            if let Some(lang) = &lit.language {
                return Ok(Term::iri(if base_dir(lang).is_some() { RDF_DIR_LANG_STRING } else { RDF_LANG_STRING }));
            }
            Ok(Term::iri(lit.datatype.clone().unwrap_or_else(|| XSD_STRING.to_string())))
        }
        _ => Err(err("DATATYPE expects a literal")),
    }
}

fn xsd_cast_datatype(name: &str) -> Option<&'static str> {
    if !name.starts_with(XSD_NS) {
        return None;
    }
    match name {
        XSD_STRING => Some(XSD_STRING),
        XSD_BOOLEAN => Some(XSD_BOOLEAN),
        XSD_INTEGER => Some(XSD_INTEGER),
        XSD_DECIMAL => Some(XSD_DECIMAL),
        XSD_DOUBLE => Some(XSD_DOUBLE),
        _ => None,
    }
}

fn cast_xsd(datatype: &str, value: &Term) -> EvalResult {
    match datatype {
        XSD_STRING => Ok(Term::Literal(Literal { value: string_value(value), datatype: Some(XSD_STRING.to_string()), language: None })),
        XSD_BOOLEAN => {
            if let Some(n) = numeric_value(value) {
                return Ok(boolean_literal(n.value != 0.0 && !n.value.is_nan()));
            }
            let lexical = string_value(value);
            match lexical.trim() {
                "true" | "1" => Ok(boolean_literal(true)),
                "false" | "0" => Ok(boolean_literal(false)),
                other => Err(err(format!("cannot cast {} to xsd:boolean", other))),
            }
        }
        XSD_INTEGER => {
            if let Term::Literal(lit) = value {
                if lit.datatype.as_deref() == Some(XSD_BOOLEAN) {
                    return Ok(numeric_literal(if lit.value == "true" { 1.0 } else { 0.0 }, true));
                }
            }
            let numeric = numeric_value(value).map(|n| n.value).or_else(|| string_value(value).trim().parse::<f64>().ok());
            match numeric {
                Some(n) if n.is_finite() => Ok(numeric_literal(n.trunc(), true)),
                _ => Err(err(format!("cannot cast {} to xsd:integer", string_value(value)))),
            }
        }
        XSD_DECIMAL | XSD_DOUBLE => {
            let numeric = numeric_value(value).map(|n| n.value).or_else(|| string_value(value).trim().parse::<f64>().ok());
            match numeric {
                Some(n) if !n.is_nan() => Ok(Term::Literal(Literal { value: trim_float(n), datatype: Some(datatype.to_string()), language: None })),
                _ => Err(err(format!("cannot cast {} to {}", string_value(value), datatype))),
            }
        }
        other => Err(err(format!("unsupported XSD cast {}", other))),
    }
}

fn trim_float(value: f64) -> String {
    if value.fract() == 0.0 && value.is_finite() {
        format!("{:.1}", value)
    } else {
        let mut s = value.to_string();
        if !s.contains('.') {
            s.push_str(".0");
        }
        s
    }
}

fn eval_call(name: &str, args: &[Expr], bindings: &Bindings, ctx: &EvalCtx) -> EvalResult {
    if name == "IF" {
        if args.len() != 3 {
            return Err(err(format!("IF expects 3 arguments, got {}", args.len())));
        }
        let cond = eval_expr(&args[0], bindings, ctx)?;
        return eval_expr(if boolean_value(&cond) { &args[1] } else { &args[2] }, bindings, ctx);
    }
    if let Some(datatype) = xsd_cast_datatype(name) {
        if args.len() != 1 {
            return Err(err(format!("{} expects 1 argument, got {}", name, args.len())));
        }
        let v = eval_expr(&args[0], bindings, ctx)?;
        return cast_xsd(datatype, &v);
    }
    let mut values = Vec::with_capacity(args.len());
    for arg in args {
        values.push(eval_expr(arg, bindings, ctx)?);
    }
    call_builtin(name, &values, ctx)
}

fn check_arity(name: &str, got: usize, min: usize, max: Option<usize>) -> Result<(), EvalError> {
    let ok = got >= min && max.is_none_or(|m| got <= m);
    if ok {
        Ok(())
    } else {
        let expected = match max {
            Some(m) if m == min => format!("{}", min),
            Some(m) => format!("{}-{}", min, m),
            None => format!("at least {}", min),
        };
        Err(err(format!("{} expects {} argument(s), got {}", name, expected, got)))
    }
}

fn builtin_arity(name: &str) -> Option<(usize, Option<usize>)> {
    Some(match name {
        "STR" | "LANG" | "LANGDIR" | "DATATYPE" | "IRI" | "URI" | "ABS" | "CEIL" | "FLOOR" | "ROUND" | "STRLEN"
        | "UCASE" | "LCASE" | "ENCODE_FOR_URI" | "YEAR" | "MONTH" | "DAY" | "HOURS" | "MINUTES" | "SECONDS"
        | "TIMEZONE" | "TZ" | "ISIRI" | "ISURI" | "ISBLANK" | "ISLITERAL" | "ISNUMERIC" | "HASLANG"
        | "HASLANGDIR" | "ISTRIPLE" | "SUBJECT" | "PREDICATE" | "OBJECT" => (1, Some(1)),
        "LANGMATCHES" | "CONTAINS" | "STRSTARTS" | "STRENDS" | "STRBEFORE" | "STRAFTER" | "STRDT" | "STRLANG" | "SAMETERM" => (2, Some(2)),
        "STRLANGDIR" => (3, Some(3)),
        "SUBSTR" => (2, Some(3)),
        "REPLACE" => (3, Some(4)),
        "REGEX" => (2, Some(3)),
        "CONCAT" => (0, None),
        "BNODE" => (0, Some(1)),
        "NOW" | "UUID" | "STRUUID" => (0, Some(0)),
        "TRIPLE" => (3, Some(3)),
        "IF" => (3, Some(3)),
        _ => return None,
    })
}

fn call_builtin(name: &str, args: &[Term], ctx: &EvalCtx) -> EvalResult {
    let (min, max) = builtin_arity(name).ok_or_else(|| err(format!("unknown builtin {}", name)))?;
    check_arity(name, args.len(), min, max)?;
    match name {
        "STR" => Ok(str_literal(string_value(&args[0]))),
        "IRI" | "URI" => Ok(Term::iri(string_value(&args[0]))),
        "BNODE" => {
            if args.is_empty() {
                Ok(Term::blank(ctx.next_blank()))
            } else {
                Ok(Term::blank(string_value(&args[0])))
            }
        }
        "CONCAT" => Ok(str_literal(args.iter().map(string_value).collect::<String>())),
        "LCASE" => Ok(str_literal(string_value(&args[0]).to_lowercase())),
        "UCASE" => Ok(str_literal(string_value(&args[0]).to_uppercase())),
        "CONTAINS" => Ok(boolean_literal(string_value(&args[0]).contains(&string_value(&args[1])))),
        "STRSTARTS" => Ok(boolean_literal(string_value(&args[0]).starts_with(&string_value(&args[1])))),
        "STRENDS" => Ok(boolean_literal(string_value(&args[0]).ends_with(&string_value(&args[1])))),
        "STRBEFORE" => {
            let s = string_value(&args[0]);
            let needle = string_value(&args[1]);
            Ok(str_literal(match s.find(&needle) {
                Some(idx) => s[..idx].to_string(),
                None => String::new(),
            }))
        }
        "STRAFTER" => {
            let s = string_value(&args[0]);
            let needle = string_value(&args[1]);
            Ok(str_literal(match s.find(&needle) {
                Some(idx) => s[idx + needle.len()..].to_string(),
                None => String::new(),
            }))
        }
        "ENCODE_FOR_URI" => Ok(str_literal(percent_encode(&string_value(&args[0])))),
        "REGEX" => {
            let flags = args.get(2).map(string_value).unwrap_or_default();
            let re = build_regex(&string_value(&args[1]), &flags)?;
            Ok(boolean_literal(re.is_match(&string_value(&args[0]))))
        }
        "REPLACE" => {
            let flags = args.get(3).map(string_value).unwrap_or_default();
            let re = build_regex(&string_value(&args[1]), &flags)?;
            let replacement = translate_regex_replacement(&string_value(&args[2]));
            Ok(str_literal(re.replace_all(&string_value(&args[0]), replacement.as_str()).into_owned()))
        }
        "SUBSTR" => {
            let value = string_value(&args[0]);
            let chars: Vec<char> = value.chars().collect();
            let start_arg = numeric_of(&args[1])?.value;
            let start = ((start_arg - 1.0).max(0.0)) as usize;
            let end = if args.len() >= 3 {
                let len = numeric_of(&args[2])?.value;
                (start + len.max(0.0) as usize).min(chars.len())
            } else {
                chars.len()
            };
            let start = start.min(chars.len());
            let end = end.max(start);
            Ok(str_literal(chars[start..end].iter().collect::<String>()))
        }
        "SAMETERM" => Ok(boolean_literal(args[0] == args[1])),
        "ISIRI" | "ISURI" => Ok(boolean_literal(matches!(args[0], Term::Iri(_)))),
        "ISBLANK" => Ok(boolean_literal(matches!(args[0], Term::Blank(_)))),
        "ISLITERAL" => Ok(boolean_literal(matches!(args[0], Term::Literal(_)))),
        "ISTRIPLE" => Ok(boolean_literal(is_triple_term(&args[0]))),
        "ISNUMERIC" => Ok(boolean_literal(numeric_value(&args[0]).is_some())),
        "DATATYPE" => datatype_of(&args[0]),
        "LANG" => Ok(str_literal(lang_of(&args[0]))),
        "LANGMATCHES" => Ok(boolean_literal(lang_matches(&string_value(&args[0]), &string_value(&args[1])))),
        "HASLANG" => Ok(boolean_literal(has_lang(&args[0]))),
        "LANGDIR" => Ok(str_literal(langdir_of(&args[0]))),
        "HASLANGDIR" => Ok(boolean_literal(has_langdir(&args[0]))),
        "STRLEN" => Ok(numeric_literal(string_value(&args[0]).chars().count() as f64, true)),
        "ABS" => Ok(numeric_result(numeric_of(&args[0])?.value.abs())),
        "FLOOR" => Ok(numeric_result(numeric_of(&args[0])?.value.floor())),
        "CEIL" => Ok(numeric_result(numeric_of(&args[0])?.value.ceil())),
        "ROUND" => Ok(numeric_result((numeric_of(&args[0])?.value + 0.5).floor())),
        "STRDT" => Ok(Term::Literal(Literal { value: string_value(&args[0]), datatype: Some(string_value(&args[1])), language: None })),
        "STRLANG" => Ok(Term::Literal(Literal { value: string_value(&args[0]), datatype: None, language: Some(string_value(&args[1]).to_lowercase()) })),
        "STRLANGDIR" => {
            let lang = string_value(&args[1]).to_lowercase();
            let dir = string_value(&args[2]).to_lowercase();
            if dir != "ltr" && dir != "rtl" {
                return Err(err(format!("invalid base direction {}; expected ltr or rtl", dir)));
            }
            Ok(Term::Literal(Literal { value: string_value(&args[0]), datatype: None, language: Some(format!("{}--{}", lang, dir)) }))
        }
        "TRIPLE" => Ok(Term::formula(vec![Triple::new(args[0].clone(), args[1].clone(), args[2].clone())])),
        "SUBJECT" => triple_component(&args[0], 0),
        "PREDICATE" => triple_component(&args[0], 1),
        "OBJECT" => triple_component(&args[0], 2),
        "YEAR" => date_part(&args[0], DatePart::Year),
        "MONTH" => date_part(&args[0], DatePart::Month),
        "DAY" => date_part(&args[0], DatePart::Day),
        "HOURS" => date_part(&args[0], DatePart::Hours),
        "MINUTES" => date_part(&args[0], DatePart::Minutes),
        "SECONDS" => date_part(&args[0], DatePart::Seconds),
        "TIMEZONE" => timezone_duration(&string_value(&args[0])),
        "TZ" => Ok(str_literal(timezone_lexical(&string_value(&args[0])))),
        "NOW" => Ok(Term::Literal(Literal { value: ctx.now.clone(), datatype: Some(XSD_DATE_TIME.to_string()), language: None })),
        "UUID" => Ok(Term::iri(format!("urn:uuid:{}", ctx.next_uuid()))),
        "STRUUID" => Ok(str_literal(ctx.next_uuid())),
        other => Err(err(format!("unimplemented builtin {}", other))),
    }
}

fn percent_encode(value: &str) -> String {
    let mut out = String::with_capacity(value.len());
    for byte in value.bytes() {
        let ch = byte as char;
        if ch.is_ascii_alphanumeric() || matches!(ch, '-' | '_' | '.' | '~') {
            out.push(ch);
        } else {
            out.push_str(&format!("%{:02X}", byte));
        }
    }
    out
}

fn build_regex(pattern: &str, flags: &str) -> Result<regex::Regex, EvalError> {
    let mut builder = regex::RegexBuilder::new(pattern);
    for ch in flags.chars() {
        match ch {
            'i' => {
                builder.case_insensitive(true);
            }
            'm' => {
                builder.multi_line(true);
            }
            's' => {
                builder.dot_matches_new_line(true);
            }
            // SPARQL/XPath's free-spacing "x" flag and JS-specific u/y/g
            // flags have no equivalent (or no meaning) in the `regex`
            // crate's syntax; silently ignored, matching eyeleng's own
            // `regexFlags` comment about the "x" flag.
            _ => {}
        }
    }
    builder.build().map_err(|e| err(format!("invalid regular expression: {}", e)))
}

/// SPARQL/XPath backreferences in a `REPLACE` replacement string use `$1`,
/// `$2`, ...; the `regex` crate's replacement syntax already matches this,
/// so this is currently a passthrough kept as a named step for clarity and
/// as the natural place to handle `\$`-style escaping if a future SRL test
/// requires it.
fn translate_regex_replacement(value: &str) -> String {
    value.to_string()
}

#[derive(Clone, Copy)]
enum DatePart {
    Year,
    Month,
    Day,
    Hours,
    Minutes,
    Seconds,
}

struct ParsedDateTime {
    year: i64,
    month: u32,
    day: u32,
    hours: u32,
    minutes: u32,
    seconds: f64,
}

fn parse_lexical_datetime(lexical: &str) -> Option<ParsedDateTime> {
    // `-?YYYY-MM-DD(THH:MM:SS(.fff)?(Z|+HH:MM|-HH:MM)?)?`
    let (sign, rest) = match lexical.strip_prefix('-') {
        Some(r) => (-1i64, r),
        None => (1i64, lexical),
    };
    let mut parts = rest.splitn(2, 'T');
    let date_part = parts.next()?;
    let time_part = parts.next();

    let mut date_fields = date_part.split('-');
    let year: i64 = date_fields.next()?.parse().ok()?;
    let month: u32 = date_fields.next()?.parse().ok()?;
    let day: u32 = date_fields.next()?.parse().ok()?;

    let (hours, minutes, seconds) = if let Some(time) = time_part {
        let time = time.trim_end_matches('Z');
        let time = match time.find(['+', '-']) {
            Some(idx) if idx > 0 => &time[..idx],
            _ => time,
        };
        let mut time_fields = time.split(':');
        let h: u32 = time_fields.next()?.parse().ok()?;
        let m: u32 = time_fields.next()?.parse().ok()?;
        let s: f64 = time_fields.next().unwrap_or("0").parse().ok()?;
        (h, m, s)
    } else {
        (0, 0, 0.0)
    };

    Some(ParsedDateTime { year: sign * year, month, day, hours, minutes, seconds })
}

fn date_part(term: &Term, part: DatePart) -> EvalResult {
    let lexical = string_value(term);
    let Some(parsed) = parse_lexical_datetime(&lexical) else { return Ok(Term::Literal(Literal::plain(""))) };
    Ok(match part {
        DatePart::Year => numeric_literal(parsed.year as f64, true),
        DatePart::Month => numeric_literal(parsed.month as f64, true),
        DatePart::Day => numeric_literal(parsed.day as f64, true),
        DatePart::Hours => numeric_literal(parsed.hours as f64, true),
        DatePart::Minutes => numeric_literal(parsed.minutes as f64, true),
        DatePart::Seconds => numeric_literal(parsed.seconds, parsed.seconds.fract() == 0.0),
    })
}

fn timezone_lexical(lexical: &str) -> String {
    if lexical.ends_with('Z') && lexical.contains('T') {
        return "Z".to_string();
    }
    if let Some(t_idx) = lexical.find('T') {
        let time = &lexical[t_idx..];
        if let Some(sign_idx) = time.rfind(['+', '-']) {
            // Guard against picking up the date's own leading '-' sign
            // (e.g. a negative year) by only looking within the time part.
            return time[sign_idx..].to_string();
        }
    }
    String::new()
}

fn timezone_duration(lexical: &str) -> EvalResult {
    let zone = timezone_lexical(lexical);
    if zone.is_empty() {
        return Ok(Term::Literal(Literal::plain("")));
    }
    if zone == "Z" {
        return Ok(Term::Literal(Literal { value: "PT0S".to_string(), datatype: Some(XSD_DAY_TIME_DURATION.to_string()), language: None }));
    }
    let (sign, rest) = if let Some(r) = zone.strip_prefix('-') { ("-", r) } else { (zone.as_str().strip_prefix('+').map(|_| "").unwrap_or(""), zone.trim_start_matches('+')) };
    let mut fields = rest.split(':');
    let hours: u32 = fields.next().and_then(|s| s.parse().ok()).unwrap_or(0);
    let minutes: u32 = fields.next().and_then(|s| s.parse().ok()).unwrap_or(0);
    let mut body = String::new();
    if hours != 0 {
        body.push_str(&format!("{}H", hours));
    }
    if minutes != 0 {
        body.push_str(&format!("{}M", minutes));
    }
    if body.is_empty() {
        body.push_str("0S");
    }
    Ok(Term::Literal(Literal { value: format!("{}PT{}", sign, body), datatype: Some(XSD_DAY_TIME_DURATION.to_string()), language: None }))
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::ast::Term;
    use crate::n3::parser::number_literal;
    use std::collections::BTreeMap;

    fn b() -> Bindings {
        BTreeMap::new()
    }

    #[test]
    fn recognizes_case_insensitive_builtins() {
        assert!(is_builtin_name("concat"));
        assert!(is_builtin_name("CONCAT"));
        assert!(is_builtin_name("isNUMERIC"));
        assert!(!is_builtin_name("frobnicate"));
    }

    #[test]
    fn comparison_and_arithmetic() {
        let ctx = EvalCtx::new();
        let expr = Expr::Binary {
            op: BinaryOp::Gt,
            left: Box::new(Expr::Term(number_literal("1500".into()))),
            right: Box::new(Expr::Term(number_literal("1000".into()))),
        };
        let result = eval_expr(&expr, &b(), &ctx).unwrap();
        assert_eq!(result, boolean_literal(true));

        let sum = Expr::Binary {
            op: BinaryOp::Add,
            left: Box::new(Expr::Term(number_literal("2".into()))),
            right: Box::new(Expr::Term(number_literal("3".into()))),
        };
        assert_eq!(eval_expr(&sum, &b(), &ctx).unwrap(), number_literal("5".into()));
    }

    #[test]
    fn short_circuit_and_or() {
        let ctx = EvalCtx::new();
        let mut bindings = b();
        bindings.insert("x".to_string(), Term::var("unused-should-not-be-read"));
        // `false && ?unbound` must not evaluate the right side.
        let expr = Expr::Binary {
            op: BinaryOp::And,
            left: Box::new(Expr::Term(boolean_literal(false))),
            right: Box::new(Expr::Var("does_not_exist".to_string())),
        };
        assert_eq!(eval_expr(&expr, &bindings, &ctx).unwrap(), boolean_literal(false));
    }

    #[test]
    fn concat_and_string_functions() {
        let ctx = EvalCtx::new();
        let call = Expr::Call {
            name: "CONCAT".to_string(),
            args: vec![Expr::Term(Term::Literal(Literal::plain("foo"))), Expr::Term(Term::Literal(Literal::plain("bar")))],
        };
        assert_eq!(eval_expr(&call, &b(), &ctx).unwrap(), Term::Literal(Literal::plain("foobar")));
    }

    #[test]
    fn xsd_integer_cast() {
        let ctx = EvalCtx::new();
        let call = Expr::Call {
            name: XSD_INTEGER.to_string(),
            args: vec![Expr::Term(Term::Literal(Literal::plain("3.9")))],
        };
        assert_eq!(eval_expr(&call, &b(), &ctx).unwrap(), number_literal("3".into()));
    }

    #[test]
    fn regex_and_replace() {
        let ctx = EvalCtx::new();
        let re = Expr::Call {
            name: "REGEX".to_string(),
            args: vec![Expr::Term(Term::Literal(Literal::plain("hello world"))), Expr::Term(Term::Literal(Literal::plain("^hello")))],
        };
        assert_eq!(eval_expr(&re, &b(), &ctx).unwrap(), boolean_literal(true));

        let replace = Expr::Call {
            name: "REPLACE".to_string(),
            args: vec![
                Expr::Term(Term::Literal(Literal::plain("abc123"))),
                Expr::Term(Term::Literal(Literal::plain("[0-9]+"))),
                Expr::Term(Term::Literal(Literal::plain("#"))),
            ],
        };
        assert_eq!(eval_expr(&replace, &b(), &ctx).unwrap(), Term::Literal(Literal::plain("abc#")));
    }

    #[test]
    fn in_and_not_in() {
        let ctx = EvalCtx::new();
        let expr = Expr::Binary {
            op: BinaryOp::In,
            left: Box::new(Expr::Term(number_literal("2".into()))),
            right: Box::new(Expr::List(vec![Expr::Term(number_literal("1".into())), Expr::Term(number_literal("2".into()))])),
        };
        assert_eq!(eval_expr(&expr, &b(), &ctx).unwrap(), boolean_literal(true));
    }

    #[test]
    fn triple_term_accessors() {
        let ctx = EvalCtx::new();
        let triple = Term::formula(vec![Triple::new(Term::iri("urn:a"), Term::iri("urn:p"), Term::iri("urn:b"))]);
        let subj = Expr::Call { name: "SUBJECT".to_string(), args: vec![Expr::Term(triple.clone())] };
        assert_eq!(eval_expr(&subj, &b(), &ctx).unwrap(), Term::iri("urn:a"));
        let is_triple = Expr::Call { name: "ISTRIPLE".to_string(), args: vec![Expr::Term(triple)] };
        assert_eq!(eval_expr(&is_triple, &b(), &ctx).unwrap(), boolean_literal(true));
    }

    #[test]
    fn date_parts() {
        let ctx = EvalCtx::new();
        let year = Expr::Call {
            name: "YEAR".to_string(),
            args: vec![Expr::Term(Term::Literal(Literal { value: "2024-03-05T10:15:30Z".to_string(), datatype: Some(XSD_DATE_TIME.to_string()), language: None }))],
        };
        assert_eq!(eval_expr(&year, &b(), &ctx).unwrap(), number_literal("2024".into()));
    }
}
