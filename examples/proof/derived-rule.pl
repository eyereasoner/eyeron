% Prolog result format 4
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], [test_is(true)]).

clause(1, cat(minka), true).
clause(2, dog(charly), true).
clause(3, test_is(true), (cat(var('X')), dog(var('Y')))).

step(test_is(true), rule(3), ['X' = minka, 'Y' = charly], [cat(minka), dog(charly)]).
step(cat(minka), fact(1), [], []).
step(dog(charly), fact(2), [], []).
