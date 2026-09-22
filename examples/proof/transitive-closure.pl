% Prolog result format 3
query(1, direct_links(_0), ['Links' = _0]).
result(1, complete, 1).
answer(1, ['Links' = 69]).
why(1, ['Links' = 69], 2).
query(2, reachable_pairs(_0), ['Pairs' = _0]).
result(2, complete, 1).
answer(2, ['Pairs' = 2415]).
why(2, ['Pairs' = 2415], 4).
query(3, test_is(_0), ['R' = _0]).
result(3, complete, 1).
answer(3, ['R' = true]).
why(3, ['R' = true], 145).
clause(1, link(n(var('N')), n(var('Next'))), (between(1, 69, var('N')), var('Next') is var('N') + 1)).
clause(2, reaches(var('From'), var('To')), link(var('From'), var('To'))).
clause(3, reaches(var('From'), var('To')), (link(var('From'), var('Via')), reaches(var('Via'), var('To')))).
clause(4, direct_links(var('Links')), var('Links') is 70 - 1).
clause(5, reachable_pairs(var('Pairs')), (var('Max') is 70, var('Previous') is var('Max') - 1, var('Twice') is var('Max') * var('Previous'), var('Pairs') is var('Twice') // 2)).
clause(6, test_is(true), reaches(n(1), n(70))).
substitution(1, ['Links' = 69]).
proof(1, direct_links(69), rule(4), [builtin(69 is 70 - 1)]).
substitution(2, ['Links' = 69]).
proof(2, solution([69]), query, [uses(1, direct_links(69))]).
substitution(3, ['Pairs' = 2415, 'Max' = 70, 'Previous' = 69, 'Twice' = 4830]).
proof(3, reachable_pairs(2415), rule(5), [builtin(70 is 70), builtin(69 is 70 - 1), builtin(4830 is 70 * 69), builtin(2415 is 4830 // 2)]).
substitution(4, ['Pairs' = 2415]).
proof(4, solution([2415]), query, [uses(3, reachable_pairs(2415))]).
substitution(5, ['N' = 1, 'Next' = 2]).
proof(5, link(n(1), n(2)), rule(1), [builtin(between(1, 69, 1)), builtin(2 is 1 + 1)]).
substitution(6, ['N' = 2, 'Next' = 3]).
proof(6, link(n(2), n(3)), rule(1), [builtin(between(1, 69, 2)), builtin(3 is 2 + 1)]).
substitution(7, ['N' = 3, 'Next' = 4]).
proof(7, link(n(3), n(4)), rule(1), [builtin(between(1, 69, 3)), builtin(4 is 3 + 1)]).
substitution(8, ['N' = 4, 'Next' = 5]).
proof(8, link(n(4), n(5)), rule(1), [builtin(between(1, 69, 4)), builtin(5 is 4 + 1)]).
substitution(9, ['N' = 5, 'Next' = 6]).
proof(9, link(n(5), n(6)), rule(1), [builtin(between(1, 69, 5)), builtin(6 is 5 + 1)]).
substitution(10, ['N' = 6, 'Next' = 7]).
proof(10, link(n(6), n(7)), rule(1), [builtin(between(1, 69, 6)), builtin(7 is 6 + 1)]).
substitution(11, ['N' = 7, 'Next' = 8]).
proof(11, link(n(7), n(8)), rule(1), [builtin(between(1, 69, 7)), builtin(8 is 7 + 1)]).
substitution(12, ['N' = 8, 'Next' = 9]).
proof(12, link(n(8), n(9)), rule(1), [builtin(between(1, 69, 8)), builtin(9 is 8 + 1)]).
substitution(13, ['N' = 9, 'Next' = 10]).
proof(13, link(n(9), n(10)), rule(1), [builtin(between(1, 69, 9)), builtin(10 is 9 + 1)]).
substitution(14, ['N' = 10, 'Next' = 11]).
proof(14, link(n(10), n(11)), rule(1), [builtin(between(1, 69, 10)), builtin(11 is 10 + 1)]).
substitution(15, ['N' = 11, 'Next' = 12]).
proof(15, link(n(11), n(12)), rule(1), [builtin(between(1, 69, 11)), builtin(12 is 11 + 1)]).
substitution(16, ['N' = 12, 'Next' = 13]).
proof(16, link(n(12), n(13)), rule(1), [builtin(between(1, 69, 12)), builtin(13 is 12 + 1)]).
substitution(17, ['N' = 13, 'Next' = 14]).
proof(17, link(n(13), n(14)), rule(1), [builtin(between(1, 69, 13)), builtin(14 is 13 + 1)]).
substitution(18, ['N' = 14, 'Next' = 15]).
proof(18, link(n(14), n(15)), rule(1), [builtin(between(1, 69, 14)), builtin(15 is 14 + 1)]).
substitution(19, ['N' = 15, 'Next' = 16]).
proof(19, link(n(15), n(16)), rule(1), [builtin(between(1, 69, 15)), builtin(16 is 15 + 1)]).
substitution(20, ['N' = 16, 'Next' = 17]).
proof(20, link(n(16), n(17)), rule(1), [builtin(between(1, 69, 16)), builtin(17 is 16 + 1)]).
substitution(21, ['N' = 17, 'Next' = 18]).
proof(21, link(n(17), n(18)), rule(1), [builtin(between(1, 69, 17)), builtin(18 is 17 + 1)]).
substitution(22, ['N' = 18, 'Next' = 19]).
proof(22, link(n(18), n(19)), rule(1), [builtin(between(1, 69, 18)), builtin(19 is 18 + 1)]).
substitution(23, ['N' = 19, 'Next' = 20]).
proof(23, link(n(19), n(20)), rule(1), [builtin(between(1, 69, 19)), builtin(20 is 19 + 1)]).
substitution(24, ['N' = 20, 'Next' = 21]).
proof(24, link(n(20), n(21)), rule(1), [builtin(between(1, 69, 20)), builtin(21 is 20 + 1)]).
substitution(25, ['N' = 21, 'Next' = 22]).
proof(25, link(n(21), n(22)), rule(1), [builtin(between(1, 69, 21)), builtin(22 is 21 + 1)]).
substitution(26, ['N' = 22, 'Next' = 23]).
proof(26, link(n(22), n(23)), rule(1), [builtin(between(1, 69, 22)), builtin(23 is 22 + 1)]).
substitution(27, ['N' = 23, 'Next' = 24]).
proof(27, link(n(23), n(24)), rule(1), [builtin(between(1, 69, 23)), builtin(24 is 23 + 1)]).
substitution(28, ['N' = 24, 'Next' = 25]).
proof(28, link(n(24), n(25)), rule(1), [builtin(between(1, 69, 24)), builtin(25 is 24 + 1)]).
substitution(29, ['N' = 25, 'Next' = 26]).
proof(29, link(n(25), n(26)), rule(1), [builtin(between(1, 69, 25)), builtin(26 is 25 + 1)]).
substitution(30, ['N' = 26, 'Next' = 27]).
proof(30, link(n(26), n(27)), rule(1), [builtin(between(1, 69, 26)), builtin(27 is 26 + 1)]).
substitution(31, ['N' = 27, 'Next' = 28]).
proof(31, link(n(27), n(28)), rule(1), [builtin(between(1, 69, 27)), builtin(28 is 27 + 1)]).
substitution(32, ['N' = 28, 'Next' = 29]).
proof(32, link(n(28), n(29)), rule(1), [builtin(between(1, 69, 28)), builtin(29 is 28 + 1)]).
substitution(33, ['N' = 29, 'Next' = 30]).
proof(33, link(n(29), n(30)), rule(1), [builtin(between(1, 69, 29)), builtin(30 is 29 + 1)]).
substitution(34, ['N' = 30, 'Next' = 31]).
proof(34, link(n(30), n(31)), rule(1), [builtin(between(1, 69, 30)), builtin(31 is 30 + 1)]).
substitution(35, ['N' = 31, 'Next' = 32]).
proof(35, link(n(31), n(32)), rule(1), [builtin(between(1, 69, 31)), builtin(32 is 31 + 1)]).
substitution(36, ['N' = 32, 'Next' = 33]).
proof(36, link(n(32), n(33)), rule(1), [builtin(between(1, 69, 32)), builtin(33 is 32 + 1)]).
substitution(37, ['N' = 33, 'Next' = 34]).
proof(37, link(n(33), n(34)), rule(1), [builtin(between(1, 69, 33)), builtin(34 is 33 + 1)]).
substitution(38, ['N' = 34, 'Next' = 35]).
proof(38, link(n(34), n(35)), rule(1), [builtin(between(1, 69, 34)), builtin(35 is 34 + 1)]).
substitution(39, ['N' = 35, 'Next' = 36]).
proof(39, link(n(35), n(36)), rule(1), [builtin(between(1, 69, 35)), builtin(36 is 35 + 1)]).
substitution(40, ['N' = 36, 'Next' = 37]).
proof(40, link(n(36), n(37)), rule(1), [builtin(between(1, 69, 36)), builtin(37 is 36 + 1)]).
substitution(41, ['N' = 37, 'Next' = 38]).
proof(41, link(n(37), n(38)), rule(1), [builtin(between(1, 69, 37)), builtin(38 is 37 + 1)]).
substitution(42, ['N' = 38, 'Next' = 39]).
proof(42, link(n(38), n(39)), rule(1), [builtin(between(1, 69, 38)), builtin(39 is 38 + 1)]).
substitution(43, ['N' = 39, 'Next' = 40]).
proof(43, link(n(39), n(40)), rule(1), [builtin(between(1, 69, 39)), builtin(40 is 39 + 1)]).
substitution(44, ['N' = 40, 'Next' = 41]).
proof(44, link(n(40), n(41)), rule(1), [builtin(between(1, 69, 40)), builtin(41 is 40 + 1)]).
substitution(45, ['N' = 41, 'Next' = 42]).
proof(45, link(n(41), n(42)), rule(1), [builtin(between(1, 69, 41)), builtin(42 is 41 + 1)]).
substitution(46, ['N' = 42, 'Next' = 43]).
proof(46, link(n(42), n(43)), rule(1), [builtin(between(1, 69, 42)), builtin(43 is 42 + 1)]).
substitution(47, ['N' = 43, 'Next' = 44]).
proof(47, link(n(43), n(44)), rule(1), [builtin(between(1, 69, 43)), builtin(44 is 43 + 1)]).
substitution(48, ['N' = 44, 'Next' = 45]).
proof(48, link(n(44), n(45)), rule(1), [builtin(between(1, 69, 44)), builtin(45 is 44 + 1)]).
substitution(49, ['N' = 45, 'Next' = 46]).
proof(49, link(n(45), n(46)), rule(1), [builtin(between(1, 69, 45)), builtin(46 is 45 + 1)]).
substitution(50, ['N' = 46, 'Next' = 47]).
proof(50, link(n(46), n(47)), rule(1), [builtin(between(1, 69, 46)), builtin(47 is 46 + 1)]).
substitution(51, ['N' = 47, 'Next' = 48]).
proof(51, link(n(47), n(48)), rule(1), [builtin(between(1, 69, 47)), builtin(48 is 47 + 1)]).
substitution(52, ['N' = 48, 'Next' = 49]).
proof(52, link(n(48), n(49)), rule(1), [builtin(between(1, 69, 48)), builtin(49 is 48 + 1)]).
substitution(53, ['N' = 49, 'Next' = 50]).
proof(53, link(n(49), n(50)), rule(1), [builtin(between(1, 69, 49)), builtin(50 is 49 + 1)]).
substitution(54, ['N' = 50, 'Next' = 51]).
proof(54, link(n(50), n(51)), rule(1), [builtin(between(1, 69, 50)), builtin(51 is 50 + 1)]).
substitution(55, ['N' = 51, 'Next' = 52]).
proof(55, link(n(51), n(52)), rule(1), [builtin(between(1, 69, 51)), builtin(52 is 51 + 1)]).
substitution(56, ['N' = 52, 'Next' = 53]).
proof(56, link(n(52), n(53)), rule(1), [builtin(between(1, 69, 52)), builtin(53 is 52 + 1)]).
substitution(57, ['N' = 53, 'Next' = 54]).
proof(57, link(n(53), n(54)), rule(1), [builtin(between(1, 69, 53)), builtin(54 is 53 + 1)]).
substitution(58, ['N' = 54, 'Next' = 55]).
proof(58, link(n(54), n(55)), rule(1), [builtin(between(1, 69, 54)), builtin(55 is 54 + 1)]).
substitution(59, ['N' = 55, 'Next' = 56]).
proof(59, link(n(55), n(56)), rule(1), [builtin(between(1, 69, 55)), builtin(56 is 55 + 1)]).
substitution(60, ['N' = 56, 'Next' = 57]).
proof(60, link(n(56), n(57)), rule(1), [builtin(between(1, 69, 56)), builtin(57 is 56 + 1)]).
substitution(61, ['N' = 57, 'Next' = 58]).
proof(61, link(n(57), n(58)), rule(1), [builtin(between(1, 69, 57)), builtin(58 is 57 + 1)]).
substitution(62, ['N' = 58, 'Next' = 59]).
proof(62, link(n(58), n(59)), rule(1), [builtin(between(1, 69, 58)), builtin(59 is 58 + 1)]).
substitution(63, ['N' = 59, 'Next' = 60]).
proof(63, link(n(59), n(60)), rule(1), [builtin(between(1, 69, 59)), builtin(60 is 59 + 1)]).
substitution(64, ['N' = 60, 'Next' = 61]).
proof(64, link(n(60), n(61)), rule(1), [builtin(between(1, 69, 60)), builtin(61 is 60 + 1)]).
substitution(65, ['N' = 61, 'Next' = 62]).
proof(65, link(n(61), n(62)), rule(1), [builtin(between(1, 69, 61)), builtin(62 is 61 + 1)]).
substitution(66, ['N' = 62, 'Next' = 63]).
proof(66, link(n(62), n(63)), rule(1), [builtin(between(1, 69, 62)), builtin(63 is 62 + 1)]).
substitution(67, ['N' = 63, 'Next' = 64]).
proof(67, link(n(63), n(64)), rule(1), [builtin(between(1, 69, 63)), builtin(64 is 63 + 1)]).
substitution(68, ['N' = 64, 'Next' = 65]).
proof(68, link(n(64), n(65)), rule(1), [builtin(between(1, 69, 64)), builtin(65 is 64 + 1)]).
substitution(69, ['N' = 65, 'Next' = 66]).
proof(69, link(n(65), n(66)), rule(1), [builtin(between(1, 69, 65)), builtin(66 is 65 + 1)]).
substitution(70, ['N' = 66, 'Next' = 67]).
proof(70, link(n(66), n(67)), rule(1), [builtin(between(1, 69, 66)), builtin(67 is 66 + 1)]).
substitution(71, ['N' = 67, 'Next' = 68]).
proof(71, link(n(67), n(68)), rule(1), [builtin(between(1, 69, 67)), builtin(68 is 67 + 1)]).
substitution(72, ['N' = 68, 'Next' = 69]).
proof(72, link(n(68), n(69)), rule(1), [builtin(between(1, 69, 68)), builtin(69 is 68 + 1)]).
substitution(73, ['N' = 69, 'Next' = 70]).
proof(73, link(n(69), n(70)), rule(1), [builtin(between(1, 69, 69)), builtin(70 is 69 + 1)]).
substitution(74, ['N' = 69, 'Next' = 70]).
proof(74, link(n(69), n(70)), rule(1), [builtin(between(1, 69, 69)), builtin(70 is 69 + 1)]).
substitution(75, ['From' = n(69), 'To' = n(70)]).
proof(75, reaches(n(69), n(70)), rule(2), [uses(73, link(n(69), n(70)))]).
substitution(76, ['From' = n(68), 'To' = n(70), 'Via' = n(69)]).
proof(76, reaches(n(68), n(70)), rule(3), [uses(72, link(n(68), n(69))), uses(75, reaches(n(69), n(70)))]).
substitution(77, ['From' = n(67), 'To' = n(70), 'Via' = n(68)]).
proof(77, reaches(n(67), n(70)), rule(3), [uses(71, link(n(67), n(68))), uses(76, reaches(n(68), n(70)))]).
substitution(78, ['From' = n(66), 'To' = n(70), 'Via' = n(67)]).
proof(78, reaches(n(66), n(70)), rule(3), [uses(70, link(n(66), n(67))), uses(77, reaches(n(67), n(70)))]).
substitution(79, ['From' = n(65), 'To' = n(70), 'Via' = n(66)]).
proof(79, reaches(n(65), n(70)), rule(3), [uses(69, link(n(65), n(66))), uses(78, reaches(n(66), n(70)))]).
substitution(80, ['From' = n(64), 'To' = n(70), 'Via' = n(65)]).
proof(80, reaches(n(64), n(70)), rule(3), [uses(68, link(n(64), n(65))), uses(79, reaches(n(65), n(70)))]).
substitution(81, ['From' = n(63), 'To' = n(70), 'Via' = n(64)]).
proof(81, reaches(n(63), n(70)), rule(3), [uses(67, link(n(63), n(64))), uses(80, reaches(n(64), n(70)))]).
substitution(82, ['From' = n(62), 'To' = n(70), 'Via' = n(63)]).
proof(82, reaches(n(62), n(70)), rule(3), [uses(66, link(n(62), n(63))), uses(81, reaches(n(63), n(70)))]).
substitution(83, ['From' = n(61), 'To' = n(70), 'Via' = n(62)]).
proof(83, reaches(n(61), n(70)), rule(3), [uses(65, link(n(61), n(62))), uses(82, reaches(n(62), n(70)))]).
substitution(84, ['From' = n(60), 'To' = n(70), 'Via' = n(61)]).
proof(84, reaches(n(60), n(70)), rule(3), [uses(64, link(n(60), n(61))), uses(83, reaches(n(61), n(70)))]).
substitution(85, ['From' = n(59), 'To' = n(70), 'Via' = n(60)]).
proof(85, reaches(n(59), n(70)), rule(3), [uses(63, link(n(59), n(60))), uses(84, reaches(n(60), n(70)))]).
substitution(86, ['From' = n(58), 'To' = n(70), 'Via' = n(59)]).
proof(86, reaches(n(58), n(70)), rule(3), [uses(62, link(n(58), n(59))), uses(85, reaches(n(59), n(70)))]).
substitution(87, ['From' = n(57), 'To' = n(70), 'Via' = n(58)]).
proof(87, reaches(n(57), n(70)), rule(3), [uses(61, link(n(57), n(58))), uses(86, reaches(n(58), n(70)))]).
substitution(88, ['From' = n(56), 'To' = n(70), 'Via' = n(57)]).
proof(88, reaches(n(56), n(70)), rule(3), [uses(60, link(n(56), n(57))), uses(87, reaches(n(57), n(70)))]).
substitution(89, ['From' = n(55), 'To' = n(70), 'Via' = n(56)]).
proof(89, reaches(n(55), n(70)), rule(3), [uses(59, link(n(55), n(56))), uses(88, reaches(n(56), n(70)))]).
substitution(90, ['From' = n(54), 'To' = n(70), 'Via' = n(55)]).
proof(90, reaches(n(54), n(70)), rule(3), [uses(58, link(n(54), n(55))), uses(89, reaches(n(55), n(70)))]).
substitution(91, ['From' = n(53), 'To' = n(70), 'Via' = n(54)]).
proof(91, reaches(n(53), n(70)), rule(3), [uses(57, link(n(53), n(54))), uses(90, reaches(n(54), n(70)))]).
substitution(92, ['From' = n(52), 'To' = n(70), 'Via' = n(53)]).
proof(92, reaches(n(52), n(70)), rule(3), [uses(56, link(n(52), n(53))), uses(91, reaches(n(53), n(70)))]).
substitution(93, ['From' = n(51), 'To' = n(70), 'Via' = n(52)]).
proof(93, reaches(n(51), n(70)), rule(3), [uses(55, link(n(51), n(52))), uses(92, reaches(n(52), n(70)))]).
substitution(94, ['From' = n(50), 'To' = n(70), 'Via' = n(51)]).
proof(94, reaches(n(50), n(70)), rule(3), [uses(54, link(n(50), n(51))), uses(93, reaches(n(51), n(70)))]).
substitution(95, ['From' = n(49), 'To' = n(70), 'Via' = n(50)]).
proof(95, reaches(n(49), n(70)), rule(3), [uses(53, link(n(49), n(50))), uses(94, reaches(n(50), n(70)))]).
substitution(96, ['From' = n(48), 'To' = n(70), 'Via' = n(49)]).
proof(96, reaches(n(48), n(70)), rule(3), [uses(52, link(n(48), n(49))), uses(95, reaches(n(49), n(70)))]).
substitution(97, ['From' = n(47), 'To' = n(70), 'Via' = n(48)]).
proof(97, reaches(n(47), n(70)), rule(3), [uses(51, link(n(47), n(48))), uses(96, reaches(n(48), n(70)))]).
substitution(98, ['From' = n(46), 'To' = n(70), 'Via' = n(47)]).
proof(98, reaches(n(46), n(70)), rule(3), [uses(50, link(n(46), n(47))), uses(97, reaches(n(47), n(70)))]).
substitution(99, ['From' = n(45), 'To' = n(70), 'Via' = n(46)]).
proof(99, reaches(n(45), n(70)), rule(3), [uses(49, link(n(45), n(46))), uses(98, reaches(n(46), n(70)))]).
substitution(100, ['From' = n(44), 'To' = n(70), 'Via' = n(45)]).
proof(100, reaches(n(44), n(70)), rule(3), [uses(48, link(n(44), n(45))), uses(99, reaches(n(45), n(70)))]).
substitution(101, ['From' = n(43), 'To' = n(70), 'Via' = n(44)]).
proof(101, reaches(n(43), n(70)), rule(3), [uses(47, link(n(43), n(44))), uses(100, reaches(n(44), n(70)))]).
substitution(102, ['From' = n(42), 'To' = n(70), 'Via' = n(43)]).
proof(102, reaches(n(42), n(70)), rule(3), [uses(46, link(n(42), n(43))), uses(101, reaches(n(43), n(70)))]).
substitution(103, ['From' = n(41), 'To' = n(70), 'Via' = n(42)]).
proof(103, reaches(n(41), n(70)), rule(3), [uses(45, link(n(41), n(42))), uses(102, reaches(n(42), n(70)))]).
substitution(104, ['From' = n(40), 'To' = n(70), 'Via' = n(41)]).
proof(104, reaches(n(40), n(70)), rule(3), [uses(44, link(n(40), n(41))), uses(103, reaches(n(41), n(70)))]).
substitution(105, ['From' = n(39), 'To' = n(70), 'Via' = n(40)]).
proof(105, reaches(n(39), n(70)), rule(3), [uses(43, link(n(39), n(40))), uses(104, reaches(n(40), n(70)))]).
substitution(106, ['From' = n(38), 'To' = n(70), 'Via' = n(39)]).
proof(106, reaches(n(38), n(70)), rule(3), [uses(42, link(n(38), n(39))), uses(105, reaches(n(39), n(70)))]).
substitution(107, ['From' = n(37), 'To' = n(70), 'Via' = n(38)]).
proof(107, reaches(n(37), n(70)), rule(3), [uses(41, link(n(37), n(38))), uses(106, reaches(n(38), n(70)))]).
substitution(108, ['From' = n(36), 'To' = n(70), 'Via' = n(37)]).
proof(108, reaches(n(36), n(70)), rule(3), [uses(40, link(n(36), n(37))), uses(107, reaches(n(37), n(70)))]).
substitution(109, ['From' = n(35), 'To' = n(70), 'Via' = n(36)]).
proof(109, reaches(n(35), n(70)), rule(3), [uses(39, link(n(35), n(36))), uses(108, reaches(n(36), n(70)))]).
substitution(110, ['From' = n(34), 'To' = n(70), 'Via' = n(35)]).
proof(110, reaches(n(34), n(70)), rule(3), [uses(38, link(n(34), n(35))), uses(109, reaches(n(35), n(70)))]).
substitution(111, ['From' = n(33), 'To' = n(70), 'Via' = n(34)]).
proof(111, reaches(n(33), n(70)), rule(3), [uses(37, link(n(33), n(34))), uses(110, reaches(n(34), n(70)))]).
substitution(112, ['From' = n(32), 'To' = n(70), 'Via' = n(33)]).
proof(112, reaches(n(32), n(70)), rule(3), [uses(36, link(n(32), n(33))), uses(111, reaches(n(33), n(70)))]).
substitution(113, ['From' = n(31), 'To' = n(70), 'Via' = n(32)]).
proof(113, reaches(n(31), n(70)), rule(3), [uses(35, link(n(31), n(32))), uses(112, reaches(n(32), n(70)))]).
substitution(114, ['From' = n(30), 'To' = n(70), 'Via' = n(31)]).
proof(114, reaches(n(30), n(70)), rule(3), [uses(34, link(n(30), n(31))), uses(113, reaches(n(31), n(70)))]).
substitution(115, ['From' = n(29), 'To' = n(70), 'Via' = n(30)]).
proof(115, reaches(n(29), n(70)), rule(3), [uses(33, link(n(29), n(30))), uses(114, reaches(n(30), n(70)))]).
substitution(116, ['From' = n(28), 'To' = n(70), 'Via' = n(29)]).
proof(116, reaches(n(28), n(70)), rule(3), [uses(32, link(n(28), n(29))), uses(115, reaches(n(29), n(70)))]).
substitution(117, ['From' = n(27), 'To' = n(70), 'Via' = n(28)]).
proof(117, reaches(n(27), n(70)), rule(3), [uses(31, link(n(27), n(28))), uses(116, reaches(n(28), n(70)))]).
substitution(118, ['From' = n(26), 'To' = n(70), 'Via' = n(27)]).
proof(118, reaches(n(26), n(70)), rule(3), [uses(30, link(n(26), n(27))), uses(117, reaches(n(27), n(70)))]).
substitution(119, ['From' = n(25), 'To' = n(70), 'Via' = n(26)]).
proof(119, reaches(n(25), n(70)), rule(3), [uses(29, link(n(25), n(26))), uses(118, reaches(n(26), n(70)))]).
substitution(120, ['From' = n(24), 'To' = n(70), 'Via' = n(25)]).
proof(120, reaches(n(24), n(70)), rule(3), [uses(28, link(n(24), n(25))), uses(119, reaches(n(25), n(70)))]).
substitution(121, ['From' = n(23), 'To' = n(70), 'Via' = n(24)]).
proof(121, reaches(n(23), n(70)), rule(3), [uses(27, link(n(23), n(24))), uses(120, reaches(n(24), n(70)))]).
substitution(122, ['From' = n(22), 'To' = n(70), 'Via' = n(23)]).
proof(122, reaches(n(22), n(70)), rule(3), [uses(26, link(n(22), n(23))), uses(121, reaches(n(23), n(70)))]).
substitution(123, ['From' = n(21), 'To' = n(70), 'Via' = n(22)]).
proof(123, reaches(n(21), n(70)), rule(3), [uses(25, link(n(21), n(22))), uses(122, reaches(n(22), n(70)))]).
substitution(124, ['From' = n(20), 'To' = n(70), 'Via' = n(21)]).
proof(124, reaches(n(20), n(70)), rule(3), [uses(24, link(n(20), n(21))), uses(123, reaches(n(21), n(70)))]).
substitution(125, ['From' = n(19), 'To' = n(70), 'Via' = n(20)]).
proof(125, reaches(n(19), n(70)), rule(3), [uses(23, link(n(19), n(20))), uses(124, reaches(n(20), n(70)))]).
substitution(126, ['From' = n(18), 'To' = n(70), 'Via' = n(19)]).
proof(126, reaches(n(18), n(70)), rule(3), [uses(22, link(n(18), n(19))), uses(125, reaches(n(19), n(70)))]).
substitution(127, ['From' = n(17), 'To' = n(70), 'Via' = n(18)]).
proof(127, reaches(n(17), n(70)), rule(3), [uses(21, link(n(17), n(18))), uses(126, reaches(n(18), n(70)))]).
substitution(128, ['From' = n(16), 'To' = n(70), 'Via' = n(17)]).
proof(128, reaches(n(16), n(70)), rule(3), [uses(20, link(n(16), n(17))), uses(127, reaches(n(17), n(70)))]).
substitution(129, ['From' = n(15), 'To' = n(70), 'Via' = n(16)]).
proof(129, reaches(n(15), n(70)), rule(3), [uses(19, link(n(15), n(16))), uses(128, reaches(n(16), n(70)))]).
substitution(130, ['From' = n(14), 'To' = n(70), 'Via' = n(15)]).
proof(130, reaches(n(14), n(70)), rule(3), [uses(18, link(n(14), n(15))), uses(129, reaches(n(15), n(70)))]).
substitution(131, ['From' = n(13), 'To' = n(70), 'Via' = n(14)]).
proof(131, reaches(n(13), n(70)), rule(3), [uses(17, link(n(13), n(14))), uses(130, reaches(n(14), n(70)))]).
substitution(132, ['From' = n(12), 'To' = n(70), 'Via' = n(13)]).
proof(132, reaches(n(12), n(70)), rule(3), [uses(16, link(n(12), n(13))), uses(131, reaches(n(13), n(70)))]).
substitution(133, ['From' = n(11), 'To' = n(70), 'Via' = n(12)]).
proof(133, reaches(n(11), n(70)), rule(3), [uses(15, link(n(11), n(12))), uses(132, reaches(n(12), n(70)))]).
substitution(134, ['From' = n(10), 'To' = n(70), 'Via' = n(11)]).
proof(134, reaches(n(10), n(70)), rule(3), [uses(14, link(n(10), n(11))), uses(133, reaches(n(11), n(70)))]).
substitution(135, ['From' = n(9), 'To' = n(70), 'Via' = n(10)]).
proof(135, reaches(n(9), n(70)), rule(3), [uses(13, link(n(9), n(10))), uses(134, reaches(n(10), n(70)))]).
substitution(136, ['From' = n(8), 'To' = n(70), 'Via' = n(9)]).
proof(136, reaches(n(8), n(70)), rule(3), [uses(12, link(n(8), n(9))), uses(135, reaches(n(9), n(70)))]).
substitution(137, ['From' = n(7), 'To' = n(70), 'Via' = n(8)]).
proof(137, reaches(n(7), n(70)), rule(3), [uses(11, link(n(7), n(8))), uses(136, reaches(n(8), n(70)))]).
substitution(138, ['From' = n(6), 'To' = n(70), 'Via' = n(7)]).
proof(138, reaches(n(6), n(70)), rule(3), [uses(10, link(n(6), n(7))), uses(137, reaches(n(7), n(70)))]).
substitution(139, ['From' = n(5), 'To' = n(70), 'Via' = n(6)]).
proof(139, reaches(n(5), n(70)), rule(3), [uses(9, link(n(5), n(6))), uses(138, reaches(n(6), n(70)))]).
substitution(140, ['From' = n(4), 'To' = n(70), 'Via' = n(5)]).
proof(140, reaches(n(4), n(70)), rule(3), [uses(8, link(n(4), n(5))), uses(139, reaches(n(5), n(70)))]).
substitution(141, ['From' = n(3), 'To' = n(70), 'Via' = n(4)]).
proof(141, reaches(n(3), n(70)), rule(3), [uses(7, link(n(3), n(4))), uses(140, reaches(n(4), n(70)))]).
substitution(142, ['From' = n(2), 'To' = n(70), 'Via' = n(3)]).
proof(142, reaches(n(2), n(70)), rule(3), [uses(6, link(n(2), n(3))), uses(141, reaches(n(3), n(70)))]).
substitution(143, ['From' = n(1), 'To' = n(70), 'Via' = n(2)]).
proof(143, reaches(n(1), n(70)), rule(3), [uses(5, link(n(1), n(2))), uses(142, reaches(n(2), n(70)))]).
substitution(144, []).
proof(144, test_is(true), rule(6), [uses(143, reaches(n(1), n(70)))]).
substitution(145, ['R' = true]).
proof(145, solution([true]), query, [uses(144, test_is(true))]).
