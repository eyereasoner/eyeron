//! Arithmetic evaluation and the built-in predicates that need neither the
//! program nor the evaluator. The four that do — `\+/1`, `call/1`,
//! `findall/3` and `clause/2` — are listed here so static validation
//! accepts them, but they are dispatched in `super::engine`.

use std::cmp::Ordering;

use num_bigint::BigInt;
use num_traits::{Signed, ToPrimitive, Zero};

use crate::error::{EyeronError, Result};

use super::term::{self, array, big_vs_float, ground, instantiate, order, unify, Bindings, Term};

/// Every built-in predicate indicator. A program may not define any of
/// them (specification §10).
pub const BUILTIN_RELATIONS: [&str; 30] = [
    // control
    "true/0",
    "fail/0",
    "false/0",
    "\\+/1",
    "call/1",
    // unification and term comparison
    "=/2",
    "\\=/2",
    "==/2",
    "\\==/2",
    "@</2",
    "@>/2",
    "@=</2",
    "@>=/2",
    // arithmetic
    "is/2",
    "=:=/2",
    "=\\=/2",
    "</2",
    ">/2",
    "=</2",
    ">=/2",
    // all solutions and clause inspection
    "findall/3",
    "clause/2",
    // list and atomic library
    "between/3",
    "length/2",
    "sort/2",
    "sum_list/2",
    "max_list/2",
    "min_list/2",
    "atomics_to_string/2",
    // eyeron extension
    "sudoku/2",
];

/// The four built-ins `super::engine` dispatches itself, because each one
/// needs the program or a nested evaluation.
pub const ENGINE_RELATIONS: [&str; 4] = ["\\+/1", "call/1", "findall/3", "clause/2"];

pub fn is_builtin_relation(signature: &str) -> bool {
    BUILTIN_RELATIONS.contains(&signature)
}

pub fn is_engine_relation(signature: &str) -> bool {
    ENGINE_RELATIONS.contains(&signature)
}

enum Num {
    Int(BigInt),
    Float(f64),
}

pub fn require_ground(value: Term, context: &str) -> Result<Term> {
    if !ground(&value) {
        return Err(EyeronError::new(format!("{} needs bound inputs; got {}", context, term::format(&value))));
    }
    Ok(value)
}

fn as_number(value: &Term) -> Result<Num> {
    match value {
        Term::Int(v) => Ok(Num::Int(v.clone())),
        Term::Float(v) => Ok(Num::Float(*v)),
        other => Err(EyeronError::new(format!("Expected a number; got {}", term::format(other)))),
    }
}

fn number_term(num: Num) -> Result<Term> {
    match num {
        Num::Int(v) => Ok(Term::Int(v)),
        Num::Float(f) => {
            if !f.is_finite() {
                return Err(EyeronError::new("Arithmetic result is not finite"));
            }
            Ok(Term::Float(f))
        }
    }
}

/// Widen an integer to `f64`, refusing the cases where that would silently
/// lose precision.
fn as_float(num: &Num) -> Result<f64> {
    match num {
        Num::Float(f) => Ok(*f),
        Num::Int(v) => match v.to_f64() {
            Some(f) if f.is_finite() && BigInt::from(f as i128) == *v => Ok(f),
            _ => Err(EyeronError::new("Integer is too large for implicit floating-point conversion")),
        },
    }
}

/// Exact comparison between two evaluated numbers, without widening a
/// bigint to `f64`.
fn num_cmp(a: &Num, b: &Num) -> Result<Ordering> {
    Ok(match (a, b) {
        (Num::Int(x), Num::Int(y)) => x.cmp(y),
        (Num::Float(x), Num::Float(y)) => x.partial_cmp(y).ok_or_else(|| EyeronError::new("Cannot compare a non-numeric float"))?,
        (Num::Int(x), Num::Float(y)) => big_vs_float(x, *y).unwrap_or(Ordering::Equal),
        (Num::Float(x), Num::Int(y)) => big_vs_float(y, *x).unwrap_or(Ordering::Equal).reverse(),
    })
}

fn is_zero(num: &Num) -> bool {
    match num {
        Num::Int(v) => v.is_zero(),
        Num::Float(f) => *f == 0.0,
    }
}

fn integers(op: &str, a: Num, b: Num) -> Result<(BigInt, BigInt)> {
    match (a, b) {
        (Num::Int(x), Num::Int(y)) => Ok((x, y)),
        _ => Err(EyeronError::new(format!("{} requires integer operands", op))),
    }
}

fn to_integer(value: f64, name: &str) -> Result<Term> {
    if !value.is_finite() {
        return Err(EyeronError::new(format!("{} of a non-finite float", name)));
    }
    Ok(Term::Int(BigInt::from(value as i128)))
}

fn binary(op: &str, left: Num, right: Num) -> Result<Term> {
    match op {
        "+" | "-" | "*" => {
            if let (Num::Int(x), Num::Int(y)) = (&left, &right) {
                let value = match op {
                    "+" => x + y,
                    "-" => x - y,
                    _ => x * y,
                };
                return Ok(Term::Int(value));
            }
            let (x, y) = (as_float(&left)?, as_float(&right)?);
            number_term(Num::Float(match op {
                "+" => x + y,
                "-" => x - y,
                _ => x * y,
            }))
        }
        "/" => {
            if is_zero(&right) {
                return Err(EyeronError::new("Division by zero"));
            }
            // Two integers that divide exactly give the integer quotient;
            // every other case gives a float (§8).
            if let (Num::Int(x), Num::Int(y)) = (&left, &right) {
                if (x % y).is_zero() {
                    return Ok(Term::Int(x / y));
                }
            }
            number_term(Num::Float(as_float(&left)? / as_float(&right)?))
        }
        "//" | "mod" | "rem" => {
            if is_zero(&right) {
                return Err(EyeronError::new("Division by zero"));
            }
            let (x, y) = integers(op, left, right)?;
            Ok(Term::Int(match op {
                // Truncating quotient and its remainder, so `rem` carries
                // the sign of the dividend.
                "//" => &x / &y,
                "rem" => &x % &y,
                // Floor modulo, carrying the sign of the divisor.
                _ => {
                    let remainder = &x % &y;
                    if !remainder.is_zero() && (remainder.is_negative() != y.is_negative()) {
                        remainder + y
                    } else {
                        remainder
                    }
                }
            }))
        }
        "min" | "max" => {
            let keep_left = (num_cmp(&left, &right)? != Ordering::Greater) == (op == "min");
            number_term(if keep_left { left } else { right })
        }
        "**" => number_term(Num::Float(as_float(&left)?.powf(as_float(&right)?))),
        "^" => {
            if let (Num::Int(x), Num::Int(y)) = (&left, &right) {
                let exponent = y.to_u32().ok_or_else(|| EyeronError::new("^ needs a non-negative integer exponent below 2^32"))?;
                return Ok(Term::Int(x.pow(exponent)));
            }
            number_term(Num::Float(as_float(&left)?.powf(as_float(&right)?)))
        }
        _ => Err(EyeronError::new(format!("Unknown evaluable functor {}/2", op))),
    }
}

fn unary(op: &str, value: Num) -> Result<Term> {
    match op {
        "-" => number_term(match value {
            Num::Int(v) => Num::Int(-v),
            Num::Float(f) => Num::Float(-f),
        }),
        "+" => number_term(value),
        "abs" => number_term(match value {
            Num::Int(v) => Num::Int(v.abs()),
            Num::Float(f) => Num::Float(f.abs()),
        }),
        "sign" => Ok(match value {
            Num::Int(v) => Term::Int(BigInt::from(if v.is_zero() { 0 } else if v.is_negative() { -1 } else { 1 })),
            Num::Float(f) => Term::Float(if f == 0.0 { 0.0 } else { f.signum() }),
        }),
        "sqrt" => number_term(Num::Float(as_float(&value)?.sqrt())),
        "float" => number_term(Num::Float(as_float(&value)?)),
        "floor" | "ceiling" | "truncate" | "round" | "integer" => {
            if let Num::Int(v) = value {
                return Ok(Term::Int(v));
            }
            let f = as_float(&value)?;
            to_integer(
                match op {
                    "floor" => f.floor(),
                    "ceiling" => f.ceil(),
                    "truncate" => f.trunc(),
                    // ISO/IEC 13211-1 §9.1.6.1 defines rounding as
                    // floor(x + 1/2), so a tie goes toward positive
                    // infinity and `round(-2.5)` is -2. Rust's own
                    // `f64::round` breaks ties away from zero and would
                    // answer -3; SWI-Prolog does the same, and GNU Prolog
                    // rounds ties to even, so all three answers exist in
                    // the wild. This follows the standard's text.
                    _ => (f + 0.5).floor(),
                },
                op,
            )
        }
        _ => Err(EyeronError::new(format!("Unknown evaluable functor {}/1", op))),
    }
}

/// Evaluate `expr` as an arithmetic expression, the way `is/2` does. An
/// unbound variable or a functor with no arithmetic meaning is an error,
/// never a failure (§8).
pub fn evaluate(expr: &Term, env: &Bindings) -> Result<Term> {
    let value = instantiate(expr, env);
    match &value {
        Term::Int(_) | Term::Float(_) => Ok(value),
        Term::Var(..) => Err(EyeronError::new("Arithmetic needs bound inputs; got an unbound variable")),
        Term::Str(_) => Err(EyeronError::new(format!("Expected a number; got {}", term::format(&value)))),
        Term::Struct(name, args) => match args.len() {
            1 => unary(name, as_number(&evaluate(&args[0], env)?)?),
            2 => binary(name, as_number(&evaluate(&args[0], env)?)?, as_number(&evaluate(&args[1], env)?)?),
            _ => Err(EyeronError::new(format!("Unknown evaluable functor {}/{}", name, args.len()))),
        },
    }
}

fn numeric_compare(op: &str, left: &Term, right: &Term, env: &Bindings) -> Result<bool> {
    let a = as_number(&evaluate(left, env)?)?;
    let b = as_number(&evaluate(right, env)?)?;
    let ord = num_cmp(&a, &b)?;
    Ok(match op {
        "<" => ord == Ordering::Less,
        ">" => ord == Ordering::Greater,
        "=<" => ord != Ordering::Greater,
        ">=" => ord != Ordering::Less,
        "=:=" => ord == Ordering::Equal,
        _ => ord != Ordering::Equal,
    })
}

fn term_compare(op: &str, left: &Term, right: &Term, env: &Bindings) -> bool {
    let ord = order(&instantiate(left, env), &instantiate(right, env));
    match op {
        "==" => ord == Ordering::Equal,
        "\\==" => ord != Ordering::Equal,
        "@<" => ord == Ordering::Less,
        "@>" => ord == Ordering::Greater,
        "@=<" => ord != Ordering::Greater,
        _ => ord != Ordering::Less,
    }
}

fn sorted(values: Vec<Term>) -> Vec<Term> {
    let mut unique = values;
    unique.sort_by(order);
    unique.dedup_by(|a, b| order(a, b) == Ordering::Equal);
    unique
}

fn fold_numeric(name: &str, values: &[Term]) -> Result<Term> {
    if name != "sum_list" && values.is_empty() {
        return Err(EyeronError::new(format!("{} requires a nonempty list", name)));
    }
    let mut acc = Num::Int(BigInt::zero());
    for (index, value) in values.iter().enumerate() {
        let next = as_number(value)?;
        acc = match name {
            "sum_list" => as_number(&binary("+", acc, next)?)?,
            _ if index == 0 => next,
            "min_list" => as_number(&binary("min", acc, next)?)?,
            _ => as_number(&binary("max", acc, next)?)?,
        };
    }
    number_term(acc)
}

/// Dispatch a built-in goal, returning every resulting binding environment
/// (one per solution). `call`'s arguments are already instantiated against
/// `env` by the caller.
pub fn call_builtin(call: &Term, env: &Bindings, tick: &mut dyn FnMut() -> Result<()>) -> Result<Vec<Bindings>> {
    let Term::Struct(name, args) = call else { return Ok(Vec::new()) };
    let one = |branch: Bindings| -> Vec<Bindings> { vec![branch] };
    let unify_one = |target: &Term, value: Term| -> Vec<Bindings> {
        let mut branch = env.clone();
        if unify(target, &value, &mut branch) {
            one(branch)
        } else {
            Vec::new()
        }
    };
    match (name.as_str(), args.len()) {
        ("true", 0) => Ok(one(env.clone())),
        ("fail", 0) | ("false", 0) => Ok(Vec::new()),
        ("=", 2) => {
            let mut branch = env.clone();
            Ok(if unify(&args[0], &args[1], &mut branch) { one(branch) } else { Vec::new() })
        }
        ("\\=", 2) => {
            let mut probe = env.clone();
            Ok(if unify(&args[0], &args[1], &mut probe) { Vec::new() } else { one(env.clone()) })
        }
        ("==", 2) | ("\\==", 2) | ("@<", 2) | ("@>", 2) | ("@=<", 2) | ("@>=", 2) => {
            Ok(if term_compare(name, &args[0], &args[1], env) { one(env.clone()) } else { Vec::new() })
        }
        ("is", 2) => Ok(unify_one(&args[0], evaluate(&args[1], env)?)),
        ("<", 2) | (">", 2) | ("=<", 2) | (">=", 2) | ("=:=", 2) | ("=\\=", 2) => {
            Ok(if numeric_compare(name, &args[0], &args[1], env)? { one(env.clone()) } else { Vec::new() })
        }
        ("between", 3) => {
            let (low, high) = integers("between", as_number(&require_ground(args[0].clone(), "between")?)?, as_number(&require_ground(args[1].clone(), "between")?)?)?;
            let mut out = Vec::new();
            let mut i = low;
            while i <= high {
                tick()?;
                let mut branch = env.clone();
                if unify(&args[2], &Term::Int(i.clone()), &mut branch) {
                    out.push(branch);
                }
                i += 1;
            }
            Ok(out)
        }
        ("length", 2) => {
            let values = array(&require_ground(args[0].clone(), "length")?).map_err(EyeronError::new)?;
            Ok(unify_one(&args[1], Term::Int(BigInt::from(values.len()))))
        }
        ("sort", 2) => {
            let values = array(&require_ground(args[0].clone(), "sort")?).map_err(EyeronError::new)?;
            Ok(unify_one(&args[1], term::list(sorted(values))))
        }
        ("sum_list", 2) | ("max_list", 2) | ("min_list", 2) => {
            let values = array(&require_ground(args[0].clone(), name)?).map_err(EyeronError::new)?;
            Ok(unify_one(&args[1], fold_numeric(name, &values)?))
        }
        ("atomics_to_string", 2) => {
            let values = array(&require_ground(args[0].clone(), "atomics_to_string")?).map_err(EyeronError::new)?;
            let mut text = String::new();
            for value in &values {
                match term::lexical_text(value) {
                    Some(part) => text.push_str(&part),
                    None => return Err(EyeronError::new(format!("atomics_to_string needs atomic list elements; got {}", term::format(value)))),
                }
            }
            Ok(unify_one(&args[1], term::str_(text)))
        }
        ("sudoku", 2) => sudoku(&args[0], &args[1], env, tick),
        _ => Ok(Vec::new()),
    }
}

struct SudokuState {
    grid: [i32; 81],
    row_masks: [u32; 9],
    col_masks: [u32; 9],
    box_masks: [u32; 9],
}

fn sudoku_state(value: &Term) -> Result<Option<SudokuState>> {
    let value = require_ground(value.clone(), "sudoku puzzle")?;
    let rows = array(&value).map_err(EyeronError::new)?;
    if rows.len() != 9 {
        return Err(EyeronError::new("sudoku needs exactly 9 rows"));
    }
    let mut grid = [0i32; 81];
    for (r, row) in rows.iter().enumerate() {
        let cells = array(row).map_err(EyeronError::new)?;
        if cells.len() != 9 {
            return Err(EyeronError::new("each sudoku row needs exactly 9 cells"));
        }
        for (c, cell) in cells.iter().enumerate() {
            let value = match cell {
                Term::Int(v) => v,
                _ => return Err(EyeronError::new("sudoku cells must be integers from 0 through 9")),
            };
            let digit = value.to_i32().filter(|d| (0..=9).contains(d)).ok_or_else(|| EyeronError::new("sudoku cells must be integers from 0 through 9"))?;
            grid[r * 9 + c] = digit;
        }
    }
    let mut row_masks = [0u32; 9];
    let mut col_masks = [0u32; 9];
    let mut box_masks = [0u32; 9];
    for (index, &digit) in grid.iter().enumerate() {
        if digit == 0 {
            continue;
        }
        let row = index / 9;
        let col = index % 9;
        let boxi = (row / 3) * 3 + (col / 3);
        let bit = 1u32 << digit;
        if (row_masks[row] | col_masks[col] | box_masks[boxi]) & bit != 0 {
            return Ok(None);
        }
        row_masks[row] |= bit;
        col_masks[col] |= bit;
        box_masks[boxi] |= bit;
    }
    Ok(Some(SudokuState { grid, row_masks, col_masks, box_masks }))
}

/// Returns `Ok(false)` iff `on_solution` asked the search to stop early.
fn sudoku_solutions(state: &mut SudokuState, tick: &mut dyn FnMut() -> Result<()>, on_solution: &mut dyn FnMut(&[i32; 81]) -> bool) -> Result<bool> {
    let mut best: i32 = -1;
    let mut choices = 0u32;
    let mut smallest = 10u32;
    for index in 0..81 {
        if state.grid[index] != 0 {
            continue;
        }
        let row = index / 9;
        let col = index % 9;
        let boxi = (row / 3) * 3 + (col / 3);
        let available = 0x3fe & !(state.row_masks[row] | state.col_masks[col] | state.box_masks[boxi]);
        let count = available.count_ones();
        if count == 0 {
            return Ok(true);
        }
        if count < smallest {
            best = index as i32;
            choices = available;
            smallest = count;
        }
    }
    if best < 0 {
        return Ok(on_solution(&state.grid));
    }
    let best = best as usize;
    let row = best / 9;
    let col = best % 9;
    let boxi = (row / 3) * 3 + (col / 3);
    for digit in 1..=9u32 {
        let bit = 1u32 << digit;
        if choices & bit == 0 {
            continue;
        }
        tick()?;
        state.grid[best] = digit as i32;
        state.row_masks[row] |= bit;
        state.col_masks[col] |= bit;
        state.box_masks[boxi] |= bit;
        let keep_going = sudoku_solutions(state, tick, on_solution)?;
        state.row_masks[row] ^= bit;
        state.col_masks[col] ^= bit;
        state.box_masks[boxi] ^= bit;
        state.grid[best] = 0;
        if !keep_going {
            return Ok(false);
        }
    }
    Ok(true)
}

fn sudoku_term(grid: &[i32; 81]) -> Term {
    term::list((0..9).map(|r| term::list((0..9).map(|c| Term::Int(BigInt::from(grid[r * 9 + c]))).collect())).collect())
}

fn sudoku(puzzle: &Term, target: &Term, env: &Bindings, tick: &mut dyn FnMut() -> Result<()>) -> Result<Vec<Bindings>> {
    let Some(mut state) = sudoku_state(puzzle)? else { return Ok(Vec::new()) };
    let target = target.clone();
    let env = env.clone();
    let mut out = Vec::new();
    sudoku_solutions(&mut state, tick, &mut |grid| {
        let mut branch = env.clone();
        if unify(&target, &sudoku_term(grid), &mut branch) {
            out.push(branch);
        }
        true
    })?;
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn eval(source: &str) -> Result<Term> {
        let mut counter = term::VarCounter::new();
        let program = super::super::parser::parse(&format!("p({}).", source), &mut counter).unwrap();
        let Term::Struct(_, args) = &program.rules[0].head else { panic!() };
        evaluate(&args[0], &Bindings::new())
    }

    fn evaluated(source: &str) -> String {
        term::format(&eval(source).unwrap_or_else(|err| panic!("{source}: {err}")))
    }

    #[test]
    fn integer_arithmetic_stays_integral() {
        assert_eq!(evaluated("1 + 2 * 3"), "7");
        assert_eq!(evaluated("7 // 2"), "3");
        assert_eq!(evaluated("-7 // 2"), "-3");
        assert_eq!(evaluated("4 / 2"), "2");
        assert_eq!(evaluated("2 ^ 10"), "1024");
    }

    #[test]
    fn mod_takes_the_divisor_sign_and_rem_the_dividend_sign() {
        assert_eq!(evaluated("-7 mod 3"), "2");
        assert_eq!(evaluated("-7 rem 3"), "-1");
        assert_eq!(evaluated("7 mod -3"), "-2");
    }

    #[test]
    fn float_results_are_floats() {
        assert_eq!(evaluated("1 / 2"), "0.5");
        assert_eq!(evaluated("sqrt(4)"), "2.0");
        assert_eq!(evaluated("2.0 ** 3"), "8.0");
    }

    #[test]
    fn rounding_functions_return_integers() {
        assert_eq!(evaluated("round(2.5)"), "3");
        assert_eq!(evaluated("round(-2.5)"), "-2");
        assert_eq!(evaluated("floor(-2.5)"), "-3");
        assert_eq!(evaluated("ceiling(-2.5)"), "-2");
        assert_eq!(evaluated("truncate(-2.5)"), "-2");
    }

    #[test]
    fn an_unknown_functor_is_an_error_not_a_failure() {
        assert!(eval("frobnicate(1)").is_err());
        assert!(eval("X + 1").is_err());
    }

    #[test]
    fn sort_uses_the_standard_order_and_removes_duplicates() {
        let values = vec![term::atom("b"), term::int(2), term::atom("a"), term::int(2), term::float(1.5)];
        assert_eq!(term::format(&term::list(sorted(values))), "[1.5, 2, a, b]");
    }
}
