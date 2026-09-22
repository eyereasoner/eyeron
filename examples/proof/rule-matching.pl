% Prolog result format 4
query(1, result_is_true, []).
result(1, complete, 1).
answer(1, []).
why(1, [], [result_is_true]).

clause(1, implication(rule1), true).
clause(2, result_is_true, implication(anonymous(1))).

step(result_is_true, rule(2), [], [implication(rule1)]).
step(implication(rule1), fact(1), [], []).
