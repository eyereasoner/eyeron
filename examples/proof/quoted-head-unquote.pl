% Prolog result format 4
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], [test_is(true)]).

clause(1, cat(c), true).
clause(2, animal(var('X')), cat(var('X'))).
clause(3, test_is(true), animal(c)).

step(test_is(true), rule(3), [], [animal(c)]).
step(animal(c), rule(2), ['X' = c], [cat(c)]).
step(cat(c), fact(1), [], []).
