//! Eyelang's term model: symbols, strings, arbitrary-size integers, floats,
//! booleans, and compound (`struct`) terms, plus structural unification.
//!
//! This is deliberately a separate model from `crate::ast::Term` (used by
//! the N3 and SPARQL-RL front ends): Eyelang is not an RDF triple language,
//! and its compound terms (`parent(alice, bob)`, list sugar via `cons/2`/
//! `nil/0`) have nothing in common with RDF terms except at the explicit
//! RDF-bridge boundary (`super::rdf`). Bindings are a branch-local map from
//! variable id to term, cloned before each backtracking attempt and
//! discarded on failure — the same convention `crate::srl::eval::Bindings`
//! already uses for SPARQL-RL.

use std::collections::BTreeMap;

use num_bigint::BigInt;

#[derive(Debug, Clone, PartialEq)]
pub enum Term {
    /// A logic variable: a process-unique id plus its source display name
    /// (`"_"` for the anonymous variable, which never appears in results).
    Var(u64, String),
    /// A bare symbol, e.g. `red`. Distinct from the zero-arg struct `red()`.
    Atom(String),
    /// A compound term: `name(args...)`. Lists are `cons/2`/`nil/0` sugar.
    Struct(String, Vec<Term>),
    Str(String),
    Int(BigInt),
    Float(f64),
    Bool(bool),
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
    Term::Atom(name.into())
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

pub fn boolean(value: bool) -> Term {
    Term::Bool(value)
}

pub fn nil() -> Term {
    Term::Struct("nil".into(), Vec::new())
}

pub fn cons(head: Term, tail: Term) -> Term {
    Term::Struct("cons".into(), vec![head, tail])
}

/// Build a closed list term from `values`, right-to-left (mirrors
/// `terms.js`'s `list = values => values.reduceRight(...)`).
pub fn list(values: Vec<Term>) -> Term {
    values.into_iter().rev().fold(nil(), |tail, head| cons(head, tail))
}

/// Follow variable bindings until reaching a non-variable term or an
/// unbound variable (does not recurse into struct arguments).
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
            (Term::Atom(ln), Term::Atom(rn)) => {
                if ln != rn {
                    return false;
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
            (Term::Bool(lb), Term::Bool(rb)) => {
                if lb != rb {
                    return false;
                }
            }
            _ => return false,
        }
    }
    true
}

/// True iff `term` contains no variables. Assumes `term` has already been
/// instantiated (mirrors `terms.js`'s `ground`, which does not consult an
/// environment).
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
/// tables and to order `sort`/`collect` results.
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord)]
pub enum Key {
    Var(usize),
    Atom(String),
    Struct(String, Vec<Key>),
    Str(String),
    Int(String),
    Float(String),
    Bool(bool),
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
        Term::Atom(name) => Key::Atom(name.clone()),
        Term::Struct(name, args) => Key::Struct(name.clone(), args.iter().map(|a| key_with(a, vars)).collect()),
        Term::Str(s) => Key::Str(s.clone()),
        Term::Int(i) => Key::Int(i.to_string()),
        Term::Float(f) => Key::Float(f.to_string()),
        Term::Bool(b) => Key::Bool(*b),
    }
}

/// A canonical string form of `key(term)`, suitable as a hash-map key for
/// answer/table dedup (mirrors `terms.js`'s `termKey`).
pub fn term_key(term: &Term) -> String {
    format!("{:?}", key(term))
}

/// Unpack a closed, finite list (`cons(_, cons(_, ... nil))`) into a
/// `Vec<Term>`. Errors on an open tail or a non-list term.
pub fn array(term: &Term) -> Result<Vec<Term>, String> {
    let mut values = Vec::new();
    let mut current = term.clone();
    loop {
        match current {
            Term::Struct(ref name, ref args) if name == "cons" && args.len() == 2 => {
                values.push(args[0].clone());
                current = args[1].clone();
            }
            Term::Struct(ref name, ref args) if name == "nil" && args.is_empty() => break,
            _ => return Err("Expected a finite, closed list".to_string()),
        }
    }
    Ok(values)
}

/// The plain JS-style `Number.prototype.toString()` rendering of `value`:
/// fixed notation for magnitudes roughly in `1e-6..1e21`, exponential
/// notation outside it. Rust's own `{}` for `f64` never switches to
/// exponential notation, so the switch point is detected via `{:e}`'s
/// exponent instead. Used both by `term::format` (which additionally
/// appends `.0` to integral values printed in fixed notation, Eyelang's
/// own convention) and by `builtins::lexical`'s `str`/`concat` conversion
/// (which does not).
pub fn format_number_js(value: f64) -> String {
    if value.is_nan() {
        return "NaN".to_string();
    }
    if value.is_infinite() {
        return if value > 0.0 { "Infinity".to_string() } else { "-Infinity".to_string() };
    }
    if value == 0.0 {
        return if value.is_sign_negative() { "-0".to_string() } else { "0".to_string() };
    }
    let exp_form = format!("{:e}", value);
    let e_idx = exp_form.rfind('e').expect("LowerExp output always contains 'e'");
    let exponent: i32 = exp_form[e_idx + 1..].parse().expect("LowerExp exponent is always a valid integer");
    if (-6..21).contains(&exponent) {
        format!("{}", value)
    } else {
        let mantissa = &exp_form[..e_idx];
        let sign = if exponent >= 0 { format!("+{}", exponent) } else { exponent.to_string() };
        format!("{}e{}", mantissa, sign)
    }
}

fn format_float(value: f64) -> String {
    let text = format_number_js(value);
    if value.is_finite() && value == value.trunc() && !text.contains('e') {
        format!("{}.0", text)
    } else {
        text
    }
}

/// Eyelang concrete syntax for `term`, including list sugar. Anonymous
/// variables print as `?v0`, `?v1`, ... in first-encountered order, shared
/// across one top-level `format` call (mirrors `terms.js`'s `format`).
pub fn format(term: &Term) -> String {
    let mut vars = BTreeMap::new();
    format_with(term, &mut vars)
}

fn format_with(term: &Term, vars: &mut BTreeMap<u64, String>) -> String {
    match term {
        Term::Var(id, _) => {
            let next = vars.len();
            let name = vars.entry(*id).or_insert_with(|| format!("v{}", next));
            format!("?{}", name)
        }
        Term::Atom(name) => name.clone(),
        Term::Str(value) => format!("{:?}", value),
        Term::Int(value) => value.to_string(),
        Term::Bool(value) => value.to_string(),
        Term::Float(value) => format_float(*value),
        Term::Struct(name, args) => {
            if name == "nil" && args.is_empty() {
                return "[]".to_string();
            }
            if name == "cons" && args.len() == 2 {
                let mut parts = Vec::new();
                let mut tail = term.clone();
                loop {
                    match &tail {
                        Term::Struct(n, a) if n == "cons" && a.len() == 2 => {
                            parts.push(format_with(&a[0], vars));
                            tail = a[1].clone();
                        }
                        _ => break,
                    }
                }
                let closed = matches!(&tail, Term::Struct(n, a) if n == "nil" && a.is_empty());
                if closed {
                    format!("[{}]", parts.join(", "))
                } else {
                    format!("[{} | {}]", parts.join(", "), format_with(&tail, vars))
                }
            } else {
                let args_text: Vec<String> = args.iter().map(|a| format_with(a, vars)).collect();
                format!("{}({})", name, args_text.join(", "))
            }
        }
    }
}

/// Named variables referenced by `term` (the anonymous variable `_` is
/// excluded), in first-encountered (structural, left-to-right) order.
///
/// This must be a genuinely insertion-ordered collection, not a `BTreeMap`
/// keyed by variable id: a variable's id reflects when it was *minted*
/// (e.g. during an earlier, unrelated fresh-renaming pass), which does not
/// always agree with its position in `term`'s own structure — for example
/// a `collect` template's fresh-renamed variables get their ids from the
/// order they were first seen while fresh-renaming the *body*, which can
/// differ from their left-to-right order in the template itself. Callers
/// that need this order (e.g. a proof entry's `substitution` list) would
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
        let x = v(&mut counter, "x");
        let mut env = Bindings::new();
        assert!(unify(&x, &atom("red"), &mut env));
        assert_eq!(instantiate(&x, &env), atom("red"));
    }

    #[test]
    fn unify_fails_on_occurs_check() {
        let mut counter = VarCounter::new();
        let x = v(&mut counter, "x");
        let mut env = Bindings::new();
        let cyclic = struct_("f", vec![x.clone()]);
        assert!(!unify(&x, &cyclic, &mut env));
    }

    #[test]
    fn unify_structural_mismatch_fails() {
        let mut env = Bindings::new();
        assert!(!unify(&struct_("f", vec![atom("a")]), &struct_("f", vec![atom("b")]), &mut env));
        assert!(!unify(&struct_("f", vec![atom("a")]), &struct_("g", vec![atom("a")]), &mut env));
    }

    #[test]
    fn fresh_renames_consistently() {
        let mut counter = VarCounter::new();
        let x = counter.fresh("x");
        let term = struct_("f", vec![x.clone(), x.clone()]);
        let mut variables = BTreeMap::new();
        let renamed = fresh(&term, &mut variables, &mut counter);
        if let Term::Struct(_, args) = renamed {
            assert_eq!(args[0], args[1]);
            assert_ne!(args[0], x);
        } else {
            panic!("expected struct");
        }
    }

    #[test]
    fn ground_detects_variables() {
        let mut counter = VarCounter::new();
        let x = counter.fresh("x");
        assert!(ground(&atom("a")));
        assert!(!ground(&x));
        assert!(!ground(&struct_("f", vec![x])));
    }

    #[test]
    fn term_key_ignores_variable_identity() {
        let mut c1 = VarCounter::new();
        let mut c2 = VarCounter::new();
        let a = struct_("f", vec![c1.fresh("x")]);
        let b = struct_("f", vec![c2.fresh("y")]);
        assert_eq!(term_key(&a), term_key(&b));
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
        let open = cons(atom("a"), counter.fresh("tail"));
        assert!(array(&open).is_err());
    }

    #[test]
    fn format_lists_and_atoms() {
        assert_eq!(format(&nil()), "[]");
        assert_eq!(format(&list(vec![atom("a"), atom("b")])), "[a, b]");
        assert_eq!(format(&struct_("f", vec![atom("a")])), "f(a)");
        assert_eq!(format(&int(BigInt::from(3))), "3");
        assert_eq!(format(&float(3.0)), "3.0");
        assert_eq!(format(&float(3.5)), "3.5");
        assert_eq!(format(&str_("hi")), "\"hi\"");
        assert_eq!(format(&boolean(true)), "true");
    }

    #[test]
    fn format_open_list_shows_tail() {
        let mut counter = VarCounter::new();
        let tail = counter.fresh("t");
        let open = cons(atom("a"), tail);
        assert_eq!(format(&open), "[a | ?v0]");
    }
}
