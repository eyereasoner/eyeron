# Eyelang result format 2
query(1, [call(place(4, 4, [], ?v0))], [binding("rows", ?v0)]).
result(1, complete, 2).
answer(1, [binding("rows", [3, 1, 4, 2])]).
why(1, [binding("rows", [3, 1, 4, 2])], 45).
answer(1, [binding("rows", [2, 4, 1, 3])]).
why(1, [binding("rows", [2, 4, 1, 3])], 46).
clause(1, safe(anonymous(1), [], anonymous(2)), []).
clause(2, safe(var("row"), [var("other") | var("rest")], var("distance")), [compare("!=", var("row"), var("other")), calculate(var("delta"), function("abs", [binary("-", value(var("row")), value(var("other")))])), compare("!=", var("delta"), var("distance")), calculate(var("next"), binary("+", value(var("distance")), value(1))), call(safe(var("row"), var("rest"), var("next")))]).
clause(3, place(0, anonymous(1), var("placed"), var("placed")), []).
clause(4, place(var("remaining"), var("size"), var("placed"), var("rows")), [compare(">", var("remaining"), 0), call(range(1, var("size"), var("row"))), call(safe(var("row"), var("placed"), 1)), calculate(var("next"), binary("-", value(var("remaining")), value(1))), call(place(var("next"), var("size"), [var("row") | var("placed")], var("rows")))]).
substitution(1, []).
proof(1, safe(1, [], 1), rule(1), []).
substitution(2, []).
proof(2, safe(2, [], 1), rule(1), []).
substitution(3, []).
proof(3, safe(3, [], 1), rule(1), []).
substitution(4, []).
proof(4, safe(4, [], 1), rule(1), []).
substitution(5, []).
proof(5, safe(3, [], 2), rule(1), []).
substitution(6, []).
proof(6, safe(4, [], 2), rule(1), []).
substitution(7, []).
proof(7, safe(1, [], 2), rule(1), []).
substitution(8, []).
proof(8, safe(2, [], 2), rule(1), []).
substitution(9, [binding("row", 3), binding("other", 1), binding("rest", []), binding("distance", 1), binding("delta", 2), binding("next", 2)]).
proof(9, safe(3, [1], 1), rule(2), [compared("!=", 3, 1), calculated(2, function("abs", [binary("-", value(3), value(1))])), compared("!=", 2, 1), calculated(2, binary("+", value(1), value(1))), uses(5, safe(3, [], 2))]).
substitution(10, [binding("row", 4), binding("other", 1), binding("rest", []), binding("distance", 1), binding("delta", 3), binding("next", 2)]).
proof(10, safe(4, [1], 1), rule(2), [compared("!=", 4, 1), calculated(3, function("abs", [binary("-", value(4), value(1))])), compared("!=", 3, 1), calculated(2, binary("+", value(1), value(1))), uses(6, safe(4, [], 2))]).
substitution(11, [binding("row", 4), binding("other", 2), binding("rest", []), binding("distance", 1), binding("delta", 2), binding("next", 2)]).
proof(11, safe(4, [2], 1), rule(2), [compared("!=", 4, 2), calculated(2, function("abs", [binary("-", value(4), value(2))])), compared("!=", 2, 1), calculated(2, binary("+", value(1), value(1))), uses(6, safe(4, [], 2))]).
substitution(12, [binding("row", 1), binding("other", 3), binding("rest", []), binding("distance", 1), binding("delta", 2), binding("next", 2)]).
proof(12, safe(1, [3], 1), rule(2), [compared("!=", 1, 3), calculated(2, function("abs", [binary("-", value(1), value(3))])), compared("!=", 2, 1), calculated(2, binary("+", value(1), value(1))), uses(7, safe(1, [], 2))]).
substitution(13, [binding("row", 1), binding("other", 4), binding("rest", []), binding("distance", 1), binding("delta", 3), binding("next", 2)]).
proof(13, safe(1, [4], 1), rule(2), [compared("!=", 1, 4), calculated(3, function("abs", [binary("-", value(1), value(4))])), compared("!=", 3, 1), calculated(2, binary("+", value(1), value(1))), uses(7, safe(1, [], 2))]).
substitution(14, [binding("row", 2), binding("other", 4), binding("rest", []), binding("distance", 1), binding("delta", 2), binding("next", 2)]).
proof(14, safe(2, [4], 1), rule(2), [compared("!=", 2, 4), calculated(2, function("abs", [binary("-", value(2), value(4))])), compared("!=", 2, 1), calculated(2, binary("+", value(1), value(1))), uses(8, safe(2, [], 2))]).
substitution(15, []).
proof(15, safe(2, [], 3), rule(1), []).
substitution(16, []).
proof(16, safe(1, [], 3), rule(1), []).
substitution(17, []).
proof(17, safe(4, [], 3), rule(1), []).
substitution(18, []).
proof(18, safe(3, [], 3), rule(1), []).
substitution(19, [binding("row", 2), binding("other", 1), binding("rest", []), binding("distance", 2), binding("delta", 1), binding("next", 3)]).
proof(19, safe(2, [1], 2), rule(2), [compared("!=", 2, 1), calculated(1, function("abs", [binary("-", value(2), value(1))])), compared("!=", 1, 2), calculated(3, binary("+", value(2), value(1))), uses(15, safe(2, [], 3))]).
substitution(20, [binding("row", 1), binding("other", 2), binding("rest", []), binding("distance", 2), binding("delta", 1), binding("next", 3)]).
proof(20, safe(1, [2], 2), rule(2), [compared("!=", 1, 2), calculated(1, function("abs", [binary("-", value(1), value(2))])), compared("!=", 1, 2), calculated(3, binary("+", value(2), value(1))), uses(16, safe(1, [], 3))]).
substitution(21, [binding("row", 4), binding("other", 3), binding("rest", []), binding("distance", 2), binding("delta", 1), binding("next", 3)]).
proof(21, safe(4, [3], 2), rule(2), [compared("!=", 4, 3), calculated(1, function("abs", [binary("-", value(4), value(3))])), compared("!=", 1, 2), calculated(3, binary("+", value(2), value(1))), uses(17, safe(4, [], 3))]).
substitution(22, [binding("row", 3), binding("other", 4), binding("rest", []), binding("distance", 2), binding("delta", 1), binding("next", 3)]).
proof(22, safe(3, [4], 2), rule(2), [compared("!=", 3, 4), calculated(1, function("abs", [binary("-", value(3), value(4))])), compared("!=", 1, 2), calculated(3, binary("+", value(2), value(1))), uses(18, safe(3, [], 3))]).
substitution(23, [binding("row", 2), binding("other", 4), binding("rest", [1]), binding("distance", 1), binding("delta", 2), binding("next", 2)]).
proof(23, safe(2, [4, 1], 1), rule(2), [compared("!=", 2, 4), calculated(2, function("abs", [binary("-", value(2), value(4))])), compared("!=", 2, 1), calculated(2, binary("+", value(1), value(1))), uses(19, safe(2, [1], 2))]).
substitution(24, [binding("row", 1), binding("other", 4), binding("rest", [2]), binding("distance", 1), binding("delta", 3), binding("next", 2)]).
proof(24, safe(1, [4, 2], 1), rule(2), [compared("!=", 1, 4), calculated(3, function("abs", [binary("-", value(1), value(4))])), compared("!=", 3, 1), calculated(2, binary("+", value(1), value(1))), uses(20, safe(1, [2], 2))]).
substitution(25, [binding("row", 4), binding("other", 1), binding("rest", [3]), binding("distance", 1), binding("delta", 3), binding("next", 2)]).
proof(25, safe(4, [1, 3], 1), rule(2), [compared("!=", 4, 1), calculated(3, function("abs", [binary("-", value(4), value(1))])), compared("!=", 3, 1), calculated(2, binary("+", value(1), value(1))), uses(21, safe(4, [3], 2))]).
substitution(26, [binding("row", 3), binding("other", 1), binding("rest", [4]), binding("distance", 1), binding("delta", 2), binding("next", 2)]).
proof(26, safe(3, [1, 4], 1), rule(2), [compared("!=", 3, 1), calculated(2, function("abs", [binary("-", value(3), value(1))])), compared("!=", 2, 1), calculated(2, binary("+", value(1), value(1))), uses(22, safe(3, [4], 2))]).
substitution(27, []).
proof(27, safe(3, [], 4), rule(1), []).
substitution(28, []).
proof(28, safe(2, [], 4), rule(1), []).
substitution(29, [binding("row", 3), binding("other", 2), binding("rest", []), binding("distance", 3), binding("delta", 1), binding("next", 4)]).
proof(29, safe(3, [2], 3), rule(2), [compared("!=", 3, 2), calculated(1, function("abs", [binary("-", value(3), value(2))])), compared("!=", 1, 3), calculated(4, binary("+", value(3), value(1))), uses(27, safe(3, [], 4))]).
substitution(30, [binding("row", 2), binding("other", 3), binding("rest", []), binding("distance", 3), binding("delta", 1), binding("next", 4)]).
proof(30, safe(2, [3], 3), rule(2), [compared("!=", 2, 3), calculated(1, function("abs", [binary("-", value(2), value(3))])), compared("!=", 1, 3), calculated(4, binary("+", value(3), value(1))), uses(28, safe(2, [], 4))]).
substitution(31, [binding("row", 3), binding("other", 4), binding("rest", [2]), binding("distance", 2), binding("delta", 1), binding("next", 3)]).
proof(31, safe(3, [4, 2], 2), rule(2), [compared("!=", 3, 4), calculated(1, function("abs", [binary("-", value(3), value(4))])), compared("!=", 1, 2), calculated(3, binary("+", value(2), value(1))), uses(29, safe(3, [2], 3))]).
substitution(32, [binding("row", 2), binding("other", 1), binding("rest", [3]), binding("distance", 2), binding("delta", 1), binding("next", 3)]).
proof(32, safe(2, [1, 3], 2), rule(2), [compared("!=", 2, 1), calculated(1, function("abs", [binary("-", value(2), value(1))])), compared("!=", 1, 2), calculated(3, binary("+", value(2), value(1))), uses(30, safe(2, [3], 3))]).
substitution(33, [binding("row", 3), binding("other", 1), binding("rest", [4, 2]), binding("distance", 1), binding("delta", 2), binding("next", 2)]).
proof(33, safe(3, [1, 4, 2], 1), rule(2), [compared("!=", 3, 1), calculated(2, function("abs", [binary("-", value(3), value(1))])), compared("!=", 2, 1), calculated(2, binary("+", value(1), value(1))), uses(31, safe(3, [4, 2], 2))]).
substitution(34, [binding("row", 2), binding("other", 4), binding("rest", [1, 3]), binding("distance", 1), binding("delta", 2), binding("next", 2)]).
proof(34, safe(2, [4, 1, 3], 1), rule(2), [compared("!=", 2, 4), calculated(2, function("abs", [binary("-", value(2), value(4))])), compared("!=", 2, 1), calculated(2, binary("+", value(1), value(1))), uses(32, safe(2, [1, 3], 2))]).
substitution(35, [binding("placed", [3, 1, 4, 2])]).
proof(35, place(0, 4, [3, 1, 4, 2], [3, 1, 4, 2]), rule(3), []).
substitution(36, [binding("placed", [2, 4, 1, 3])]).
proof(36, place(0, 4, [2, 4, 1, 3], [2, 4, 1, 3]), rule(3), []).
substitution(37, [binding("remaining", 1), binding("size", 4), binding("placed", [1, 4, 2]), binding("rows", [3, 1, 4, 2]), binding("row", 3), binding("next", 0)]).
proof(37, place(1, 4, [1, 4, 2], [3, 1, 4, 2]), rule(4), [compared(">", 1, 0), builtin(range(1, 4, 3)), uses(33, safe(3, [1, 4, 2], 1)), calculated(0, binary("-", value(1), value(1))), uses(35, place(0, 4, [3, 1, 4, 2], [3, 1, 4, 2]))]).
substitution(38, [binding("remaining", 1), binding("size", 4), binding("placed", [4, 1, 3]), binding("rows", [2, 4, 1, 3]), binding("row", 2), binding("next", 0)]).
proof(38, place(1, 4, [4, 1, 3], [2, 4, 1, 3]), rule(4), [compared(">", 1, 0), builtin(range(1, 4, 2)), uses(34, safe(2, [4, 1, 3], 1)), calculated(0, binary("-", value(1), value(1))), uses(36, place(0, 4, [2, 4, 1, 3], [2, 4, 1, 3]))]).
substitution(39, [binding("remaining", 2), binding("size", 4), binding("placed", [4, 2]), binding("rows", [3, 1, 4, 2]), binding("row", 1), binding("next", 1)]).
proof(39, place(2, 4, [4, 2], [3, 1, 4, 2]), rule(4), [compared(">", 2, 0), builtin(range(1, 4, 1)), uses(24, safe(1, [4, 2], 1)), calculated(1, binary("-", value(2), value(1))), uses(37, place(1, 4, [1, 4, 2], [3, 1, 4, 2]))]).
substitution(40, [binding("remaining", 2), binding("size", 4), binding("placed", [1, 3]), binding("rows", [2, 4, 1, 3]), binding("row", 4), binding("next", 1)]).
proof(40, place(2, 4, [1, 3], [2, 4, 1, 3]), rule(4), [compared(">", 2, 0), builtin(range(1, 4, 4)), uses(25, safe(4, [1, 3], 1)), calculated(1, binary("-", value(2), value(1))), uses(38, place(1, 4, [4, 1, 3], [2, 4, 1, 3]))]).
substitution(41, [binding("remaining", 3), binding("size", 4), binding("placed", [2]), binding("rows", [3, 1, 4, 2]), binding("row", 4), binding("next", 2)]).
proof(41, place(3, 4, [2], [3, 1, 4, 2]), rule(4), [compared(">", 3, 0), builtin(range(1, 4, 4)), uses(11, safe(4, [2], 1)), calculated(2, binary("-", value(3), value(1))), uses(39, place(2, 4, [4, 2], [3, 1, 4, 2]))]).
substitution(42, [binding("remaining", 3), binding("size", 4), binding("placed", [3]), binding("rows", [2, 4, 1, 3]), binding("row", 1), binding("next", 2)]).
proof(42, place(3, 4, [3], [2, 4, 1, 3]), rule(4), [compared(">", 3, 0), builtin(range(1, 4, 1)), uses(12, safe(1, [3], 1)), calculated(2, binary("-", value(3), value(1))), uses(40, place(2, 4, [1, 3], [2, 4, 1, 3]))]).
substitution(43, [binding("remaining", 4), binding("size", 4), binding("placed", []), binding("rows", [3, 1, 4, 2]), binding("row", 2), binding("next", 3)]).
proof(43, place(4, 4, [], [3, 1, 4, 2]), rule(4), [compared(">", 4, 0), builtin(range(1, 4, 2)), uses(2, safe(2, [], 1)), calculated(3, binary("-", value(4), value(1))), uses(41, place(3, 4, [2], [3, 1, 4, 2]))]).
substitution(44, [binding("remaining", 4), binding("size", 4), binding("placed", []), binding("rows", [2, 4, 1, 3]), binding("row", 3), binding("next", 3)]).
proof(44, place(4, 4, [], [2, 4, 1, 3]), rule(4), [compared(">", 4, 0), builtin(range(1, 4, 3)), uses(3, safe(3, [], 1)), calculated(3, binary("-", value(4), value(1))), uses(42, place(3, 4, [3], [2, 4, 1, 3]))]).
substitution(45, [binding("rows", [3, 1, 4, 2])]).
proof(45, solution([[3, 1, 4, 2]]), query, [uses(43, place(4, 4, [], [3, 1, 4, 2]))]).
substitution(46, [binding("rows", [2, 4, 1, 3])]).
proof(46, solution([[2, 4, 1, 3]]), query, [uses(44, place(4, 4, [], [2, 4, 1, 3]))]).
