# Eyelang result format 2
query(1, [call(direct_links(?v0))], [binding("links", ?v0)]).
result(1, complete, 1).
answer(1, [binding("links", 69)]).
why(1, [binding("links", 69)], 2).
query(2, [call(reachable_pairs(?v0))], [binding("pairs", ?v0)]).
result(2, complete, 1).
answer(2, [binding("pairs", 2415)]).
why(2, [binding("pairs", 2415)], 4).
query(3, [call(test_is(?v0))], [binding("r", ?v0)]).
result(3, complete, 1).
answer(3, [binding("r", true)]).
why(3, [binding("r", true)], 145).
clause(1, link(n(var("n")), n(var("next"))), [call(range(1, 69, var("n"))), calculate(var("next"), binary("+", value(var("n")), value(1)))]).
clause(2, reaches(var("from"), var("to")), [call(link(var("from"), var("to")))]).
clause(3, reaches(var("from"), var("to")), [call(link(var("from"), var("via"))), call(reaches(var("via"), var("to")))]).
clause(4, direct_links(var("links")), [calculate(var("links"), binary("-", value(70), value(1)))]).
clause(5, reachable_pairs(var("pairs")), [calculate(var("max"), value(70)), calculate(var("previous"), binary("-", value(var("max")), value(1))), calculate(var("twice"), binary("*", value(var("max")), value(var("previous")))), calculate(var("pairs"), binary("//", value(var("twice")), value(2)))]).
clause(6, test_is(true), [call(reaches(n(1), n(70)))]).
substitution(1, [binding("links", 69)]).
proof(1, direct_links(69), rule(4), [calculated(69, binary("-", value(70), value(1)))]).
substitution(2, [binding("links", 69)]).
proof(2, solution([69]), query, [uses(1, direct_links(69))]).
substitution(3, [binding("pairs", 2415), binding("max", 70), binding("previous", 69), binding("twice", 4830)]).
proof(3, reachable_pairs(2415), rule(5), [calculated(70, value(70)), calculated(69, binary("-", value(70), value(1))), calculated(4830, binary("*", value(70), value(69))), calculated(2415, binary("//", value(4830), value(2)))]).
substitution(4, [binding("pairs", 2415)]).
proof(4, solution([2415]), query, [uses(3, reachable_pairs(2415))]).
substitution(5, [binding("n", 1), binding("next", 2)]).
proof(5, link(n(1), n(2)), rule(1), [builtin(range(1, 69, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(6, [binding("n", 2), binding("next", 3)]).
proof(6, link(n(2), n(3)), rule(1), [builtin(range(1, 69, 2)), calculated(3, binary("+", value(2), value(1)))]).
substitution(7, [binding("n", 3), binding("next", 4)]).
proof(7, link(n(3), n(4)), rule(1), [builtin(range(1, 69, 3)), calculated(4, binary("+", value(3), value(1)))]).
substitution(8, [binding("n", 4), binding("next", 5)]).
proof(8, link(n(4), n(5)), rule(1), [builtin(range(1, 69, 4)), calculated(5, binary("+", value(4), value(1)))]).
substitution(9, [binding("n", 5), binding("next", 6)]).
proof(9, link(n(5), n(6)), rule(1), [builtin(range(1, 69, 5)), calculated(6, binary("+", value(5), value(1)))]).
substitution(10, [binding("n", 6), binding("next", 7)]).
proof(10, link(n(6), n(7)), rule(1), [builtin(range(1, 69, 6)), calculated(7, binary("+", value(6), value(1)))]).
substitution(11, [binding("n", 7), binding("next", 8)]).
proof(11, link(n(7), n(8)), rule(1), [builtin(range(1, 69, 7)), calculated(8, binary("+", value(7), value(1)))]).
substitution(12, [binding("n", 8), binding("next", 9)]).
proof(12, link(n(8), n(9)), rule(1), [builtin(range(1, 69, 8)), calculated(9, binary("+", value(8), value(1)))]).
substitution(13, [binding("n", 9), binding("next", 10)]).
proof(13, link(n(9), n(10)), rule(1), [builtin(range(1, 69, 9)), calculated(10, binary("+", value(9), value(1)))]).
substitution(14, [binding("n", 10), binding("next", 11)]).
proof(14, link(n(10), n(11)), rule(1), [builtin(range(1, 69, 10)), calculated(11, binary("+", value(10), value(1)))]).
substitution(15, [binding("n", 11), binding("next", 12)]).
proof(15, link(n(11), n(12)), rule(1), [builtin(range(1, 69, 11)), calculated(12, binary("+", value(11), value(1)))]).
substitution(16, [binding("n", 12), binding("next", 13)]).
proof(16, link(n(12), n(13)), rule(1), [builtin(range(1, 69, 12)), calculated(13, binary("+", value(12), value(1)))]).
substitution(17, [binding("n", 13), binding("next", 14)]).
proof(17, link(n(13), n(14)), rule(1), [builtin(range(1, 69, 13)), calculated(14, binary("+", value(13), value(1)))]).
substitution(18, [binding("n", 14), binding("next", 15)]).
proof(18, link(n(14), n(15)), rule(1), [builtin(range(1, 69, 14)), calculated(15, binary("+", value(14), value(1)))]).
substitution(19, [binding("n", 15), binding("next", 16)]).
proof(19, link(n(15), n(16)), rule(1), [builtin(range(1, 69, 15)), calculated(16, binary("+", value(15), value(1)))]).
substitution(20, [binding("n", 16), binding("next", 17)]).
proof(20, link(n(16), n(17)), rule(1), [builtin(range(1, 69, 16)), calculated(17, binary("+", value(16), value(1)))]).
substitution(21, [binding("n", 17), binding("next", 18)]).
proof(21, link(n(17), n(18)), rule(1), [builtin(range(1, 69, 17)), calculated(18, binary("+", value(17), value(1)))]).
substitution(22, [binding("n", 18), binding("next", 19)]).
proof(22, link(n(18), n(19)), rule(1), [builtin(range(1, 69, 18)), calculated(19, binary("+", value(18), value(1)))]).
substitution(23, [binding("n", 19), binding("next", 20)]).
proof(23, link(n(19), n(20)), rule(1), [builtin(range(1, 69, 19)), calculated(20, binary("+", value(19), value(1)))]).
substitution(24, [binding("n", 20), binding("next", 21)]).
proof(24, link(n(20), n(21)), rule(1), [builtin(range(1, 69, 20)), calculated(21, binary("+", value(20), value(1)))]).
substitution(25, [binding("n", 21), binding("next", 22)]).
proof(25, link(n(21), n(22)), rule(1), [builtin(range(1, 69, 21)), calculated(22, binary("+", value(21), value(1)))]).
substitution(26, [binding("n", 22), binding("next", 23)]).
proof(26, link(n(22), n(23)), rule(1), [builtin(range(1, 69, 22)), calculated(23, binary("+", value(22), value(1)))]).
substitution(27, [binding("n", 23), binding("next", 24)]).
proof(27, link(n(23), n(24)), rule(1), [builtin(range(1, 69, 23)), calculated(24, binary("+", value(23), value(1)))]).
substitution(28, [binding("n", 24), binding("next", 25)]).
proof(28, link(n(24), n(25)), rule(1), [builtin(range(1, 69, 24)), calculated(25, binary("+", value(24), value(1)))]).
substitution(29, [binding("n", 25), binding("next", 26)]).
proof(29, link(n(25), n(26)), rule(1), [builtin(range(1, 69, 25)), calculated(26, binary("+", value(25), value(1)))]).
substitution(30, [binding("n", 26), binding("next", 27)]).
proof(30, link(n(26), n(27)), rule(1), [builtin(range(1, 69, 26)), calculated(27, binary("+", value(26), value(1)))]).
substitution(31, [binding("n", 27), binding("next", 28)]).
proof(31, link(n(27), n(28)), rule(1), [builtin(range(1, 69, 27)), calculated(28, binary("+", value(27), value(1)))]).
substitution(32, [binding("n", 28), binding("next", 29)]).
proof(32, link(n(28), n(29)), rule(1), [builtin(range(1, 69, 28)), calculated(29, binary("+", value(28), value(1)))]).
substitution(33, [binding("n", 29), binding("next", 30)]).
proof(33, link(n(29), n(30)), rule(1), [builtin(range(1, 69, 29)), calculated(30, binary("+", value(29), value(1)))]).
substitution(34, [binding("n", 30), binding("next", 31)]).
proof(34, link(n(30), n(31)), rule(1), [builtin(range(1, 69, 30)), calculated(31, binary("+", value(30), value(1)))]).
substitution(35, [binding("n", 31), binding("next", 32)]).
proof(35, link(n(31), n(32)), rule(1), [builtin(range(1, 69, 31)), calculated(32, binary("+", value(31), value(1)))]).
substitution(36, [binding("n", 32), binding("next", 33)]).
proof(36, link(n(32), n(33)), rule(1), [builtin(range(1, 69, 32)), calculated(33, binary("+", value(32), value(1)))]).
substitution(37, [binding("n", 33), binding("next", 34)]).
proof(37, link(n(33), n(34)), rule(1), [builtin(range(1, 69, 33)), calculated(34, binary("+", value(33), value(1)))]).
substitution(38, [binding("n", 34), binding("next", 35)]).
proof(38, link(n(34), n(35)), rule(1), [builtin(range(1, 69, 34)), calculated(35, binary("+", value(34), value(1)))]).
substitution(39, [binding("n", 35), binding("next", 36)]).
proof(39, link(n(35), n(36)), rule(1), [builtin(range(1, 69, 35)), calculated(36, binary("+", value(35), value(1)))]).
substitution(40, [binding("n", 36), binding("next", 37)]).
proof(40, link(n(36), n(37)), rule(1), [builtin(range(1, 69, 36)), calculated(37, binary("+", value(36), value(1)))]).
substitution(41, [binding("n", 37), binding("next", 38)]).
proof(41, link(n(37), n(38)), rule(1), [builtin(range(1, 69, 37)), calculated(38, binary("+", value(37), value(1)))]).
substitution(42, [binding("n", 38), binding("next", 39)]).
proof(42, link(n(38), n(39)), rule(1), [builtin(range(1, 69, 38)), calculated(39, binary("+", value(38), value(1)))]).
substitution(43, [binding("n", 39), binding("next", 40)]).
proof(43, link(n(39), n(40)), rule(1), [builtin(range(1, 69, 39)), calculated(40, binary("+", value(39), value(1)))]).
substitution(44, [binding("n", 40), binding("next", 41)]).
proof(44, link(n(40), n(41)), rule(1), [builtin(range(1, 69, 40)), calculated(41, binary("+", value(40), value(1)))]).
substitution(45, [binding("n", 41), binding("next", 42)]).
proof(45, link(n(41), n(42)), rule(1), [builtin(range(1, 69, 41)), calculated(42, binary("+", value(41), value(1)))]).
substitution(46, [binding("n", 42), binding("next", 43)]).
proof(46, link(n(42), n(43)), rule(1), [builtin(range(1, 69, 42)), calculated(43, binary("+", value(42), value(1)))]).
substitution(47, [binding("n", 43), binding("next", 44)]).
proof(47, link(n(43), n(44)), rule(1), [builtin(range(1, 69, 43)), calculated(44, binary("+", value(43), value(1)))]).
substitution(48, [binding("n", 44), binding("next", 45)]).
proof(48, link(n(44), n(45)), rule(1), [builtin(range(1, 69, 44)), calculated(45, binary("+", value(44), value(1)))]).
substitution(49, [binding("n", 45), binding("next", 46)]).
proof(49, link(n(45), n(46)), rule(1), [builtin(range(1, 69, 45)), calculated(46, binary("+", value(45), value(1)))]).
substitution(50, [binding("n", 46), binding("next", 47)]).
proof(50, link(n(46), n(47)), rule(1), [builtin(range(1, 69, 46)), calculated(47, binary("+", value(46), value(1)))]).
substitution(51, [binding("n", 47), binding("next", 48)]).
proof(51, link(n(47), n(48)), rule(1), [builtin(range(1, 69, 47)), calculated(48, binary("+", value(47), value(1)))]).
substitution(52, [binding("n", 48), binding("next", 49)]).
proof(52, link(n(48), n(49)), rule(1), [builtin(range(1, 69, 48)), calculated(49, binary("+", value(48), value(1)))]).
substitution(53, [binding("n", 49), binding("next", 50)]).
proof(53, link(n(49), n(50)), rule(1), [builtin(range(1, 69, 49)), calculated(50, binary("+", value(49), value(1)))]).
substitution(54, [binding("n", 50), binding("next", 51)]).
proof(54, link(n(50), n(51)), rule(1), [builtin(range(1, 69, 50)), calculated(51, binary("+", value(50), value(1)))]).
substitution(55, [binding("n", 51), binding("next", 52)]).
proof(55, link(n(51), n(52)), rule(1), [builtin(range(1, 69, 51)), calculated(52, binary("+", value(51), value(1)))]).
substitution(56, [binding("n", 52), binding("next", 53)]).
proof(56, link(n(52), n(53)), rule(1), [builtin(range(1, 69, 52)), calculated(53, binary("+", value(52), value(1)))]).
substitution(57, [binding("n", 53), binding("next", 54)]).
proof(57, link(n(53), n(54)), rule(1), [builtin(range(1, 69, 53)), calculated(54, binary("+", value(53), value(1)))]).
substitution(58, [binding("n", 54), binding("next", 55)]).
proof(58, link(n(54), n(55)), rule(1), [builtin(range(1, 69, 54)), calculated(55, binary("+", value(54), value(1)))]).
substitution(59, [binding("n", 55), binding("next", 56)]).
proof(59, link(n(55), n(56)), rule(1), [builtin(range(1, 69, 55)), calculated(56, binary("+", value(55), value(1)))]).
substitution(60, [binding("n", 56), binding("next", 57)]).
proof(60, link(n(56), n(57)), rule(1), [builtin(range(1, 69, 56)), calculated(57, binary("+", value(56), value(1)))]).
substitution(61, [binding("n", 57), binding("next", 58)]).
proof(61, link(n(57), n(58)), rule(1), [builtin(range(1, 69, 57)), calculated(58, binary("+", value(57), value(1)))]).
substitution(62, [binding("n", 58), binding("next", 59)]).
proof(62, link(n(58), n(59)), rule(1), [builtin(range(1, 69, 58)), calculated(59, binary("+", value(58), value(1)))]).
substitution(63, [binding("n", 59), binding("next", 60)]).
proof(63, link(n(59), n(60)), rule(1), [builtin(range(1, 69, 59)), calculated(60, binary("+", value(59), value(1)))]).
substitution(64, [binding("n", 60), binding("next", 61)]).
proof(64, link(n(60), n(61)), rule(1), [builtin(range(1, 69, 60)), calculated(61, binary("+", value(60), value(1)))]).
substitution(65, [binding("n", 61), binding("next", 62)]).
proof(65, link(n(61), n(62)), rule(1), [builtin(range(1, 69, 61)), calculated(62, binary("+", value(61), value(1)))]).
substitution(66, [binding("n", 62), binding("next", 63)]).
proof(66, link(n(62), n(63)), rule(1), [builtin(range(1, 69, 62)), calculated(63, binary("+", value(62), value(1)))]).
substitution(67, [binding("n", 63), binding("next", 64)]).
proof(67, link(n(63), n(64)), rule(1), [builtin(range(1, 69, 63)), calculated(64, binary("+", value(63), value(1)))]).
substitution(68, [binding("n", 64), binding("next", 65)]).
proof(68, link(n(64), n(65)), rule(1), [builtin(range(1, 69, 64)), calculated(65, binary("+", value(64), value(1)))]).
substitution(69, [binding("n", 65), binding("next", 66)]).
proof(69, link(n(65), n(66)), rule(1), [builtin(range(1, 69, 65)), calculated(66, binary("+", value(65), value(1)))]).
substitution(70, [binding("n", 66), binding("next", 67)]).
proof(70, link(n(66), n(67)), rule(1), [builtin(range(1, 69, 66)), calculated(67, binary("+", value(66), value(1)))]).
substitution(71, [binding("n", 67), binding("next", 68)]).
proof(71, link(n(67), n(68)), rule(1), [builtin(range(1, 69, 67)), calculated(68, binary("+", value(67), value(1)))]).
substitution(72, [binding("n", 68), binding("next", 69)]).
proof(72, link(n(68), n(69)), rule(1), [builtin(range(1, 69, 68)), calculated(69, binary("+", value(68), value(1)))]).
substitution(73, [binding("n", 69), binding("next", 70)]).
proof(73, link(n(69), n(70)), rule(1), [builtin(range(1, 69, 69)), calculated(70, binary("+", value(69), value(1)))]).
substitution(74, [binding("n", 69), binding("next", 70)]).
proof(74, link(n(69), n(70)), rule(1), [builtin(range(1, 69, 69)), calculated(70, binary("+", value(69), value(1)))]).
substitution(75, [binding("from", n(69)), binding("to", n(70))]).
proof(75, reaches(n(69), n(70)), rule(2), [uses(73, link(n(69), n(70)))]).
substitution(76, [binding("from", n(68)), binding("to", n(70)), binding("via", n(69))]).
proof(76, reaches(n(68), n(70)), rule(3), [uses(72, link(n(68), n(69))), uses(75, reaches(n(69), n(70)))]).
substitution(77, [binding("from", n(67)), binding("to", n(70)), binding("via", n(68))]).
proof(77, reaches(n(67), n(70)), rule(3), [uses(71, link(n(67), n(68))), uses(76, reaches(n(68), n(70)))]).
substitution(78, [binding("from", n(66)), binding("to", n(70)), binding("via", n(67))]).
proof(78, reaches(n(66), n(70)), rule(3), [uses(70, link(n(66), n(67))), uses(77, reaches(n(67), n(70)))]).
substitution(79, [binding("from", n(65)), binding("to", n(70)), binding("via", n(66))]).
proof(79, reaches(n(65), n(70)), rule(3), [uses(69, link(n(65), n(66))), uses(78, reaches(n(66), n(70)))]).
substitution(80, [binding("from", n(64)), binding("to", n(70)), binding("via", n(65))]).
proof(80, reaches(n(64), n(70)), rule(3), [uses(68, link(n(64), n(65))), uses(79, reaches(n(65), n(70)))]).
substitution(81, [binding("from", n(63)), binding("to", n(70)), binding("via", n(64))]).
proof(81, reaches(n(63), n(70)), rule(3), [uses(67, link(n(63), n(64))), uses(80, reaches(n(64), n(70)))]).
substitution(82, [binding("from", n(62)), binding("to", n(70)), binding("via", n(63))]).
proof(82, reaches(n(62), n(70)), rule(3), [uses(66, link(n(62), n(63))), uses(81, reaches(n(63), n(70)))]).
substitution(83, [binding("from", n(61)), binding("to", n(70)), binding("via", n(62))]).
proof(83, reaches(n(61), n(70)), rule(3), [uses(65, link(n(61), n(62))), uses(82, reaches(n(62), n(70)))]).
substitution(84, [binding("from", n(60)), binding("to", n(70)), binding("via", n(61))]).
proof(84, reaches(n(60), n(70)), rule(3), [uses(64, link(n(60), n(61))), uses(83, reaches(n(61), n(70)))]).
substitution(85, [binding("from", n(59)), binding("to", n(70)), binding("via", n(60))]).
proof(85, reaches(n(59), n(70)), rule(3), [uses(63, link(n(59), n(60))), uses(84, reaches(n(60), n(70)))]).
substitution(86, [binding("from", n(58)), binding("to", n(70)), binding("via", n(59))]).
proof(86, reaches(n(58), n(70)), rule(3), [uses(62, link(n(58), n(59))), uses(85, reaches(n(59), n(70)))]).
substitution(87, [binding("from", n(57)), binding("to", n(70)), binding("via", n(58))]).
proof(87, reaches(n(57), n(70)), rule(3), [uses(61, link(n(57), n(58))), uses(86, reaches(n(58), n(70)))]).
substitution(88, [binding("from", n(56)), binding("to", n(70)), binding("via", n(57))]).
proof(88, reaches(n(56), n(70)), rule(3), [uses(60, link(n(56), n(57))), uses(87, reaches(n(57), n(70)))]).
substitution(89, [binding("from", n(55)), binding("to", n(70)), binding("via", n(56))]).
proof(89, reaches(n(55), n(70)), rule(3), [uses(59, link(n(55), n(56))), uses(88, reaches(n(56), n(70)))]).
substitution(90, [binding("from", n(54)), binding("to", n(70)), binding("via", n(55))]).
proof(90, reaches(n(54), n(70)), rule(3), [uses(58, link(n(54), n(55))), uses(89, reaches(n(55), n(70)))]).
substitution(91, [binding("from", n(53)), binding("to", n(70)), binding("via", n(54))]).
proof(91, reaches(n(53), n(70)), rule(3), [uses(57, link(n(53), n(54))), uses(90, reaches(n(54), n(70)))]).
substitution(92, [binding("from", n(52)), binding("to", n(70)), binding("via", n(53))]).
proof(92, reaches(n(52), n(70)), rule(3), [uses(56, link(n(52), n(53))), uses(91, reaches(n(53), n(70)))]).
substitution(93, [binding("from", n(51)), binding("to", n(70)), binding("via", n(52))]).
proof(93, reaches(n(51), n(70)), rule(3), [uses(55, link(n(51), n(52))), uses(92, reaches(n(52), n(70)))]).
substitution(94, [binding("from", n(50)), binding("to", n(70)), binding("via", n(51))]).
proof(94, reaches(n(50), n(70)), rule(3), [uses(54, link(n(50), n(51))), uses(93, reaches(n(51), n(70)))]).
substitution(95, [binding("from", n(49)), binding("to", n(70)), binding("via", n(50))]).
proof(95, reaches(n(49), n(70)), rule(3), [uses(53, link(n(49), n(50))), uses(94, reaches(n(50), n(70)))]).
substitution(96, [binding("from", n(48)), binding("to", n(70)), binding("via", n(49))]).
proof(96, reaches(n(48), n(70)), rule(3), [uses(52, link(n(48), n(49))), uses(95, reaches(n(49), n(70)))]).
substitution(97, [binding("from", n(47)), binding("to", n(70)), binding("via", n(48))]).
proof(97, reaches(n(47), n(70)), rule(3), [uses(51, link(n(47), n(48))), uses(96, reaches(n(48), n(70)))]).
substitution(98, [binding("from", n(46)), binding("to", n(70)), binding("via", n(47))]).
proof(98, reaches(n(46), n(70)), rule(3), [uses(50, link(n(46), n(47))), uses(97, reaches(n(47), n(70)))]).
substitution(99, [binding("from", n(45)), binding("to", n(70)), binding("via", n(46))]).
proof(99, reaches(n(45), n(70)), rule(3), [uses(49, link(n(45), n(46))), uses(98, reaches(n(46), n(70)))]).
substitution(100, [binding("from", n(44)), binding("to", n(70)), binding("via", n(45))]).
proof(100, reaches(n(44), n(70)), rule(3), [uses(48, link(n(44), n(45))), uses(99, reaches(n(45), n(70)))]).
substitution(101, [binding("from", n(43)), binding("to", n(70)), binding("via", n(44))]).
proof(101, reaches(n(43), n(70)), rule(3), [uses(47, link(n(43), n(44))), uses(100, reaches(n(44), n(70)))]).
substitution(102, [binding("from", n(42)), binding("to", n(70)), binding("via", n(43))]).
proof(102, reaches(n(42), n(70)), rule(3), [uses(46, link(n(42), n(43))), uses(101, reaches(n(43), n(70)))]).
substitution(103, [binding("from", n(41)), binding("to", n(70)), binding("via", n(42))]).
proof(103, reaches(n(41), n(70)), rule(3), [uses(45, link(n(41), n(42))), uses(102, reaches(n(42), n(70)))]).
substitution(104, [binding("from", n(40)), binding("to", n(70)), binding("via", n(41))]).
proof(104, reaches(n(40), n(70)), rule(3), [uses(44, link(n(40), n(41))), uses(103, reaches(n(41), n(70)))]).
substitution(105, [binding("from", n(39)), binding("to", n(70)), binding("via", n(40))]).
proof(105, reaches(n(39), n(70)), rule(3), [uses(43, link(n(39), n(40))), uses(104, reaches(n(40), n(70)))]).
substitution(106, [binding("from", n(38)), binding("to", n(70)), binding("via", n(39))]).
proof(106, reaches(n(38), n(70)), rule(3), [uses(42, link(n(38), n(39))), uses(105, reaches(n(39), n(70)))]).
substitution(107, [binding("from", n(37)), binding("to", n(70)), binding("via", n(38))]).
proof(107, reaches(n(37), n(70)), rule(3), [uses(41, link(n(37), n(38))), uses(106, reaches(n(38), n(70)))]).
substitution(108, [binding("from", n(36)), binding("to", n(70)), binding("via", n(37))]).
proof(108, reaches(n(36), n(70)), rule(3), [uses(40, link(n(36), n(37))), uses(107, reaches(n(37), n(70)))]).
substitution(109, [binding("from", n(35)), binding("to", n(70)), binding("via", n(36))]).
proof(109, reaches(n(35), n(70)), rule(3), [uses(39, link(n(35), n(36))), uses(108, reaches(n(36), n(70)))]).
substitution(110, [binding("from", n(34)), binding("to", n(70)), binding("via", n(35))]).
proof(110, reaches(n(34), n(70)), rule(3), [uses(38, link(n(34), n(35))), uses(109, reaches(n(35), n(70)))]).
substitution(111, [binding("from", n(33)), binding("to", n(70)), binding("via", n(34))]).
proof(111, reaches(n(33), n(70)), rule(3), [uses(37, link(n(33), n(34))), uses(110, reaches(n(34), n(70)))]).
substitution(112, [binding("from", n(32)), binding("to", n(70)), binding("via", n(33))]).
proof(112, reaches(n(32), n(70)), rule(3), [uses(36, link(n(32), n(33))), uses(111, reaches(n(33), n(70)))]).
substitution(113, [binding("from", n(31)), binding("to", n(70)), binding("via", n(32))]).
proof(113, reaches(n(31), n(70)), rule(3), [uses(35, link(n(31), n(32))), uses(112, reaches(n(32), n(70)))]).
substitution(114, [binding("from", n(30)), binding("to", n(70)), binding("via", n(31))]).
proof(114, reaches(n(30), n(70)), rule(3), [uses(34, link(n(30), n(31))), uses(113, reaches(n(31), n(70)))]).
substitution(115, [binding("from", n(29)), binding("to", n(70)), binding("via", n(30))]).
proof(115, reaches(n(29), n(70)), rule(3), [uses(33, link(n(29), n(30))), uses(114, reaches(n(30), n(70)))]).
substitution(116, [binding("from", n(28)), binding("to", n(70)), binding("via", n(29))]).
proof(116, reaches(n(28), n(70)), rule(3), [uses(32, link(n(28), n(29))), uses(115, reaches(n(29), n(70)))]).
substitution(117, [binding("from", n(27)), binding("to", n(70)), binding("via", n(28))]).
proof(117, reaches(n(27), n(70)), rule(3), [uses(31, link(n(27), n(28))), uses(116, reaches(n(28), n(70)))]).
substitution(118, [binding("from", n(26)), binding("to", n(70)), binding("via", n(27))]).
proof(118, reaches(n(26), n(70)), rule(3), [uses(30, link(n(26), n(27))), uses(117, reaches(n(27), n(70)))]).
substitution(119, [binding("from", n(25)), binding("to", n(70)), binding("via", n(26))]).
proof(119, reaches(n(25), n(70)), rule(3), [uses(29, link(n(25), n(26))), uses(118, reaches(n(26), n(70)))]).
substitution(120, [binding("from", n(24)), binding("to", n(70)), binding("via", n(25))]).
proof(120, reaches(n(24), n(70)), rule(3), [uses(28, link(n(24), n(25))), uses(119, reaches(n(25), n(70)))]).
substitution(121, [binding("from", n(23)), binding("to", n(70)), binding("via", n(24))]).
proof(121, reaches(n(23), n(70)), rule(3), [uses(27, link(n(23), n(24))), uses(120, reaches(n(24), n(70)))]).
substitution(122, [binding("from", n(22)), binding("to", n(70)), binding("via", n(23))]).
proof(122, reaches(n(22), n(70)), rule(3), [uses(26, link(n(22), n(23))), uses(121, reaches(n(23), n(70)))]).
substitution(123, [binding("from", n(21)), binding("to", n(70)), binding("via", n(22))]).
proof(123, reaches(n(21), n(70)), rule(3), [uses(25, link(n(21), n(22))), uses(122, reaches(n(22), n(70)))]).
substitution(124, [binding("from", n(20)), binding("to", n(70)), binding("via", n(21))]).
proof(124, reaches(n(20), n(70)), rule(3), [uses(24, link(n(20), n(21))), uses(123, reaches(n(21), n(70)))]).
substitution(125, [binding("from", n(19)), binding("to", n(70)), binding("via", n(20))]).
proof(125, reaches(n(19), n(70)), rule(3), [uses(23, link(n(19), n(20))), uses(124, reaches(n(20), n(70)))]).
substitution(126, [binding("from", n(18)), binding("to", n(70)), binding("via", n(19))]).
proof(126, reaches(n(18), n(70)), rule(3), [uses(22, link(n(18), n(19))), uses(125, reaches(n(19), n(70)))]).
substitution(127, [binding("from", n(17)), binding("to", n(70)), binding("via", n(18))]).
proof(127, reaches(n(17), n(70)), rule(3), [uses(21, link(n(17), n(18))), uses(126, reaches(n(18), n(70)))]).
substitution(128, [binding("from", n(16)), binding("to", n(70)), binding("via", n(17))]).
proof(128, reaches(n(16), n(70)), rule(3), [uses(20, link(n(16), n(17))), uses(127, reaches(n(17), n(70)))]).
substitution(129, [binding("from", n(15)), binding("to", n(70)), binding("via", n(16))]).
proof(129, reaches(n(15), n(70)), rule(3), [uses(19, link(n(15), n(16))), uses(128, reaches(n(16), n(70)))]).
substitution(130, [binding("from", n(14)), binding("to", n(70)), binding("via", n(15))]).
proof(130, reaches(n(14), n(70)), rule(3), [uses(18, link(n(14), n(15))), uses(129, reaches(n(15), n(70)))]).
substitution(131, [binding("from", n(13)), binding("to", n(70)), binding("via", n(14))]).
proof(131, reaches(n(13), n(70)), rule(3), [uses(17, link(n(13), n(14))), uses(130, reaches(n(14), n(70)))]).
substitution(132, [binding("from", n(12)), binding("to", n(70)), binding("via", n(13))]).
proof(132, reaches(n(12), n(70)), rule(3), [uses(16, link(n(12), n(13))), uses(131, reaches(n(13), n(70)))]).
substitution(133, [binding("from", n(11)), binding("to", n(70)), binding("via", n(12))]).
proof(133, reaches(n(11), n(70)), rule(3), [uses(15, link(n(11), n(12))), uses(132, reaches(n(12), n(70)))]).
substitution(134, [binding("from", n(10)), binding("to", n(70)), binding("via", n(11))]).
proof(134, reaches(n(10), n(70)), rule(3), [uses(14, link(n(10), n(11))), uses(133, reaches(n(11), n(70)))]).
substitution(135, [binding("from", n(9)), binding("to", n(70)), binding("via", n(10))]).
proof(135, reaches(n(9), n(70)), rule(3), [uses(13, link(n(9), n(10))), uses(134, reaches(n(10), n(70)))]).
substitution(136, [binding("from", n(8)), binding("to", n(70)), binding("via", n(9))]).
proof(136, reaches(n(8), n(70)), rule(3), [uses(12, link(n(8), n(9))), uses(135, reaches(n(9), n(70)))]).
substitution(137, [binding("from", n(7)), binding("to", n(70)), binding("via", n(8))]).
proof(137, reaches(n(7), n(70)), rule(3), [uses(11, link(n(7), n(8))), uses(136, reaches(n(8), n(70)))]).
substitution(138, [binding("from", n(6)), binding("to", n(70)), binding("via", n(7))]).
proof(138, reaches(n(6), n(70)), rule(3), [uses(10, link(n(6), n(7))), uses(137, reaches(n(7), n(70)))]).
substitution(139, [binding("from", n(5)), binding("to", n(70)), binding("via", n(6))]).
proof(139, reaches(n(5), n(70)), rule(3), [uses(9, link(n(5), n(6))), uses(138, reaches(n(6), n(70)))]).
substitution(140, [binding("from", n(4)), binding("to", n(70)), binding("via", n(5))]).
proof(140, reaches(n(4), n(70)), rule(3), [uses(8, link(n(4), n(5))), uses(139, reaches(n(5), n(70)))]).
substitution(141, [binding("from", n(3)), binding("to", n(70)), binding("via", n(4))]).
proof(141, reaches(n(3), n(70)), rule(3), [uses(7, link(n(3), n(4))), uses(140, reaches(n(4), n(70)))]).
substitution(142, [binding("from", n(2)), binding("to", n(70)), binding("via", n(3))]).
proof(142, reaches(n(2), n(70)), rule(3), [uses(6, link(n(2), n(3))), uses(141, reaches(n(3), n(70)))]).
substitution(143, [binding("from", n(1)), binding("to", n(70)), binding("via", n(2))]).
proof(143, reaches(n(1), n(70)), rule(3), [uses(5, link(n(1), n(2))), uses(142, reaches(n(2), n(70)))]).
substitution(144, []).
proof(144, test_is(true), rule(6), [uses(143, reaches(n(1), n(70)))]).
substitution(145, [binding("r", true)]).
proof(145, solution([true]), query, [uses(144, test_is(true))]).
