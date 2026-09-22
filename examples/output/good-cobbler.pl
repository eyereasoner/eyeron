% Prolog result format 4
query(1, report(_0), ['Statement' = _0]).
result(1, complete, 1).
answer(1, ['Statement' = quoted(triple(joe, is_a, [good, cobbler]))]).
query(2, is_a(joe, good), []).
result(2, complete, 0).
