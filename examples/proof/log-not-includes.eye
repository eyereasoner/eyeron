# Eyelang result format 2
query(1, [call(a_b_c(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 4).
query(2, [call(test_is(?v0))], [binding("r", ?v0)]).
result(2, complete, 0).
clause(1, equal_one(1), []).
clause(2, x_y(1), [call(equal_one(1))]).
clause(3, a_b_c(true), [call(x_y(1))]).
substitution(1, []).
proof(1, equal_one(1), rule(1), []).
substitution(2, []).
proof(2, x_y(1), rule(2), [uses(1, equal_one(1))]).
substitution(3, []).
proof(3, a_b_c(true), rule(3), [uses(2, x_y(1))]).
substitution(4, [binding("r", true)]).
proof(4, solution([true]), query, [uses(3, a_b_c(true))]).
substitution(5, []).
proof(5, equal_one(1), rule(1), []).
substitution(6, []).
proof(6, x_y(1), rule(2), [uses(5, equal_one(1))]).
substitution(7, []).
proof(7, a_b_c(true), rule(3), [uses(6, x_y(1))]).
substitution(8, []).
proof(8, solution([]), query, [uses(7, a_b_c(true))]).
