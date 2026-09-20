# Eyelang result format 2
query(1, [call(test_concatenation(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 2).
query(2, [call(test_equal(?v0))], [binding("r", ?v0)]).
result(2, complete, 1).
answer(2, [binding("r", true)]).
why(2, [binding("r", true)], 4).
query(3, [call(test_not_equal(?v0))], [binding("r", ?v0)]).
result(3, complete, 1).
answer(3, [binding("r", true)]).
why(3, [binding("r", true)], 6).
clause(1, test_concatenation(true), [calculate(var("s"), function("concat", [value("hello"), value(" "), value("world!")])), compare("=", var("s"), "hello world!")]).
clause(2, test_equal(true), [compare("=", "hello world!", "hello world!")]).
clause(3, test_not_equal(true), [compare("!=", "hello world!", "hi")]).
substitution(1, [binding("s", "hello world!")]).
proof(1, test_concatenation(true), rule(1), [calculated("hello world!", function("concat", [value("hello"), value(" "), value("world!")])), compared("=", "hello world!", "hello world!")]).
substitution(2, [binding("r", true)]).
proof(2, solution([true]), query, [uses(1, test_concatenation(true))]).
substitution(3, []).
proof(3, test_equal(true), rule(2), [compared("=", "hello world!", "hello world!")]).
substitution(4, [binding("r", true)]).
proof(4, solution([true]), query, [uses(3, test_equal(true))]).
substitution(5, []).
proof(5, test_not_equal(true), rule(3), [compared("!=", "hello world!", "hi")]).
substitution(6, [binding("r", true)]).
proof(6, solution([true]), query, [uses(5, test_not_equal(true))]).
