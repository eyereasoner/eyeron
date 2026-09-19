# Eyelang result format 2
query(1, [call(best(a, d, ?v0, ?v1))], [binding("path", ?v0), binding("cost", ?v1)]).
result(1, complete, 1).
answer(1, [binding("path", [a, b, c, d]), binding("cost", 5)]).
why(1, [binding("path", [a, b, c, d]), binding("cost", 5)], 61).
clause(1, edge(a, b, 2), []).
clause(2, edge(a, c, 5), []).
clause(3, edge(b, c, 1), []).
clause(4, edge(b, d, 7), []).
clause(5, edge(c, d, 2), []).
clause(6, edge(c, a, 1), []).
clause(7, member(var("x"), [var("x") | anonymous(1)]), []).
clause(8, member(var("x"), [anonymous(1) | var("rest")]), [call(member(var("x"), var("rest")))]).
clause(9, route(var("goal"), var("goal"), anonymous(1), [var("goal")], 0), []).
clause(10, route(var("from"), var("goal"), var("visited"), [var("from") | var("path")], var("cost")), [call(edge(var("from"), var("next"), var("step"))), absent(member(var("next"), var("visited"))), call(route(var("next"), var("goal"), [var("next") | var("visited")], var("path"), var("remaining"))), calculate(var("cost"), binary("+", value(var("step")), value(var("remaining"))))]).
clause(11, best(var("from"), var("to"), var("path"), var("cost")), [collect(var("costs"), var("candidate"), [call(route(var("from"), var("to"), [var("from")], anonymous(1), var("candidate")))]), calculate(var("cost"), function("min", [value(var("costs"))])), call(route(var("from"), var("to"), [var("from")], var("path"), var("cost")))]).
substitution(1, []).
proof(1, edge(a, b, 2), rule(1), []).
substitution(2, []).
proof(2, edge(a, c, 5), rule(2), []).
substitution(3, []).
proof(3, edge(b, c, 1), rule(3), []).
substitution(4, []).
proof(4, edge(b, d, 7), rule(4), []).
substitution(5, []).
proof(5, edge(c, d, 2), rule(5), []).
substitution(6, []).
proof(6, edge(c, a, 1), rule(6), []).
substitution(7, [binding("x", a)]).
proof(7, member(a, [a]), rule(7), []).
substitution(8, [binding("x", a), binding("rest", [a])]).
proof(8, member(a, [c, a]), rule(8), [uses(7, member(a, [a]))]).
substitution(9, []).
proof(9, solution([]), query, [uses(8, member(a, [c, a]))]).
substitution(10, [binding("x", a)]).
proof(10, member(a, [a]), rule(7), []).
substitution(11, [binding("x", a), binding("rest", [a])]).
proof(11, member(a, [b, a]), rule(8), [uses(10, member(a, [a]))]).
substitution(12, [binding("x", a), binding("rest", [b, a])]).
proof(12, member(a, [c, b, a]), rule(8), [uses(11, member(a, [b, a]))]).
substitution(13, []).
proof(13, solution([]), query, [uses(12, member(a, [c, b, a]))]).
substitution(14, [binding("goal", d)]).
proof(14, route(d, d, [d, b, a], [d], 0), rule(9), []).
substitution(15, [binding("goal", d)]).
proof(15, route(d, d, [d, c, a], [d], 0), rule(9), []).
substitution(16, [binding("goal", d)]).
proof(16, route(d, d, [d, c, b, a], [d], 0), rule(9), []).
substitution(17, [binding("from", b), binding("goal", d), binding("visited", [b, a]), binding("path", [d]), binding("cost", 7), binding("next", d), binding("step", 7), binding("remaining", 0)]).
proof(17, route(b, d, [b, a], [b, d], 7), rule(10), [uses(4, edge(b, d, 7)), absent(member(d, [b, a]), complete), uses(14, route(d, d, [d, b, a], [d], 0)), calculated(7, binary("+", value(7), value(0)))]).
substitution(18, [binding("from", c), binding("goal", d), binding("visited", [c, a]), binding("path", [d]), binding("cost", 2), binding("next", d), binding("step", 2), binding("remaining", 0)]).
proof(18, route(c, d, [c, a], [c, d], 2), rule(10), [uses(5, edge(c, d, 2)), absent(member(d, [c, a]), complete), uses(15, route(d, d, [d, c, a], [d], 0)), calculated(2, binary("+", value(2), value(0)))]).
substitution(19, [binding("from", c), binding("goal", d), binding("visited", [c, b, a]), binding("path", [d]), binding("cost", 2), binding("next", d), binding("step", 2), binding("remaining", 0)]).
proof(19, route(c, d, [c, b, a], [c, d], 2), rule(10), [uses(5, edge(c, d, 2)), absent(member(d, [c, b, a]), complete), uses(16, route(d, d, [d, c, b, a], [d], 0)), calculated(2, binary("+", value(2), value(0)))]).
substitution(20, [binding("from", a), binding("goal", d), binding("visited", [a]), binding("path", [b, d]), binding("cost", 9), binding("next", b), binding("step", 2), binding("remaining", 7)]).
proof(20, route(a, d, [a], [a, b, d], 9), rule(10), [uses(1, edge(a, b, 2)), absent(member(b, [a]), complete), uses(17, route(b, d, [b, a], [b, d], 7)), calculated(9, binary("+", value(2), value(7)))]).
substitution(21, [binding("from", a), binding("goal", d), binding("visited", [a]), binding("path", [c, d]), binding("cost", 7), binding("next", c), binding("step", 5), binding("remaining", 2)]).
proof(21, route(a, d, [a], [a, c, d], 7), rule(10), [uses(2, edge(a, c, 5)), absent(member(c, [a]), complete), uses(18, route(c, d, [c, a], [c, d], 2)), calculated(7, binary("+", value(5), value(2)))]).
substitution(22, [binding("from", b), binding("goal", d), binding("visited", [b, a]), binding("path", [c, d]), binding("cost", 3), binding("next", c), binding("step", 1), binding("remaining", 2)]).
proof(22, route(b, d, [b, a], [b, c, d], 3), rule(10), [uses(3, edge(b, c, 1)), absent(member(c, [b, a]), complete), uses(19, route(c, d, [c, b, a], [c, d], 2)), calculated(3, binary("+", value(1), value(2)))]).
substitution(23, [binding("candidate", 9)]).
proof(23, solution([9]), query, [uses(20, route(a, d, [a], [a, b, d], 9))]).
substitution(24, [binding("candidate", 7)]).
proof(24, solution([7]), query, [uses(21, route(a, d, [a], [a, c, d], 7))]).
substitution(25, [binding("from", a), binding("goal", d), binding("visited", [a]), binding("path", [b, c, d]), binding("cost", 5), binding("next", b), binding("step", 2), binding("remaining", 3)]).
proof(25, route(a, d, [a], [a, b, c, d], 5), rule(10), [uses(1, edge(a, b, 2)), absent(member(b, [a]), complete), uses(22, route(b, d, [b, a], [b, c, d], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(26, [binding("candidate", 5)]).
proof(26, solution([5]), query, [uses(25, route(a, d, [a], [a, b, c, d], 5))]).
substitution(27, []).
proof(27, edge(a, b, 2), rule(1), []).
substitution(28, []).
proof(28, edge(a, c, 5), rule(2), []).
substitution(29, []).
proof(29, edge(b, c, 1), rule(3), []).
substitution(30, []).
proof(30, edge(b, d, 7), rule(4), []).
substitution(31, []).
proof(31, edge(c, d, 2), rule(5), []).
substitution(32, []).
proof(32, edge(c, a, 1), rule(6), []).
substitution(33, [binding("goal", d)]).
proof(33, route(d, d, [d, b, a], [d], 0), rule(9), []).
substitution(34, [binding("goal", d)]).
proof(34, route(d, d, [d, c, a], [d], 0), rule(9), []).
substitution(35, [binding("goal", d)]).
proof(35, route(d, d, [d, c, b, a], [d], 0), rule(9), []).
substitution(36, [binding("from", b), binding("goal", d), binding("visited", [b, a]), binding("path", [d]), binding("cost", 7), binding("next", d), binding("step", 7), binding("remaining", 0)]).
proof(36, route(b, d, [b, a], [b, d], 7), rule(10), [uses(30, edge(b, d, 7)), absent(member(d, [b, a]), complete), uses(33, route(d, d, [d, b, a], [d], 0)), calculated(7, binary("+", value(7), value(0)))]).
substitution(37, [binding("from", c), binding("goal", d), binding("visited", [c, a]), binding("path", [d]), binding("cost", 2), binding("next", d), binding("step", 2), binding("remaining", 0)]).
proof(37, route(c, d, [c, a], [c, d], 2), rule(10), [uses(31, edge(c, d, 2)), absent(member(d, [c, a]), complete), uses(34, route(d, d, [d, c, a], [d], 0)), calculated(2, binary("+", value(2), value(0)))]).
substitution(38, [binding("from", c), binding("goal", d), binding("visited", [c, b, a]), binding("path", [d]), binding("cost", 2), binding("next", d), binding("step", 2), binding("remaining", 0)]).
proof(38, route(c, d, [c, b, a], [c, d], 2), rule(10), [uses(31, edge(c, d, 2)), absent(member(d, [c, b, a]), complete), uses(35, route(d, d, [d, c, b, a], [d], 0)), calculated(2, binary("+", value(2), value(0)))]).
substitution(39, [binding("from", b), binding("goal", d), binding("visited", [b, a]), binding("path", [c, d]), binding("cost", 3), binding("next", c), binding("step", 1), binding("remaining", 2)]).
proof(39, route(b, d, [b, a], [b, c, d], 3), rule(10), [uses(29, edge(b, c, 1)), absent(member(c, [b, a]), complete), uses(38, route(c, d, [c, b, a], [c, d], 2)), calculated(3, binary("+", value(1), value(2)))]).
substitution(40, [binding("from", a), binding("goal", d), binding("visited", [a]), binding("path", [b, c, d]), binding("cost", 5), binding("next", b), binding("step", 2), binding("remaining", 3)]).
proof(40, route(a, d, [a], [a, b, c, d], 5), rule(10), [uses(27, edge(a, b, 2)), absent(member(b, [a]), complete), uses(39, route(b, d, [b, a], [b, c, d], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(41, []).
proof(41, edge(a, b, 2), rule(1), []).
substitution(42, []).
proof(42, edge(a, c, 5), rule(2), []).
substitution(43, []).
proof(43, edge(b, c, 1), rule(3), []).
substitution(44, []).
proof(44, edge(b, d, 7), rule(4), []).
substitution(45, []).
proof(45, edge(c, d, 2), rule(5), []).
substitution(46, []).
proof(46, edge(c, a, 1), rule(6), []).
substitution(47, [binding("goal", d)]).
proof(47, route(d, d, [d, b, a], [d], 0), rule(9), []).
substitution(48, [binding("goal", d)]).
proof(48, route(d, d, [d, c, a], [d], 0), rule(9), []).
substitution(49, [binding("goal", d)]).
proof(49, route(d, d, [d, c, b, a], [d], 0), rule(9), []).
substitution(50, [binding("from", b), binding("goal", d), binding("visited", [b, a]), binding("path", [d]), binding("cost", 7), binding("next", d), binding("step", 7), binding("remaining", 0)]).
proof(50, route(b, d, [b, a], [b, d], 7), rule(10), [uses(44, edge(b, d, 7)), absent(member(d, [b, a]), complete), uses(47, route(d, d, [d, b, a], [d], 0)), calculated(7, binary("+", value(7), value(0)))]).
substitution(51, [binding("from", c), binding("goal", d), binding("visited", [c, a]), binding("path", [d]), binding("cost", 2), binding("next", d), binding("step", 2), binding("remaining", 0)]).
proof(51, route(c, d, [c, a], [c, d], 2), rule(10), [uses(45, edge(c, d, 2)), absent(member(d, [c, a]), complete), uses(48, route(d, d, [d, c, a], [d], 0)), calculated(2, binary("+", value(2), value(0)))]).
substitution(52, [binding("from", c), binding("goal", d), binding("visited", [c, b, a]), binding("path", [d]), binding("cost", 2), binding("next", d), binding("step", 2), binding("remaining", 0)]).
proof(52, route(c, d, [c, b, a], [c, d], 2), rule(10), [uses(45, edge(c, d, 2)), absent(member(d, [c, b, a]), complete), uses(49, route(d, d, [d, c, b, a], [d], 0)), calculated(2, binary("+", value(2), value(0)))]).
substitution(53, [binding("from", a), binding("goal", d), binding("visited", [a]), binding("path", [b, d]), binding("cost", 9), binding("next", b), binding("step", 2), binding("remaining", 7)]).
proof(53, route(a, d, [a], [a, b, d], 9), rule(10), [uses(41, edge(a, b, 2)), absent(member(b, [a]), complete), uses(50, route(b, d, [b, a], [b, d], 7)), calculated(9, binary("+", value(2), value(7)))]).
substitution(54, [binding("from", a), binding("goal", d), binding("visited", [a]), binding("path", [c, d]), binding("cost", 7), binding("next", c), binding("step", 5), binding("remaining", 2)]).
proof(54, route(a, d, [a], [a, c, d], 7), rule(10), [uses(42, edge(a, c, 5)), absent(member(c, [a]), complete), uses(51, route(c, d, [c, a], [c, d], 2)), calculated(7, binary("+", value(5), value(2)))]).
substitution(55, [binding("from", b), binding("goal", d), binding("visited", [b, a]), binding("path", [c, d]), binding("cost", 3), binding("next", c), binding("step", 1), binding("remaining", 2)]).
proof(55, route(b, d, [b, a], [b, c, d], 3), rule(10), [uses(43, edge(b, c, 1)), absent(member(c, [b, a]), complete), uses(52, route(c, d, [c, b, a], [c, d], 2)), calculated(3, binary("+", value(1), value(2)))]).
substitution(56, [binding("candidate", 9)]).
proof(56, solution([9]), query, [uses(53, route(a, d, [a], [a, b, d], 9))]).
substitution(57, [binding("candidate", 7)]).
proof(57, solution([7]), query, [uses(54, route(a, d, [a], [a, c, d], 7))]).
substitution(58, [binding("from", a), binding("goal", d), binding("visited", [a]), binding("path", [b, c, d]), binding("cost", 5), binding("next", b), binding("step", 2), binding("remaining", 3)]).
proof(58, route(a, d, [a], [a, b, c, d], 5), rule(10), [uses(41, edge(a, b, 2)), absent(member(b, [a]), complete), uses(55, route(b, d, [b, a], [b, c, d], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(59, [binding("candidate", 5)]).
proof(59, solution([5]), query, [uses(58, route(a, d, [a], [a, b, c, d], 5))]).
substitution(60, [binding("from", a), binding("to", d), binding("path", [a, b, c, d]), binding("cost", 5), binding("costs", [5, 7, 9]), binding("candidate", ?v0)]).
proof(60, best(a, d, [a, b, c, d], 5), rule(11), [collected([5, 7, 9], ?v0, [call(route(a, d, [a], ?v1, ?v0))], [56, 57, 59], complete), calculated(5, function("min", [value([5, 7, 9])])), uses(40, route(a, d, [a], [a, b, c, d], 5))]).
substitution(61, [binding("path", [a, b, c, d]), binding("cost", 5)]).
proof(61, solution([[a, b, c, d], 5]), query, [uses(60, best(a, d, [a, b, c, d], 5))]).
