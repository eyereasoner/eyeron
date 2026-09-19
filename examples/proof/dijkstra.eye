# Eyelang result format 2
query(1, [call(best(a, f, ?v0, ?v1))], [binding("path", ?v0), binding("cost", ?v1)]).
result(1, complete, 1).
answer(1, [binding("path", [a, c, b, d, e, f]), binding("cost", 13)]).
why(1, [binding("path", [a, c, b, d, e, f]), binding("cost", 13)], 646).
clause(1, edge(a, b, 4), []).
clause(2, edge(a, c, 2), []).
clause(3, edge(b, c, 1), []).
clause(4, edge(b, d, 5), []).
clause(5, edge(c, d, 8), []).
clause(6, edge(c, e, 10), []).
clause(7, edge(d, e, 2), []).
clause(8, edge(d, f, 6), []).
clause(9, edge(e, f, 3), []).
clause(10, connected(var("right"), var("left"), var("weight")), [call(edge(var("left"), var("right"), var("weight")))]).
clause(11, connected(var("left"), var("right"), var("weight")), [call(edge(var("left"), var("right"), var("weight")))]).
clause(12, member(var("x"), [var("x") | anonymous(1)]), []).
clause(13, member(var("x"), [anonymous(1) | var("rest")]), [call(member(var("x"), var("rest")))]).
clause(14, route(var("goal"), var("goal"), anonymous(1), [var("goal")], 0), []).
clause(15, route(var("from"), var("goal"), var("visited"), [var("from") | var("path")], var("cost")), [call(connected(var("from"), var("next"), var("step"))), absent(member(var("next"), var("visited"))), call(route(var("next"), var("goal"), [var("next") | var("visited")], var("path"), var("remaining"))), calculate(var("cost"), binary("+", value(var("step")), value(var("remaining"))))]).
clause(16, best(var("from"), var("to"), var("path"), var("cost")), [collect(var("costs"), var("candidate"), [call(route(var("from"), var("to"), [var("from")], anonymous(1), var("candidate")))]), calculate(var("cost"), function("min", [value(var("costs"))])), call(route(var("from"), var("to"), [var("from")], var("path"), var("cost")))]).
substitution(1, []).
proof(1, edge(a, b, 4), rule(1), []).
substitution(2, []).
proof(2, edge(a, c, 2), rule(2), []).
substitution(3, [binding("left", a), binding("right", b), binding("weight", 4)]).
proof(3, connected(a, b, 4), rule(11), [uses(1, edge(a, b, 4))]).
substitution(4, [binding("left", a), binding("right", c), binding("weight", 2)]).
proof(4, connected(a, c, 2), rule(11), [uses(2, edge(a, c, 2))]).
substitution(5, []).
proof(5, edge(a, b, 4), rule(1), []).
substitution(6, []).
proof(6, edge(b, c, 1), rule(3), []).
substitution(7, []).
proof(7, edge(b, d, 5), rule(4), []).
substitution(8, []).
proof(8, edge(a, c, 2), rule(2), []).
substitution(9, []).
proof(9, edge(b, c, 1), rule(3), []).
substitution(10, []).
proof(10, edge(c, d, 8), rule(5), []).
substitution(11, []).
proof(11, edge(c, e, 10), rule(6), []).
substitution(12, [binding("right", b), binding("left", a), binding("weight", 4)]).
proof(12, connected(b, a, 4), rule(10), [uses(5, edge(a, b, 4))]).
substitution(13, [binding("left", b), binding("right", c), binding("weight", 1)]).
proof(13, connected(b, c, 1), rule(11), [uses(6, edge(b, c, 1))]).
substitution(14, [binding("left", b), binding("right", d), binding("weight", 5)]).
proof(14, connected(b, d, 5), rule(11), [uses(7, edge(b, d, 5))]).
substitution(15, [binding("right", c), binding("left", a), binding("weight", 2)]).
proof(15, connected(c, a, 2), rule(10), [uses(8, edge(a, c, 2))]).
substitution(16, [binding("right", c), binding("left", b), binding("weight", 1)]).
proof(16, connected(c, b, 1), rule(10), [uses(9, edge(b, c, 1))]).
substitution(17, [binding("left", c), binding("right", d), binding("weight", 8)]).
proof(17, connected(c, d, 8), rule(11), [uses(10, edge(c, d, 8))]).
substitution(18, [binding("left", c), binding("right", e), binding("weight", 10)]).
proof(18, connected(c, e, 10), rule(11), [uses(11, edge(c, e, 10))]).
substitution(19, [binding("x", a)]).
proof(19, member(a, [a]), rule(12), []).
substitution(20, [binding("x", a), binding("rest", [a])]).
proof(20, member(a, [b, a]), rule(13), [uses(19, member(a, [a]))]).
substitution(21, []).
proof(21, solution([]), query, [uses(20, member(a, [b, a]))]).
substitution(22, [binding("x", a)]).
proof(22, member(a, [a]), rule(12), []).
substitution(23, [binding("x", a), binding("rest", [a])]).
proof(23, member(a, [c, a]), rule(13), [uses(22, member(a, [a]))]).
substitution(24, []).
proof(24, solution([]), query, [uses(23, member(a, [c, a]))]).
substitution(25, [binding("x", a)]).
proof(25, member(a, [a]), rule(12), []).
substitution(26, [binding("x", a), binding("rest", [a])]).
proof(26, member(a, [b, a]), rule(13), [uses(25, member(a, [a]))]).
substitution(27, [binding("x", a), binding("rest", [b, a])]).
proof(27, member(a, [c, b, a]), rule(13), [uses(26, member(a, [b, a]))]).
substitution(28, []).
proof(28, solution([]), query, [uses(27, member(a, [c, b, a]))]).
substitution(29, [binding("x", b)]).
proof(29, member(b, [b, a]), rule(12), []).
substitution(30, [binding("x", b), binding("rest", [b, a])]).
proof(30, member(b, [c, b, a]), rule(13), [uses(29, member(b, [b, a]))]).
substitution(31, []).
proof(31, solution([]), query, [uses(30, member(b, [c, b, a]))]).
substitution(32, [binding("x", a)]).
proof(32, member(a, [a]), rule(12), []).
substitution(33, [binding("x", a), binding("rest", [a])]).
proof(33, member(a, [c, a]), rule(13), [uses(32, member(a, [a]))]).
substitution(34, [binding("x", a), binding("rest", [c, a])]).
proof(34, member(a, [b, c, a]), rule(13), [uses(33, member(a, [c, a]))]).
substitution(35, []).
proof(35, solution([]), query, [uses(34, member(a, [b, c, a]))]).
substitution(36, [binding("x", c)]).
proof(36, member(c, [c, a]), rule(12), []).
substitution(37, [binding("x", c), binding("rest", [c, a])]).
proof(37, member(c, [b, c, a]), rule(13), [uses(36, member(c, [c, a]))]).
substitution(38, []).
proof(38, solution([]), query, [uses(37, member(c, [b, c, a]))]).
substitution(39, []).
proof(39, edge(b, d, 5), rule(4), []).
substitution(40, []).
proof(40, edge(c, d, 8), rule(5), []).
substitution(41, []).
proof(41, edge(d, e, 2), rule(7), []).
substitution(42, []).
proof(42, edge(d, f, 6), rule(8), []).
substitution(43, []).
proof(43, edge(c, e, 10), rule(6), []).
substitution(44, []).
proof(44, edge(d, e, 2), rule(7), []).
substitution(45, []).
proof(45, edge(e, f, 3), rule(9), []).
substitution(46, [binding("right", d), binding("left", b), binding("weight", 5)]).
proof(46, connected(d, b, 5), rule(10), [uses(39, edge(b, d, 5))]).
substitution(47, [binding("right", d), binding("left", c), binding("weight", 8)]).
proof(47, connected(d, c, 8), rule(10), [uses(40, edge(c, d, 8))]).
substitution(48, [binding("left", d), binding("right", e), binding("weight", 2)]).
proof(48, connected(d, e, 2), rule(11), [uses(41, edge(d, e, 2))]).
substitution(49, [binding("left", d), binding("right", f), binding("weight", 6)]).
proof(49, connected(d, f, 6), rule(11), [uses(42, edge(d, f, 6))]).
substitution(50, [binding("right", e), binding("left", c), binding("weight", 10)]).
proof(50, connected(e, c, 10), rule(10), [uses(43, edge(c, e, 10))]).
substitution(51, [binding("right", e), binding("left", d), binding("weight", 2)]).
proof(51, connected(e, d, 2), rule(10), [uses(44, edge(d, e, 2))]).
substitution(52, [binding("left", e), binding("right", f), binding("weight", 3)]).
proof(52, connected(e, f, 3), rule(11), [uses(45, edge(e, f, 3))]).
substitution(53, [binding("x", b)]).
proof(53, member(b, [b, a]), rule(12), []).
substitution(54, [binding("x", b), binding("rest", [b, a])]).
proof(54, member(b, [d, b, a]), rule(13), [uses(53, member(b, [b, a]))]).
substitution(55, []).
proof(55, solution([]), query, [uses(54, member(b, [d, b, a]))]).
substitution(56, [binding("x", c)]).
proof(56, member(c, [c, a]), rule(12), []).
substitution(57, [binding("x", c), binding("rest", [c, a])]).
proof(57, member(c, [d, c, a]), rule(13), [uses(56, member(c, [c, a]))]).
substitution(58, []).
proof(58, solution([]), query, [uses(57, member(c, [d, c, a]))]).
substitution(59, [binding("x", b)]).
proof(59, member(b, [b, a]), rule(12), []).
substitution(60, [binding("x", b), binding("rest", [b, a])]).
proof(60, member(b, [c, b, a]), rule(13), [uses(59, member(b, [b, a]))]).
substitution(61, [binding("x", b), binding("rest", [c, b, a])]).
proof(61, member(b, [d, c, b, a]), rule(13), [uses(60, member(b, [c, b, a]))]).
substitution(62, []).
proof(62, solution([]), query, [uses(61, member(b, [d, c, b, a]))]).
substitution(63, [binding("x", c)]).
proof(63, member(c, [c, b, a]), rule(12), []).
substitution(64, [binding("x", c), binding("rest", [c, b, a])]).
proof(64, member(c, [d, c, b, a]), rule(13), [uses(63, member(c, [c, b, a]))]).
substitution(65, []).
proof(65, solution([]), query, [uses(64, member(c, [d, c, b, a]))]).
substitution(66, [binding("x", b)]).
proof(66, member(b, [b, c, a]), rule(12), []).
substitution(67, [binding("x", b), binding("rest", [b, c, a])]).
proof(67, member(b, [d, b, c, a]), rule(13), [uses(66, member(b, [b, c, a]))]).
substitution(68, []).
proof(68, solution([]), query, [uses(67, member(b, [d, b, c, a]))]).
substitution(69, [binding("x", c)]).
proof(69, member(c, [c, a]), rule(12), []).
substitution(70, [binding("x", c), binding("rest", [c, a])]).
proof(70, member(c, [b, c, a]), rule(13), [uses(69, member(c, [c, a]))]).
substitution(71, [binding("x", c), binding("rest", [b, c, a])]).
proof(71, member(c, [d, b, c, a]), rule(13), [uses(70, member(c, [b, c, a]))]).
substitution(72, []).
proof(72, solution([]), query, [uses(71, member(c, [d, b, c, a]))]).
substitution(73, [binding("x", c)]).
proof(73, member(c, [c, a]), rule(12), []).
substitution(74, [binding("x", c), binding("rest", [c, a])]).
proof(74, member(c, [e, c, a]), rule(13), [uses(73, member(c, [c, a]))]).
substitution(75, []).
proof(75, solution([]), query, [uses(74, member(c, [e, c, a]))]).
substitution(76, [binding("x", c)]).
proof(76, member(c, [c, b, a]), rule(12), []).
substitution(77, [binding("x", c), binding("rest", [c, b, a])]).
proof(77, member(c, [e, c, b, a]), rule(13), [uses(76, member(c, [c, b, a]))]).
substitution(78, []).
proof(78, solution([]), query, [uses(77, member(c, [e, c, b, a]))]).
substitution(79, [binding("x", a)]).
proof(79, member(a, [a]), rule(12), []).
substitution(80, [binding("x", a), binding("rest", [a])]).
proof(80, member(a, [b, a]), rule(13), [uses(79, member(a, [a]))]).
substitution(81, [binding("x", a), binding("rest", [b, a])]).
proof(81, member(a, [d, b, a]), rule(13), [uses(80, member(a, [b, a]))]).
substitution(82, [binding("x", a), binding("rest", [d, b, a])]).
proof(82, member(a, [c, d, b, a]), rule(13), [uses(81, member(a, [d, b, a]))]).
substitution(83, []).
proof(83, solution([]), query, [uses(82, member(a, [c, d, b, a]))]).
substitution(84, [binding("x", b)]).
proof(84, member(b, [b, a]), rule(12), []).
substitution(85, [binding("x", b), binding("rest", [b, a])]).
proof(85, member(b, [d, b, a]), rule(13), [uses(84, member(b, [b, a]))]).
substitution(86, [binding("x", b), binding("rest", [d, b, a])]).
proof(86, member(b, [c, d, b, a]), rule(13), [uses(85, member(b, [d, b, a]))]).
substitution(87, []).
proof(87, solution([]), query, [uses(86, member(b, [c, d, b, a]))]).
substitution(88, [binding("x", d)]).
proof(88, member(d, [d, b, a]), rule(12), []).
substitution(89, [binding("x", d), binding("rest", [d, b, a])]).
proof(89, member(d, [c, d, b, a]), rule(13), [uses(88, member(d, [d, b, a]))]).
substitution(90, []).
proof(90, solution([]), query, [uses(89, member(d, [c, d, b, a]))]).
substitution(91, [binding("x", d)]).
proof(91, member(d, [d, b, a]), rule(12), []).
substitution(92, [binding("x", d), binding("rest", [d, b, a])]).
proof(92, member(d, [e, d, b, a]), rule(13), [uses(91, member(d, [d, b, a]))]).
substitution(93, []).
proof(93, solution([]), query, [uses(92, member(d, [e, d, b, a]))]).
substitution(94, [binding("goal", f)]).
proof(94, route(f, f, [f, d, b, a], [f], 0), rule(14), []).
substitution(95, [binding("x", a)]).
proof(95, member(a, [a]), rule(12), []).
substitution(96, [binding("x", a), binding("rest", [a])]).
proof(96, member(a, [c, a]), rule(13), [uses(95, member(a, [a]))]).
substitution(97, [binding("x", a), binding("rest", [c, a])]).
proof(97, member(a, [d, c, a]), rule(13), [uses(96, member(a, [c, a]))]).
substitution(98, [binding("x", a), binding("rest", [d, c, a])]).
proof(98, member(a, [b, d, c, a]), rule(13), [uses(97, member(a, [d, c, a]))]).
substitution(99, []).
proof(99, solution([]), query, [uses(98, member(a, [b, d, c, a]))]).
substitution(100, [binding("x", c)]).
proof(100, member(c, [c, a]), rule(12), []).
substitution(101, [binding("x", c), binding("rest", [c, a])]).
proof(101, member(c, [d, c, a]), rule(13), [uses(100, member(c, [c, a]))]).
substitution(102, [binding("x", c), binding("rest", [d, c, a])]).
proof(102, member(c, [b, d, c, a]), rule(13), [uses(101, member(c, [d, c, a]))]).
substitution(103, []).
proof(103, solution([]), query, [uses(102, member(c, [b, d, c, a]))]).
substitution(104, [binding("x", d)]).
proof(104, member(d, [d, c, a]), rule(12), []).
substitution(105, [binding("x", d), binding("rest", [d, c, a])]).
proof(105, member(d, [b, d, c, a]), rule(13), [uses(104, member(d, [d, c, a]))]).
substitution(106, []).
proof(106, solution([]), query, [uses(105, member(d, [b, d, c, a]))]).
substitution(107, [binding("x", c)]).
proof(107, member(c, [c, a]), rule(12), []).
substitution(108, [binding("x", c), binding("rest", [c, a])]).
proof(108, member(c, [d, c, a]), rule(13), [uses(107, member(c, [c, a]))]).
substitution(109, [binding("x", c), binding("rest", [d, c, a])]).
proof(109, member(c, [e, d, c, a]), rule(13), [uses(108, member(c, [d, c, a]))]).
substitution(110, []).
proof(110, solution([]), query, [uses(109, member(c, [e, d, c, a]))]).
substitution(111, [binding("x", d)]).
proof(111, member(d, [d, c, a]), rule(12), []).
substitution(112, [binding("x", d), binding("rest", [d, c, a])]).
proof(112, member(d, [e, d, c, a]), rule(13), [uses(111, member(d, [d, c, a]))]).
substitution(113, []).
proof(113, solution([]), query, [uses(112, member(d, [e, d, c, a]))]).
substitution(114, [binding("goal", f)]).
proof(114, route(f, f, [f, d, c, a], [f], 0), rule(14), []).
substitution(115, [binding("x", c)]).
proof(115, member(c, [c, b, a]), rule(12), []).
substitution(116, [binding("x", c), binding("rest", [c, b, a])]).
proof(116, member(c, [d, c, b, a]), rule(13), [uses(115, member(c, [c, b, a]))]).
substitution(117, [binding("x", c), binding("rest", [d, c, b, a])]).
proof(117, member(c, [e, d, c, b, a]), rule(13), [uses(116, member(c, [d, c, b, a]))]).
substitution(118, []).
proof(118, solution([]), query, [uses(117, member(c, [e, d, c, b, a]))]).
substitution(119, [binding("x", d)]).
proof(119, member(d, [d, c, b, a]), rule(12), []).
substitution(120, [binding("x", d), binding("rest", [d, c, b, a])]).
proof(120, member(d, [e, d, c, b, a]), rule(13), [uses(119, member(d, [d, c, b, a]))]).
substitution(121, []).
proof(121, solution([]), query, [uses(120, member(d, [e, d, c, b, a]))]).
substitution(122, [binding("goal", f)]).
proof(122, route(f, f, [f, d, c, b, a], [f], 0), rule(14), []).
substitution(123, [binding("x", c)]).
proof(123, member(c, [c, a]), rule(12), []).
substitution(124, [binding("x", c), binding("rest", [c, a])]).
proof(124, member(c, [b, c, a]), rule(13), [uses(123, member(c, [c, a]))]).
substitution(125, [binding("x", c), binding("rest", [b, c, a])]).
proof(125, member(c, [d, b, c, a]), rule(13), [uses(124, member(c, [b, c, a]))]).
substitution(126, [binding("x", c), binding("rest", [d, b, c, a])]).
proof(126, member(c, [e, d, b, c, a]), rule(13), [uses(125, member(c, [d, b, c, a]))]).
substitution(127, []).
proof(127, solution([]), query, [uses(126, member(c, [e, d, b, c, a]))]).
substitution(128, [binding("x", d)]).
proof(128, member(d, [d, b, c, a]), rule(12), []).
substitution(129, [binding("x", d), binding("rest", [d, b, c, a])]).
proof(129, member(d, [e, d, b, c, a]), rule(13), [uses(128, member(d, [d, b, c, a]))]).
substitution(130, []).
proof(130, solution([]), query, [uses(129, member(d, [e, d, b, c, a]))]).
substitution(131, [binding("goal", f)]).
proof(131, route(f, f, [f, d, b, c, a], [f], 0), rule(14), []).
substitution(132, [binding("x", c)]).
proof(132, member(c, [c, a]), rule(12), []).
substitution(133, [binding("x", c), binding("rest", [c, a])]).
proof(133, member(c, [e, c, a]), rule(13), [uses(132, member(c, [c, a]))]).
substitution(134, [binding("x", c), binding("rest", [e, c, a])]).
proof(134, member(c, [d, e, c, a]), rule(13), [uses(133, member(c, [e, c, a]))]).
substitution(135, []).
proof(135, solution([]), query, [uses(134, member(c, [d, e, c, a]))]).
substitution(136, [binding("x", e)]).
proof(136, member(e, [e, c, a]), rule(12), []).
substitution(137, [binding("x", e), binding("rest", [e, c, a])]).
proof(137, member(e, [d, e, c, a]), rule(13), [uses(136, member(e, [e, c, a]))]).
substitution(138, []).
proof(138, solution([]), query, [uses(137, member(e, [d, e, c, a]))]).
substitution(139, [binding("goal", f)]).
proof(139, route(f, f, [f, e, c, a], [f], 0), rule(14), []).
substitution(140, [binding("x", b)]).
proof(140, member(b, [b, a]), rule(12), []).
substitution(141, [binding("x", b), binding("rest", [b, a])]).
proof(141, member(b, [c, b, a]), rule(13), [uses(140, member(b, [b, a]))]).
substitution(142, [binding("x", b), binding("rest", [c, b, a])]).
proof(142, member(b, [e, c, b, a]), rule(13), [uses(141, member(b, [c, b, a]))]).
substitution(143, [binding("x", b), binding("rest", [e, c, b, a])]).
proof(143, member(b, [d, e, c, b, a]), rule(13), [uses(142, member(b, [e, c, b, a]))]).
substitution(144, []).
proof(144, solution([]), query, [uses(143, member(b, [d, e, c, b, a]))]).
substitution(145, [binding("x", c)]).
proof(145, member(c, [c, b, a]), rule(12), []).
substitution(146, [binding("x", c), binding("rest", [c, b, a])]).
proof(146, member(c, [e, c, b, a]), rule(13), [uses(145, member(c, [c, b, a]))]).
substitution(147, [binding("x", c), binding("rest", [e, c, b, a])]).
proof(147, member(c, [d, e, c, b, a]), rule(13), [uses(146, member(c, [e, c, b, a]))]).
substitution(148, []).
proof(148, solution([]), query, [uses(147, member(c, [d, e, c, b, a]))]).
substitution(149, [binding("x", e)]).
proof(149, member(e, [e, c, b, a]), rule(12), []).
substitution(150, [binding("x", e), binding("rest", [e, c, b, a])]).
proof(150, member(e, [d, e, c, b, a]), rule(13), [uses(149, member(e, [e, c, b, a]))]).
substitution(151, []).
proof(151, solution([]), query, [uses(150, member(e, [d, e, c, b, a]))]).
substitution(152, [binding("goal", f)]).
proof(152, route(f, f, [f, e, c, b, a], [f], 0), rule(14), []).
substitution(153, [binding("x", c)]).
proof(153, member(c, [c, d, b, a]), rule(12), []).
substitution(154, [binding("x", c), binding("rest", [c, d, b, a])]).
proof(154, member(c, [e, c, d, b, a]), rule(13), [uses(153, member(c, [c, d, b, a]))]).
substitution(155, []).
proof(155, solution([]), query, [uses(154, member(c, [e, c, d, b, a]))]).
substitution(156, [binding("x", d)]).
proof(156, member(d, [d, b, a]), rule(12), []).
substitution(157, [binding("x", d), binding("rest", [d, b, a])]).
proof(157, member(d, [c, d, b, a]), rule(13), [uses(156, member(d, [d, b, a]))]).
substitution(158, [binding("x", d), binding("rest", [c, d, b, a])]).
proof(158, member(d, [e, c, d, b, a]), rule(13), [uses(157, member(d, [c, d, b, a]))]).
substitution(159, []).
proof(159, solution([]), query, [uses(158, member(d, [e, c, d, b, a]))]).
substitution(160, [binding("x", a)]).
proof(160, member(a, [a]), rule(12), []).
substitution(161, [binding("x", a), binding("rest", [a])]).
proof(161, member(a, [b, a]), rule(13), [uses(160, member(a, [a]))]).
substitution(162, [binding("x", a), binding("rest", [b, a])]).
proof(162, member(a, [d, b, a]), rule(13), [uses(161, member(a, [b, a]))]).
substitution(163, [binding("x", a), binding("rest", [d, b, a])]).
proof(163, member(a, [e, d, b, a]), rule(13), [uses(162, member(a, [d, b, a]))]).
substitution(164, [binding("x", a), binding("rest", [e, d, b, a])]).
proof(164, member(a, [c, e, d, b, a]), rule(13), [uses(163, member(a, [e, d, b, a]))]).
substitution(165, []).
proof(165, solution([]), query, [uses(164, member(a, [c, e, d, b, a]))]).
substitution(166, [binding("x", b)]).
proof(166, member(b, [b, a]), rule(12), []).
substitution(167, [binding("x", b), binding("rest", [b, a])]).
proof(167, member(b, [d, b, a]), rule(13), [uses(166, member(b, [b, a]))]).
substitution(168, [binding("x", b), binding("rest", [d, b, a])]).
proof(168, member(b, [e, d, b, a]), rule(13), [uses(167, member(b, [d, b, a]))]).
substitution(169, [binding("x", b), binding("rest", [e, d, b, a])]).
proof(169, member(b, [c, e, d, b, a]), rule(13), [uses(168, member(b, [e, d, b, a]))]).
substitution(170, []).
proof(170, solution([]), query, [uses(169, member(b, [c, e, d, b, a]))]).
substitution(171, [binding("x", d)]).
proof(171, member(d, [d, b, a]), rule(12), []).
substitution(172, [binding("x", d), binding("rest", [d, b, a])]).
proof(172, member(d, [e, d, b, a]), rule(13), [uses(171, member(d, [d, b, a]))]).
substitution(173, [binding("x", d), binding("rest", [e, d, b, a])]).
proof(173, member(d, [c, e, d, b, a]), rule(13), [uses(172, member(d, [e, d, b, a]))]).
substitution(174, []).
proof(174, solution([]), query, [uses(173, member(d, [c, e, d, b, a]))]).
substitution(175, [binding("x", e)]).
proof(175, member(e, [e, d, b, a]), rule(12), []).
substitution(176, [binding("x", e), binding("rest", [e, d, b, a])]).
proof(176, member(e, [c, e, d, b, a]), rule(13), [uses(175, member(e, [e, d, b, a]))]).
substitution(177, []).
proof(177, solution([]), query, [uses(176, member(e, [c, e, d, b, a]))]).
substitution(178, [binding("goal", f)]).
proof(178, route(f, f, [f, e, d, b, a], [f], 0), rule(14), []).
substitution(179, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(179, route(d, f, [d, b, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, b, a]), complete), uses(94, route(f, f, [f, d, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(180, [binding("goal", f)]).
proof(180, route(f, f, [f, e, d, c, a], [f], 0), rule(14), []).
substitution(181, [binding("from", d), binding("goal", f), binding("visited", [d, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(181, route(d, f, [d, c, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, c, a]), complete), uses(114, route(f, f, [f, d, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(182, [binding("goal", f)]).
proof(182, route(f, f, [f, e, d, c, b, a], [f], 0), rule(14), []).
substitution(183, [binding("from", d), binding("goal", f), binding("visited", [d, c, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(183, route(d, f, [d, c, b, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, c, b, a]), complete), uses(122, route(f, f, [f, d, c, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(184, [binding("goal", f)]).
proof(184, route(f, f, [f, e, d, b, c, a], [f], 0), rule(14), []).
substitution(185, [binding("from", d), binding("goal", f), binding("visited", [d, b, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(185, route(d, f, [d, b, c, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, b, c, a]), complete), uses(131, route(f, f, [f, d, b, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(186, [binding("x", a)]).
proof(186, member(a, [a]), rule(12), []).
substitution(187, [binding("x", a), binding("rest", [a])]).
proof(187, member(a, [c, a]), rule(13), [uses(186, member(a, [a]))]).
substitution(188, [binding("x", a), binding("rest", [c, a])]).
proof(188, member(a, [e, c, a]), rule(13), [uses(187, member(a, [c, a]))]).
substitution(189, [binding("x", a), binding("rest", [e, c, a])]).
proof(189, member(a, [d, e, c, a]), rule(13), [uses(188, member(a, [e, c, a]))]).
substitution(190, [binding("x", a), binding("rest", [d, e, c, a])]).
proof(190, member(a, [b, d, e, c, a]), rule(13), [uses(189, member(a, [d, e, c, a]))]).
substitution(191, []).
proof(191, solution([]), query, [uses(190, member(a, [b, d, e, c, a]))]).
substitution(192, [binding("x", c)]).
proof(192, member(c, [c, a]), rule(12), []).
substitution(193, [binding("x", c), binding("rest", [c, a])]).
proof(193, member(c, [e, c, a]), rule(13), [uses(192, member(c, [c, a]))]).
substitution(194, [binding("x", c), binding("rest", [e, c, a])]).
proof(194, member(c, [d, e, c, a]), rule(13), [uses(193, member(c, [e, c, a]))]).
substitution(195, [binding("x", c), binding("rest", [d, e, c, a])]).
proof(195, member(c, [b, d, e, c, a]), rule(13), [uses(194, member(c, [d, e, c, a]))]).
substitution(196, []).
proof(196, solution([]), query, [uses(195, member(c, [b, d, e, c, a]))]).
substitution(197, [binding("x", d)]).
proof(197, member(d, [d, e, c, a]), rule(12), []).
substitution(198, [binding("x", d), binding("rest", [d, e, c, a])]).
proof(198, member(d, [b, d, e, c, a]), rule(13), [uses(197, member(d, [d, e, c, a]))]).
substitution(199, []).
proof(199, solution([]), query, [uses(198, member(d, [b, d, e, c, a]))]).
substitution(200, [binding("goal", f)]).
proof(200, route(f, f, [f, d, e, c, a], [f], 0), rule(14), []).
substitution(201, [binding("from", e), binding("goal", f), binding("visited", [e, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(201, route(e, f, [e, c, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, c, a]), complete), uses(139, route(f, f, [f, e, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(202, [binding("goal", f)]).
proof(202, route(f, f, [f, d, e, c, b, a], [f], 0), rule(14), []).
substitution(203, [binding("from", e), binding("goal", f), binding("visited", [e, c, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(203, route(e, f, [e, c, b, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, c, b, a]), complete), uses(152, route(f, f, [f, e, c, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(204, [binding("goal", f)]).
proof(204, route(f, f, [f, e, c, d, b, a], [f], 0), rule(14), []).
substitution(205, [binding("from", e), binding("goal", f), binding("visited", [e, d, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(205, route(e, f, [e, d, b, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, d, b, a]), complete), uses(178, route(f, f, [f, e, d, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(206, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, f]), binding("cost", 11), binding("next", d), binding("step", 5), binding("remaining", 6)]).
proof(206, route(b, f, [b, a], [b, d, f], 11), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(179, route(d, f, [d, b, a], [d, f], 6)), calculated(11, binary("+", value(5), value(6)))]).
substitution(207, []).
proof(207, edge(d, f, 6), rule(8), []).
substitution(208, []).
proof(208, edge(e, f, 3), rule(9), []).
substitution(209, [binding("from", e), binding("goal", f), binding("visited", [e, d, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(209, route(e, f, [e, d, c, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, d, c, a]), complete), uses(180, route(f, f, [f, e, d, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(210, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [d, f]), binding("cost", 14), binding("next", d), binding("step", 8), binding("remaining", 6)]).
proof(210, route(c, f, [c, a], [c, d, f], 14), rule(15), [uses(17, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(181, route(d, f, [d, c, a], [d, f], 6)), calculated(14, binary("+", value(8), value(6)))]).
substitution(211, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(211, route(c, f, [c, a], [c, e, f], 13), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(201, route(e, f, [e, c, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(212, [binding("from", e), binding("goal", f), binding("visited", [e, d, c, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(212, route(e, f, [e, d, c, b, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, d, c, b, a]), complete), uses(182, route(f, f, [f, e, d, c, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(213, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [d, f]), binding("cost", 14), binding("next", d), binding("step", 8), binding("remaining", 6)]).
proof(213, route(c, f, [c, b, a], [c, d, f], 14), rule(15), [uses(17, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(183, route(d, f, [d, c, b, a], [d, f], 6)), calculated(14, binary("+", value(8), value(6)))]).
substitution(214, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(214, route(c, f, [c, b, a], [c, e, f], 13), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(203, route(e, f, [e, c, b, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(215, [binding("from", e), binding("goal", f), binding("visited", [e, d, b, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(215, route(e, f, [e, d, b, c, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, d, b, c, a]), complete), uses(184, route(f, f, [f, e, d, b, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(216, [binding("from", b), binding("goal", f), binding("visited", [b, c, a]), binding("path", [d, f]), binding("cost", 11), binding("next", d), binding("step", 5), binding("remaining", 6)]).
proof(216, route(b, f, [b, c, a], [b, d, f], 11), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(185, route(d, f, [d, b, c, a], [d, f], 6)), calculated(11, binary("+", value(5), value(6)))]).
substitution(217, [binding("from", d), binding("goal", f), binding("visited", [d, e, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(217, route(d, f, [d, e, c, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, e, c, a]), complete), uses(200, route(f, f, [f, d, e, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(218, [binding("from", d), binding("goal", f), binding("visited", [d, e, c, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(218, route(d, f, [d, e, c, b, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, e, c, b, a]), complete), uses(202, route(f, f, [f, d, e, c, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(219, [binding("from", e), binding("goal", f), binding("visited", [e, c, d, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(219, route(e, f, [e, c, d, b, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, c, d, b, a]), complete), uses(204, route(f, f, [f, e, c, d, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(220, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(220, route(d, f, [d, b, a], [d, e, f], 5), rule(15), [uses(48, connected(d, e, 2)), absent(member(e, [d, b, a]), complete), uses(205, route(e, f, [e, d, b, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(221, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, d, f]), binding("cost", 15), binding("next", b), binding("step", 4), binding("remaining", 11)]).
proof(221, route(a, f, [a], [a, b, d, f], 15), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(206, route(b, f, [b, a], [b, d, f], 11)), calculated(15, binary("+", value(4), value(11)))]).
substitution(222, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, d, f]), binding("cost", 16), binding("next", c), binding("step", 2), binding("remaining", 14)]).
proof(222, route(a, f, [a], [a, c, d, f], 16), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(210, route(c, f, [c, a], [c, d, f], 14)), calculated(16, binary("+", value(2), value(14)))]).
substitution(223, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, e, f]), binding("cost", 15), binding("next", c), binding("step", 2), binding("remaining", 13)]).
proof(223, route(a, f, [a], [a, c, e, f], 15), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(211, route(c, f, [c, a], [c, e, f], 13)), calculated(15, binary("+", value(2), value(13)))]).
substitution(224, [binding("right", f), binding("left", d), binding("weight", 6)]).
proof(224, connected(f, d, 6), rule(10), [uses(207, edge(d, f, 6))]).
substitution(225, [binding("right", f), binding("left", e), binding("weight", 3)]).
proof(225, connected(f, e, 3), rule(10), [uses(208, edge(e, f, 3))]).
substitution(226, [binding("from", d), binding("goal", f), binding("visited", [d, c, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(226, route(d, f, [d, c, a], [d, e, f], 5), rule(15), [uses(48, connected(d, e, 2)), absent(member(e, [d, c, a]), complete), uses(209, route(e, f, [e, d, c, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(227, [binding("from", d), binding("goal", f), binding("visited", [d, c, b, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(227, route(d, f, [d, c, b, a], [d, e, f], 5), rule(15), [uses(48, connected(d, e, 2)), absent(member(e, [d, c, b, a]), complete), uses(212, route(e, f, [e, d, c, b, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(228, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, d, f]), binding("cost", 15), binding("next", c), binding("step", 1), binding("remaining", 14)]).
proof(228, route(b, f, [b, a], [b, c, d, f], 15), rule(15), [uses(13, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(213, route(c, f, [c, b, a], [c, d, f], 14)), calculated(15, binary("+", value(1), value(14)))]).
substitution(229, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, e, f]), binding("cost", 14), binding("next", c), binding("step", 1), binding("remaining", 13)]).
proof(229, route(b, f, [b, a], [b, c, e, f], 14), rule(15), [uses(13, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(214, route(c, f, [c, b, a], [c, e, f], 13)), calculated(14, binary("+", value(1), value(13)))]).
substitution(230, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, e, f]), binding("cost", 10), binding("next", d), binding("step", 5), binding("remaining", 5)]).
proof(230, route(b, f, [b, a], [b, d, e, f], 10), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(220, route(d, f, [d, b, a], [d, e, f], 5)), calculated(10, binary("+", value(5), value(5)))]).
substitution(231, [binding("from", d), binding("goal", f), binding("visited", [d, b, c, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(231, route(d, f, [d, b, c, a], [d, e, f], 5), rule(15), [uses(48, connected(d, e, 2)), absent(member(e, [d, b, c, a]), complete), uses(215, route(e, f, [e, d, b, c, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(232, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [b, d, f]), binding("cost", 12), binding("next", b), binding("step", 1), binding("remaining", 11)]).
proof(232, route(c, f, [c, a], [c, b, d, f], 12), rule(15), [uses(16, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(216, route(b, f, [b, c, a], [b, d, f], 11)), calculated(12, binary("+", value(1), value(11)))]).
substitution(233, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [d, e, f]), binding("cost", 13), binding("next", d), binding("step", 8), binding("remaining", 5)]).
proof(233, route(c, f, [c, a], [c, d, e, f], 13), rule(15), [uses(17, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(226, route(d, f, [d, c, a], [d, e, f], 5)), calculated(13, binary("+", value(8), value(5)))]).
substitution(234, [binding("from", e), binding("goal", f), binding("visited", [e, c, a]), binding("path", [d, f]), binding("cost", 8), binding("next", d), binding("step", 2), binding("remaining", 6)]).
proof(234, route(e, f, [e, c, a], [e, d, f], 8), rule(15), [uses(51, connected(e, d, 2)), absent(member(d, [e, c, a]), complete), uses(217, route(d, f, [d, e, c, a], [d, f], 6)), calculated(8, binary("+", value(2), value(6)))]).
substitution(235, [binding("from", e), binding("goal", f), binding("visited", [e, c, b, a]), binding("path", [d, f]), binding("cost", 8), binding("next", d), binding("step", 2), binding("remaining", 6)]).
proof(235, route(e, f, [e, c, b, a], [e, d, f], 8), rule(15), [uses(51, connected(e, d, 2)), absent(member(d, [e, c, b, a]), complete), uses(218, route(d, f, [d, e, c, b, a], [d, f], 6)), calculated(8, binary("+", value(2), value(6)))]).
substitution(236, [binding("from", c), binding("goal", f), binding("visited", [c, d, b, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(236, route(c, f, [c, d, b, a], [c, e, f], 13), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, d, b, a]), complete), uses(219, route(e, f, [e, c, d, b, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(237, [binding("candidate", 15)]).
proof(237, solution([15]), query, [uses(221, route(a, f, [a], [a, b, d, f], 15))]).
substitution(238, [binding("candidate", 16)]).
proof(238, solution([16]), query, [uses(222, route(a, f, [a], [a, c, d, f], 16))]).
substitution(239, [binding("x", d)]).
proof(239, member(d, [d, b, a]), rule(12), []).
substitution(240, [binding("x", d), binding("rest", [d, b, a])]).
proof(240, member(d, [f, d, b, a]), rule(13), [uses(239, member(d, [d, b, a]))]).
substitution(241, []).
proof(241, solution([]), query, [uses(240, member(d, [f, d, b, a]))]).
substitution(242, [binding("x", d)]).
proof(242, member(d, [d, c, a]), rule(12), []).
substitution(243, [binding("x", d), binding("rest", [d, c, a])]).
proof(243, member(d, [f, d, c, a]), rule(13), [uses(242, member(d, [d, c, a]))]).
substitution(244, []).
proof(244, solution([]), query, [uses(243, member(d, [f, d, c, a]))]).
substitution(245, [binding("x", d)]).
proof(245, member(d, [d, c, b, a]), rule(12), []).
substitution(246, [binding("x", d), binding("rest", [d, c, b, a])]).
proof(246, member(d, [f, d, c, b, a]), rule(13), [uses(245, member(d, [d, c, b, a]))]).
substitution(247, []).
proof(247, solution([]), query, [uses(246, member(d, [f, d, c, b, a]))]).
substitution(248, [binding("x", d)]).
proof(248, member(d, [d, b, c, a]), rule(12), []).
substitution(249, [binding("x", d), binding("rest", [d, b, c, a])]).
proof(249, member(d, [f, d, b, c, a]), rule(13), [uses(248, member(d, [d, b, c, a]))]).
substitution(250, []).
proof(250, solution([]), query, [uses(249, member(d, [f, d, b, c, a]))]).
substitution(251, [binding("x", e)]).
proof(251, member(e, [e, c, a]), rule(12), []).
substitution(252, [binding("x", e), binding("rest", [e, c, a])]).
proof(252, member(e, [f, e, c, a]), rule(13), [uses(251, member(e, [e, c, a]))]).
substitution(253, []).
proof(253, solution([]), query, [uses(252, member(e, [f, e, c, a]))]).
substitution(254, [binding("x", e)]).
proof(254, member(e, [e, c, b, a]), rule(12), []).
substitution(255, [binding("x", e), binding("rest", [e, c, b, a])]).
proof(255, member(e, [f, e, c, b, a]), rule(13), [uses(254, member(e, [e, c, b, a]))]).
substitution(256, []).
proof(256, solution([]), query, [uses(255, member(e, [f, e, c, b, a]))]).
substitution(257, [binding("x", d)]).
proof(257, member(d, [d, b, a]), rule(12), []).
substitution(258, [binding("x", d), binding("rest", [d, b, a])]).
proof(258, member(d, [e, d, b, a]), rule(13), [uses(257, member(d, [d, b, a]))]).
substitution(259, [binding("x", d), binding("rest", [e, d, b, a])]).
proof(259, member(d, [f, e, d, b, a]), rule(13), [uses(258, member(d, [e, d, b, a]))]).
substitution(260, []).
proof(260, solution([]), query, [uses(259, member(d, [f, e, d, b, a]))]).
substitution(261, [binding("x", e)]).
proof(261, member(e, [e, d, b, a]), rule(12), []).
substitution(262, [binding("x", e), binding("rest", [e, d, b, a])]).
proof(262, member(e, [f, e, d, b, a]), rule(13), [uses(261, member(e, [e, d, b, a]))]).
substitution(263, []).
proof(263, solution([]), query, [uses(262, member(e, [f, e, d, b, a]))]).
substitution(264, [binding("x", d)]).
proof(264, member(d, [d, c, a]), rule(12), []).
substitution(265, [binding("x", d), binding("rest", [d, c, a])]).
proof(265, member(d, [e, d, c, a]), rule(13), [uses(264, member(d, [d, c, a]))]).
substitution(266, [binding("x", d), binding("rest", [e, d, c, a])]).
proof(266, member(d, [f, e, d, c, a]), rule(13), [uses(265, member(d, [e, d, c, a]))]).
substitution(267, []).
proof(267, solution([]), query, [uses(266, member(d, [f, e, d, c, a]))]).
substitution(268, [binding("x", e)]).
proof(268, member(e, [e, d, c, a]), rule(12), []).
substitution(269, [binding("x", e), binding("rest", [e, d, c, a])]).
proof(269, member(e, [f, e, d, c, a]), rule(13), [uses(268, member(e, [e, d, c, a]))]).
substitution(270, []).
proof(270, solution([]), query, [uses(269, member(e, [f, e, d, c, a]))]).
substitution(271, [binding("x", d)]).
proof(271, member(d, [d, c, b, a]), rule(12), []).
substitution(272, [binding("x", d), binding("rest", [d, c, b, a])]).
proof(272, member(d, [e, d, c, b, a]), rule(13), [uses(271, member(d, [d, c, b, a]))]).
substitution(273, [binding("x", d), binding("rest", [e, d, c, b, a])]).
proof(273, member(d, [f, e, d, c, b, a]), rule(13), [uses(272, member(d, [e, d, c, b, a]))]).
substitution(274, []).
proof(274, solution([]), query, [uses(273, member(d, [f, e, d, c, b, a]))]).
substitution(275, [binding("x", e)]).
proof(275, member(e, [e, d, c, b, a]), rule(12), []).
substitution(276, [binding("x", e), binding("rest", [e, d, c, b, a])]).
proof(276, member(e, [f, e, d, c, b, a]), rule(13), [uses(275, member(e, [e, d, c, b, a]))]).
substitution(277, []).
proof(277, solution([]), query, [uses(276, member(e, [f, e, d, c, b, a]))]).
substitution(278, [binding("x", d)]).
proof(278, member(d, [d, b, c, a]), rule(12), []).
substitution(279, [binding("x", d), binding("rest", [d, b, c, a])]).
proof(279, member(d, [e, d, b, c, a]), rule(13), [uses(278, member(d, [d, b, c, a]))]).
substitution(280, [binding("x", d), binding("rest", [e, d, b, c, a])]).
proof(280, member(d, [f, e, d, b, c, a]), rule(13), [uses(279, member(d, [e, d, b, c, a]))]).
substitution(281, []).
proof(281, solution([]), query, [uses(280, member(d, [f, e, d, b, c, a]))]).
substitution(282, [binding("x", e)]).
proof(282, member(e, [e, d, b, c, a]), rule(12), []).
substitution(283, [binding("x", e), binding("rest", [e, d, b, c, a])]).
proof(283, member(e, [f, e, d, b, c, a]), rule(13), [uses(282, member(e, [e, d, b, c, a]))]).
substitution(284, []).
proof(284, solution([]), query, [uses(283, member(e, [f, e, d, b, c, a]))]).
substitution(285, [binding("x", d)]).
proof(285, member(d, [d, e, c, a]), rule(12), []).
substitution(286, [binding("x", d), binding("rest", [d, e, c, a])]).
proof(286, member(d, [f, d, e, c, a]), rule(13), [uses(285, member(d, [d, e, c, a]))]).
substitution(287, []).
proof(287, solution([]), query, [uses(286, member(d, [f, d, e, c, a]))]).
substitution(288, [binding("x", e)]).
proof(288, member(e, [e, c, a]), rule(12), []).
substitution(289, [binding("x", e), binding("rest", [e, c, a])]).
proof(289, member(e, [d, e, c, a]), rule(13), [uses(288, member(e, [e, c, a]))]).
substitution(290, [binding("x", e), binding("rest", [d, e, c, a])]).
proof(290, member(e, [f, d, e, c, a]), rule(13), [uses(289, member(e, [d, e, c, a]))]).
substitution(291, []).
proof(291, solution([]), query, [uses(290, member(e, [f, d, e, c, a]))]).
substitution(292, [binding("x", d)]).
proof(292, member(d, [d, e, c, b, a]), rule(12), []).
substitution(293, [binding("x", d), binding("rest", [d, e, c, b, a])]).
proof(293, member(d, [f, d, e, c, b, a]), rule(13), [uses(292, member(d, [d, e, c, b, a]))]).
substitution(294, []).
proof(294, solution([]), query, [uses(293, member(d, [f, d, e, c, b, a]))]).
substitution(295, [binding("x", e)]).
proof(295, member(e, [e, c, b, a]), rule(12), []).
substitution(296, [binding("x", e), binding("rest", [e, c, b, a])]).
proof(296, member(e, [d, e, c, b, a]), rule(13), [uses(295, member(e, [e, c, b, a]))]).
substitution(297, [binding("x", e), binding("rest", [d, e, c, b, a])]).
proof(297, member(e, [f, d, e, c, b, a]), rule(13), [uses(296, member(e, [d, e, c, b, a]))]).
substitution(298, []).
proof(298, solution([]), query, [uses(297, member(e, [f, d, e, c, b, a]))]).
substitution(299, [binding("x", d)]).
proof(299, member(d, [d, b, a]), rule(12), []).
substitution(300, [binding("x", d), binding("rest", [d, b, a])]).
proof(300, member(d, [c, d, b, a]), rule(13), [uses(299, member(d, [d, b, a]))]).
substitution(301, [binding("x", d), binding("rest", [c, d, b, a])]).
proof(301, member(d, [e, c, d, b, a]), rule(13), [uses(300, member(d, [c, d, b, a]))]).
substitution(302, [binding("x", d), binding("rest", [e, c, d, b, a])]).
proof(302, member(d, [f, e, c, d, b, a]), rule(13), [uses(301, member(d, [e, c, d, b, a]))]).
substitution(303, []).
proof(303, solution([]), query, [uses(302, member(d, [f, e, c, d, b, a]))]).
substitution(304, [binding("x", e)]).
proof(304, member(e, [e, c, d, b, a]), rule(12), []).
substitution(305, [binding("x", e), binding("rest", [e, c, d, b, a])]).
proof(305, member(e, [f, e, c, d, b, a]), rule(13), [uses(304, member(e, [e, c, d, b, a]))]).
substitution(306, []).
proof(306, solution([]), query, [uses(305, member(e, [f, e, c, d, b, a]))]).
substitution(307, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [d, e, f]), binding("cost", 13), binding("next", d), binding("step", 8), binding("remaining", 5)]).
proof(307, route(c, f, [c, b, a], [c, d, e, f], 13), rule(15), [uses(17, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(227, route(d, f, [d, c, b, a], [d, e, f], 5)), calculated(13, binary("+", value(8), value(5)))]).
substitution(308, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [e, d, f]), binding("cost", 18), binding("next", e), binding("step", 10), binding("remaining", 8)]).
proof(308, route(c, f, [c, b, a], [c, e, d, f], 18), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(235, route(e, f, [e, c, b, a], [e, d, f], 8)), calculated(18, binary("+", value(10), value(8)))]).
substitution(309, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, c, d, f]), binding("cost", 19), binding("next", b), binding("step", 4), binding("remaining", 15)]).
proof(309, route(a, f, [a], [a, b, c, d, f], 19), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(228, route(b, f, [b, a], [b, c, d, f], 15)), calculated(19, binary("+", value(4), value(15)))]).
substitution(310, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, c, e, f]), binding("cost", 18), binding("next", b), binding("step", 4), binding("remaining", 14)]).
proof(310, route(a, f, [a], [a, b, c, e, f], 18), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(229, route(b, f, [b, a], [b, c, e, f], 14)), calculated(18, binary("+", value(4), value(14)))]).
substitution(311, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, d, e, f]), binding("cost", 14), binding("next", b), binding("step", 4), binding("remaining", 10)]).
proof(311, route(a, f, [a], [a, b, d, e, f], 14), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(230, route(b, f, [b, a], [b, d, e, f], 10)), calculated(14, binary("+", value(4), value(10)))]).
substitution(312, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, b, d, f]), binding("cost", 14), binding("next", c), binding("step", 2), binding("remaining", 12)]).
proof(312, route(a, f, [a], [a, c, b, d, f], 14), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(232, route(c, f, [c, a], [c, b, d, f], 12)), calculated(14, binary("+", value(2), value(12)))]).
substitution(313, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, d, e, f]), binding("cost", 15), binding("next", c), binding("step", 2), binding("remaining", 13)]).
proof(313, route(a, f, [a], [a, c, d, e, f], 15), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(233, route(c, f, [c, a], [c, d, e, f], 13)), calculated(15, binary("+", value(2), value(13)))]).
substitution(314, [binding("from", b), binding("goal", f), binding("visited", [b, c, a]), binding("path", [d, e, f]), binding("cost", 10), binding("next", d), binding("step", 5), binding("remaining", 5)]).
proof(314, route(b, f, [b, c, a], [b, d, e, f], 10), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(231, route(d, f, [d, b, c, a], [d, e, f], 5)), calculated(10, binary("+", value(5), value(5)))]).
substitution(315, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [b, d, e, f]), binding("cost", 11), binding("next", b), binding("step", 1), binding("remaining", 10)]).
proof(315, route(c, f, [c, a], [c, b, d, e, f], 11), rule(15), [uses(16, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(314, route(b, f, [b, c, a], [b, d, e, f], 10)), calculated(11, binary("+", value(1), value(10)))]).
substitution(316, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [e, d, f]), binding("cost", 18), binding("next", e), binding("step", 10), binding("remaining", 8)]).
proof(316, route(c, f, [c, a], [c, e, d, f], 18), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(234, route(e, f, [e, c, a], [e, d, f], 8)), calculated(18, binary("+", value(10), value(8)))]).
substitution(317, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [c, e, f]), binding("cost", 21), binding("next", c), binding("step", 8), binding("remaining", 13)]).
proof(317, route(d, f, [d, b, a], [d, c, e, f], 21), rule(15), [uses(47, connected(d, c, 8)), absent(member(c, [d, b, a]), complete), uses(236, route(c, f, [c, d, b, a], [c, e, f], 13)), calculated(21, binary("+", value(8), value(13)))]).
substitution(318, [binding("x", d)]).
proof(318, member(d, [d, b, a]), rule(12), []).
substitution(319, [binding("x", d), binding("rest", [d, b, a])]).
proof(319, member(d, [f, d, b, a]), rule(13), [uses(318, member(d, [d, b, a]))]).
substitution(320, [binding("x", d), binding("rest", [f, d, b, a])]).
proof(320, member(d, [e, f, d, b, a]), rule(13), [uses(319, member(d, [f, d, b, a]))]).
substitution(321, []).
proof(321, solution([]), query, [uses(320, member(d, [e, f, d, b, a]))]).
substitution(322, [binding("x", f)]).
proof(322, member(f, [f, d, b, a]), rule(12), []).
substitution(323, [binding("x", f), binding("rest", [f, d, b, a])]).
proof(323, member(f, [e, f, d, b, a]), rule(13), [uses(322, member(f, [f, d, b, a]))]).
substitution(324, []).
proof(324, solution([]), query, [uses(323, member(f, [e, f, d, b, a]))]).
substitution(325, [binding("x", c)]).
proof(325, member(c, [c, a]), rule(12), []).
substitution(326, [binding("x", c), binding("rest", [c, a])]).
proof(326, member(c, [d, c, a]), rule(13), [uses(325, member(c, [c, a]))]).
substitution(327, [binding("x", c), binding("rest", [d, c, a])]).
proof(327, member(c, [f, d, c, a]), rule(13), [uses(326, member(c, [d, c, a]))]).
substitution(328, [binding("x", c), binding("rest", [f, d, c, a])]).
proof(328, member(c, [e, f, d, c, a]), rule(13), [uses(327, member(c, [f, d, c, a]))]).
substitution(329, []).
proof(329, solution([]), query, [uses(328, member(c, [e, f, d, c, a]))]).
substitution(330, [binding("x", d)]).
proof(330, member(d, [d, c, a]), rule(12), []).
substitution(331, [binding("x", d), binding("rest", [d, c, a])]).
proof(331, member(d, [f, d, c, a]), rule(13), [uses(330, member(d, [d, c, a]))]).
substitution(332, [binding("x", d), binding("rest", [f, d, c, a])]).
proof(332, member(d, [e, f, d, c, a]), rule(13), [uses(331, member(d, [f, d, c, a]))]).
substitution(333, []).
proof(333, solution([]), query, [uses(332, member(d, [e, f, d, c, a]))]).
substitution(334, [binding("x", f)]).
proof(334, member(f, [f, d, c, a]), rule(12), []).
substitution(335, [binding("x", f), binding("rest", [f, d, c, a])]).
proof(335, member(f, [e, f, d, c, a]), rule(13), [uses(334, member(f, [f, d, c, a]))]).
substitution(336, []).
proof(336, solution([]), query, [uses(335, member(f, [e, f, d, c, a]))]).
substitution(337, [binding("x", c)]).
proof(337, member(c, [c, b, a]), rule(12), []).
substitution(338, [binding("x", c), binding("rest", [c, b, a])]).
proof(338, member(c, [d, c, b, a]), rule(13), [uses(337, member(c, [c, b, a]))]).
substitution(339, [binding("x", c), binding("rest", [d, c, b, a])]).
proof(339, member(c, [f, d, c, b, a]), rule(13), [uses(338, member(c, [d, c, b, a]))]).
substitution(340, [binding("x", c), binding("rest", [f, d, c, b, a])]).
proof(340, member(c, [e, f, d, c, b, a]), rule(13), [uses(339, member(c, [f, d, c, b, a]))]).
substitution(341, []).
proof(341, solution([]), query, [uses(340, member(c, [e, f, d, c, b, a]))]).
substitution(342, [binding("x", d)]).
proof(342, member(d, [d, c, b, a]), rule(12), []).
substitution(343, [binding("x", d), binding("rest", [d, c, b, a])]).
proof(343, member(d, [f, d, c, b, a]), rule(13), [uses(342, member(d, [d, c, b, a]))]).
substitution(344, [binding("x", d), binding("rest", [f, d, c, b, a])]).
proof(344, member(d, [e, f, d, c, b, a]), rule(13), [uses(343, member(d, [f, d, c, b, a]))]).
substitution(345, []).
proof(345, solution([]), query, [uses(344, member(d, [e, f, d, c, b, a]))]).
substitution(346, [binding("x", f)]).
proof(346, member(f, [f, d, c, b, a]), rule(12), []).
substitution(347, [binding("x", f), binding("rest", [f, d, c, b, a])]).
proof(347, member(f, [e, f, d, c, b, a]), rule(13), [uses(346, member(f, [f, d, c, b, a]))]).
substitution(348, []).
proof(348, solution([]), query, [uses(347, member(f, [e, f, d, c, b, a]))]).
substitution(349, [binding("x", c)]).
proof(349, member(c, [c, a]), rule(12), []).
substitution(350, [binding("x", c), binding("rest", [c, a])]).
proof(350, member(c, [b, c, a]), rule(13), [uses(349, member(c, [c, a]))]).
substitution(351, [binding("x", c), binding("rest", [b, c, a])]).
proof(351, member(c, [d, b, c, a]), rule(13), [uses(350, member(c, [b, c, a]))]).
substitution(352, [binding("x", c), binding("rest", [d, b, c, a])]).
proof(352, member(c, [f, d, b, c, a]), rule(13), [uses(351, member(c, [d, b, c, a]))]).
substitution(353, [binding("x", c), binding("rest", [f, d, b, c, a])]).
proof(353, member(c, [e, f, d, b, c, a]), rule(13), [uses(352, member(c, [f, d, b, c, a]))]).
substitution(354, []).
proof(354, solution([]), query, [uses(353, member(c, [e, f, d, b, c, a]))]).
substitution(355, [binding("x", d)]).
proof(355, member(d, [d, b, c, a]), rule(12), []).
substitution(356, [binding("x", d), binding("rest", [d, b, c, a])]).
proof(356, member(d, [f, d, b, c, a]), rule(13), [uses(355, member(d, [d, b, c, a]))]).
substitution(357, [binding("x", d), binding("rest", [f, d, b, c, a])]).
proof(357, member(d, [e, f, d, b, c, a]), rule(13), [uses(356, member(d, [f, d, b, c, a]))]).
substitution(358, []).
proof(358, solution([]), query, [uses(357, member(d, [e, f, d, b, c, a]))]).
substitution(359, [binding("x", f)]).
proof(359, member(f, [f, d, b, c, a]), rule(12), []).
substitution(360, [binding("x", f), binding("rest", [f, d, b, c, a])]).
proof(360, member(f, [e, f, d, b, c, a]), rule(13), [uses(359, member(f, [f, d, b, c, a]))]).
substitution(361, []).
proof(361, solution([]), query, [uses(360, member(f, [e, f, d, b, c, a]))]).
substitution(362, [binding("x", c)]).
proof(362, member(c, [c, a]), rule(12), []).
substitution(363, [binding("x", c), binding("rest", [c, a])]).
proof(363, member(c, [e, c, a]), rule(13), [uses(362, member(c, [c, a]))]).
substitution(364, [binding("x", c), binding("rest", [e, c, a])]).
proof(364, member(c, [f, e, c, a]), rule(13), [uses(363, member(c, [e, c, a]))]).
substitution(365, [binding("x", c), binding("rest", [f, e, c, a])]).
proof(365, member(c, [d, f, e, c, a]), rule(13), [uses(364, member(c, [f, e, c, a]))]).
substitution(366, []).
proof(366, solution([]), query, [uses(365, member(c, [d, f, e, c, a]))]).
substitution(367, [binding("x", e)]).
proof(367, member(e, [e, c, a]), rule(12), []).
substitution(368, [binding("x", e), binding("rest", [e, c, a])]).
proof(368, member(e, [f, e, c, a]), rule(13), [uses(367, member(e, [e, c, a]))]).
substitution(369, [binding("x", e), binding("rest", [f, e, c, a])]).
proof(369, member(e, [d, f, e, c, a]), rule(13), [uses(368, member(e, [f, e, c, a]))]).
substitution(370, []).
proof(370, solution([]), query, [uses(369, member(e, [d, f, e, c, a]))]).
substitution(371, [binding("x", f)]).
proof(371, member(f, [f, e, c, a]), rule(12), []).
substitution(372, [binding("x", f), binding("rest", [f, e, c, a])]).
proof(372, member(f, [d, f, e, c, a]), rule(13), [uses(371, member(f, [f, e, c, a]))]).
substitution(373, []).
proof(373, solution([]), query, [uses(372, member(f, [d, f, e, c, a]))]).
substitution(374, [binding("x", b)]).
proof(374, member(b, [b, a]), rule(12), []).
substitution(375, [binding("x", b), binding("rest", [b, a])]).
proof(375, member(b, [c, b, a]), rule(13), [uses(374, member(b, [b, a]))]).
substitution(376, [binding("x", b), binding("rest", [c, b, a])]).
proof(376, member(b, [e, c, b, a]), rule(13), [uses(375, member(b, [c, b, a]))]).
substitution(377, [binding("x", b), binding("rest", [e, c, b, a])]).
proof(377, member(b, [f, e, c, b, a]), rule(13), [uses(376, member(b, [e, c, b, a]))]).
substitution(378, [binding("x", b), binding("rest", [f, e, c, b, a])]).
proof(378, member(b, [d, f, e, c, b, a]), rule(13), [uses(377, member(b, [f, e, c, b, a]))]).
substitution(379, []).
proof(379, solution([]), query, [uses(378, member(b, [d, f, e, c, b, a]))]).
substitution(380, [binding("x", c)]).
proof(380, member(c, [c, b, a]), rule(12), []).
substitution(381, [binding("x", c), binding("rest", [c, b, a])]).
proof(381, member(c, [e, c, b, a]), rule(13), [uses(380, member(c, [c, b, a]))]).
substitution(382, [binding("x", c), binding("rest", [e, c, b, a])]).
proof(382, member(c, [f, e, c, b, a]), rule(13), [uses(381, member(c, [e, c, b, a]))]).
substitution(383, [binding("x", c), binding("rest", [f, e, c, b, a])]).
proof(383, member(c, [d, f, e, c, b, a]), rule(13), [uses(382, member(c, [f, e, c, b, a]))]).
substitution(384, []).
proof(384, solution([]), query, [uses(383, member(c, [d, f, e, c, b, a]))]).
substitution(385, [binding("x", e)]).
proof(385, member(e, [e, c, b, a]), rule(12), []).
substitution(386, [binding("x", e), binding("rest", [e, c, b, a])]).
proof(386, member(e, [f, e, c, b, a]), rule(13), [uses(385, member(e, [e, c, b, a]))]).
substitution(387, [binding("x", e), binding("rest", [f, e, c, b, a])]).
proof(387, member(e, [d, f, e, c, b, a]), rule(13), [uses(386, member(e, [f, e, c, b, a]))]).
substitution(388, []).
proof(388, solution([]), query, [uses(387, member(e, [d, f, e, c, b, a]))]).
substitution(389, [binding("x", f)]).
proof(389, member(f, [f, e, c, b, a]), rule(12), []).
substitution(390, [binding("x", f), binding("rest", [f, e, c, b, a])]).
proof(390, member(f, [d, f, e, c, b, a]), rule(13), [uses(389, member(f, [f, e, c, b, a]))]).
substitution(391, []).
proof(391, solution([]), query, [uses(390, member(f, [d, f, e, c, b, a]))]).
substitution(392, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, d, e, f]), binding("cost", 14), binding("next", c), binding("step", 1), binding("remaining", 13)]).
proof(392, route(b, f, [b, a], [b, c, d, e, f], 14), rule(15), [uses(13, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(307, route(c, f, [c, b, a], [c, d, e, f], 13)), calculated(14, binary("+", value(1), value(13)))]).
substitution(393, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, e, d, f]), binding("cost", 19), binding("next", c), binding("step", 1), binding("remaining", 18)]).
proof(393, route(b, f, [b, a], [b, c, e, d, f], 19), rule(15), [uses(13, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(308, route(c, f, [c, b, a], [c, e, d, f], 18)), calculated(19, binary("+", value(1), value(18)))]).
substitution(394, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, c, e, f]), binding("cost", 26), binding("next", d), binding("step", 5), binding("remaining", 21)]).
proof(394, route(b, f, [b, a], [b, d, c, e, f], 26), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(317, route(d, f, [d, b, a], [d, c, e, f], 21)), calculated(26, binary("+", value(5), value(21)))]).
substitution(395, [binding("candidate", 19)]).
proof(395, solution([19]), query, [uses(309, route(a, f, [a], [a, b, c, d, f], 19))]).
substitution(396, [binding("candidate", 18)]).
proof(396, solution([18]), query, [uses(310, route(a, f, [a], [a, b, c, e, f], 18))]).
substitution(397, [binding("candidate", 14)]).
proof(397, solution([14]), query, [uses(311, route(a, f, [a], [a, b, d, e, f], 14))]).
substitution(398, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, c, d, e, f]), binding("cost", 18), binding("next", b), binding("step", 4), binding("remaining", 14)]).
proof(398, route(a, f, [a], [a, b, c, d, e, f], 18), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(392, route(b, f, [b, a], [b, c, d, e, f], 14)), calculated(18, binary("+", value(4), value(14)))]).
substitution(399, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, c, e, d, f]), binding("cost", 23), binding("next", b), binding("step", 4), binding("remaining", 19)]).
proof(399, route(a, f, [a], [a, b, c, e, d, f], 23), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(393, route(b, f, [b, a], [b, c, e, d, f], 19)), calculated(23, binary("+", value(4), value(19)))]).
substitution(400, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, d, c, e, f]), binding("cost", 30), binding("next", b), binding("step", 4), binding("remaining", 26)]).
proof(400, route(a, f, [a], [a, b, d, c, e, f], 30), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(394, route(b, f, [b, a], [b, d, c, e, f], 26)), calculated(30, binary("+", value(4), value(26)))]).
substitution(401, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, b, d, e, f]), binding("cost", 13), binding("next", c), binding("step", 2), binding("remaining", 11)]).
proof(401, route(a, f, [a], [a, c, b, d, e, f], 13), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(315, route(c, f, [c, a], [c, b, d, e, f], 11)), calculated(13, binary("+", value(2), value(11)))]).
substitution(402, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, e, d, f]), binding("cost", 20), binding("next", c), binding("step", 2), binding("remaining", 18)]).
proof(402, route(a, f, [a], [a, c, e, d, f], 20), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(316, route(c, f, [c, a], [c, e, d, f], 18)), calculated(20, binary("+", value(2), value(18)))]).
substitution(403, [binding("x", a)]).
proof(403, member(a, [a]), rule(12), []).
substitution(404, [binding("x", a), binding("rest", [a])]).
proof(404, member(a, [b, a]), rule(13), [uses(403, member(a, [a]))]).
substitution(405, [binding("x", a), binding("rest", [b, a])]).
proof(405, member(a, [d, b, a]), rule(13), [uses(404, member(a, [b, a]))]).
substitution(406, [binding("x", a), binding("rest", [d, b, a])]).
proof(406, member(a, [f, d, b, a]), rule(13), [uses(405, member(a, [d, b, a]))]).
substitution(407, [binding("x", a), binding("rest", [f, d, b, a])]).
proof(407, member(a, [e, f, d, b, a]), rule(13), [uses(406, member(a, [f, d, b, a]))]).
substitution(408, [binding("x", a), binding("rest", [e, f, d, b, a])]).
proof(408, member(a, [c, e, f, d, b, a]), rule(13), [uses(407, member(a, [e, f, d, b, a]))]).
substitution(409, []).
proof(409, solution([]), query, [uses(408, member(a, [c, e, f, d, b, a]))]).
substitution(410, [binding("x", b)]).
proof(410, member(b, [b, a]), rule(12), []).
substitution(411, [binding("x", b), binding("rest", [b, a])]).
proof(411, member(b, [d, b, a]), rule(13), [uses(410, member(b, [b, a]))]).
substitution(412, [binding("x", b), binding("rest", [d, b, a])]).
proof(412, member(b, [f, d, b, a]), rule(13), [uses(411, member(b, [d, b, a]))]).
substitution(413, [binding("x", b), binding("rest", [f, d, b, a])]).
proof(413, member(b, [e, f, d, b, a]), rule(13), [uses(412, member(b, [f, d, b, a]))]).
substitution(414, [binding("x", b), binding("rest", [e, f, d, b, a])]).
proof(414, member(b, [c, e, f, d, b, a]), rule(13), [uses(413, member(b, [e, f, d, b, a]))]).
substitution(415, []).
proof(415, solution([]), query, [uses(414, member(b, [c, e, f, d, b, a]))]).
substitution(416, [binding("x", d)]).
proof(416, member(d, [d, b, a]), rule(12), []).
substitution(417, [binding("x", d), binding("rest", [d, b, a])]).
proof(417, member(d, [f, d, b, a]), rule(13), [uses(416, member(d, [d, b, a]))]).
substitution(418, [binding("x", d), binding("rest", [f, d, b, a])]).
proof(418, member(d, [e, f, d, b, a]), rule(13), [uses(417, member(d, [f, d, b, a]))]).
substitution(419, [binding("x", d), binding("rest", [e, f, d, b, a])]).
proof(419, member(d, [c, e, f, d, b, a]), rule(13), [uses(418, member(d, [e, f, d, b, a]))]).
substitution(420, []).
proof(420, solution([]), query, [uses(419, member(d, [c, e, f, d, b, a]))]).
substitution(421, [binding("x", e)]).
proof(421, member(e, [e, f, d, b, a]), rule(12), []).
substitution(422, [binding("x", e), binding("rest", [e, f, d, b, a])]).
proof(422, member(e, [c, e, f, d, b, a]), rule(13), [uses(421, member(e, [e, f, d, b, a]))]).
substitution(423, []).
proof(423, solution([]), query, [uses(422, member(e, [c, e, f, d, b, a]))]).
substitution(424, [binding("x", a)]).
proof(424, member(a, [a]), rule(12), []).
substitution(425, [binding("x", a), binding("rest", [a])]).
proof(425, member(a, [c, a]), rule(13), [uses(424, member(a, [a]))]).
substitution(426, [binding("x", a), binding("rest", [c, a])]).
proof(426, member(a, [e, c, a]), rule(13), [uses(425, member(a, [c, a]))]).
substitution(427, [binding("x", a), binding("rest", [e, c, a])]).
proof(427, member(a, [f, e, c, a]), rule(13), [uses(426, member(a, [e, c, a]))]).
substitution(428, [binding("x", a), binding("rest", [f, e, c, a])]).
proof(428, member(a, [d, f, e, c, a]), rule(13), [uses(427, member(a, [f, e, c, a]))]).
substitution(429, [binding("x", a), binding("rest", [d, f, e, c, a])]).
proof(429, member(a, [b, d, f, e, c, a]), rule(13), [uses(428, member(a, [d, f, e, c, a]))]).
substitution(430, []).
proof(430, solution([]), query, [uses(429, member(a, [b, d, f, e, c, a]))]).
substitution(431, [binding("x", c)]).
proof(431, member(c, [c, a]), rule(12), []).
substitution(432, [binding("x", c), binding("rest", [c, a])]).
proof(432, member(c, [e, c, a]), rule(13), [uses(431, member(c, [c, a]))]).
substitution(433, [binding("x", c), binding("rest", [e, c, a])]).
proof(433, member(c, [f, e, c, a]), rule(13), [uses(432, member(c, [e, c, a]))]).
substitution(434, [binding("x", c), binding("rest", [f, e, c, a])]).
proof(434, member(c, [d, f, e, c, a]), rule(13), [uses(433, member(c, [f, e, c, a]))]).
substitution(435, [binding("x", c), binding("rest", [d, f, e, c, a])]).
proof(435, member(c, [b, d, f, e, c, a]), rule(13), [uses(434, member(c, [d, f, e, c, a]))]).
substitution(436, []).
proof(436, solution([]), query, [uses(435, member(c, [b, d, f, e, c, a]))]).
substitution(437, [binding("x", d)]).
proof(437, member(d, [d, f, e, c, a]), rule(12), []).
substitution(438, [binding("x", d), binding("rest", [d, f, e, c, a])]).
proof(438, member(d, [b, d, f, e, c, a]), rule(13), [uses(437, member(d, [d, f, e, c, a]))]).
substitution(439, []).
proof(439, solution([]), query, [uses(438, member(d, [b, d, f, e, c, a]))]).
substitution(440, [binding("candidate", 23)]).
proof(440, solution([23]), query, [uses(399, route(a, f, [a], [a, b, c, e, d, f], 23))]).
substitution(441, [binding("candidate", 30)]).
proof(441, solution([30]), query, [uses(400, route(a, f, [a], [a, b, d, c, e, f], 30))]).
substitution(442, [binding("candidate", 13)]).
proof(442, solution([13]), query, [uses(401, route(a, f, [a], [a, c, b, d, e, f], 13))]).
substitution(443, [binding("candidate", 20)]).
proof(443, solution([20]), query, [uses(402, route(a, f, [a], [a, c, e, d, f], 20))]).
substitution(444, []).
proof(444, edge(a, b, 4), rule(1), []).
substitution(445, []).
proof(445, edge(a, c, 2), rule(2), []).
substitution(446, [binding("left", a), binding("right", b), binding("weight", 4)]).
proof(446, connected(a, b, 4), rule(11), [uses(444, edge(a, b, 4))]).
substitution(447, [binding("left", a), binding("right", c), binding("weight", 2)]).
proof(447, connected(a, c, 2), rule(11), [uses(445, edge(a, c, 2))]).
substitution(448, []).
proof(448, edge(a, b, 4), rule(1), []).
substitution(449, []).
proof(449, edge(b, c, 1), rule(3), []).
substitution(450, []).
proof(450, edge(b, d, 5), rule(4), []).
substitution(451, []).
proof(451, edge(a, c, 2), rule(2), []).
substitution(452, []).
proof(452, edge(b, c, 1), rule(3), []).
substitution(453, []).
proof(453, edge(c, d, 8), rule(5), []).
substitution(454, []).
proof(454, edge(c, e, 10), rule(6), []).
substitution(455, [binding("right", b), binding("left", a), binding("weight", 4)]).
proof(455, connected(b, a, 4), rule(10), [uses(448, edge(a, b, 4))]).
substitution(456, [binding("left", b), binding("right", c), binding("weight", 1)]).
proof(456, connected(b, c, 1), rule(11), [uses(449, edge(b, c, 1))]).
substitution(457, [binding("left", b), binding("right", d), binding("weight", 5)]).
proof(457, connected(b, d, 5), rule(11), [uses(450, edge(b, d, 5))]).
substitution(458, [binding("right", c), binding("left", a), binding("weight", 2)]).
proof(458, connected(c, a, 2), rule(10), [uses(451, edge(a, c, 2))]).
substitution(459, [binding("right", c), binding("left", b), binding("weight", 1)]).
proof(459, connected(c, b, 1), rule(10), [uses(452, edge(b, c, 1))]).
substitution(460, [binding("left", c), binding("right", d), binding("weight", 8)]).
proof(460, connected(c, d, 8), rule(11), [uses(453, edge(c, d, 8))]).
substitution(461, [binding("left", c), binding("right", e), binding("weight", 10)]).
proof(461, connected(c, e, 10), rule(11), [uses(454, edge(c, e, 10))]).
substitution(462, []).
proof(462, edge(b, d, 5), rule(4), []).
substitution(463, []).
proof(463, edge(c, d, 8), rule(5), []).
substitution(464, []).
proof(464, edge(d, e, 2), rule(7), []).
substitution(465, []).
proof(465, edge(d, f, 6), rule(8), []).
substitution(466, []).
proof(466, edge(c, e, 10), rule(6), []).
substitution(467, []).
proof(467, edge(d, e, 2), rule(7), []).
substitution(468, []).
proof(468, edge(e, f, 3), rule(9), []).
substitution(469, [binding("right", d), binding("left", b), binding("weight", 5)]).
proof(469, connected(d, b, 5), rule(10), [uses(462, edge(b, d, 5))]).
substitution(470, [binding("right", d), binding("left", c), binding("weight", 8)]).
proof(470, connected(d, c, 8), rule(10), [uses(463, edge(c, d, 8))]).
substitution(471, [binding("left", d), binding("right", e), binding("weight", 2)]).
proof(471, connected(d, e, 2), rule(11), [uses(464, edge(d, e, 2))]).
substitution(472, [binding("left", d), binding("right", f), binding("weight", 6)]).
proof(472, connected(d, f, 6), rule(11), [uses(465, edge(d, f, 6))]).
substitution(473, [binding("right", e), binding("left", c), binding("weight", 10)]).
proof(473, connected(e, c, 10), rule(10), [uses(466, edge(c, e, 10))]).
substitution(474, [binding("right", e), binding("left", d), binding("weight", 2)]).
proof(474, connected(e, d, 2), rule(10), [uses(467, edge(d, e, 2))]).
substitution(475, [binding("left", e), binding("right", f), binding("weight", 3)]).
proof(475, connected(e, f, 3), rule(11), [uses(468, edge(e, f, 3))]).
substitution(476, [binding("goal", f)]).
proof(476, route(f, f, [f, d, b, a], [f], 0), rule(14), []).
substitution(477, [binding("goal", f)]).
proof(477, route(f, f, [f, d, c, a], [f], 0), rule(14), []).
substitution(478, [binding("goal", f)]).
proof(478, route(f, f, [f, d, c, b, a], [f], 0), rule(14), []).
substitution(479, [binding("goal", f)]).
proof(479, route(f, f, [f, d, b, c, a], [f], 0), rule(14), []).
substitution(480, [binding("goal", f)]).
proof(480, route(f, f, [f, e, c, a], [f], 0), rule(14), []).
substitution(481, [binding("goal", f)]).
proof(481, route(f, f, [f, e, c, b, a], [f], 0), rule(14), []).
substitution(482, [binding("goal", f)]).
proof(482, route(f, f, [f, e, d, b, a], [f], 0), rule(14), []).
substitution(483, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(483, route(d, f, [d, b, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, b, a]), complete), uses(476, route(f, f, [f, d, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(484, [binding("goal", f)]).
proof(484, route(f, f, [f, e, d, c, a], [f], 0), rule(14), []).
substitution(485, [binding("from", d), binding("goal", f), binding("visited", [d, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(485, route(d, f, [d, c, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, c, a]), complete), uses(477, route(f, f, [f, d, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(486, [binding("goal", f)]).
proof(486, route(f, f, [f, e, d, c, b, a], [f], 0), rule(14), []).
substitution(487, [binding("from", d), binding("goal", f), binding("visited", [d, c, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(487, route(d, f, [d, c, b, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, c, b, a]), complete), uses(478, route(f, f, [f, d, c, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(488, [binding("goal", f)]).
proof(488, route(f, f, [f, e, d, b, c, a], [f], 0), rule(14), []).
substitution(489, [binding("from", d), binding("goal", f), binding("visited", [d, b, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(489, route(d, f, [d, b, c, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, b, c, a]), complete), uses(479, route(f, f, [f, d, b, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(490, [binding("goal", f)]).
proof(490, route(f, f, [f, d, e, c, a], [f], 0), rule(14), []).
substitution(491, [binding("from", e), binding("goal", f), binding("visited", [e, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(491, route(e, f, [e, c, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, c, a]), complete), uses(480, route(f, f, [f, e, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(492, [binding("goal", f)]).
proof(492, route(f, f, [f, d, e, c, b, a], [f], 0), rule(14), []).
substitution(493, [binding("from", e), binding("goal", f), binding("visited", [e, c, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(493, route(e, f, [e, c, b, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, c, b, a]), complete), uses(481, route(f, f, [f, e, c, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(494, [binding("goal", f)]).
proof(494, route(f, f, [f, e, c, d, b, a], [f], 0), rule(14), []).
substitution(495, [binding("from", e), binding("goal", f), binding("visited", [e, d, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(495, route(e, f, [e, d, b, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, d, b, a]), complete), uses(482, route(f, f, [f, e, d, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(496, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, f]), binding("cost", 11), binding("next", d), binding("step", 5), binding("remaining", 6)]).
proof(496, route(b, f, [b, a], [b, d, f], 11), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(483, route(d, f, [d, b, a], [d, f], 6)), calculated(11, binary("+", value(5), value(6)))]).
substitution(497, []).
proof(497, edge(d, f, 6), rule(8), []).
substitution(498, []).
proof(498, edge(e, f, 3), rule(9), []).
substitution(499, [binding("from", e), binding("goal", f), binding("visited", [e, d, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(499, route(e, f, [e, d, c, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, d, c, a]), complete), uses(484, route(f, f, [f, e, d, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(500, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [d, f]), binding("cost", 14), binding("next", d), binding("step", 8), binding("remaining", 6)]).
proof(500, route(c, f, [c, a], [c, d, f], 14), rule(15), [uses(460, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(485, route(d, f, [d, c, a], [d, f], 6)), calculated(14, binary("+", value(8), value(6)))]).
substitution(501, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(501, route(c, f, [c, a], [c, e, f], 13), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(491, route(e, f, [e, c, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(502, [binding("from", e), binding("goal", f), binding("visited", [e, d, c, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(502, route(e, f, [e, d, c, b, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, d, c, b, a]), complete), uses(486, route(f, f, [f, e, d, c, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(503, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [d, f]), binding("cost", 14), binding("next", d), binding("step", 8), binding("remaining", 6)]).
proof(503, route(c, f, [c, b, a], [c, d, f], 14), rule(15), [uses(460, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(487, route(d, f, [d, c, b, a], [d, f], 6)), calculated(14, binary("+", value(8), value(6)))]).
substitution(504, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(504, route(c, f, [c, b, a], [c, e, f], 13), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(493, route(e, f, [e, c, b, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(505, [binding("from", e), binding("goal", f), binding("visited", [e, d, b, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(505, route(e, f, [e, d, b, c, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, d, b, c, a]), complete), uses(488, route(f, f, [f, e, d, b, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(506, [binding("from", b), binding("goal", f), binding("visited", [b, c, a]), binding("path", [d, f]), binding("cost", 11), binding("next", d), binding("step", 5), binding("remaining", 6)]).
proof(506, route(b, f, [b, c, a], [b, d, f], 11), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(489, route(d, f, [d, b, c, a], [d, f], 6)), calculated(11, binary("+", value(5), value(6)))]).
substitution(507, [binding("from", d), binding("goal", f), binding("visited", [d, e, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(507, route(d, f, [d, e, c, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, e, c, a]), complete), uses(490, route(f, f, [f, d, e, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(508, [binding("from", d), binding("goal", f), binding("visited", [d, e, c, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(508, route(d, f, [d, e, c, b, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, e, c, b, a]), complete), uses(492, route(f, f, [f, d, e, c, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(509, [binding("from", e), binding("goal", f), binding("visited", [e, c, d, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(509, route(e, f, [e, c, d, b, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, c, d, b, a]), complete), uses(494, route(f, f, [f, e, c, d, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(510, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(510, route(d, f, [d, b, a], [d, e, f], 5), rule(15), [uses(471, connected(d, e, 2)), absent(member(e, [d, b, a]), complete), uses(495, route(e, f, [e, d, b, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(511, [binding("right", f), binding("left", d), binding("weight", 6)]).
proof(511, connected(f, d, 6), rule(10), [uses(497, edge(d, f, 6))]).
substitution(512, [binding("right", f), binding("left", e), binding("weight", 3)]).
proof(512, connected(f, e, 3), rule(10), [uses(498, edge(e, f, 3))]).
substitution(513, [binding("from", d), binding("goal", f), binding("visited", [d, c, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(513, route(d, f, [d, c, a], [d, e, f], 5), rule(15), [uses(471, connected(d, e, 2)), absent(member(e, [d, c, a]), complete), uses(499, route(e, f, [e, d, c, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(514, [binding("from", d), binding("goal", f), binding("visited", [d, c, b, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(514, route(d, f, [d, c, b, a], [d, e, f], 5), rule(15), [uses(471, connected(d, e, 2)), absent(member(e, [d, c, b, a]), complete), uses(502, route(e, f, [e, d, c, b, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(515, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, d, f]), binding("cost", 15), binding("next", c), binding("step", 1), binding("remaining", 14)]).
proof(515, route(b, f, [b, a], [b, c, d, f], 15), rule(15), [uses(456, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(503, route(c, f, [c, b, a], [c, d, f], 14)), calculated(15, binary("+", value(1), value(14)))]).
substitution(516, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, e, f]), binding("cost", 14), binding("next", c), binding("step", 1), binding("remaining", 13)]).
proof(516, route(b, f, [b, a], [b, c, e, f], 14), rule(15), [uses(456, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(504, route(c, f, [c, b, a], [c, e, f], 13)), calculated(14, binary("+", value(1), value(13)))]).
substitution(517, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, e, f]), binding("cost", 10), binding("next", d), binding("step", 5), binding("remaining", 5)]).
proof(517, route(b, f, [b, a], [b, d, e, f], 10), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(510, route(d, f, [d, b, a], [d, e, f], 5)), calculated(10, binary("+", value(5), value(5)))]).
substitution(518, [binding("from", d), binding("goal", f), binding("visited", [d, b, c, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(518, route(d, f, [d, b, c, a], [d, e, f], 5), rule(15), [uses(471, connected(d, e, 2)), absent(member(e, [d, b, c, a]), complete), uses(505, route(e, f, [e, d, b, c, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(519, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [b, d, f]), binding("cost", 12), binding("next", b), binding("step", 1), binding("remaining", 11)]).
proof(519, route(c, f, [c, a], [c, b, d, f], 12), rule(15), [uses(459, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(506, route(b, f, [b, c, a], [b, d, f], 11)), calculated(12, binary("+", value(1), value(11)))]).
substitution(520, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [d, e, f]), binding("cost", 13), binding("next", d), binding("step", 8), binding("remaining", 5)]).
proof(520, route(c, f, [c, a], [c, d, e, f], 13), rule(15), [uses(460, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(513, route(d, f, [d, c, a], [d, e, f], 5)), calculated(13, binary("+", value(8), value(5)))]).
substitution(521, [binding("from", e), binding("goal", f), binding("visited", [e, c, a]), binding("path", [d, f]), binding("cost", 8), binding("next", d), binding("step", 2), binding("remaining", 6)]).
proof(521, route(e, f, [e, c, a], [e, d, f], 8), rule(15), [uses(474, connected(e, d, 2)), absent(member(d, [e, c, a]), complete), uses(507, route(d, f, [d, e, c, a], [d, f], 6)), calculated(8, binary("+", value(2), value(6)))]).
substitution(522, [binding("from", e), binding("goal", f), binding("visited", [e, c, b, a]), binding("path", [d, f]), binding("cost", 8), binding("next", d), binding("step", 2), binding("remaining", 6)]).
proof(522, route(e, f, [e, c, b, a], [e, d, f], 8), rule(15), [uses(474, connected(e, d, 2)), absent(member(d, [e, c, b, a]), complete), uses(508, route(d, f, [d, e, c, b, a], [d, f], 6)), calculated(8, binary("+", value(2), value(6)))]).
substitution(523, [binding("from", c), binding("goal", f), binding("visited", [c, d, b, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(523, route(c, f, [c, d, b, a], [c, e, f], 13), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, d, b, a]), complete), uses(509, route(e, f, [e, c, d, b, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(524, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [d, e, f]), binding("cost", 13), binding("next", d), binding("step", 8), binding("remaining", 5)]).
proof(524, route(c, f, [c, b, a], [c, d, e, f], 13), rule(15), [uses(460, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(514, route(d, f, [d, c, b, a], [d, e, f], 5)), calculated(13, binary("+", value(8), value(5)))]).
substitution(525, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [e, d, f]), binding("cost", 18), binding("next", e), binding("step", 10), binding("remaining", 8)]).
proof(525, route(c, f, [c, b, a], [c, e, d, f], 18), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(522, route(e, f, [e, c, b, a], [e, d, f], 8)), calculated(18, binary("+", value(10), value(8)))]).
substitution(526, [binding("from", b), binding("goal", f), binding("visited", [b, c, a]), binding("path", [d, e, f]), binding("cost", 10), binding("next", d), binding("step", 5), binding("remaining", 5)]).
proof(526, route(b, f, [b, c, a], [b, d, e, f], 10), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(518, route(d, f, [d, b, c, a], [d, e, f], 5)), calculated(10, binary("+", value(5), value(5)))]).
substitution(527, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [b, d, e, f]), binding("cost", 11), binding("next", b), binding("step", 1), binding("remaining", 10)]).
proof(527, route(c, f, [c, a], [c, b, d, e, f], 11), rule(15), [uses(459, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(526, route(b, f, [b, c, a], [b, d, e, f], 10)), calculated(11, binary("+", value(1), value(10)))]).
substitution(528, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [e, d, f]), binding("cost", 18), binding("next", e), binding("step", 10), binding("remaining", 8)]).
proof(528, route(c, f, [c, a], [c, e, d, f], 18), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(521, route(e, f, [e, c, a], [e, d, f], 8)), calculated(18, binary("+", value(10), value(8)))]).
substitution(529, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [c, e, f]), binding("cost", 21), binding("next", c), binding("step", 8), binding("remaining", 13)]).
proof(529, route(d, f, [d, b, a], [d, c, e, f], 21), rule(15), [uses(470, connected(d, c, 8)), absent(member(c, [d, b, a]), complete), uses(523, route(c, f, [c, d, b, a], [c, e, f], 13)), calculated(21, binary("+", value(8), value(13)))]).
substitution(530, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, d, e, f]), binding("cost", 14), binding("next", c), binding("step", 1), binding("remaining", 13)]).
proof(530, route(b, f, [b, a], [b, c, d, e, f], 14), rule(15), [uses(456, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(524, route(c, f, [c, b, a], [c, d, e, f], 13)), calculated(14, binary("+", value(1), value(13)))]).
substitution(531, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, e, d, f]), binding("cost", 19), binding("next", c), binding("step", 1), binding("remaining", 18)]).
proof(531, route(b, f, [b, a], [b, c, e, d, f], 19), rule(15), [uses(456, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(525, route(c, f, [c, b, a], [c, e, d, f], 18)), calculated(19, binary("+", value(1), value(18)))]).
substitution(532, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, c, e, f]), binding("cost", 26), binding("next", d), binding("step", 5), binding("remaining", 21)]).
proof(532, route(b, f, [b, a], [b, d, c, e, f], 26), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(529, route(d, f, [d, b, a], [d, c, e, f], 21)), calculated(26, binary("+", value(5), value(21)))]).
substitution(533, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, b, d, e, f]), binding("cost", 13), binding("next", c), binding("step", 2), binding("remaining", 11)]).
proof(533, route(a, f, [a], [a, c, b, d, e, f], 13), rule(15), [uses(447, connected(a, c, 2)), absent(member(c, [a]), complete), uses(527, route(c, f, [c, a], [c, b, d, e, f], 11)), calculated(13, binary("+", value(2), value(11)))]).
substitution(534, []).
proof(534, edge(a, b, 4), rule(1), []).
substitution(535, []).
proof(535, edge(a, c, 2), rule(2), []).
substitution(536, [binding("left", a), binding("right", b), binding("weight", 4)]).
proof(536, connected(a, b, 4), rule(11), [uses(534, edge(a, b, 4))]).
substitution(537, [binding("left", a), binding("right", c), binding("weight", 2)]).
proof(537, connected(a, c, 2), rule(11), [uses(535, edge(a, c, 2))]).
substitution(538, []).
proof(538, edge(a, b, 4), rule(1), []).
substitution(539, []).
proof(539, edge(b, c, 1), rule(3), []).
substitution(540, []).
proof(540, edge(b, d, 5), rule(4), []).
substitution(541, []).
proof(541, edge(a, c, 2), rule(2), []).
substitution(542, []).
proof(542, edge(b, c, 1), rule(3), []).
substitution(543, []).
proof(543, edge(c, d, 8), rule(5), []).
substitution(544, []).
proof(544, edge(c, e, 10), rule(6), []).
substitution(545, [binding("right", b), binding("left", a), binding("weight", 4)]).
proof(545, connected(b, a, 4), rule(10), [uses(538, edge(a, b, 4))]).
substitution(546, [binding("left", b), binding("right", c), binding("weight", 1)]).
proof(546, connected(b, c, 1), rule(11), [uses(539, edge(b, c, 1))]).
substitution(547, [binding("left", b), binding("right", d), binding("weight", 5)]).
proof(547, connected(b, d, 5), rule(11), [uses(540, edge(b, d, 5))]).
substitution(548, [binding("right", c), binding("left", a), binding("weight", 2)]).
proof(548, connected(c, a, 2), rule(10), [uses(541, edge(a, c, 2))]).
substitution(549, [binding("right", c), binding("left", b), binding("weight", 1)]).
proof(549, connected(c, b, 1), rule(10), [uses(542, edge(b, c, 1))]).
substitution(550, [binding("left", c), binding("right", d), binding("weight", 8)]).
proof(550, connected(c, d, 8), rule(11), [uses(543, edge(c, d, 8))]).
substitution(551, [binding("left", c), binding("right", e), binding("weight", 10)]).
proof(551, connected(c, e, 10), rule(11), [uses(544, edge(c, e, 10))]).
substitution(552, []).
proof(552, edge(b, d, 5), rule(4), []).
substitution(553, []).
proof(553, edge(c, d, 8), rule(5), []).
substitution(554, []).
proof(554, edge(d, e, 2), rule(7), []).
substitution(555, []).
proof(555, edge(d, f, 6), rule(8), []).
substitution(556, []).
proof(556, edge(c, e, 10), rule(6), []).
substitution(557, []).
proof(557, edge(d, e, 2), rule(7), []).
substitution(558, []).
proof(558, edge(e, f, 3), rule(9), []).
substitution(559, [binding("right", d), binding("left", b), binding("weight", 5)]).
proof(559, connected(d, b, 5), rule(10), [uses(552, edge(b, d, 5))]).
substitution(560, [binding("right", d), binding("left", c), binding("weight", 8)]).
proof(560, connected(d, c, 8), rule(10), [uses(553, edge(c, d, 8))]).
substitution(561, [binding("left", d), binding("right", e), binding("weight", 2)]).
proof(561, connected(d, e, 2), rule(11), [uses(554, edge(d, e, 2))]).
substitution(562, [binding("left", d), binding("right", f), binding("weight", 6)]).
proof(562, connected(d, f, 6), rule(11), [uses(555, edge(d, f, 6))]).
substitution(563, [binding("right", e), binding("left", c), binding("weight", 10)]).
proof(563, connected(e, c, 10), rule(10), [uses(556, edge(c, e, 10))]).
substitution(564, [binding("right", e), binding("left", d), binding("weight", 2)]).
proof(564, connected(e, d, 2), rule(10), [uses(557, edge(d, e, 2))]).
substitution(565, [binding("left", e), binding("right", f), binding("weight", 3)]).
proof(565, connected(e, f, 3), rule(11), [uses(558, edge(e, f, 3))]).
substitution(566, [binding("goal", f)]).
proof(566, route(f, f, [f, d, b, a], [f], 0), rule(14), []).
substitution(567, [binding("goal", f)]).
proof(567, route(f, f, [f, d, c, a], [f], 0), rule(14), []).
substitution(568, [binding("goal", f)]).
proof(568, route(f, f, [f, d, c, b, a], [f], 0), rule(14), []).
substitution(569, [binding("goal", f)]).
proof(569, route(f, f, [f, d, b, c, a], [f], 0), rule(14), []).
substitution(570, [binding("goal", f)]).
proof(570, route(f, f, [f, e, c, a], [f], 0), rule(14), []).
substitution(571, [binding("goal", f)]).
proof(571, route(f, f, [f, e, c, b, a], [f], 0), rule(14), []).
substitution(572, [binding("goal", f)]).
proof(572, route(f, f, [f, e, d, b, a], [f], 0), rule(14), []).
substitution(573, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(573, route(d, f, [d, b, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, b, a]), complete), uses(566, route(f, f, [f, d, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(574, [binding("goal", f)]).
proof(574, route(f, f, [f, e, d, c, a], [f], 0), rule(14), []).
substitution(575, [binding("from", d), binding("goal", f), binding("visited", [d, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(575, route(d, f, [d, c, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, c, a]), complete), uses(567, route(f, f, [f, d, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(576, [binding("goal", f)]).
proof(576, route(f, f, [f, e, d, c, b, a], [f], 0), rule(14), []).
substitution(577, [binding("from", d), binding("goal", f), binding("visited", [d, c, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(577, route(d, f, [d, c, b, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, c, b, a]), complete), uses(568, route(f, f, [f, d, c, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(578, [binding("goal", f)]).
proof(578, route(f, f, [f, e, d, b, c, a], [f], 0), rule(14), []).
substitution(579, [binding("from", d), binding("goal", f), binding("visited", [d, b, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(579, route(d, f, [d, b, c, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, b, c, a]), complete), uses(569, route(f, f, [f, d, b, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(580, [binding("goal", f)]).
proof(580, route(f, f, [f, d, e, c, a], [f], 0), rule(14), []).
substitution(581, [binding("from", e), binding("goal", f), binding("visited", [e, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(581, route(e, f, [e, c, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, c, a]), complete), uses(570, route(f, f, [f, e, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(582, [binding("goal", f)]).
proof(582, route(f, f, [f, d, e, c, b, a], [f], 0), rule(14), []).
substitution(583, [binding("from", e), binding("goal", f), binding("visited", [e, c, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(583, route(e, f, [e, c, b, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, c, b, a]), complete), uses(571, route(f, f, [f, e, c, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(584, [binding("goal", f)]).
proof(584, route(f, f, [f, e, c, d, b, a], [f], 0), rule(14), []).
substitution(585, [binding("from", e), binding("goal", f), binding("visited", [e, d, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(585, route(e, f, [e, d, b, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, d, b, a]), complete), uses(572, route(f, f, [f, e, d, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(586, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, f]), binding("cost", 11), binding("next", d), binding("step", 5), binding("remaining", 6)]).
proof(586, route(b, f, [b, a], [b, d, f], 11), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(573, route(d, f, [d, b, a], [d, f], 6)), calculated(11, binary("+", value(5), value(6)))]).
substitution(587, []).
proof(587, edge(d, f, 6), rule(8), []).
substitution(588, []).
proof(588, edge(e, f, 3), rule(9), []).
substitution(589, [binding("from", e), binding("goal", f), binding("visited", [e, d, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(589, route(e, f, [e, d, c, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, d, c, a]), complete), uses(574, route(f, f, [f, e, d, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(590, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [d, f]), binding("cost", 14), binding("next", d), binding("step", 8), binding("remaining", 6)]).
proof(590, route(c, f, [c, a], [c, d, f], 14), rule(15), [uses(550, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(575, route(d, f, [d, c, a], [d, f], 6)), calculated(14, binary("+", value(8), value(6)))]).
substitution(591, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(591, route(c, f, [c, a], [c, e, f], 13), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(581, route(e, f, [e, c, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(592, [binding("from", e), binding("goal", f), binding("visited", [e, d, c, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(592, route(e, f, [e, d, c, b, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, d, c, b, a]), complete), uses(576, route(f, f, [f, e, d, c, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(593, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [d, f]), binding("cost", 14), binding("next", d), binding("step", 8), binding("remaining", 6)]).
proof(593, route(c, f, [c, b, a], [c, d, f], 14), rule(15), [uses(550, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(577, route(d, f, [d, c, b, a], [d, f], 6)), calculated(14, binary("+", value(8), value(6)))]).
substitution(594, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(594, route(c, f, [c, b, a], [c, e, f], 13), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(583, route(e, f, [e, c, b, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(595, [binding("from", e), binding("goal", f), binding("visited", [e, d, b, c, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(595, route(e, f, [e, d, b, c, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, d, b, c, a]), complete), uses(578, route(f, f, [f, e, d, b, c, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(596, [binding("from", b), binding("goal", f), binding("visited", [b, c, a]), binding("path", [d, f]), binding("cost", 11), binding("next", d), binding("step", 5), binding("remaining", 6)]).
proof(596, route(b, f, [b, c, a], [b, d, f], 11), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(579, route(d, f, [d, b, c, a], [d, f], 6)), calculated(11, binary("+", value(5), value(6)))]).
substitution(597, [binding("from", d), binding("goal", f), binding("visited", [d, e, c, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(597, route(d, f, [d, e, c, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, e, c, a]), complete), uses(580, route(f, f, [f, d, e, c, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(598, [binding("from", d), binding("goal", f), binding("visited", [d, e, c, b, a]), binding("path", [f]), binding("cost", 6), binding("next", f), binding("step", 6), binding("remaining", 0)]).
proof(598, route(d, f, [d, e, c, b, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, e, c, b, a]), complete), uses(582, route(f, f, [f, d, e, c, b, a], [f], 0)), calculated(6, binary("+", value(6), value(0)))]).
substitution(599, [binding("from", e), binding("goal", f), binding("visited", [e, c, d, b, a]), binding("path", [f]), binding("cost", 3), binding("next", f), binding("step", 3), binding("remaining", 0)]).
proof(599, route(e, f, [e, c, d, b, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, c, d, b, a]), complete), uses(584, route(f, f, [f, e, c, d, b, a], [f], 0)), calculated(3, binary("+", value(3), value(0)))]).
substitution(600, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(600, route(d, f, [d, b, a], [d, e, f], 5), rule(15), [uses(561, connected(d, e, 2)), absent(member(e, [d, b, a]), complete), uses(585, route(e, f, [e, d, b, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(601, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, d, f]), binding("cost", 15), binding("next", b), binding("step", 4), binding("remaining", 11)]).
proof(601, route(a, f, [a], [a, b, d, f], 15), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(586, route(b, f, [b, a], [b, d, f], 11)), calculated(15, binary("+", value(4), value(11)))]).
substitution(602, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, d, f]), binding("cost", 16), binding("next", c), binding("step", 2), binding("remaining", 14)]).
proof(602, route(a, f, [a], [a, c, d, f], 16), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(590, route(c, f, [c, a], [c, d, f], 14)), calculated(16, binary("+", value(2), value(14)))]).
substitution(603, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, e, f]), binding("cost", 15), binding("next", c), binding("step", 2), binding("remaining", 13)]).
proof(603, route(a, f, [a], [a, c, e, f], 15), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(591, route(c, f, [c, a], [c, e, f], 13)), calculated(15, binary("+", value(2), value(13)))]).
substitution(604, [binding("right", f), binding("left", d), binding("weight", 6)]).
proof(604, connected(f, d, 6), rule(10), [uses(587, edge(d, f, 6))]).
substitution(605, [binding("right", f), binding("left", e), binding("weight", 3)]).
proof(605, connected(f, e, 3), rule(10), [uses(588, edge(e, f, 3))]).
substitution(606, [binding("from", d), binding("goal", f), binding("visited", [d, c, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(606, route(d, f, [d, c, a], [d, e, f], 5), rule(15), [uses(561, connected(d, e, 2)), absent(member(e, [d, c, a]), complete), uses(589, route(e, f, [e, d, c, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(607, [binding("from", d), binding("goal", f), binding("visited", [d, c, b, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(607, route(d, f, [d, c, b, a], [d, e, f], 5), rule(15), [uses(561, connected(d, e, 2)), absent(member(e, [d, c, b, a]), complete), uses(592, route(e, f, [e, d, c, b, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(608, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, d, f]), binding("cost", 15), binding("next", c), binding("step", 1), binding("remaining", 14)]).
proof(608, route(b, f, [b, a], [b, c, d, f], 15), rule(15), [uses(546, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(593, route(c, f, [c, b, a], [c, d, f], 14)), calculated(15, binary("+", value(1), value(14)))]).
substitution(609, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, e, f]), binding("cost", 14), binding("next", c), binding("step", 1), binding("remaining", 13)]).
proof(609, route(b, f, [b, a], [b, c, e, f], 14), rule(15), [uses(546, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(594, route(c, f, [c, b, a], [c, e, f], 13)), calculated(14, binary("+", value(1), value(13)))]).
substitution(610, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, e, f]), binding("cost", 10), binding("next", d), binding("step", 5), binding("remaining", 5)]).
proof(610, route(b, f, [b, a], [b, d, e, f], 10), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(600, route(d, f, [d, b, a], [d, e, f], 5)), calculated(10, binary("+", value(5), value(5)))]).
substitution(611, [binding("from", d), binding("goal", f), binding("visited", [d, b, c, a]), binding("path", [e, f]), binding("cost", 5), binding("next", e), binding("step", 2), binding("remaining", 3)]).
proof(611, route(d, f, [d, b, c, a], [d, e, f], 5), rule(15), [uses(561, connected(d, e, 2)), absent(member(e, [d, b, c, a]), complete), uses(595, route(e, f, [e, d, b, c, a], [e, f], 3)), calculated(5, binary("+", value(2), value(3)))]).
substitution(612, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [b, d, f]), binding("cost", 12), binding("next", b), binding("step", 1), binding("remaining", 11)]).
proof(612, route(c, f, [c, a], [c, b, d, f], 12), rule(15), [uses(549, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(596, route(b, f, [b, c, a], [b, d, f], 11)), calculated(12, binary("+", value(1), value(11)))]).
substitution(613, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [d, e, f]), binding("cost", 13), binding("next", d), binding("step", 8), binding("remaining", 5)]).
proof(613, route(c, f, [c, a], [c, d, e, f], 13), rule(15), [uses(550, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(606, route(d, f, [d, c, a], [d, e, f], 5)), calculated(13, binary("+", value(8), value(5)))]).
substitution(614, [binding("from", e), binding("goal", f), binding("visited", [e, c, a]), binding("path", [d, f]), binding("cost", 8), binding("next", d), binding("step", 2), binding("remaining", 6)]).
proof(614, route(e, f, [e, c, a], [e, d, f], 8), rule(15), [uses(564, connected(e, d, 2)), absent(member(d, [e, c, a]), complete), uses(597, route(d, f, [d, e, c, a], [d, f], 6)), calculated(8, binary("+", value(2), value(6)))]).
substitution(615, [binding("from", e), binding("goal", f), binding("visited", [e, c, b, a]), binding("path", [d, f]), binding("cost", 8), binding("next", d), binding("step", 2), binding("remaining", 6)]).
proof(615, route(e, f, [e, c, b, a], [e, d, f], 8), rule(15), [uses(564, connected(e, d, 2)), absent(member(d, [e, c, b, a]), complete), uses(598, route(d, f, [d, e, c, b, a], [d, f], 6)), calculated(8, binary("+", value(2), value(6)))]).
substitution(616, [binding("from", c), binding("goal", f), binding("visited", [c, d, b, a]), binding("path", [e, f]), binding("cost", 13), binding("next", e), binding("step", 10), binding("remaining", 3)]).
proof(616, route(c, f, [c, d, b, a], [c, e, f], 13), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, d, b, a]), complete), uses(599, route(e, f, [e, c, d, b, a], [e, f], 3)), calculated(13, binary("+", value(10), value(3)))]).
substitution(617, [binding("candidate", 15)]).
proof(617, solution([15]), query, [uses(601, route(a, f, [a], [a, b, d, f], 15))]).
substitution(618, [binding("candidate", 16)]).
proof(618, solution([16]), query, [uses(602, route(a, f, [a], [a, c, d, f], 16))]).
substitution(619, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [d, e, f]), binding("cost", 13), binding("next", d), binding("step", 8), binding("remaining", 5)]).
proof(619, route(c, f, [c, b, a], [c, d, e, f], 13), rule(15), [uses(550, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(607, route(d, f, [d, c, b, a], [d, e, f], 5)), calculated(13, binary("+", value(8), value(5)))]).
substitution(620, [binding("from", c), binding("goal", f), binding("visited", [c, b, a]), binding("path", [e, d, f]), binding("cost", 18), binding("next", e), binding("step", 10), binding("remaining", 8)]).
proof(620, route(c, f, [c, b, a], [c, e, d, f], 18), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(615, route(e, f, [e, c, b, a], [e, d, f], 8)), calculated(18, binary("+", value(10), value(8)))]).
substitution(621, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, c, d, f]), binding("cost", 19), binding("next", b), binding("step", 4), binding("remaining", 15)]).
proof(621, route(a, f, [a], [a, b, c, d, f], 19), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(608, route(b, f, [b, a], [b, c, d, f], 15)), calculated(19, binary("+", value(4), value(15)))]).
substitution(622, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, c, e, f]), binding("cost", 18), binding("next", b), binding("step", 4), binding("remaining", 14)]).
proof(622, route(a, f, [a], [a, b, c, e, f], 18), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(609, route(b, f, [b, a], [b, c, e, f], 14)), calculated(18, binary("+", value(4), value(14)))]).
substitution(623, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, d, e, f]), binding("cost", 14), binding("next", b), binding("step", 4), binding("remaining", 10)]).
proof(623, route(a, f, [a], [a, b, d, e, f], 14), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(610, route(b, f, [b, a], [b, d, e, f], 10)), calculated(14, binary("+", value(4), value(10)))]).
substitution(624, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, b, d, f]), binding("cost", 14), binding("next", c), binding("step", 2), binding("remaining", 12)]).
proof(624, route(a, f, [a], [a, c, b, d, f], 14), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(612, route(c, f, [c, a], [c, b, d, f], 12)), calculated(14, binary("+", value(2), value(12)))]).
substitution(625, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, d, e, f]), binding("cost", 15), binding("next", c), binding("step", 2), binding("remaining", 13)]).
proof(625, route(a, f, [a], [a, c, d, e, f], 15), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(613, route(c, f, [c, a], [c, d, e, f], 13)), calculated(15, binary("+", value(2), value(13)))]).
substitution(626, [binding("from", b), binding("goal", f), binding("visited", [b, c, a]), binding("path", [d, e, f]), binding("cost", 10), binding("next", d), binding("step", 5), binding("remaining", 5)]).
proof(626, route(b, f, [b, c, a], [b, d, e, f], 10), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(611, route(d, f, [d, b, c, a], [d, e, f], 5)), calculated(10, binary("+", value(5), value(5)))]).
substitution(627, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [b, d, e, f]), binding("cost", 11), binding("next", b), binding("step", 1), binding("remaining", 10)]).
proof(627, route(c, f, [c, a], [c, b, d, e, f], 11), rule(15), [uses(549, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(626, route(b, f, [b, c, a], [b, d, e, f], 10)), calculated(11, binary("+", value(1), value(10)))]).
substitution(628, [binding("from", c), binding("goal", f), binding("visited", [c, a]), binding("path", [e, d, f]), binding("cost", 18), binding("next", e), binding("step", 10), binding("remaining", 8)]).
proof(628, route(c, f, [c, a], [c, e, d, f], 18), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(614, route(e, f, [e, c, a], [e, d, f], 8)), calculated(18, binary("+", value(10), value(8)))]).
substitution(629, [binding("from", d), binding("goal", f), binding("visited", [d, b, a]), binding("path", [c, e, f]), binding("cost", 21), binding("next", c), binding("step", 8), binding("remaining", 13)]).
proof(629, route(d, f, [d, b, a], [d, c, e, f], 21), rule(15), [uses(560, connected(d, c, 8)), absent(member(c, [d, b, a]), complete), uses(616, route(c, f, [c, d, b, a], [c, e, f], 13)), calculated(21, binary("+", value(8), value(13)))]).
substitution(630, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, d, e, f]), binding("cost", 14), binding("next", c), binding("step", 1), binding("remaining", 13)]).
proof(630, route(b, f, [b, a], [b, c, d, e, f], 14), rule(15), [uses(546, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(619, route(c, f, [c, b, a], [c, d, e, f], 13)), calculated(14, binary("+", value(1), value(13)))]).
substitution(631, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [c, e, d, f]), binding("cost", 19), binding("next", c), binding("step", 1), binding("remaining", 18)]).
proof(631, route(b, f, [b, a], [b, c, e, d, f], 19), rule(15), [uses(546, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(620, route(c, f, [c, b, a], [c, e, d, f], 18)), calculated(19, binary("+", value(1), value(18)))]).
substitution(632, [binding("from", b), binding("goal", f), binding("visited", [b, a]), binding("path", [d, c, e, f]), binding("cost", 26), binding("next", d), binding("step", 5), binding("remaining", 21)]).
proof(632, route(b, f, [b, a], [b, d, c, e, f], 26), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(629, route(d, f, [d, b, a], [d, c, e, f], 21)), calculated(26, binary("+", value(5), value(21)))]).
substitution(633, [binding("candidate", 19)]).
proof(633, solution([19]), query, [uses(621, route(a, f, [a], [a, b, c, d, f], 19))]).
substitution(634, [binding("candidate", 18)]).
proof(634, solution([18]), query, [uses(622, route(a, f, [a], [a, b, c, e, f], 18))]).
substitution(635, [binding("candidate", 14)]).
proof(635, solution([14]), query, [uses(623, route(a, f, [a], [a, b, d, e, f], 14))]).
substitution(636, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, c, d, e, f]), binding("cost", 18), binding("next", b), binding("step", 4), binding("remaining", 14)]).
proof(636, route(a, f, [a], [a, b, c, d, e, f], 18), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(630, route(b, f, [b, a], [b, c, d, e, f], 14)), calculated(18, binary("+", value(4), value(14)))]).
substitution(637, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, c, e, d, f]), binding("cost", 23), binding("next", b), binding("step", 4), binding("remaining", 19)]).
proof(637, route(a, f, [a], [a, b, c, e, d, f], 23), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(631, route(b, f, [b, a], [b, c, e, d, f], 19)), calculated(23, binary("+", value(4), value(19)))]).
substitution(638, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [b, d, c, e, f]), binding("cost", 30), binding("next", b), binding("step", 4), binding("remaining", 26)]).
proof(638, route(a, f, [a], [a, b, d, c, e, f], 30), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(632, route(b, f, [b, a], [b, d, c, e, f], 26)), calculated(30, binary("+", value(4), value(26)))]).
substitution(639, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, b, d, e, f]), binding("cost", 13), binding("next", c), binding("step", 2), binding("remaining", 11)]).
proof(639, route(a, f, [a], [a, c, b, d, e, f], 13), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(627, route(c, f, [c, a], [c, b, d, e, f], 11)), calculated(13, binary("+", value(2), value(11)))]).
substitution(640, [binding("from", a), binding("goal", f), binding("visited", [a]), binding("path", [c, e, d, f]), binding("cost", 20), binding("next", c), binding("step", 2), binding("remaining", 18)]).
proof(640, route(a, f, [a], [a, c, e, d, f], 20), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(628, route(c, f, [c, a], [c, e, d, f], 18)), calculated(20, binary("+", value(2), value(18)))]).
substitution(641, [binding("candidate", 23)]).
proof(641, solution([23]), query, [uses(637, route(a, f, [a], [a, b, c, e, d, f], 23))]).
substitution(642, [binding("candidate", 30)]).
proof(642, solution([30]), query, [uses(638, route(a, f, [a], [a, b, d, c, e, f], 30))]).
substitution(643, [binding("candidate", 13)]).
proof(643, solution([13]), query, [uses(639, route(a, f, [a], [a, c, b, d, e, f], 13))]).
substitution(644, [binding("candidate", 20)]).
proof(644, solution([20]), query, [uses(640, route(a, f, [a], [a, c, e, d, f], 20))]).
substitution(645, [binding("from", a), binding("to", f), binding("path", [a, c, b, d, e, f]), binding("cost", 13), binding("costs", [13, 14, 15, 16, 18, 19, 20, 23, 30]), binding("candidate", ?v0)]).
proof(645, best(a, f, [a, c, b, d, e, f], 13), rule(16), [collected([13, 14, 15, 16, 18, 19, 20, 23, 30], ?v0, [call(route(a, f, [a], ?v1, ?v0))], [617, 618, 633, 634, 635, 641, 642, 643, 644], complete), calculated(13, function("min", [value([13, 14, 15, 16, 18, 19, 20, 23, 30])])), uses(533, route(a, f, [a], [a, c, b, d, e, f], 13))]).
substitution(646, [binding("path", [a, c, b, d, e, f]), binding("cost", 13)]).
proof(646, solution([[a, c, b, d, e, f], 13]), query, [uses(645, best(a, f, [a, c, b, d, e, f], 13))]).
