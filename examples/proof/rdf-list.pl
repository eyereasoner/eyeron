test_is(true).

clause(1, val(x, [1, 2]), true).
clause(2, test_is(true), (val(x, [var('H')|var('T')]), var('H') = 1, var('T') = [2])).

step(test_is(true), rule(2), ['H' = 1, 'T' = [2]], [val(x, [1, 2]), 1 = 1, [2] = [2]]).
step(val(x, [1, 2]), fact(1), [], []).
step(1 = 1, builtin, [], []).
step([2] = [2], builtin, [], []).
