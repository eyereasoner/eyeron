//! The term model: variables, atoms, compound terms, strings, integers and
//! floats, plus structural unification, the standard order of terms, and
//! the writer.
//!
//! An atom is a compound term of arity zero (`Struct("red", [])`), so the
//! goal `ready` and the term `ready` are the same object and unify — which
//! is what lets `clause/2` hand a zero-argument clause's head back to the
//! program. Lists are the usual `'.'/2` pairs ending in the atom `[]`.
//!
//! This is deliberately a separate model from `crate::ast::Term` (used by
//! the N3 and SPARQL-RL front ends): Prolog is not an RDF triple language,
//! and its compound terms have nothing in common with RDF terms except at
//! the explicit RDF-bridge boundary (`super::rdf`). Bindings are a
//! branch-local map from variable id to term, cloned before each
//! backtracking attempt and discarded on failure — the same convention
//! `crate::srl::eval::Bindings` already uses for SPARQL-RL.

use std::cmp::Ordering;
use std::collections::BTreeMap;

use num_bigint::BigInt;

use super::ops;

#[derive(Debug, Clone, PartialEq)]
pub enum Term {
    /// A variable: a process-unique id plus its source name (`"_"` for the
    /// anonymous variable, which is never reported in an answer).
    Var(u64, String),
    /// A compound term `name(args...)`; an atom is the arity-zero case.
    /// Lists are `'.'/2` pairs ending in the atom `[]`.
    Struct(String, Vec<Term>),
    /// A string object (`"text"`). eyeron's one deliberate departure from
    /// ISO's `double_quotes` flag — see the specification's conformance
    /// section.
    Str(String),
    Int(BigInt),
    Float(f64),
}

/// A branch-local substitution: variable id -> term. Cloned before each
/// backtracking attempt, discarded on failure.
pub type Bindings = BTreeMap<u64, Term>;

/// Supplies fresh, process-unique variable ids. Held explicitly by whatever
/// evaluation context needs to mint variables, never as global state.
#[derive(Debug, Default, Clone)]
pub struct VarCounter(u64);

impl VarCounter {
    pub fn new() -> Self {
        Self(0)
    }

    pub fn fresh(&mut self, name: impl Into<String>) -> Term {
        let id = self.0;
        self.0 += 1;
        Term::Var(id, name.into())
    }
}

pub fn atom(name: impl Into<String>) -> Term {
    Term::Struct(name.into(), Vec::new())
}

pub fn struct_(name: impl Into<String>, args: Vec<Term>) -> Term {
    Term::Struct(name.into(), args)
}

pub fn str_(value: impl Into<String>) -> Term {
    Term::Str(value.into())
}

pub fn int(value: impl Into<BigInt>) -> Term {
    Term::Int(value.into())
}

pub fn float(value: f64) -> Term {
    Term::Float(value)
}

pub fn nil() -> Term {
    atom("[]")
}

pub fn cons(head: Term, tail: Term) -> Term {
    Term::Struct(".".into(), vec![head, tail])
}

/// Build a closed list term from `values`, right-to-left.
pub fn list(values: Vec<Term>) -> Term {
    values.into_iter().rev().fold(nil(), |tail, head| cons(head, tail))
}

/// True iff `term` is the atom `[]`.
pub fn is_nil(term: &Term) -> bool {
    matches!(term, Term::Struct(name, args) if name == "[]" && args.is_empty())
}

/// `Some((head, tail))` iff `term` is a `'.'/2` pair.
pub fn as_cons(term: &Term) -> Option<(&Term, &Term)> {
    match term {
        Term::Struct(name, args) if name == "." && args.len() == 2 => Some((&args[0], &args[1])),
        _ => None,
    }
}

/// True iff `term` is callable: an atom or a compound term. Numbers,
/// strings and variables are not.
pub fn is_callable(term: &Term) -> bool {
    matches!(term, Term::Struct(..))
}

/// Follow variable bindings until reaching a non-variable term or an
/// unbound variable (does not recurse into compound arguments).
pub fn deref(term: &Term, env: &Bindings) -> Term {
    let mut current = term.clone();
    while let Term::Var(id, _) = &current {
        match env.get(id) {
            Some(bound) => current = bound.clone(),
            None => break,
        }
    }
    current
}

/// Fully substitute every bound variable, recursively, producing a term
/// with no remaining bound variables reachable through it.
pub fn instantiate(term: &Term, env: &Bindings) -> Term {
    match deref(term, env) {
        Term::Struct(name, args) => Term::Struct(name, args.iter().map(|a| instantiate(a, env)).collect()),
        other => other,
    }
}

fn occurs(id: u64, term: &Term, env: &Bindings) -> bool {
    match deref(term, env) {
        Term::Var(other, _) => other == id,
        Term::Struct(_, args) => args.iter().any(|a| occurs(id, a, env)),
        _ => false,
    }
}

/// Structural unification with an occurs check, mutating `env` in place.
/// Callers clone `env` before attempting this and discard the clone on
/// failure (see the module-level doc comment).
pub fn unify(a: &Term, b: &Term, env: &mut Bindings) -> bool {
    let mut pending = vec![(a.clone(), b.clone())];
    while let Some((left, right)) = pending.pop() {
        let left = deref(&left, env);
        let right = deref(&right, env);
        match (&left, &right) {
            (Term::Var(lid, _), Term::Var(rid, _)) if lid == rid => continue,
            (Term::Var(lid, _), _) => {
                if occurs(*lid, &right, env) {
                    return false;
                }
                env.insert(*lid, right);
            }
            (_, Term::Var(rid, _)) => {
                if occurs(*rid, &left, env) {
                    return false;
                }
                env.insert(*rid, left);
            }
            (Term::Struct(ln, la), Term::Struct(rn, ra)) => {
                if ln != rn || la.len() != ra.len() {
                    return false;
                }
                for (l, r) in la.iter().zip(ra.iter()) {
                    pending.push((l.clone(), r.clone()));
                }
            }
            (Term::Str(ls), Term::Str(rs)) => {
                if ls != rs {
                    return false;
                }
            }
            (Term::Int(li), Term::Int(ri)) => {
                if li != ri {
                    return false;
                }
            }
            (Term::Float(lf), Term::Float(rf)) => {
                if lf != rf {
                    return false;
                }
            }
            _ => return false,
        }
    }
    true
}

/// True iff `term` contains no variables. Assumes `term` has already been
/// instantiated.
pub fn ground(term: &Term) -> bool {
    match term {
        Term::Var(..) => false,
        Term::Struct(_, args) => args.iter().all(ground),
        _ => true,
    }
}

/// Rename apart: replace every variable in `term` with a fresh one,
/// consistently within one call (repeated occurrences of the same variable
/// map to the same fresh variable) via the shared `variables` map.
pub fn fresh(term: &Term, variables: &mut BTreeMap<u64, Term>, counter: &mut VarCounter) -> Term {
    match term {
        Term::Var(id, name) => {
            if let Some(existing) = variables.get(id) {
                existing.clone()
            } else {
                let fresh_var = counter.fresh(name.clone());
                variables.insert(*id, fresh_var.clone());
                fresh_var
            }
        }
        Term::Struct(name, args) => Term::Struct(name.clone(), args.iter().map(|a| fresh(a, variables, counter)).collect()),
        other => other.clone(),
    }
}

/// A canonical, variable-identity-independent shape used to dedupe answers/
/// tables. Two terms share a key exactly when they are variants of each
/// other, which is the equivalence the tabled evaluator memoizes by.
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord)]
pub enum Key {
    Var(usize),
    Struct(String, Vec<Key>),
    Str(String),
    Int(String),
    Float(String),
}

pub fn key(term: &Term) -> Key {
    let mut vars = BTreeMap::new();
    key_with(term, &mut vars)
}

fn key_with(term: &Term, vars: &mut BTreeMap<u64, usize>) -> Key {
    match term {
        Term::Var(id, _) => {
            let next = vars.len();
            let n = *vars.entry(*id).or_insert(next);
            Key::Var(n)
        }
        Term::Struct(name, args) => Key::Struct(name.clone(), args.iter().map(|a| key_with(a, vars)).collect()),
        Term::Str(s) => Key::Str(s.clone()),
        Term::Int(i) => Key::Int(i.to_string()),
        Term::Float(f) => Key::Float(f.to_string()),
    }
}

/// A canonical string form of `key(term)`, suitable as a hash-map key for
/// answer/table dedup.
pub fn term_key(term: &Term) -> String {
    format!("{:?}", key(term))
}

/// The class of a term in the standard order (specification §5): variables
/// precede numbers, which precede atoms, which precede strings, which
/// precede compound terms.
fn order_class(term: &Term) -> u8 {
    match term {
        Term::Var(..) => 0,
        Term::Float(_) | Term::Int(_) => 1,
        Term::Struct(_, args) if args.is_empty() => 2,
        Term::Str(_) => 3,
        Term::Struct(..) => 4,
    }
}

/// Compare `a` and `b` in the standard order of terms. Unlike `key`, this
/// respects variable identity, so `X @< Y` holds for two distinct
/// variables; callers instantiate both terms first.
pub fn order(a: &Term, b: &Term) -> Ordering {
    let (ca, cb) = (order_class(a), order_class(b));
    if ca != cb {
        return ca.cmp(&cb);
    }
    match (a, b) {
        (Term::Var(x, _), Term::Var(y, _)) => x.cmp(y),
        (Term::Int(x), Term::Int(y)) => x.cmp(y),
        (Term::Float(x), Term::Float(y)) => x.partial_cmp(y).unwrap_or(Ordering::Equal),
        // A float and an integer of equal value are ordered float first,
        // as the standard requires; otherwise by value.
        (Term::Int(x), Term::Float(y)) => big_vs_float(x, *y).unwrap_or(Ordering::Greater),
        (Term::Float(x), Term::Int(y)) => big_vs_float(y, *x).map(Ordering::reverse).unwrap_or(Ordering::Less),
        (Term::Str(x), Term::Str(y)) => x.cmp(y),
        (Term::Struct(xn, xa), Term::Struct(yn, ya)) => xa
            .len()
            .cmp(&ya.len())
            .then_with(|| xn.cmp(yn))
            .then_with(|| xa.iter().zip(ya.iter()).map(|(l, r)| order(l, r)).find(|o| *o != Ordering::Equal).unwrap_or(Ordering::Equal)),
        _ => Ordering::Equal,
    }
}

/// Compares an integer against a float by value, or `None` when they are
/// numerically equal (which the caller breaks by kind). Done through the
/// float's own integral decomposition rather than by widening the integer,
/// so a bigint far outside `f64`'s range still compares exactly.
pub(crate) fn big_vs_float(int: &BigInt, float: f64) -> Option<Ordering> {
    if float.is_nan() {
        return Some(Ordering::Greater);
    }
    if float.is_infinite() {
        return Some(if float > 0.0 { Ordering::Less } else { Ordering::Greater });
    }
    let truncated = float.trunc();
    let whole = BigInt::from(truncated as i128);
    let by_whole = int.cmp(&whole);
    if by_whole != Ordering::Equal {
        return Some(by_whole);
    }
    // Equal whole parts: the float's fraction decides.
    let fraction = float - truncated;
    if fraction > 0.0 {
        Some(Ordering::Less)
    } else if fraction < 0.0 {
        Some(Ordering::Greater)
    } else {
        None
    }
}

/// Unpack a closed, finite list into a `Vec<Term>`. Errors on an open tail
/// or a non-list term.
pub fn array(term: &Term) -> Result<Vec<Term>, String> {
    let mut values = Vec::new();
    let mut current = term.clone();
    loop {
        if is_nil(&current) {
            break;
        }
        match as_cons(&current) {
            Some((head, tail)) => {
                values.push(head.clone());
                current = tail.clone();
            }
            None => return Err("Expected a finite, closed list".to_string()),
        }
    }
    Ok(values)
}

/// A float's text, always in a form that reads back as a float: either
/// fixed notation with a fractional part (`3.0`, `-0.25`) or exponent
/// notation whose mantissa has one (`1.0e21`). Magnitudes roughly within
/// `1e-6..1e21` use fixed notation.
pub fn format_float(value: f64) -> String {
    if value.is_nan() {
        return "nan".to_string();
    }
    if value.is_infinite() {
        return if value > 0.0 { "inf".to_string() } else { "-inf".to_string() };
    }
    if value == 0.0 {
        return if value.is_sign_negative() { "-0.0".to_string() } else { "0.0".to_string() };
    }
    let exp_form = format!("{:e}", value);
    let e_idx = exp_form.rfind('e').expect("LowerExp output always contains 'e'");
    let exponent: i32 = exp_form[e_idx + 1..].parse().expect("LowerExp exponent is always a valid integer");
    if (-6..21).contains(&exponent) {
        let text = format!("{}", value);
        if text.contains('.') {
            text
        } else {
            format!("{}.0", text)
        }
    } else {
        let mantissa = &exp_form[..e_idx];
        let mantissa = if mantissa.contains('.') { mantissa.to_string() } else { format!("{}.0", mantissa) };
        format!("{}e{}", mantissa, exponent)
    }
}

/// The plain text of an atomic value, without quotes or a float's forced
/// `.0` — what `atomics_to_string/2` concatenates.
pub fn lexical_text(term: &Term) -> Option<String> {
    match term {
        Term::Struct(name, args) if args.is_empty() => Some(name.clone()),
        Term::Str(value) => Some(value.clone()),
        Term::Int(value) => Some(value.to_string()),
        Term::Float(value) => Some(format_float(*value)),
        _ => None,
    }
}

/// True iff `name` can be written without quotes: an identifier atom, a
/// graphic-token atom such as `+` or `=..`, or one of the solo atoms.
fn atom_needs_no_quotes(name: &str) -> bool {
    if name.is_empty() {
        return false;
    }
    if name == "[]" || name == "{}" || name == "!" || name == ";" {
        return true;
    }
    let mut chars = name.chars();
    let first = chars.next().unwrap();
    if first.is_ascii_lowercase() {
        return name.chars().all(|c| c.is_ascii_alphanumeric() || c == '_');
    }
    name.chars().all(is_graphic_char)
}

/// The graphic characters of ISO/IEC 13211-1 §6.4.2, which combine into
/// one token by maximal munch. The same set the lexer scans.
pub fn is_graphic_char(c: char) -> bool {
    matches!(c, '#' | '$' | '&' | '*' | '+' | '-' | '.' | '/' | ':' | '<' | '=' | '>' | '?' | '@' | '^' | '~' | '\\')
}

fn quoted(text: &str, quote: char) -> String {
    let mut out = String::with_capacity(text.len() + 2);
    out.push(quote);
    for ch in text.chars() {
        match ch {
            '\\' => out.push_str("\\\\"),
            '\n' => out.push_str("\\n"),
            '\t' => out.push_str("\\t"),
            '\r' => out.push_str("\\r"),
            c if c == quote => {
                out.push('\\');
                out.push(c);
            }
            c if (c as u32) < 0x20 => out.push_str(&format!("\\x{:x}\\", c as u32)),
            c => out.push(c),
        }
    }
    out.push(quote);
    out
}

pub fn format_atom(name: &str) -> String {
    if atom_needs_no_quotes(name) {
        name.to_string()
    } else {
        quoted(name, '\'')
    }
}

/// Write `term` the way `writeq/1` does: quoted where needed, operators in
/// their operator positions, lists in list notation, and brackets wherever
/// a subterm's priority would otherwise misread. Variables print as `_0`,
/// `_1`, ... in first-encountered order, shared across one `format` call,
/// so a written term reads back with the same variable sharing.
pub fn format(term: &Term) -> String {
    let mut vars = BTreeMap::new();
    write_term(term, 1200, &mut vars)
}

/// `format`, but for a term appearing as an argument or list element,
/// where a bare `,` operator would be read as the separator.
pub fn format_arg(term: &Term) -> String {
    let mut vars = BTreeMap::new();
    write_term(term, 999, &mut vars)
}

fn write_term(term: &Term, max: u16, vars: &mut BTreeMap<u64, String>) -> String {
    match term {
        Term::Var(id, _) => {
            let next = vars.len();
            vars.entry(*id).or_insert_with(|| format!("_{}", next)).clone()
        }
        Term::Str(value) => quoted(value, '"'),
        Term::Int(value) => value.to_string(),
        Term::Float(value) => format_float(*value),
        Term::Struct(name, args) => write_compound(term, name, args, max, vars),
    }
}

fn bracket(text: String, prec: u16, max: u16) -> String {
    if prec > max {
        format!("({})", text)
    } else {
        text
    }
}

fn write_compound(term: &Term, name: &str, args: &[Term], max: u16, vars: &mut BTreeMap<u64, String>) -> String {
    if args.is_empty() {
        return format_atom(name);
    }
    if is_nil(term) {
        return "[]".to_string();
    }
    if as_cons(term).is_some() {
        let mut parts = Vec::new();
        let mut tail = term.clone();
        while let Some((head, rest)) = as_cons(&tail) {
            parts.push(write_term(head, 999, vars));
            tail = rest.clone();
        }
        return if is_nil(&tail) {
            format!("[{}]", parts.join(", "))
        } else {
            format!("[{}|{}]", parts.join(", "), write_term(&tail, 999, vars))
        };
    }
    if args.len() == 2 {
        if let Some((prec, left_max, right_max)) = ops::infix(name) {
            let left = write_term(&args[0], left_max, vars);
            let right = write_term(&args[1], right_max, vars);
            let text = if name == "," { format!("{}, {}", left, right) } else { format!("{} {} {}", left, format_atom(name), right) };
            return bracket(text, prec, max);
        }
    }
    if args.len() == 1 {
        if let Some((prec, arg_max)) = ops::prefix(name) {
            let arg = write_term(&args[0], arg_max, vars);
            // `-(1)` must not be written `-1`, which reads back as the
            // negative integer; a space keeps the two distinguishable.
            let separator = if arg.starts_with(|c: char| c.is_ascii_digit()) || arg.starts_with(is_graphic_char) { " " } else { "" };
            let text = if name.chars().next().is_some_and(|c| c.is_ascii_alphabetic()) {
                format!("{} {}", format_atom(name), arg)
            } else {
                format!("{}{}{}", format_atom(name), separator, arg)
            };
            return bracket(text, prec, max);
        }
    }
    let args_text: Vec<String> = args.iter().map(|a| write_term(a, 999, vars)).collect();
    format!("{}({})", format_atom(name), args_text.join(", "))
}

/// Named variables referenced by `term` (the anonymous variable `_` is
/// excluded), in first-encountered (structural, left-to-right) order.
///
/// This must be a genuinely insertion-ordered collection, not a `BTreeMap`
/// keyed by variable id: a variable's id reflects when it was *minted*
/// (e.g. during an earlier, unrelated fresh-renaming pass), which does not
/// always agree with its position in `term`'s own structure. Callers that
/// need this order (e.g. a proof entry's `substitution` list) would
/// otherwise silently reorder it.
pub fn variables_in(term: &Term, out: &mut Vec<(u64, Term)>) {
    if let Term::Var(id, name) = term {
        if name != "_" && !out.iter().any(|(existing, _)| existing == id) {
            out.push((*id, term.clone()));
        }
    }
    if let Term::Struct(_, args) = term {
        for arg in args {
            variables_in(arg, out);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn v(counter: &mut VarCounter, name: &str) -> Term {
        counter.fresh(name)
    }

    #[test]
    fn unify_binds_variable_to_atom() {
        let mut counter = VarCounter::new();
        let x = v(&mut counter, "X");
        let mut env = Bindings::new();
        assert!(unify(&x, &atom("red"), &mut env));
        assert_eq!(instantiate(&x, &env), atom("red"));
    }

    #[test]
    fn an_atom_is_a_compound_of_arity_zero() {
        let mut env = Bindings::new();
        assert!(unify(&atom("ready"), &struct_("ready", Vec::new()), &mut env));
    }

    #[test]
    fn unify_fails_on_occurs_check() {
        let mut counter = VarCounter::new();
        let x = v(&mut counter, "X");
        let mut env = Bindings::new();
        let cyclic = struct_("f", vec![x.clone()]);
        assert!(!unify(&x, &cyclic, &mut env));
    }

    #[test]
    fn standard_order_puts_numbers_before_atoms_before_compounds() {
        let mut counter = VarCounter::new();
        let x = v(&mut counter, "X");
        assert_eq!(order(&x, &int(1)), Ordering::Less);
        assert_eq!(order(&int(1), &atom("a")), Ordering::Less);
        assert_eq!(order(&atom("a"), &str_("a")), Ordering::Less);
        assert_eq!(order(&str_("a"), &struct_("f", vec![atom("a")])), Ordering::Less);
        assert_eq!(order(&float(1.0), &int(1)), Ordering::Less);
        assert_eq!(order(&int(2), &float(1.5)), Ordering::Greater);
    }

    #[test]
    fn standard_order_compares_compounds_by_arity_then_name() {
        assert_eq!(order(&struct_("z", vec![atom("a")]), &struct_("a", vec![atom("a"), atom("b")])), Ordering::Less);
        assert_eq!(order(&struct_("b", vec![atom("a")]), &struct_("a", vec![atom("a")])), Ordering::Greater);
    }

    #[test]
    fn array_round_trips_list() {
        let items = vec![atom("a"), atom("b"), atom("c")];
        let term = list(items.clone());
        assert_eq!(array(&term).unwrap(), items);
    }

    #[test]
    fn array_rejects_open_tail() {
        let mut counter = VarCounter::new();
        let open = cons(atom("a"), counter.fresh("T"));
        assert!(array(&open).is_err());
    }

    #[test]
    fn writes_lists_atoms_and_numbers() {
        assert_eq!(format(&nil()), "[]");
        assert_eq!(format(&list(vec![atom("a"), atom("b")])), "[a, b]");
        assert_eq!(format(&struct_("f", vec![atom("a")])), "f(a)");
        assert_eq!(format(&int(3)), "3");
        assert_eq!(format(&float(3.0)), "3.0");
        assert_eq!(format(&float(1e30)), "1.0e30");
        assert_eq!(format(&str_("hi")), "\"hi\"");
        assert_eq!(format(&atom("hello world")), "'hello world'");
    }

    #[test]
    fn writes_operators_in_operator_position() {
        let sum = struct_("+", vec![int(1), struct_("*", vec![int(2), int(3)])]);
        assert_eq!(format(&sum), "1 + 2 * 3");
        let nested = struct_("*", vec![struct_("+", vec![int(1), int(2)]), int(3)]);
        assert_eq!(format(&nested), "(1 + 2) * 3");
        let body = struct_(",", vec![atom("a"), atom("b")]);
        assert_eq!(format(&body), "a, b");
        assert_eq!(format_arg(&body), "(a, b)");
        assert_eq!(format(&struct_("\\+", vec![atom("a")])), "\\+a");
        assert_eq!(format(&struct_("-", vec![int(1)])), "- 1");
    }

    #[test]
    fn writes_open_list_with_a_tail() {
        let mut counter = VarCounter::new();
        let tail = counter.fresh("T");
        assert_eq!(format(&cons(atom("a"), tail)), "[a|_0]");
    }
}
