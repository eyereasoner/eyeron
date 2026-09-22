% Prolog result format 4
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], [test_is(true)]).

clause(1, activates(cat, ruleCat), true).
clause(3, class_of(c, cat), true).
clause(4, animal(var('X')), (class_of(var('X'), cat), activates(cat, ruleCat))).
clause(6, test_is(true), animal(c)).

step(test_is(true), rule(6), [], [animal(c)]).
step(animal(c), rule(4), ['X' = c], [class_of(c, cat), activates(cat, ruleCat)]).
step(class_of(c, cat), fact(3), [], []).
step(activates(cat, ruleCat), fact(1), [], []).
