% Prolog result format 3
query(1, phase_pi(_0, _1), ['Re' = _0, 'Im' = _1]).
result(1, complete, 1).
answer(1, ['Re' = -1, 'Im' = 0]).
query(2, lhs(_0, _1), ['Re' = _0, 'Im' = _1]).
result(2, complete, 1).
answer(2, ['Re' = 0, 'Im' = 0]).
query(3, holds(_0), ['Ok' = _0]).
result(3, complete, 1).
answer(3, ['Ok' = true]).
query(4, mod_sq(_0), ['M' = _0]).
result(4, complete, 1).
answer(4, ['M' = 1]).
query(5, mod_sq_is_one(_0), ['Ok' = _0]).
result(5, complete, 1).
answer(5, ['Ok' = true]).
