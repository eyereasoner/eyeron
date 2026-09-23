result_is_true.

clause(1, implication(rule1), true).
clause(2, result_is_true, implication(anonymous(1))).

step(result_is_true, rule(2), [], [implication(rule1)]).
step(implication(rule1), fact(1), [], []).
