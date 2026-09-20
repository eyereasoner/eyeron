# Eyelang result format 2
query(1, [call(inherits_requirement(?v0, ?v1))], [binding("l", ?v0), binding("r", ?v1)]).
result(1, complete, 4).
answer(1, [binding("l", r2), binding("r", stiffnessReq)]).
why(1, [binding("l", r2), binding("r", stiffnessReq)], 7).
answer(1, [binding("l", r2), binding("r", assemblyReq)]).
why(1, [binding("l", r2), binding("r", assemblyReq)], 8).
answer(1, [binding("l", r3), binding("r", stiffnessReq)]).
why(1, [binding("l", r3), binding("r", stiffnessReq)], 23).
answer(1, [binding("l", r3), binding("r", assemblyReq)]).
why(1, [binding("l", r3), binding("r", assemblyReq)], 24).
query(2, [call(considers(?v0, ?v1))], [binding("rev", ?v0), binding("o", ?v1)]).
result(2, complete, 2).
answer(2, [binding("rev", r2), binding("o", carbonFrame)]).
why(2, [binding("rev", r2), binding("o", carbonFrame)], 31).
answer(2, [binding("rev", r3), binding("o", ribbedHousing)]).
why(2, [binding("rev", r3), binding("o", ribbedHousing)], 32).
query(3, [call(preserves(?v0, ?v1))], [binding("rev", ?v0), binding("r", ?v1)]).
result(3, complete, 3).
answer(3, [binding("rev", r2), binding("r", stiffnessReq)]).
why(3, [binding("rev", r2), binding("r", stiffnessReq)], 51).
answer(3, [binding("rev", r2), binding("r", assemblyReq)]).
why(3, [binding("rev", r2), binding("r", assemblyReq)], 52).
answer(3, [binding("rev", r3), binding("r", assemblyReq)]).
why(3, [binding("rev", r3), binding("r", assemblyReq)], 62).
query(4, [call(integrates(?v0, ?v1))], [binding("rev", ?v0), binding("o", ?v1)]).
result(4, complete, 2).
answer(4, [binding("rev", r2), binding("o", carbonFrame)]).
why(4, [binding("rev", r2), binding("o", carbonFrame)], 80).
answer(4, [binding("rev", r3), binding("o", ribbedHousing)]).
why(4, [binding("rev", r3), binding("o", ribbedHousing)], 90).
query(5, [call(satisfies(?v0, ?v1))], [binding("rev", ?v0), binding("r", ?v1)]).
result(5, complete, 5).
answer(5, [binding("rev", r1), binding("r", stiffnessReq)]).
why(5, [binding("rev", r1), binding("r", stiffnessReq)], 93).
answer(5, [binding("rev", r1), binding("r", assemblyReq)]).
why(5, [binding("rev", r1), binding("r", assemblyReq)], 94).
answer(5, [binding("rev", r2), binding("r", stiffnessReq)]).
why(5, [binding("rev", r2), binding("r", stiffnessReq)], 117).
answer(5, [binding("rev", r2), binding("r", assemblyReq)]).
why(5, [binding("rev", r2), binding("r", assemblyReq)], 118).
answer(5, [binding("rev", r3), binding("r", assemblyReq)]).
why(5, [binding("rev", r3), binding("r", assemblyReq)], 127).
query(6, [call(realizes(?v0, ?v1))], [binding("rev", ?v0), binding("o", ?v1)]).
result(6, complete, 3).
answer(6, [binding("rev", r1), binding("o", aluminumFrame)]).
why(6, [binding("rev", r1), binding("o", aluminumFrame)], 129).
answer(6, [binding("rev", r2), binding("o", carbonFrame)]).
why(6, [binding("rev", r2), binding("o", carbonFrame)], 150).
answer(6, [binding("rev", r3), binding("o", ribbedHousing)]).
why(6, [binding("rev", r3), binding("o", ribbedHousing)], 159).
query(7, [call(status(?v0, ?v1))], [binding("rev", ?v0), binding("s", ?v1)]).
result(7, complete, 3).
answer(7, [binding("rev", r1), binding("s", approvedBaseline)]).
why(7, [binding("rev", r1), binding("s", approvedBaseline)], 163).
answer(7, [binding("rev", r2), binding("s", approvedBaseline)]).
why(7, [binding("rev", r2), binding("s", approvedBaseline)], 188).
answer(7, [binding("rev", r3), binding("s", approvedBaseline)]).
why(7, [binding("rev", r3), binding("s", approvedBaseline)], 197).
query(8, [call(available_for_future_iteration(?v0, ?v1))], [binding("rev", ?v0), binding("y", ?v1)]).
result(8, complete, 3).
answer(8, [binding("rev", r1), binding("y", yes)]).
why(8, [binding("rev", r1), binding("y", yes)], 200).
answer(8, [binding("rev", r2), binding("y", yes)]).
why(8, [binding("rev", r2), binding("y", yes)], 224).
answer(8, [binding("rev", r3), binding("y", yes)]).
why(8, [binding("rev", r3), binding("y", yes)], 232).
clause(1, suggests(reduceWeight, carbonFrame), []).
clause(2, suggests(improveCooling, ribbedHousing), []).
clause(3, compatible_with(carbonFrame, stiffnessReq), []).
clause(4, compatible_with(carbonFrame, assemblyReq), []).
clause(6, compatible_with(ribbedHousing, assemblyReq), []).
clause(7, satisfies(r1, stiffnessReq), []).
clause(8, satisfies(r1, assemblyReq), []).
clause(9, realizes(r1, aluminumFrame), []).
clause(10, achieves(r1, approvedBaseline), []).
clause(11, derives_from(r2, r1), []).
clause(12, design_goal(r2, reduceWeight), []).
clause(13, derives_from(r3, r2), []).
clause(14, design_goal(r3, improveCooling), []).
clause(15, inherits_requirement(var("later"), var("req")), [call(derives_from(var("later"), var("earlier"))), call(satisfies(var("earlier"), var("req")))]).
clause(16, considers(var("rev"), var("opt")), [call(design_goal(var("rev"), var("goal"))), call(suggests(var("goal"), var("opt")))]).
clause(17, preserves(var("rev"), var("req")), [call(inherits_requirement(var("rev"), var("req"))), call(considers(var("rev"), var("opt"))), call(compatible_with(var("opt"), var("req")))]).
clause(18, integrates(var("rev"), var("opt")), [call(inherits_requirement(var("rev"), var("req"))), call(considers(var("rev"), var("opt"))), call(compatible_with(var("opt"), var("req")))]).
clause(19, satisfies(var("rev"), var("req")), [call(preserves(var("rev"), var("req")))]).
clause(20, realizes(var("rev"), var("opt")), [call(integrates(var("rev"), var("opt")))]).
clause(21, achieves(var("rev"), approvedBaseline), [call(realizes(var("rev"), var("opt")))]).
clause(22, available_for_future_iteration(var("rev"), yes), [call(realizes(var("rev"), var("opt")))]).
clause(23, status(var("rev"), approvedBaseline), [call(achieves(var("rev"), approvedBaseline))]).
substitution(1, []).
proof(1, derives_from(r2, r1), rule(11), []).
substitution(2, []).
proof(2, derives_from(r3, r2), rule(13), []).
substitution(3, []).
proof(3, satisfies(r1, stiffnessReq), rule(7), []).
substitution(4, []).
proof(4, satisfies(r1, assemblyReq), rule(8), []).
substitution(5, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(5, inherits_requirement(r2, stiffnessReq), rule(15), [uses(1, derives_from(r2, r1)), uses(3, satisfies(r1, stiffnessReq))]).
substitution(6, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(6, inherits_requirement(r2, assemblyReq), rule(15), [uses(1, derives_from(r2, r1)), uses(4, satisfies(r1, assemblyReq))]).
substitution(7, [binding("l", r2), binding("r", stiffnessReq)]).
proof(7, solution([r2, stiffnessReq]), query, [uses(5, inherits_requirement(r2, stiffnessReq))]).
substitution(8, [binding("l", r2), binding("r", assemblyReq)]).
proof(8, solution([r2, assemblyReq]), query, [uses(6, inherits_requirement(r2, assemblyReq))]).
substitution(9, []).
proof(9, derives_from(r2, r1), rule(11), []).
substitution(10, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(10, inherits_requirement(r2, stiffnessReq), rule(15), [uses(9, derives_from(r2, r1)), uses(3, satisfies(r1, stiffnessReq))]).
substitution(11, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(11, inherits_requirement(r2, assemblyReq), rule(15), [uses(9, derives_from(r2, r1)), uses(4, satisfies(r1, assemblyReq))]).
substitution(12, []).
proof(12, design_goal(r2, reduceWeight), rule(12), []).
substitution(13, []).
proof(13, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(14, [binding("rev", r2), binding("opt", carbonFrame), binding("goal", reduceWeight)]).
proof(14, considers(r2, carbonFrame), rule(16), [uses(12, design_goal(r2, reduceWeight)), uses(13, suggests(reduceWeight, carbonFrame))]).
substitution(15, []).
proof(15, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(16, []).
proof(16, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(17, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(17, preserves(r2, stiffnessReq), rule(17), [uses(10, inherits_requirement(r2, stiffnessReq)), uses(14, considers(r2, carbonFrame)), uses(15, compatible_with(carbonFrame, stiffnessReq))]).
substitution(18, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(18, preserves(r2, assemblyReq), rule(17), [uses(11, inherits_requirement(r2, assemblyReq)), uses(14, considers(r2, carbonFrame)), uses(16, compatible_with(carbonFrame, assemblyReq))]).
substitution(19, [binding("rev", r2), binding("req", stiffnessReq)]).
proof(19, satisfies(r2, stiffnessReq), rule(19), [uses(17, preserves(r2, stiffnessReq))]).
substitution(20, [binding("rev", r2), binding("req", assemblyReq)]).
proof(20, satisfies(r2, assemblyReq), rule(19), [uses(18, preserves(r2, assemblyReq))]).
substitution(21, [binding("later", r3), binding("req", stiffnessReq), binding("earlier", r2)]).
proof(21, inherits_requirement(r3, stiffnessReq), rule(15), [uses(2, derives_from(r3, r2)), uses(19, satisfies(r2, stiffnessReq))]).
substitution(22, [binding("later", r3), binding("req", assemblyReq), binding("earlier", r2)]).
proof(22, inherits_requirement(r3, assemblyReq), rule(15), [uses(2, derives_from(r3, r2)), uses(20, satisfies(r2, assemblyReq))]).
substitution(23, [binding("l", r3), binding("r", stiffnessReq)]).
proof(23, solution([r3, stiffnessReq]), query, [uses(21, inherits_requirement(r3, stiffnessReq))]).
substitution(24, [binding("l", r3), binding("r", assemblyReq)]).
proof(24, solution([r3, assemblyReq]), query, [uses(22, inherits_requirement(r3, assemblyReq))]).
substitution(25, []).
proof(25, design_goal(r2, reduceWeight), rule(12), []).
substitution(26, []).
proof(26, design_goal(r3, improveCooling), rule(14), []).
substitution(27, []).
proof(27, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(28, []).
proof(28, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(29, [binding("rev", r2), binding("opt", carbonFrame), binding("goal", reduceWeight)]).
proof(29, considers(r2, carbonFrame), rule(16), [uses(25, design_goal(r2, reduceWeight)), uses(27, suggests(reduceWeight, carbonFrame))]).
substitution(30, [binding("rev", r3), binding("opt", ribbedHousing), binding("goal", improveCooling)]).
proof(30, considers(r3, ribbedHousing), rule(16), [uses(26, design_goal(r3, improveCooling)), uses(28, suggests(improveCooling, ribbedHousing))]).
substitution(31, [binding("rev", r2), binding("o", carbonFrame)]).
proof(31, solution([r2, carbonFrame]), query, [uses(29, considers(r2, carbonFrame))]).
substitution(32, [binding("rev", r3), binding("o", ribbedHousing)]).
proof(32, solution([r3, ribbedHousing]), query, [uses(30, considers(r3, ribbedHousing))]).
substitution(33, []).
proof(33, derives_from(r2, r1), rule(11), []).
substitution(34, []).
proof(34, derives_from(r3, r2), rule(13), []).
substitution(35, []).
proof(35, satisfies(r1, stiffnessReq), rule(7), []).
substitution(36, []).
proof(36, satisfies(r1, assemblyReq), rule(8), []).
substitution(37, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(37, inherits_requirement(r2, stiffnessReq), rule(15), [uses(33, derives_from(r2, r1)), uses(35, satisfies(r1, stiffnessReq))]).
substitution(38, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(38, inherits_requirement(r2, assemblyReq), rule(15), [uses(33, derives_from(r2, r1)), uses(36, satisfies(r1, assemblyReq))]).
substitution(39, []).
proof(39, derives_from(r2, r1), rule(11), []).
substitution(40, []).
proof(40, design_goal(r2, reduceWeight), rule(12), []).
substitution(41, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(41, inherits_requirement(r2, stiffnessReq), rule(15), [uses(39, derives_from(r2, r1)), uses(35, satisfies(r1, stiffnessReq))]).
substitution(42, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(42, inherits_requirement(r2, assemblyReq), rule(15), [uses(39, derives_from(r2, r1)), uses(36, satisfies(r1, assemblyReq))]).
substitution(43, []).
proof(43, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(44, [binding("rev", r2), binding("opt", carbonFrame), binding("goal", reduceWeight)]).
proof(44, considers(r2, carbonFrame), rule(16), [uses(40, design_goal(r2, reduceWeight)), uses(43, suggests(reduceWeight, carbonFrame))]).
substitution(45, []).
proof(45, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(46, []).
proof(46, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(47, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(47, preserves(r2, stiffnessReq), rule(17), [uses(37, inherits_requirement(r2, stiffnessReq)), uses(44, considers(r2, carbonFrame)), uses(45, compatible_with(carbonFrame, stiffnessReq))]).
substitution(48, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(48, preserves(r2, assemblyReq), rule(17), [uses(38, inherits_requirement(r2, assemblyReq)), uses(44, considers(r2, carbonFrame)), uses(46, compatible_with(carbonFrame, assemblyReq))]).
substitution(49, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(49, preserves(r2, stiffnessReq), rule(17), [uses(41, inherits_requirement(r2, stiffnessReq)), uses(44, considers(r2, carbonFrame)), uses(45, compatible_with(carbonFrame, stiffnessReq))]).
substitution(50, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(50, preserves(r2, assemblyReq), rule(17), [uses(42, inherits_requirement(r2, assemblyReq)), uses(44, considers(r2, carbonFrame)), uses(46, compatible_with(carbonFrame, assemblyReq))]).
substitution(51, [binding("rev", r2), binding("r", stiffnessReq)]).
proof(51, solution([r2, stiffnessReq]), query, [uses(47, preserves(r2, stiffnessReq))]).
substitution(52, [binding("rev", r2), binding("r", assemblyReq)]).
proof(52, solution([r2, assemblyReq]), query, [uses(48, preserves(r2, assemblyReq))]).
substitution(53, [binding("rev", r2), binding("req", stiffnessReq)]).
proof(53, satisfies(r2, stiffnessReq), rule(19), [uses(49, preserves(r2, stiffnessReq))]).
substitution(54, [binding("rev", r2), binding("req", assemblyReq)]).
proof(54, satisfies(r2, assemblyReq), rule(19), [uses(50, preserves(r2, assemblyReq))]).
substitution(55, [binding("later", r3), binding("req", stiffnessReq), binding("earlier", r2)]).
proof(55, inherits_requirement(r3, stiffnessReq), rule(15), [uses(34, derives_from(r3, r2)), uses(53, satisfies(r2, stiffnessReq))]).
substitution(56, [binding("later", r3), binding("req", assemblyReq), binding("earlier", r2)]).
proof(56, inherits_requirement(r3, assemblyReq), rule(15), [uses(34, derives_from(r3, r2)), uses(54, satisfies(r2, assemblyReq))]).
substitution(57, []).
proof(57, design_goal(r3, improveCooling), rule(14), []).
substitution(58, []).
proof(58, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(59, [binding("rev", r3), binding("opt", ribbedHousing), binding("goal", improveCooling)]).
proof(59, considers(r3, ribbedHousing), rule(16), [uses(57, design_goal(r3, improveCooling)), uses(58, suggests(improveCooling, ribbedHousing))]).
substitution(60, []).
proof(60, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(61, [binding("rev", r3), binding("req", assemblyReq), binding("opt", ribbedHousing)]).
proof(61, preserves(r3, assemblyReq), rule(17), [uses(56, inherits_requirement(r3, assemblyReq)), uses(59, considers(r3, ribbedHousing)), uses(60, compatible_with(ribbedHousing, assemblyReq))]).
substitution(62, [binding("rev", r3), binding("r", assemblyReq)]).
proof(62, solution([r3, assemblyReq]), query, [uses(61, preserves(r3, assemblyReq))]).
substitution(63, []).
proof(63, derives_from(r2, r1), rule(11), []).
substitution(64, []).
proof(64, derives_from(r3, r2), rule(13), []).
substitution(65, []).
proof(65, satisfies(r1, stiffnessReq), rule(7), []).
substitution(66, []).
proof(66, satisfies(r1, assemblyReq), rule(8), []).
substitution(67, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(67, inherits_requirement(r2, stiffnessReq), rule(15), [uses(63, derives_from(r2, r1)), uses(65, satisfies(r1, stiffnessReq))]).
substitution(68, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(68, inherits_requirement(r2, assemblyReq), rule(15), [uses(63, derives_from(r2, r1)), uses(66, satisfies(r1, assemblyReq))]).
substitution(69, []).
proof(69, derives_from(r2, r1), rule(11), []).
substitution(70, []).
proof(70, design_goal(r2, reduceWeight), rule(12), []).
substitution(71, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(71, inherits_requirement(r2, stiffnessReq), rule(15), [uses(69, derives_from(r2, r1)), uses(65, satisfies(r1, stiffnessReq))]).
substitution(72, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(72, inherits_requirement(r2, assemblyReq), rule(15), [uses(69, derives_from(r2, r1)), uses(66, satisfies(r1, assemblyReq))]).
substitution(73, []).
proof(73, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(74, [binding("rev", r2), binding("opt", carbonFrame), binding("goal", reduceWeight)]).
proof(74, considers(r2, carbonFrame), rule(16), [uses(70, design_goal(r2, reduceWeight)), uses(73, suggests(reduceWeight, carbonFrame))]).
substitution(75, []).
proof(75, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(76, []).
proof(76, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(77, [binding("rev", r2), binding("opt", carbonFrame), binding("req", stiffnessReq)]).
proof(77, integrates(r2, carbonFrame), rule(18), [uses(67, inherits_requirement(r2, stiffnessReq)), uses(74, considers(r2, carbonFrame)), uses(75, compatible_with(carbonFrame, stiffnessReq))]).
substitution(78, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(78, preserves(r2, stiffnessReq), rule(17), [uses(71, inherits_requirement(r2, stiffnessReq)), uses(74, considers(r2, carbonFrame)), uses(75, compatible_with(carbonFrame, stiffnessReq))]).
substitution(79, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(79, preserves(r2, assemblyReq), rule(17), [uses(72, inherits_requirement(r2, assemblyReq)), uses(74, considers(r2, carbonFrame)), uses(76, compatible_with(carbonFrame, assemblyReq))]).
substitution(80, [binding("rev", r2), binding("o", carbonFrame)]).
proof(80, solution([r2, carbonFrame]), query, [uses(77, integrates(r2, carbonFrame))]).
substitution(81, [binding("rev", r2), binding("req", stiffnessReq)]).
proof(81, satisfies(r2, stiffnessReq), rule(19), [uses(78, preserves(r2, stiffnessReq))]).
substitution(82, [binding("rev", r2), binding("req", assemblyReq)]).
proof(82, satisfies(r2, assemblyReq), rule(19), [uses(79, preserves(r2, assemblyReq))]).
substitution(83, [binding("later", r3), binding("req", stiffnessReq), binding("earlier", r2)]).
proof(83, inherits_requirement(r3, stiffnessReq), rule(15), [uses(64, derives_from(r3, r2)), uses(81, satisfies(r2, stiffnessReq))]).
substitution(84, [binding("later", r3), binding("req", assemblyReq), binding("earlier", r2)]).
proof(84, inherits_requirement(r3, assemblyReq), rule(15), [uses(64, derives_from(r3, r2)), uses(82, satisfies(r2, assemblyReq))]).
substitution(85, []).
proof(85, design_goal(r3, improveCooling), rule(14), []).
substitution(86, []).
proof(86, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(87, [binding("rev", r3), binding("opt", ribbedHousing), binding("goal", improveCooling)]).
proof(87, considers(r3, ribbedHousing), rule(16), [uses(85, design_goal(r3, improveCooling)), uses(86, suggests(improveCooling, ribbedHousing))]).
substitution(88, []).
proof(88, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(89, [binding("rev", r3), binding("opt", ribbedHousing), binding("req", assemblyReq)]).
proof(89, integrates(r3, ribbedHousing), rule(18), [uses(84, inherits_requirement(r3, assemblyReq)), uses(87, considers(r3, ribbedHousing)), uses(88, compatible_with(ribbedHousing, assemblyReq))]).
substitution(90, [binding("rev", r3), binding("o", ribbedHousing)]).
proof(90, solution([r3, ribbedHousing]), query, [uses(89, integrates(r3, ribbedHousing))]).
substitution(91, []).
proof(91, satisfies(r1, stiffnessReq), rule(7), []).
substitution(92, []).
proof(92, satisfies(r1, assemblyReq), rule(8), []).
substitution(93, [binding("rev", r1), binding("r", stiffnessReq)]).
proof(93, solution([r1, stiffnessReq]), query, [uses(91, satisfies(r1, stiffnessReq))]).
substitution(94, [binding("rev", r1), binding("r", assemblyReq)]).
proof(94, solution([r1, assemblyReq]), query, [uses(92, satisfies(r1, assemblyReq))]).
substitution(95, []).
proof(95, derives_from(r2, r1), rule(11), []).
substitution(96, []).
proof(96, derives_from(r3, r2), rule(13), []).
substitution(97, []).
proof(97, satisfies(r1, stiffnessReq), rule(7), []).
substitution(98, []).
proof(98, satisfies(r1, assemblyReq), rule(8), []).
substitution(99, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(99, inherits_requirement(r2, stiffnessReq), rule(15), [uses(95, derives_from(r2, r1)), uses(97, satisfies(r1, stiffnessReq))]).
substitution(100, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(100, inherits_requirement(r2, assemblyReq), rule(15), [uses(95, derives_from(r2, r1)), uses(98, satisfies(r1, assemblyReq))]).
substitution(101, []).
proof(101, derives_from(r2, r1), rule(11), []).
substitution(102, []).
proof(102, design_goal(r2, reduceWeight), rule(12), []).
substitution(103, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(103, inherits_requirement(r2, stiffnessReq), rule(15), [uses(101, derives_from(r2, r1)), uses(97, satisfies(r1, stiffnessReq))]).
substitution(104, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(104, inherits_requirement(r2, assemblyReq), rule(15), [uses(101, derives_from(r2, r1)), uses(98, satisfies(r1, assemblyReq))]).
substitution(105, []).
proof(105, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(106, [binding("rev", r2), binding("opt", carbonFrame), binding("goal", reduceWeight)]).
proof(106, considers(r2, carbonFrame), rule(16), [uses(102, design_goal(r2, reduceWeight)), uses(105, suggests(reduceWeight, carbonFrame))]).
substitution(107, []).
proof(107, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(108, []).
proof(108, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(109, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(109, preserves(r2, stiffnessReq), rule(17), [uses(99, inherits_requirement(r2, stiffnessReq)), uses(106, considers(r2, carbonFrame)), uses(107, compatible_with(carbonFrame, stiffnessReq))]).
substitution(110, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(110, preserves(r2, assemblyReq), rule(17), [uses(100, inherits_requirement(r2, assemblyReq)), uses(106, considers(r2, carbonFrame)), uses(108, compatible_with(carbonFrame, assemblyReq))]).
substitution(111, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(111, preserves(r2, stiffnessReq), rule(17), [uses(103, inherits_requirement(r2, stiffnessReq)), uses(106, considers(r2, carbonFrame)), uses(107, compatible_with(carbonFrame, stiffnessReq))]).
substitution(112, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(112, preserves(r2, assemblyReq), rule(17), [uses(104, inherits_requirement(r2, assemblyReq)), uses(106, considers(r2, carbonFrame)), uses(108, compatible_with(carbonFrame, assemblyReq))]).
substitution(113, [binding("rev", r2), binding("req", stiffnessReq)]).
proof(113, satisfies(r2, stiffnessReq), rule(19), [uses(109, preserves(r2, stiffnessReq))]).
substitution(114, [binding("rev", r2), binding("req", assemblyReq)]).
proof(114, satisfies(r2, assemblyReq), rule(19), [uses(110, preserves(r2, assemblyReq))]).
substitution(115, [binding("rev", r2), binding("req", stiffnessReq)]).
proof(115, satisfies(r2, stiffnessReq), rule(19), [uses(111, preserves(r2, stiffnessReq))]).
substitution(116, [binding("rev", r2), binding("req", assemblyReq)]).
proof(116, satisfies(r2, assemblyReq), rule(19), [uses(112, preserves(r2, assemblyReq))]).
substitution(117, [binding("rev", r2), binding("r", stiffnessReq)]).
proof(117, solution([r2, stiffnessReq]), query, [uses(113, satisfies(r2, stiffnessReq))]).
substitution(118, [binding("rev", r2), binding("r", assemblyReq)]).
proof(118, solution([r2, assemblyReq]), query, [uses(114, satisfies(r2, assemblyReq))]).
substitution(119, [binding("later", r3), binding("req", stiffnessReq), binding("earlier", r2)]).
proof(119, inherits_requirement(r3, stiffnessReq), rule(15), [uses(96, derives_from(r3, r2)), uses(115, satisfies(r2, stiffnessReq))]).
substitution(120, [binding("later", r3), binding("req", assemblyReq), binding("earlier", r2)]).
proof(120, inherits_requirement(r3, assemblyReq), rule(15), [uses(96, derives_from(r3, r2)), uses(116, satisfies(r2, assemblyReq))]).
substitution(121, []).
proof(121, design_goal(r3, improveCooling), rule(14), []).
substitution(122, []).
proof(122, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(123, [binding("rev", r3), binding("opt", ribbedHousing), binding("goal", improveCooling)]).
proof(123, considers(r3, ribbedHousing), rule(16), [uses(121, design_goal(r3, improveCooling)), uses(122, suggests(improveCooling, ribbedHousing))]).
substitution(124, []).
proof(124, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(125, [binding("rev", r3), binding("req", assemblyReq), binding("opt", ribbedHousing)]).
proof(125, preserves(r3, assemblyReq), rule(17), [uses(120, inherits_requirement(r3, assemblyReq)), uses(123, considers(r3, ribbedHousing)), uses(124, compatible_with(ribbedHousing, assemblyReq))]).
substitution(126, [binding("rev", r3), binding("req", assemblyReq)]).
proof(126, satisfies(r3, assemblyReq), rule(19), [uses(125, preserves(r3, assemblyReq))]).
substitution(127, [binding("rev", r3), binding("r", assemblyReq)]).
proof(127, solution([r3, assemblyReq]), query, [uses(126, satisfies(r3, assemblyReq))]).
substitution(128, []).
proof(128, realizes(r1, aluminumFrame), rule(9), []).
substitution(129, [binding("rev", r1), binding("o", aluminumFrame)]).
proof(129, solution([r1, aluminumFrame]), query, [uses(128, realizes(r1, aluminumFrame))]).
substitution(130, []).
proof(130, derives_from(r2, r1), rule(11), []).
substitution(131, []).
proof(131, derives_from(r3, r2), rule(13), []).
substitution(132, []).
proof(132, satisfies(r1, stiffnessReq), rule(7), []).
substitution(133, []).
proof(133, satisfies(r1, assemblyReq), rule(8), []).
substitution(134, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(134, inherits_requirement(r2, stiffnessReq), rule(15), [uses(130, derives_from(r2, r1)), uses(132, satisfies(r1, stiffnessReq))]).
substitution(135, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(135, inherits_requirement(r2, assemblyReq), rule(15), [uses(130, derives_from(r2, r1)), uses(133, satisfies(r1, assemblyReq))]).
substitution(136, []).
proof(136, derives_from(r2, r1), rule(11), []).
substitution(137, []).
proof(137, design_goal(r2, reduceWeight), rule(12), []).
substitution(138, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(138, inherits_requirement(r2, stiffnessReq), rule(15), [uses(136, derives_from(r2, r1)), uses(132, satisfies(r1, stiffnessReq))]).
substitution(139, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(139, inherits_requirement(r2, assemblyReq), rule(15), [uses(136, derives_from(r2, r1)), uses(133, satisfies(r1, assemblyReq))]).
substitution(140, []).
proof(140, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(141, [binding("rev", r2), binding("opt", carbonFrame), binding("goal", reduceWeight)]).
proof(141, considers(r2, carbonFrame), rule(16), [uses(137, design_goal(r2, reduceWeight)), uses(140, suggests(reduceWeight, carbonFrame))]).
substitution(142, []).
proof(142, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(143, []).
proof(143, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(144, [binding("rev", r2), binding("opt", carbonFrame), binding("req", stiffnessReq)]).
proof(144, integrates(r2, carbonFrame), rule(18), [uses(134, inherits_requirement(r2, stiffnessReq)), uses(141, considers(r2, carbonFrame)), uses(142, compatible_with(carbonFrame, stiffnessReq))]).
substitution(145, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(145, preserves(r2, stiffnessReq), rule(17), [uses(138, inherits_requirement(r2, stiffnessReq)), uses(141, considers(r2, carbonFrame)), uses(142, compatible_with(carbonFrame, stiffnessReq))]).
substitution(146, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(146, preserves(r2, assemblyReq), rule(17), [uses(139, inherits_requirement(r2, assemblyReq)), uses(141, considers(r2, carbonFrame)), uses(143, compatible_with(carbonFrame, assemblyReq))]).
substitution(147, [binding("rev", r2), binding("opt", carbonFrame)]).
proof(147, realizes(r2, carbonFrame), rule(20), [uses(144, integrates(r2, carbonFrame))]).
substitution(148, [binding("rev", r2), binding("req", stiffnessReq)]).
proof(148, satisfies(r2, stiffnessReq), rule(19), [uses(145, preserves(r2, stiffnessReq))]).
substitution(149, [binding("rev", r2), binding("req", assemblyReq)]).
proof(149, satisfies(r2, assemblyReq), rule(19), [uses(146, preserves(r2, assemblyReq))]).
substitution(150, [binding("rev", r2), binding("o", carbonFrame)]).
proof(150, solution([r2, carbonFrame]), query, [uses(147, realizes(r2, carbonFrame))]).
substitution(151, [binding("later", r3), binding("req", stiffnessReq), binding("earlier", r2)]).
proof(151, inherits_requirement(r3, stiffnessReq), rule(15), [uses(131, derives_from(r3, r2)), uses(148, satisfies(r2, stiffnessReq))]).
substitution(152, [binding("later", r3), binding("req", assemblyReq), binding("earlier", r2)]).
proof(152, inherits_requirement(r3, assemblyReq), rule(15), [uses(131, derives_from(r3, r2)), uses(149, satisfies(r2, assemblyReq))]).
substitution(153, []).
proof(153, design_goal(r3, improveCooling), rule(14), []).
substitution(154, []).
proof(154, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(155, [binding("rev", r3), binding("opt", ribbedHousing), binding("goal", improveCooling)]).
proof(155, considers(r3, ribbedHousing), rule(16), [uses(153, design_goal(r3, improveCooling)), uses(154, suggests(improveCooling, ribbedHousing))]).
substitution(156, []).
proof(156, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(157, [binding("rev", r3), binding("opt", ribbedHousing), binding("req", assemblyReq)]).
proof(157, integrates(r3, ribbedHousing), rule(18), [uses(152, inherits_requirement(r3, assemblyReq)), uses(155, considers(r3, ribbedHousing)), uses(156, compatible_with(ribbedHousing, assemblyReq))]).
substitution(158, [binding("rev", r3), binding("opt", ribbedHousing)]).
proof(158, realizes(r3, ribbedHousing), rule(20), [uses(157, integrates(r3, ribbedHousing))]).
substitution(159, [binding("rev", r3), binding("o", ribbedHousing)]).
proof(159, solution([r3, ribbedHousing]), query, [uses(158, realizes(r3, ribbedHousing))]).
substitution(160, []).
proof(160, achieves(r1, approvedBaseline), rule(10), []).
substitution(161, [binding("rev", r1)]).
proof(161, status(r1, approvedBaseline), rule(23), [uses(160, achieves(r1, approvedBaseline))]).
substitution(162, []).
proof(162, realizes(r1, aluminumFrame), rule(9), []).
substitution(163, [binding("rev", r1), binding("s", approvedBaseline)]).
proof(163, solution([r1, approvedBaseline]), query, [uses(161, status(r1, approvedBaseline))]).
substitution(164, []).
proof(164, derives_from(r2, r1), rule(11), []).
substitution(165, []).
proof(165, derives_from(r3, r2), rule(13), []).
substitution(166, []).
proof(166, satisfies(r1, stiffnessReq), rule(7), []).
substitution(167, []).
proof(167, satisfies(r1, assemblyReq), rule(8), []).
substitution(168, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(168, inherits_requirement(r2, stiffnessReq), rule(15), [uses(164, derives_from(r2, r1)), uses(166, satisfies(r1, stiffnessReq))]).
substitution(169, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(169, inherits_requirement(r2, assemblyReq), rule(15), [uses(164, derives_from(r2, r1)), uses(167, satisfies(r1, assemblyReq))]).
substitution(170, []).
proof(170, derives_from(r2, r1), rule(11), []).
substitution(171, []).
proof(171, design_goal(r2, reduceWeight), rule(12), []).
substitution(172, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(172, inherits_requirement(r2, stiffnessReq), rule(15), [uses(170, derives_from(r2, r1)), uses(166, satisfies(r1, stiffnessReq))]).
substitution(173, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(173, inherits_requirement(r2, assemblyReq), rule(15), [uses(170, derives_from(r2, r1)), uses(167, satisfies(r1, assemblyReq))]).
substitution(174, []).
proof(174, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(175, [binding("rev", r2), binding("opt", carbonFrame), binding("goal", reduceWeight)]).
proof(175, considers(r2, carbonFrame), rule(16), [uses(171, design_goal(r2, reduceWeight)), uses(174, suggests(reduceWeight, carbonFrame))]).
substitution(176, []).
proof(176, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(177, []).
proof(177, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(178, [binding("rev", r2), binding("opt", carbonFrame), binding("req", stiffnessReq)]).
proof(178, integrates(r2, carbonFrame), rule(18), [uses(168, inherits_requirement(r2, stiffnessReq)), uses(175, considers(r2, carbonFrame)), uses(176, compatible_with(carbonFrame, stiffnessReq))]).
substitution(179, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(179, preserves(r2, stiffnessReq), rule(17), [uses(172, inherits_requirement(r2, stiffnessReq)), uses(175, considers(r2, carbonFrame)), uses(176, compatible_with(carbonFrame, stiffnessReq))]).
substitution(180, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(180, preserves(r2, assemblyReq), rule(17), [uses(173, inherits_requirement(r2, assemblyReq)), uses(175, considers(r2, carbonFrame)), uses(177, compatible_with(carbonFrame, assemblyReq))]).
substitution(181, [binding("rev", r2), binding("opt", carbonFrame)]).
proof(181, realizes(r2, carbonFrame), rule(20), [uses(178, integrates(r2, carbonFrame))]).
substitution(182, [binding("rev", r2), binding("req", stiffnessReq)]).
proof(182, satisfies(r2, stiffnessReq), rule(19), [uses(179, preserves(r2, stiffnessReq))]).
substitution(183, [binding("rev", r2), binding("req", assemblyReq)]).
proof(183, satisfies(r2, assemblyReq), rule(19), [uses(180, preserves(r2, assemblyReq))]).
substitution(184, [binding("rev", r2), binding("opt", carbonFrame)]).
proof(184, achieves(r2, approvedBaseline), rule(21), [uses(181, realizes(r2, carbonFrame))]).
substitution(185, [binding("later", r3), binding("req", stiffnessReq), binding("earlier", r2)]).
proof(185, inherits_requirement(r3, stiffnessReq), rule(15), [uses(165, derives_from(r3, r2)), uses(182, satisfies(r2, stiffnessReq))]).
substitution(186, [binding("later", r3), binding("req", assemblyReq), binding("earlier", r2)]).
proof(186, inherits_requirement(r3, assemblyReq), rule(15), [uses(165, derives_from(r3, r2)), uses(183, satisfies(r2, assemblyReq))]).
substitution(187, [binding("rev", r2)]).
proof(187, status(r2, approvedBaseline), rule(23), [uses(184, achieves(r2, approvedBaseline))]).
substitution(188, [binding("rev", r2), binding("s", approvedBaseline)]).
proof(188, solution([r2, approvedBaseline]), query, [uses(187, status(r2, approvedBaseline))]).
substitution(189, []).
proof(189, design_goal(r3, improveCooling), rule(14), []).
substitution(190, []).
proof(190, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(191, [binding("rev", r3), binding("opt", ribbedHousing), binding("goal", improveCooling)]).
proof(191, considers(r3, ribbedHousing), rule(16), [uses(189, design_goal(r3, improveCooling)), uses(190, suggests(improveCooling, ribbedHousing))]).
substitution(192, []).
proof(192, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(193, [binding("rev", r3), binding("opt", ribbedHousing), binding("req", assemblyReq)]).
proof(193, integrates(r3, ribbedHousing), rule(18), [uses(186, inherits_requirement(r3, assemblyReq)), uses(191, considers(r3, ribbedHousing)), uses(192, compatible_with(ribbedHousing, assemblyReq))]).
substitution(194, [binding("rev", r3), binding("opt", ribbedHousing)]).
proof(194, realizes(r3, ribbedHousing), rule(20), [uses(193, integrates(r3, ribbedHousing))]).
substitution(195, [binding("rev", r3), binding("opt", ribbedHousing)]).
proof(195, achieves(r3, approvedBaseline), rule(21), [uses(194, realizes(r3, ribbedHousing))]).
substitution(196, [binding("rev", r3)]).
proof(196, status(r3, approvedBaseline), rule(23), [uses(195, achieves(r3, approvedBaseline))]).
substitution(197, [binding("rev", r3), binding("s", approvedBaseline)]).
proof(197, solution([r3, approvedBaseline]), query, [uses(196, status(r3, approvedBaseline))]).
substitution(198, []).
proof(198, realizes(r1, aluminumFrame), rule(9), []).
substitution(199, [binding("rev", r1), binding("opt", aluminumFrame)]).
proof(199, available_for_future_iteration(r1, yes), rule(22), [uses(198, realizes(r1, aluminumFrame))]).
substitution(200, [binding("rev", r1), binding("y", yes)]).
proof(200, solution([r1, yes]), query, [uses(199, available_for_future_iteration(r1, yes))]).
substitution(201, []).
proof(201, derives_from(r2, r1), rule(11), []).
substitution(202, []).
proof(202, derives_from(r3, r2), rule(13), []).
substitution(203, []).
proof(203, satisfies(r1, stiffnessReq), rule(7), []).
substitution(204, []).
proof(204, satisfies(r1, assemblyReq), rule(8), []).
substitution(205, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(205, inherits_requirement(r2, stiffnessReq), rule(15), [uses(201, derives_from(r2, r1)), uses(203, satisfies(r1, stiffnessReq))]).
substitution(206, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(206, inherits_requirement(r2, assemblyReq), rule(15), [uses(201, derives_from(r2, r1)), uses(204, satisfies(r1, assemblyReq))]).
substitution(207, []).
proof(207, derives_from(r2, r1), rule(11), []).
substitution(208, []).
proof(208, design_goal(r2, reduceWeight), rule(12), []).
substitution(209, [binding("later", r2), binding("req", stiffnessReq), binding("earlier", r1)]).
proof(209, inherits_requirement(r2, stiffnessReq), rule(15), [uses(207, derives_from(r2, r1)), uses(203, satisfies(r1, stiffnessReq))]).
substitution(210, [binding("later", r2), binding("req", assemblyReq), binding("earlier", r1)]).
proof(210, inherits_requirement(r2, assemblyReq), rule(15), [uses(207, derives_from(r2, r1)), uses(204, satisfies(r1, assemblyReq))]).
substitution(211, []).
proof(211, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(212, [binding("rev", r2), binding("opt", carbonFrame), binding("goal", reduceWeight)]).
proof(212, considers(r2, carbonFrame), rule(16), [uses(208, design_goal(r2, reduceWeight)), uses(211, suggests(reduceWeight, carbonFrame))]).
substitution(213, []).
proof(213, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(214, []).
proof(214, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(215, [binding("rev", r2), binding("opt", carbonFrame), binding("req", stiffnessReq)]).
proof(215, integrates(r2, carbonFrame), rule(18), [uses(205, inherits_requirement(r2, stiffnessReq)), uses(212, considers(r2, carbonFrame)), uses(213, compatible_with(carbonFrame, stiffnessReq))]).
substitution(216, [binding("rev", r2), binding("req", stiffnessReq), binding("opt", carbonFrame)]).
proof(216, preserves(r2, stiffnessReq), rule(17), [uses(209, inherits_requirement(r2, stiffnessReq)), uses(212, considers(r2, carbonFrame)), uses(213, compatible_with(carbonFrame, stiffnessReq))]).
substitution(217, [binding("rev", r2), binding("req", assemblyReq), binding("opt", carbonFrame)]).
proof(217, preserves(r2, assemblyReq), rule(17), [uses(210, inherits_requirement(r2, assemblyReq)), uses(212, considers(r2, carbonFrame)), uses(214, compatible_with(carbonFrame, assemblyReq))]).
substitution(218, [binding("rev", r2), binding("opt", carbonFrame)]).
proof(218, realizes(r2, carbonFrame), rule(20), [uses(215, integrates(r2, carbonFrame))]).
substitution(219, [binding("rev", r2), binding("req", stiffnessReq)]).
proof(219, satisfies(r2, stiffnessReq), rule(19), [uses(216, preserves(r2, stiffnessReq))]).
substitution(220, [binding("rev", r2), binding("req", assemblyReq)]).
proof(220, satisfies(r2, assemblyReq), rule(19), [uses(217, preserves(r2, assemblyReq))]).
substitution(221, [binding("rev", r2), binding("opt", carbonFrame)]).
proof(221, available_for_future_iteration(r2, yes), rule(22), [uses(218, realizes(r2, carbonFrame))]).
substitution(222, [binding("later", r3), binding("req", stiffnessReq), binding("earlier", r2)]).
proof(222, inherits_requirement(r3, stiffnessReq), rule(15), [uses(202, derives_from(r3, r2)), uses(219, satisfies(r2, stiffnessReq))]).
substitution(223, [binding("later", r3), binding("req", assemblyReq), binding("earlier", r2)]).
proof(223, inherits_requirement(r3, assemblyReq), rule(15), [uses(202, derives_from(r3, r2)), uses(220, satisfies(r2, assemblyReq))]).
substitution(224, [binding("rev", r2), binding("y", yes)]).
proof(224, solution([r2, yes]), query, [uses(221, available_for_future_iteration(r2, yes))]).
substitution(225, []).
proof(225, design_goal(r3, improveCooling), rule(14), []).
substitution(226, []).
proof(226, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(227, [binding("rev", r3), binding("opt", ribbedHousing), binding("goal", improveCooling)]).
proof(227, considers(r3, ribbedHousing), rule(16), [uses(225, design_goal(r3, improveCooling)), uses(226, suggests(improveCooling, ribbedHousing))]).
substitution(228, []).
proof(228, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(229, [binding("rev", r3), binding("opt", ribbedHousing), binding("req", assemblyReq)]).
proof(229, integrates(r3, ribbedHousing), rule(18), [uses(223, inherits_requirement(r3, assemblyReq)), uses(227, considers(r3, ribbedHousing)), uses(228, compatible_with(ribbedHousing, assemblyReq))]).
substitution(230, [binding("rev", r3), binding("opt", ribbedHousing)]).
proof(230, realizes(r3, ribbedHousing), rule(20), [uses(229, integrates(r3, ribbedHousing))]).
substitution(231, [binding("rev", r3), binding("opt", ribbedHousing)]).
proof(231, available_for_future_iteration(r3, yes), rule(22), [uses(230, realizes(r3, ribbedHousing))]).
substitution(232, [binding("rev", r3), binding("y", yes)]).
proof(232, solution([r3, yes]), query, [uses(231, available_for_future_iteration(r3, yes))]).
