% Prolog result format 3
query(1, append(_0, _1, [a, b]), ['Left' = _0, 'Right' = _1]).
result(1, complete, 3).
answer(1, ['Left' = [], 'Right' = [a, b]]).
answer(1, ['Left' = [a], 'Right' = [b]]).
answer(1, ['Left' = [a, b], 'Right' = []]).
query(2, member(_0, [a, b, a]), ['X' = _0]).
result(2, complete, 2).
answer(2, ['X' = a]).
answer(2, ['X' = b]).
