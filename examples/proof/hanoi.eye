# Eyelang result format 2
query(1, [call(hanoi(3, left, right, center, ?v0))], [binding("moves", ?v0)]).
result(1, complete, 1).
answer(1, [binding("moves", [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]])]).
why(1, [binding("moves", [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]])], 21).
clause(1, append([], var("ys"), var("ys")), []).
clause(2, append([var("x") | var("xs")], var("ys"), [var("x") | var("zs")]), [call(append(var("xs"), var("ys"), var("zs")))]).
clause(3, hanoi(0, anonymous(1), anonymous(2), anonymous(3), []), []).
clause(4, hanoi(var("n"), var("from"), var("to"), var("via"), var("moves")), [compare(">", var("n"), 0), calculate(var("smaller"), binary("-", value(var("n")), value(1))), call(hanoi(var("smaller"), var("from"), var("via"), var("to"), var("before"))), call(hanoi(var("smaller"), var("via"), var("to"), var("from"), var("after"))), call(append(var("before"), [[var("from"), var("to")] | var("after")], var("moves")))]).
substitution(1, []).
proof(1, hanoi(0, left, center, right, []), rule(3), []).
substitution(2, []).
proof(2, hanoi(0, center, right, left, []), rule(3), []).
substitution(3, [binding("ys", [[left, right]])]).
proof(3, append([], [[left, right]], [[left, right]]), rule(1), []).
substitution(4, [binding("n", 1), binding("from", left), binding("to", right), binding("via", center), binding("moves", [[left, right]]), binding("smaller", 0), binding("before", []), binding("after", [])]).
proof(4, hanoi(1, left, right, center, [[left, right]]), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(1, hanoi(0, left, center, right, [])), uses(2, hanoi(0, center, right, left, [])), uses(3, append([], [[left, right]], [[left, right]]))]).
substitution(5, []).
proof(5, hanoi(0, right, left, center, []), rule(3), []).
substitution(6, [binding("ys", [[right, center]])]).
proof(6, append([], [[right, center]], [[right, center]]), rule(1), []).
substitution(7, [binding("n", 1), binding("from", right), binding("to", center), binding("via", left), binding("moves", [[right, center]]), binding("smaller", 0), binding("before", []), binding("after", [])]).
proof(7, hanoi(1, right, center, left, [[right, center]]), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(5, hanoi(0, right, left, center, [])), uses(1, hanoi(0, left, center, right, [])), uses(6, append([], [[right, center]], [[right, center]]))]).
substitution(8, [binding("ys", [[left, center], [right, center]])]).
proof(8, append([], [[left, center], [right, center]], [[left, center], [right, center]]), rule(1), []).
substitution(9, [binding("x", [left, right]), binding("xs", []), binding("ys", [[left, center], [right, center]]), binding("zs", [[left, center], [right, center]])]).
proof(9, append([[left, right]], [[left, center], [right, center]], [[left, right], [left, center], [right, center]]), rule(2), [uses(8, append([], [[left, center], [right, center]], [[left, center], [right, center]]))]).
substitution(10, [binding("n", 2), binding("from", left), binding("to", center), binding("via", right), binding("moves", [[left, right], [left, center], [right, center]]), binding("smaller", 1), binding("before", [[left, right]]), binding("after", [[right, center]])]).
proof(10, hanoi(2, left, center, right, [[left, right], [left, center], [right, center]]), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(4, hanoi(1, left, right, center, [[left, right]])), uses(7, hanoi(1, right, center, left, [[right, center]])), uses(9, append([[left, right]], [[left, center], [right, center]], [[left, right], [left, center], [right, center]]))]).
substitution(11, [binding("ys", [[center, left]])]).
proof(11, append([], [[center, left]], [[center, left]]), rule(1), []).
substitution(12, [binding("n", 1), binding("from", center), binding("to", left), binding("via", right), binding("moves", [[center, left]]), binding("smaller", 0), binding("before", []), binding("after", [])]).
proof(12, hanoi(1, center, left, right, [[center, left]]), rule(4), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(2, hanoi(0, center, right, left, [])), uses(5, hanoi(0, right, left, center, [])), uses(11, append([], [[center, left]], [[center, left]]))]).
substitution(13, [binding("ys", [[center, right], [left, right]])]).
proof(13, append([], [[center, right], [left, right]], [[center, right], [left, right]]), rule(1), []).
substitution(14, [binding("x", [center, left]), binding("xs", []), binding("ys", [[center, right], [left, right]]), binding("zs", [[center, right], [left, right]])]).
proof(14, append([[center, left]], [[center, right], [left, right]], [[center, left], [center, right], [left, right]]), rule(2), [uses(13, append([], [[center, right], [left, right]], [[center, right], [left, right]]))]).
substitution(15, [binding("n", 2), binding("from", center), binding("to", right), binding("via", left), binding("moves", [[center, left], [center, right], [left, right]]), binding("smaller", 1), binding("before", [[center, left]]), binding("after", [[left, right]])]).
proof(15, hanoi(2, center, right, left, [[center, left], [center, right], [left, right]]), rule(4), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(12, hanoi(1, center, left, right, [[center, left]])), uses(4, hanoi(1, left, right, center, [[left, right]])), uses(14, append([[center, left]], [[center, right], [left, right]], [[center, left], [center, right], [left, right]]))]).
substitution(16, [binding("ys", [[left, right], [center, left], [center, right], [left, right]])]).
proof(16, append([], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [center, left], [center, right], [left, right]]), rule(1), []).
substitution(17, [binding("x", [right, center]), binding("xs", []), binding("ys", [[left, right], [center, left], [center, right], [left, right]]), binding("zs", [[left, right], [center, left], [center, right], [left, right]])]).
proof(17, append([[right, center]], [[left, right], [center, left], [center, right], [left, right]], [[right, center], [left, right], [center, left], [center, right], [left, right]]), rule(2), [uses(16, append([], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [center, left], [center, right], [left, right]]))]).
substitution(18, [binding("x", [left, center]), binding("xs", [[right, center]]), binding("ys", [[left, right], [center, left], [center, right], [left, right]]), binding("zs", [[right, center], [left, right], [center, left], [center, right], [left, right]])]).
proof(18, append([[left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]), rule(2), [uses(17, append([[right, center]], [[left, right], [center, left], [center, right], [left, right]], [[right, center], [left, right], [center, left], [center, right], [left, right]]))]).
substitution(19, [binding("x", [left, right]), binding("xs", [[left, center], [right, center]]), binding("ys", [[left, right], [center, left], [center, right], [left, right]]), binding("zs", [[left, center], [right, center], [left, right], [center, left], [center, right], [left, right]])]).
proof(19, append([[left, right], [left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]), rule(2), [uses(18, append([[left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]))]).
substitution(20, [binding("n", 3), binding("from", left), binding("to", right), binding("via", center), binding("moves", [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]), binding("smaller", 2), binding("before", [[left, right], [left, center], [right, center]]), binding("after", [[center, left], [center, right], [left, right]])]).
proof(20, hanoi(3, left, right, center, [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]), rule(4), [compared(">", 3, 0), calculated(2, binary("-", value(3), value(1))), uses(10, hanoi(2, left, center, right, [[left, right], [left, center], [right, center]])), uses(15, hanoi(2, center, right, left, [[center, left], [center, right], [left, right]])), uses(19, append([[left, right], [left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]))]).
substitution(21, [binding("moves", [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]])]).
proof(21, solution([[[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]]), query, [uses(20, hanoi(3, left, right, center, [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]))]).
