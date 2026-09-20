//! Shared 9x9 Sudoku backtracking solver (minimum-remaining-candidates
//! search), used by both `n3::reasoner`'s `sudoku#solve` builtin and
//! `srl::expr`'s `sudoku(...)` custom function. The puzzle and solution are
//! both 81-character strings (`.` or `0` for a blank cell, `1`-`9` for a
//! given), ported from eyelang's own `sudoku/2` builtin
//! (`eye::builtins::sudoku_state`/`sudoku_solutions`, which instead takes a
//! 9x9 nested list and can enumerate every solution rather than just the
//! first).

use std::collections::BTreeSet;
use std::sync::OnceLock;

/// Solves a 9x9 Sudoku puzzle given as an 81-character string. Returns
/// `Ok(solution)` (an 81-character string of `1`-`9`) if solvable, `Ok(String::new())`
/// if the puzzle has no solution, or `Err(message)` if the input is
/// malformed: wrong length, a character that is not a digit or `.`, or
/// conflicting givens.
pub fn solve_sudoku_string(puzzle: &str) -> Result<String, String> {
    let text = puzzle.trim();
    if text.chars().count() != 81 || !text.chars().all(|c| c == '.' || c.is_ascii_digit()) {
        return Err("sudoku expects an 81-character puzzle string containing digits or dots".to_string());
    }
    let mut cells = [0u8; 81];
    for (i, ch) in text.chars().enumerate() {
        cells[i] = if ch == '.' { 0 } else { ch as u8 - b'0' };
    }
    let peers = sudoku_peers();
    for (i, &value) in cells.iter().enumerate() {
        if value == 0 {
            continue;
        }
        if peers[i].iter().any(|&p| cells[p] == value) {
            return Err("sudoku puzzle has conflicting givens".to_string());
        }
    }
    Ok(if solve_sudoku_cells(&mut cells, peers) {
        cells.iter().map(|&v| char::from(b'0' + v)).collect()
    } else {
        String::new()
    })
}

fn solve_sudoku_cells(cells: &mut [u8; 81], peers: &'static [Vec<usize>; 81]) -> bool {
    let mut best_index = None;
    let mut best_candidates = Vec::new();
    for (i, &value) in cells.iter().enumerate() {
        if value != 0 {
            continue;
        }
        let candidates = sudoku_candidates(cells, &peers[i]);
        if candidates.is_empty() {
            return false;
        }
        if best_index.is_none() || candidates.len() < best_candidates.len() {
            best_index = Some(i);
            best_candidates = candidates;
            if best_candidates.len() == 1 {
                break;
            }
        }
    }
    let Some(index) = best_index else { return true };
    for value in best_candidates {
        cells[index] = value;
        if solve_sudoku_cells(cells, peers) {
            return true;
        }
        cells[index] = 0;
    }
    false
}

fn sudoku_candidates(cells: &[u8; 81], peers: &[usize]) -> Vec<u8> {
    let mut used = [false; 10];
    for &p in peers {
        let value = cells[p];
        if value != 0 {
            used[value as usize] = true;
        }
    }
    (1..=9u8).filter(|&v| !used[v as usize]).collect()
}

fn sudoku_peers() -> &'static [Vec<usize>; 81] {
    static PEERS: OnceLock<[Vec<usize>; 81]> = OnceLock::new();
    PEERS.get_or_init(|| {
        std::array::from_fn(|index| {
            let row = index / 9;
            let col = index % 9;
            let box_row = (row / 3) * 3;
            let box_col = (col / 3) * 3;
            let mut set = BTreeSet::new();
            for c in 0..9 {
                set.insert(row * 9 + c);
            }
            for r in 0..9 {
                set.insert(r * 9 + col);
            }
            for r in box_row..box_row + 3 {
                for c in box_col..box_col + 3 {
                    set.insert(r * 9 + c);
                }
            }
            set.remove(&index);
            set.into_iter().collect()
        })
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn solves_ai_escargot() {
        let puzzle = "100007090030020008009600500005300900010080002600004000300000010040000007007000300";
        let solved = solve_sudoku_string(puzzle).unwrap();
        assert_eq!(solved.len(), 81);
        assert!(solved.chars().all(|c| c.is_ascii_digit() && c != '0'));
    }

    #[test]
    fn rejects_conflicting_givens() {
        let mut puzzle = vec!['.'; 81];
        puzzle[0] = '5';
        puzzle[1] = '5';
        let puzzle: String = puzzle.into_iter().collect();
        assert!(solve_sudoku_string(&puzzle).is_err());
    }

    #[test]
    fn rejects_wrong_length() {
        assert!(solve_sudoku_string("123").is_err());
    }
}
