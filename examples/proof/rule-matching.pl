% Prolog result format 3
query(1, result_is_true, []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
clause(1, implication(rule1), true).
clause(2, result_is_true, implication(anonymous(1))).
substitution(1, []).
proof(1, implication(rule1), rule(1), []).
substitution(2, []).
proof(2, result_is_true, rule(2), [uses(1, implication(rule1))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, result_is_true)]).
