# Eyelang result format 2
query(1, [call(test1(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 21).
query(2, [call(test2(?v0))], [binding("r", ?v0)]).
result(2, complete, 1).
answer(2, [binding("r", true)]).
why(2, [binding("r", true)], 58).
query(3, [call(test3(?v0))], [binding("r", ?v0)]).
result(3, complete, 1).
answer(3, [binding("r", true)]).
why(3, [binding("r", true)], 63).
query(4, [call(test4(?v0))], [binding("r", ?v0)]).
result(4, complete, 1).
answer(4, [binding("r", true)]).
why(4, [binding("r", true)], 68).
clause(1, p1(s1, o1), []).
clause(2, p1(s2, o2), []).
clause(3, p1(s3, o3), []).
clause(4, p1(s3, o4), []).
clause(6, append([], var("ys"), var("ys")), []).
clause(7, append([var("x") | var("xs")], var("ys"), [var("x") | var("zs")]), [call(append(var("xs"), var("ys"), var("zs")))]).
clause(8, flat_map_p1([], []), []).
clause(9, flat_map_p1([var("s") | var("ss")], var("result")), [collect(var("os"), var("o"), [call(p1(var("s"), var("o")))]), call(flat_map_p1(var("ss"), var("rest"))), call(append(var("os"), var("rest"), var("result")))]).
clause(10, flat_map_p2([], []), []).
clause(11, flat_map_p2([var("s") | var("ss")], var("result")), [collect(var("os"), var("o"), [call(p2(var("s"), var("o")))]), call(flat_map_p2(var("ss"), var("rest"))), call(append(var("os"), var("rest"), var("result")))]).
clause(12, test1(true), [call(flat_map_p1([s1, s2], [o1, o2]))]).
clause(13, test2(true), [call(flat_map_p1([s1, s2, s3], [o1, o2, o3, o4]))]).
clause(14, test3(true), [call(flat_map_p1([s4], []))]).
clause(15, test4(true), [call(flat_map_p2([s1], []))]).
substitution(1, []).
proof(1, p1(s1, o1), rule(1), []).
substitution(2, [binding("o", o1)]).
proof(2, solution([o1]), query, [uses(1, p1(s1, o1))]).
substitution(3, []).
proof(3, p1(s2, o2), rule(2), []).
substitution(4, [binding("o", o2)]).
proof(4, solution([o2]), query, [uses(3, p1(s2, o2))]).
substitution(5, []).
proof(5, flat_map_p1([], []), rule(8), []).
substitution(6, []).
proof(6, p1(s2, o2), rule(2), []).
substitution(7, [binding("o", o2)]).
proof(7, solution([o2]), query, [uses(6, p1(s2, o2))]).
substitution(8, [binding("ys", [])]).
proof(8, append([], [], []), rule(6), []).
substitution(9, [binding("x", o2), binding("xs", []), binding("ys", []), binding("zs", [])]).
proof(9, append([o2], [], [o2]), rule(7), [uses(8, append([], [], []))]).
substitution(10, []).
proof(10, p1(s2, o2), rule(2), []).
substitution(11, [binding("o", o2)]).
proof(11, solution([o2]), query, [uses(10, p1(s2, o2))]).
substitution(12, [binding("s", s2), binding("ss", []), binding("result", [o2]), binding("os", [o2]), binding("o", ?v0), binding("rest", [])]).
proof(12, flat_map_p1([s2], [o2]), rule(9), [collected([o2], ?v0, [call(p1(s2, ?v0))], [11], complete), uses(5, flat_map_p1([], [])), uses(9, append([o2], [], [o2]))]).
substitution(13, []).
proof(13, p1(s1, o1), rule(1), []).
substitution(14, [binding("o", o1)]).
proof(14, solution([o1]), query, [uses(13, p1(s1, o1))]).
substitution(15, [binding("ys", [o2])]).
proof(15, append([], [o2], [o2]), rule(6), []).
substitution(16, [binding("x", o1), binding("xs", []), binding("ys", [o2]), binding("zs", [o2])]).
proof(16, append([o1], [o2], [o1, o2]), rule(7), [uses(15, append([], [o2], [o2]))]).
substitution(17, []).
proof(17, p1(s1, o1), rule(1), []).
substitution(18, [binding("o", o1)]).
proof(18, solution([o1]), query, [uses(17, p1(s1, o1))]).
substitution(19, [binding("s", s1), binding("ss", [s2]), binding("result", [o1, o2]), binding("os", [o1]), binding("o", ?v0), binding("rest", [o2])]).
proof(19, flat_map_p1([s1, s2], [o1, o2]), rule(9), [collected([o1], ?v0, [call(p1(s1, ?v0))], [18], complete), uses(12, flat_map_p1([s2], [o2])), uses(16, append([o1], [o2], [o1, o2]))]).
substitution(20, []).
proof(20, test1(true), rule(12), [uses(19, flat_map_p1([s1, s2], [o1, o2]))]).
substitution(21, [binding("r", true)]).
proof(21, solution([true]), query, [uses(20, test1(true))]).
substitution(22, []).
proof(22, p1(s1, o1), rule(1), []).
substitution(23, [binding("o", o1)]).
proof(23, solution([o1]), query, [uses(22, p1(s1, o1))]).
substitution(24, []).
proof(24, p1(s2, o2), rule(2), []).
substitution(25, [binding("o", o2)]).
proof(25, solution([o2]), query, [uses(24, p1(s2, o2))]).
substitution(26, []).
proof(26, p1(s3, o3), rule(3), []).
substitution(27, []).
proof(27, p1(s3, o4), rule(4), []).
substitution(28, [binding("o", o3)]).
proof(28, solution([o3]), query, [uses(26, p1(s3, o3))]).
substitution(29, [binding("o", o4)]).
proof(29, solution([o4]), query, [uses(27, p1(s3, o4))]).
substitution(30, []).
proof(30, flat_map_p1([], []), rule(8), []).
substitution(31, []).
proof(31, p1(s3, o3), rule(3), []).
substitution(32, []).
proof(32, p1(s3, o4), rule(4), []).
substitution(33, [binding("o", o3)]).
proof(33, solution([o3]), query, [uses(31, p1(s3, o3))]).
substitution(34, [binding("o", o4)]).
proof(34, solution([o4]), query, [uses(32, p1(s3, o4))]).
substitution(35, [binding("ys", [])]).
proof(35, append([], [], []), rule(6), []).
substitution(36, [binding("x", o4), binding("xs", []), binding("ys", []), binding("zs", [])]).
proof(36, append([o4], [], [o4]), rule(7), [uses(35, append([], [], []))]).
substitution(37, [binding("x", o3), binding("xs", [o4]), binding("ys", []), binding("zs", [o4])]).
proof(37, append([o3, o4], [], [o3, o4]), rule(7), [uses(36, append([o4], [], [o4]))]).
substitution(38, []).
proof(38, p1(s3, o3), rule(3), []).
substitution(39, []).
proof(39, p1(s3, o4), rule(4), []).
substitution(40, [binding("o", o3)]).
proof(40, solution([o3]), query, [uses(38, p1(s3, o3))]).
substitution(41, [binding("o", o4)]).
proof(41, solution([o4]), query, [uses(39, p1(s3, o4))]).
substitution(42, [binding("s", s3), binding("ss", []), binding("result", [o3, o4]), binding("os", [o3, o4]), binding("o", ?v0), binding("rest", [])]).
proof(42, flat_map_p1([s3], [o3, o4]), rule(9), [collected([o3, o4], ?v0, [call(p1(s3, ?v0))], [40, 41], complete), uses(30, flat_map_p1([], [])), uses(37, append([o3, o4], [], [o3, o4]))]).
substitution(43, []).
proof(43, p1(s2, o2), rule(2), []).
substitution(44, [binding("o", o2)]).
proof(44, solution([o2]), query, [uses(43, p1(s2, o2))]).
substitution(45, [binding("ys", [o3, o4])]).
proof(45, append([], [o3, o4], [o3, o4]), rule(6), []).
substitution(46, [binding("x", o2), binding("xs", []), binding("ys", [o3, o4]), binding("zs", [o3, o4])]).
proof(46, append([o2], [o3, o4], [o2, o3, o4]), rule(7), [uses(45, append([], [o3, o4], [o3, o4]))]).
substitution(47, []).
proof(47, p1(s2, o2), rule(2), []).
substitution(48, [binding("o", o2)]).
proof(48, solution([o2]), query, [uses(47, p1(s2, o2))]).
substitution(49, [binding("s", s2), binding("ss", [s3]), binding("result", [o2, o3, o4]), binding("os", [o2]), binding("o", ?v0), binding("rest", [o3, o4])]).
proof(49, flat_map_p1([s2, s3], [o2, o3, o4]), rule(9), [collected([o2], ?v0, [call(p1(s2, ?v0))], [48], complete), uses(42, flat_map_p1([s3], [o3, o4])), uses(46, append([o2], [o3, o4], [o2, o3, o4]))]).
substitution(50, []).
proof(50, p1(s1, o1), rule(1), []).
substitution(51, [binding("o", o1)]).
proof(51, solution([o1]), query, [uses(50, p1(s1, o1))]).
substitution(52, [binding("ys", [o2, o3, o4])]).
proof(52, append([], [o2, o3, o4], [o2, o3, o4]), rule(6), []).
substitution(53, [binding("x", o1), binding("xs", []), binding("ys", [o2, o3, o4]), binding("zs", [o2, o3, o4])]).
proof(53, append([o1], [o2, o3, o4], [o1, o2, o3, o4]), rule(7), [uses(52, append([], [o2, o3, o4], [o2, o3, o4]))]).
substitution(54, []).
proof(54, p1(s1, o1), rule(1), []).
substitution(55, [binding("o", o1)]).
proof(55, solution([o1]), query, [uses(54, p1(s1, o1))]).
substitution(56, [binding("s", s1), binding("ss", [s2, s3]), binding("result", [o1, o2, o3, o4]), binding("os", [o1]), binding("o", ?v0), binding("rest", [o2, o3, o4])]).
proof(56, flat_map_p1([s1, s2, s3], [o1, o2, o3, o4]), rule(9), [collected([o1], ?v0, [call(p1(s1, ?v0))], [55], complete), uses(49, flat_map_p1([s2, s3], [o2, o3, o4])), uses(53, append([o1], [o2, o3, o4], [o1, o2, o3, o4]))]).
substitution(57, []).
proof(57, test2(true), rule(13), [uses(56, flat_map_p1([s1, s2, s3], [o1, o2, o3, o4]))]).
substitution(58, [binding("r", true)]).
proof(58, solution([true]), query, [uses(57, test2(true))]).
substitution(59, []).
proof(59, flat_map_p1([], []), rule(8), []).
substitution(60, [binding("ys", [])]).
proof(60, append([], [], []), rule(6), []).
substitution(61, [binding("s", s4), binding("ss", []), binding("result", []), binding("os", []), binding("o", ?v0), binding("rest", [])]).
proof(61, flat_map_p1([s4], []), rule(9), [collected([], ?v0, [call(p1(s4, ?v0))], [], complete), uses(59, flat_map_p1([], [])), uses(60, append([], [], []))]).
substitution(62, []).
proof(62, test3(true), rule(14), [uses(61, flat_map_p1([s4], []))]).
substitution(63, [binding("r", true)]).
proof(63, solution([true]), query, [uses(62, test3(true))]).
substitution(64, []).
proof(64, flat_map_p2([], []), rule(10), []).
substitution(65, [binding("ys", [])]).
proof(65, append([], [], []), rule(6), []).
substitution(66, [binding("s", s1), binding("ss", []), binding("result", []), binding("os", []), binding("o", ?v0), binding("rest", [])]).
proof(66, flat_map_p2([s1], []), rule(11), [collected([], ?v0, [call(p2(s1, ?v0))], [], complete), uses(64, flat_map_p2([], [])), uses(65, append([], [], []))]).
substitution(67, []).
proof(67, test4(true), rule(15), [uses(66, flat_map_p2([s1], []))]).
substitution(68, [binding("r", true)]).
proof(68, solution([true]), query, [uses(67, test4(true))]).
