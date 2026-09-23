test_is(true).

clause(1, cat(c), true).
clause(2, animal(var('X')), cat(var('X'))).
clause(3, test_is(true), animal(c)).

step(test_is(true), rule(3), [], [animal(c)]).
step(animal(c), rule(2), ['X' = c], [cat(c)]).
step(cat(c), fact(1), [], []).
