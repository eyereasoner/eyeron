% Prolog result format 4
query(1, test, []).
result(1, complete, 1).
answer(1, []).
why(1, [], [test]).

clause(1, same_as(x, y), true).
clause(2, test, same_as(x, y)).

step(test, rule(2), [], [same_as(x, y)]).
step(same_as(x, y), fact(1), [], []).
