% Prolog result format 4
query(1, a_b_c(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], [a_b_c(true)]).
query(2, test_is(_0), ['R' = _0]).
result(2, complete, 0).

clause(1, equal_one(1), true).
clause(2, x_y(1), equal_one(1)).
clause(3, a_b_c(true), x_y(1)).

step(a_b_c(true), rule(3), [], [x_y(1)]).
step(x_y(1), rule(2), [], [equal_one(1)]).
step(equal_one(1), fact(1), [], []).
