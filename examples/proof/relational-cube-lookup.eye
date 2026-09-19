# Eyelang result format 2
query(1, [call(cube(137, ?v0, 11, ?v1))], [binding("b", ?v0), binding("value", ?v1)]).
result(1, complete, 1).
answer(1, [binding("b", 110), binding("value", 2066)]).
why(1, [binding("b", 110), binding("value", 2066)], 2).
clause(1, cube(var("a"), var("b"), var("c"), var("value")), [call(range(0, 224, var("a"))), call(range(0, 14, var("c"))), calculate(var("offset"), binary("*", value(var("a")), value(17))), calculate(var("b"), binary("%", binary("+", value(var("offset")), binary("*", value(var("c")), value(31))), value(512))), calculate(var("value"), binary("+", binary("*", value(var("a")), value(15)), value(var("c"))))]).
substitution(1, [binding("a", 137), binding("b", 110), binding("c", 11), binding("value", 2066), binding("offset", 2329)]).
proof(1, cube(137, 110, 11, 2066), rule(1), [builtin(range(0, 224, 137)), builtin(range(0, 14, 11)), calculated(2329, binary("*", value(137), value(17))), calculated(110, binary("%", binary("+", value(2329), binary("*", value(11), value(31))), value(512))), calculated(2066, binary("+", binary("*", value(137), value(15)), value(11)))]).
substitution(2, [binding("b", 110), binding("value", 2066)]).
proof(2, solution([110, 2066]), query, [uses(1, cube(137, 110, 11, 2066))]).
