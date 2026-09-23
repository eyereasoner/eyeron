a_b_c(true).

clause(1, equal_one(1), true).
clause(2, x_y(1), equal_one(1)).
clause(3, a_b_c(true), x_y(1)).

step(a_b_c(true), rule(3), [], [x_y(1)]).
step(x_y(1), rule(2), [], [equal_one(1)]).
step(equal_one(1), fact(1), [], []).
