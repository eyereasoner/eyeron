% Prolog result format 3
query(1, has_parent(_0, _1), ['X' = _0, 'Y' = _1]).
result(1, complete, 1).
answer(1, ['X' = bob, 'Y' = alice]).
query(2, child_of(_0, _1), ['X' = _0, 'Y' = _1]).
result(2, complete, 1).
answer(2, ['X' = bob, 'Y' = alice]).
