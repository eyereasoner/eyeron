% Prolog result format 4
query(1, both_positive(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = x]).
why(1, ['X' = x], [both_positive(x)]).
query(2, one_zero(_0), ['X' = _0]).
result(2, complete, 0).

clause(1, values(x, 1, 2), true).
clause(2,
       both_positive(var('X')),
       (values(var('X'), var('A'), var('B')), var('A') > 0, var('B') > 0)).

step(both_positive(x), rule(2), ['X' = x, 'A' = 1, 'B' = 2], [values(x, 1, 2), 1 > 0, 2 > 0]).
step(values(x, 1, 2), fact(1), [], []).
step(1 > 0, builtin, [], []).
step(2 > 0, builtin, [], []).
