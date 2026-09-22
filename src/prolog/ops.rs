//! The operator table.
//!
//! ISO/IEC 13211-1 makes the operator table part of a Prolog processor's
//! mutable state, changed by `op/3` directives. eyeron fixes it instead:
//! this is exactly the standard's own initial table, minus the operators
//! whose predicates are outside the accepted subset (`;`, `->`, `:`, `@`,
//! `=..`, the `dynamic`/`discontiguous` declarations). Programs cannot add
//! to it, so every source file reads the same way — see
//! `docs/prolog-specification.md` §3.
//!
//! Both directions use this one table: `parser` consults it to read a term,
//! and `term::format` consults it to write one back, which is what keeps a
//! result document re-readable by the same parser (and by any conforming
//! Prolog processor, since the priorities are the standard's).

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Kind {
    Xfx,
    Xfy,
    Yfx,
    Fy,
    Fx,
}

/// `(name, priority, kind)` for every infix operator.
pub const INFIX: &[(&str, u16, Kind)] = &[
    (":-", 1200, Kind::Xfx),
    (",", 1000, Kind::Xfy),
    ("=", 700, Kind::Xfx),
    ("\\=", 700, Kind::Xfx),
    ("==", 700, Kind::Xfx),
    ("\\==", 700, Kind::Xfx),
    ("@<", 700, Kind::Xfx),
    ("@>", 700, Kind::Xfx),
    ("@=<", 700, Kind::Xfx),
    ("@>=", 700, Kind::Xfx),
    ("is", 700, Kind::Xfx),
    ("=:=", 700, Kind::Xfx),
    ("=\\=", 700, Kind::Xfx),
    ("<", 700, Kind::Xfx),
    (">", 700, Kind::Xfx),
    ("=<", 700, Kind::Xfx),
    (">=", 700, Kind::Xfx),
    ("+", 500, Kind::Yfx),
    ("-", 500, Kind::Yfx),
    ("*", 400, Kind::Yfx),
    ("/", 400, Kind::Yfx),
    ("//", 400, Kind::Yfx),
    ("mod", 400, Kind::Yfx),
    ("rem", 400, Kind::Yfx),
    ("**", 200, Kind::Xfx),
    ("^", 200, Kind::Xfy),
];

/// `(name, priority, kind)` for every prefix operator.
pub const PREFIX: &[(&str, u16, Kind)] = &[(":-", 1200, Kind::Fx), ("?-", 1200, Kind::Fx), ("\\+", 900, Kind::Fy), ("-", 200, Kind::Fy), ("+", 200, Kind::Fy)];

/// `(priority, maximum left-argument priority, maximum right-argument
/// priority)` for `name` as an infix operator. `xfx` bounds both arguments
/// one below its own priority, `xfy` only its left, `yfx` only its right —
/// which is what makes `a-b-c` read as `(a-b)-c` and `a,b,c` as `a,(b,c)`.
pub fn infix(name: &str) -> Option<(u16, u16, u16)> {
    INFIX.iter().find(|(n, _, _)| *n == name).map(|(_, prec, kind)| match kind {
        Kind::Xfx => (*prec, prec - 1, prec - 1),
        Kind::Xfy => (*prec, prec - 1, *prec),
        Kind::Yfx => (*prec, *prec, prec - 1),
        _ => unreachable!("INFIX holds no prefix kinds"),
    })
}

/// `(priority, maximum argument priority)` for `name` as a prefix operator.
pub fn prefix(name: &str) -> Option<(u16, u16)> {
    PREFIX.iter().find(|(n, _, _)| *n == name).map(|(_, prec, kind)| match kind {
        Kind::Fy => (*prec, *prec),
        Kind::Fx => (*prec, prec - 1),
        _ => unreachable!("PREFIX holds no infix kinds"),
    })
}

/// True iff `name` is an operator in either position. An operator used as
/// an ordinary atom still has to be written in brackets in an argument
/// position, which `term::format` handles.
pub fn is_operator(name: &str) -> bool {
    infix(name).is_some() || prefix(name).is_some()
}
