//! Arithmetic expression evaluation and the four built-in relations
//! (`range/3`, `length/2`, `sort/2`, `sudoku/2`), mirroring `builtins.js`.

use std::cmp::Ordering;

use num_bigint::BigInt;

use crate::error::{EyeronError, Result};

use super::ast::Expr;
use super::term::{self, array, ground, instantiate, key, term_key, unify, Bindings, Term};

pub const BUILTIN_RELATIONS: [&str; 4] = ["range/3", "length/2", "sort/2", "sudoku/2"];

pub fn is_builtin_relation(signature: &str) -> bool {
    BUILTIN_RELATIONS.contains(&signature)
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

fn numeric(value: &Term) -> Result<Num> {
    let value = require_ground(value.clone(), "Arithmetic")?;
    match value {
        Term::Int(v) => Ok(Num::Int(v)),
        Term::Float(v) => Ok(Num::Float(v)),
        other => Err(EyeronError::new(format!("Expected a number; got {}", term::format(&other)))),
    }
}

/// Lossy for integers outside `f64`'s safe range, used only for relational
/// comparisons (`<`, `>`, ...) between possibly-mixed int/float operands.
/// Eyelang's own JS relies on native cross-type comparison, which is exact
/// even for huge bigints; this port accepts that rare imprecision rather
/// than implementing exact bigint/float comparison.
fn numeric_f64(num: &Num) -> f64 {
    match num {
        Num::Int(v) => v.to_string().parse().unwrap_or(f64::NAN),
        Num::Float(f) => *f,
    }
}

fn as_float(num: &Num) -> Result<f64> {
    match num {
        Num::Float(f) => Ok(*f),
        Num::Int(v) => {
            let max = BigInt::from(9_007_199_254_740_991i64);
            if *v > max || *v < -&max {
                return Err(EyeronError::new("Integer is too large for implicit floating-point conversion"));
            }
            Ok(v.to_string().parse().unwrap())
        }
    }
}

fn is_zero(num: &Num) -> bool {
    match num {
        Num::Int(v) => *v == BigInt::from(0),
        Num::Float(f) => *f == 0.0,
    }
}

fn checked(num: Num) -> Result<Term> {
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

fn negate(num: Num) -> Num {
    match num {
        Num::Int(v) => Num::Int(-v),
        Num::Float(f) => Num::Float(-f),
    }
}

fn abs_num(num: Num) -> Num {
    match num {
        Num::Int(v) => Num::Int(if v < BigInt::from(0) { -v } else { v }),
        Num::Float(f) => Num::Float(f.abs()),
    }
}

/// The plain lexical conversion used by `str`/`concat` — deliberately not
/// `term::format`, which appends `.0` to integral floats; `String(value)`
/// in JS does not.
fn lexical(value: &Term) -> Result<String> {
    let value = require_ground(value.clone(), "String conversion")?;
    Ok(match value {
        Term::Str(s) => s,
        Term::Atom(a) => a,
        Term::Int(v) => v.to_string(),
        Term::Float(f) => term::format_number_js(f),
        Term::Bool(b) => b.to_string(),
        other => term::format(&other),
    })
}

fn binary(op: &str, a: &Term, b: &Term) -> Result<Term> {
    let left = numeric(a)?;
    let right = numeric(b)?;
    if matches!(op, "/" | "//" | "%") && is_zero(&right) {
        return Err(EyeronError::new("Division by zero"));
    }
    if op == "//" {
        return match (left, right) {
            (Num::Int(l), Num::Int(r)) => Ok(Term::Int(l / r)),
            _ => Err(EyeronError::new("// requires integer operands")),
        };
    }
    let mixed = matches!((&left, &right), (Num::Int(_), Num::Float(_)) | (Num::Float(_), Num::Int(_)));
    if op == "/" || mixed {
        let l = as_float(&left)?;
        let r = as_float(&right)?;
        let value = match op {
            "+" => l + r,
            "-" => l - r,
            "*" => l * r,
            "/" => l / r,
            "%" => l % r,
            _ => return Err(EyeronError::new(format!("Unknown arithmetic operator {}", op))),
        };
        return checked(Num::Float(value));
    }
    match (left, right) {
        (Num::Int(l), Num::Int(r)) => {
            let value = match op {
                "+" => l + r,
                "-" => l - r,
                "*" => l * r,
                "%" => l % r,
                _ => return Err(EyeronError::new(format!("Unknown arithmetic operator {}", op))),
            };
            checked(Num::Int(value))
        }
        (Num::Float(l), Num::Float(r)) => {
            let value = match op {
                "+" => l + r,
                "-" => l - r,
                "*" => l * r,
                "%" => l % r,
                _ => return Err(EyeronError::new(format!("Unknown arithmetic operator {}", op))),
            };
            checked(Num::Float(value))
        }
        _ => unreachable!(),
    }
}

pub fn evaluate(expr: &Expr, env: &Bindings) -> Result<Term> {
    match expr {
        Expr::Value(term) => require_ground(instantiate(term, env), "Expression"),
        Expr::Unary { arg } => {
            let value = evaluate(arg, env)?;
            checked(negate(numeric(&value)?))
        }
        Expr::Binary { op, left, right } => {
            let l = evaluate(left, env)?;
            let r = evaluate(right, env)?;
            binary(op, &l, &r)
        }
        Expr::Function { name, args } => {
            let values: Vec<Term> = args.iter().map(|a| evaluate(a, env)).collect::<Result<_>>()?;
            if name == "concat" {
                let parts: Vec<String> = values.iter().map(lexical).collect::<Result<_>>()?;
                return Ok(term::str_(parts.join("")));
            }
            if values.len() != 1 {
                return Err(EyeronError::new(format!("{} expects one argument", name)));
            }
            match name.as_str() {
                "str" => Ok(term::str_(lexical(&values[0])?)),
                "abs" => checked(abs_num(numeric(&values[0])?)),
                "sqrt" => checked(Num::Float(as_float(&numeric(&values[0])?)?.sqrt())),
                // Ties go toward positive infinity (specification §8), so
                // `round(-2.5)` is `-2.0`. Rust's own `f64::round` breaks
                // ties away from zero and would answer `-3.0`.
                "round" => checked(Num::Float((as_float(&numeric(&values[0])?)? + 0.5).floor())),
                "count" => {
                    let items = array(&values[0]).map_err(EyeronError::new)?;
                    Ok(Term::Int(BigInt::from(items.len())))
                }
                "sum" => sum_list(&array(&values[0]).map_err(EyeronError::new)?),
                "min" => reduce_min_max(&array(&values[0]).map_err(EyeronError::new)?, true),
                "max" => reduce_min_max(&array(&values[0]).map_err(EyeronError::new)?, false),
                _ => Err(EyeronError::new(format!("Unknown expression function {}", name))),
            }
        }
    }
}

fn sum_list(values: &[Term]) -> Result<Term> {
    let mut acc = Term::Int(BigInt::from(0));
    for value in values {
        acc = binary("+", &acc, value)?;
    }
    Ok(acc)
}

fn cmp_terms_numeric(a: &Term, b: &Term) -> Result<Ordering> {
    let na = numeric(a)?;
    let nb = numeric(b)?;
    Ok(numeric_f64(&na).partial_cmp(&numeric_f64(&nb)).unwrap_or(Ordering::Equal))
}

fn reduce_min_max(values: &[Term], want_min: bool) -> Result<Term> {
    if values.is_empty() {
        return Err(EyeronError::new(format!("{} requires a nonempty list", if want_min { "min" } else { "max" })));
    }
    for value in values {
        numeric(value)?;
    }
    let mut acc = values[0].clone();
    for value in &values[1..] {
        let ord = cmp_terms_numeric(&acc, value)?;
        let keep_acc = if want_min { ord != Ordering::Greater } else { ord != Ordering::Less };
        if !keep_acc {
            acc = value.clone();
        }
    }
    Ok(acc)
}

pub fn compare(op: &str, left: &Term, right: &Term, env: &mut Bindings) -> Result<bool> {
    if op == "=" {
        return Ok(unify(left, right, env));
    }
    let left = require_ground(instantiate(left, env), op)?;
    let right = require_ground(instantiate(right, env), op)?;
    if op == "!=" {
        return Ok(term_key(&left) != term_key(&right));
    }
    let a = numeric(&left)?;
    let b = numeric(&right)?;
    let (af, bf) = (numeric_f64(&a), numeric_f64(&b));
    Ok(match op {
        "<" => af < bf,
        ">" => af > bf,
        "<=" => af <= bf,
        ">=" => af >= bf,
        _ => return Err(EyeronError::new(format!("Unknown comparison operator {}", op))),
    })
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
            if *value < BigInt::from(0) || *value > BigInt::from(9) {
                return Err(EyeronError::new("sudoku cells must be integers from 0 through 9"));
            }
            grid[r * 9 + c] = value.to_string().parse().unwrap();
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

fn bit_count(mut bits: u32) -> u32 {
    let mut count = 0;
    while bits != 0 {
        bits &= bits - 1;
        count += 1;
    }
    count
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
        let count = bit_count(available);
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
    let rows: Vec<Term> = (0..9)
        .map(|r| term::list((0..9).map(|c| Term::Int(BigInt::from(grid[r * 9 + c]))).collect()))
        .collect();
    term::list(rows)
}

/// Dispatch a call to one of the four built-in relations, returning every
/// resulting binding-environment (mirroring `env.clone()` before `unify`
/// for each `yield`ed branch in `builtins.js`'s generator). `call`'s
/// arguments are assumed already instantiated against `env` by the caller
/// (matching `step`'s `instantiate(goal.term, env)` before the built-in
/// dispatch check).
pub fn call_builtin(call: &Term, env: &Bindings, tick: &mut dyn FnMut() -> Result<()>) -> Result<Vec<Bindings>> {
    let (name, args) = match call {
        Term::Struct(name, args) => (name.as_str(), args),
        _ => return Ok(Vec::new()),
    };
    match name {
        "range" => {
            let low = numeric(&args[0])?;
            let high = numeric(&args[1])?;
            let (Num::Int(low), Num::Int(high)) = (low, high) else {
                return Err(EyeronError::new("range needs integer bounds"));
            };
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
        "length" => {
            let values = array(&require_ground(args[0].clone(), "length")?).map_err(EyeronError::new)?;
            let mut branch = env.clone();
            Ok(if unify(&args[1], &Term::Int(BigInt::from(values.len())), &mut branch) { vec![branch] } else { Vec::new() })
        }
        "sort" => {
            let values = array(&require_ground(args[0].clone(), "sort")?).map_err(EyeronError::new)?;
            let mut seen: std::collections::BTreeMap<String, Term> = std::collections::BTreeMap::new();
            for value in &values {
                seen.entry(term_key(value)).or_insert_with(|| value.clone());
            }
            let mut unique: Vec<Term> = seen.into_values().collect();
            unique.sort_by(|a, b| {
                let a_num = matches!(a, Term::Int(_) | Term::Float(_));
                let b_num = matches!(b, Term::Int(_) | Term::Float(_));
                if a_num != b_num {
                    return if a_num { Ordering::Less } else { Ordering::Greater };
                }
                if a_num && b_num {
                    if let Ok(ord) = cmp_terms_numeric(a, b) {
                        if ord != Ordering::Equal {
                            return ord;
                        }
                    }
                }
                key(a).cmp(&key(b))
            });
            let mut branch = env.clone();
            Ok(if unify(&args[1], &term::list(unique), &mut branch) { vec![branch] } else { Vec::new() })
        }
        "sudoku" => {
            let mut state = match sudoku_state(&args[0])? {
                Some(state) => state,
                None => return Ok(Vec::new()),
            };
            let target = args[1].clone();
            let env = env.clone();
            let mut out = Vec::new();
            sudoku_solutions(&mut state, tick, &mut |grid| {
                let solution = sudoku_term(grid);
                let mut branch = env.clone();
                if unify(&target, &solution, &mut branch) {
                    out.push(branch);
                }
                true
            })?;
            Ok(out)
        }
        _ => Ok(Vec::new()),
    }
}
