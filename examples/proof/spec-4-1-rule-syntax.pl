both_positive(x).

clause(1, values(x, 1, 2), true).
clause(2,
       both_positive(var('X')),
       (values(var('X'), var('A'), var('B')), var('A') > 0, var('B') > 0)).

step(both_positive(x), rule(2), ['X' = x, 'A' = 1, 'B' = 2], [values(x, 1, 2), 1 > 0, 2 > 0]).
step(values(x, 1, 2), fact(1), [], []).
step(1 > 0, builtin, [], []).
step(2 > 0, builtin, [], []).
