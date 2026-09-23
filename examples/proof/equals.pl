test.

clause(1, same_as(x, y), true).
clause(2, test, same_as(x, y)).

step(test, rule(2), [], [same_as(x, y)]).
step(same_as(x, y), fact(1), [], []).
