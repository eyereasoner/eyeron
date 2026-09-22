% Prolog result format 3
query(1, inherits_requirement(_0, _1), ['L' = _0, 'R' = _1]).
result(1, complete, 4).
answer(1, ['L' = r2, 'R' = stiffnessReq]).
why(1, ['L' = r2, 'R' = stiffnessReq], 7).
answer(1, ['L' = r2, 'R' = assemblyReq]).
why(1, ['L' = r2, 'R' = assemblyReq], 8).
answer(1, ['L' = r3, 'R' = stiffnessReq]).
why(1, ['L' = r3, 'R' = stiffnessReq], 23).
answer(1, ['L' = r3, 'R' = assemblyReq]).
why(1, ['L' = r3, 'R' = assemblyReq], 24).
query(2, considers(_0, _1), ['Rev' = _0, 'O' = _1]).
result(2, complete, 2).
answer(2, ['Rev' = r2, 'O' = carbonFrame]).
why(2, ['Rev' = r2, 'O' = carbonFrame], 31).
answer(2, ['Rev' = r3, 'O' = ribbedHousing]).
why(2, ['Rev' = r3, 'O' = ribbedHousing], 32).
query(3, preserves(_0, _1), ['Rev' = _0, 'R' = _1]).
result(3, complete, 3).
answer(3, ['Rev' = r2, 'R' = stiffnessReq]).
why(3, ['Rev' = r2, 'R' = stiffnessReq], 51).
answer(3, ['Rev' = r2, 'R' = assemblyReq]).
why(3, ['Rev' = r2, 'R' = assemblyReq], 52).
answer(3, ['Rev' = r3, 'R' = assemblyReq]).
why(3, ['Rev' = r3, 'R' = assemblyReq], 62).
query(4, integrates(_0, _1), ['Rev' = _0, 'O' = _1]).
result(4, complete, 2).
answer(4, ['Rev' = r2, 'O' = carbonFrame]).
why(4, ['Rev' = r2, 'O' = carbonFrame], 80).
answer(4, ['Rev' = r3, 'O' = ribbedHousing]).
why(4, ['Rev' = r3, 'O' = ribbedHousing], 90).
query(5, satisfies(_0, _1), ['Rev' = _0, 'R' = _1]).
result(5, complete, 5).
answer(5, ['Rev' = r1, 'R' = stiffnessReq]).
why(5, ['Rev' = r1, 'R' = stiffnessReq], 93).
answer(5, ['Rev' = r1, 'R' = assemblyReq]).
why(5, ['Rev' = r1, 'R' = assemblyReq], 94).
answer(5, ['Rev' = r2, 'R' = stiffnessReq]).
why(5, ['Rev' = r2, 'R' = stiffnessReq], 117).
answer(5, ['Rev' = r2, 'R' = assemblyReq]).
why(5, ['Rev' = r2, 'R' = assemblyReq], 118).
answer(5, ['Rev' = r3, 'R' = assemblyReq]).
why(5, ['Rev' = r3, 'R' = assemblyReq], 127).
query(6, realizes(_0, _1), ['Rev' = _0, 'O' = _1]).
result(6, complete, 3).
answer(6, ['Rev' = r1, 'O' = aluminumFrame]).
why(6, ['Rev' = r1, 'O' = aluminumFrame], 129).
answer(6, ['Rev' = r2, 'O' = carbonFrame]).
why(6, ['Rev' = r2, 'O' = carbonFrame], 150).
answer(6, ['Rev' = r3, 'O' = ribbedHousing]).
why(6, ['Rev' = r3, 'O' = ribbedHousing], 159).
query(7, status(_0, _1), ['Rev' = _0, 'S' = _1]).
result(7, complete, 3).
answer(7, ['Rev' = r1, 'S' = approvedBaseline]).
why(7, ['Rev' = r1, 'S' = approvedBaseline], 163).
answer(7, ['Rev' = r2, 'S' = approvedBaseline]).
why(7, ['Rev' = r2, 'S' = approvedBaseline], 188).
answer(7, ['Rev' = r3, 'S' = approvedBaseline]).
why(7, ['Rev' = r3, 'S' = approvedBaseline], 197).
query(8, available_for_future_iteration(_0, _1), ['Rev' = _0, 'Y' = _1]).
result(8, complete, 3).
answer(8, ['Rev' = r1, 'Y' = yes]).
why(8, ['Rev' = r1, 'Y' = yes], 200).
answer(8, ['Rev' = r2, 'Y' = yes]).
why(8, ['Rev' = r2, 'Y' = yes], 224).
answer(8, ['Rev' = r3, 'Y' = yes]).
why(8, ['Rev' = r3, 'Y' = yes], 232).
clause(1, suggests(reduceWeight, carbonFrame), true).
clause(2, suggests(improveCooling, ribbedHousing), true).
clause(3, compatible_with(carbonFrame, stiffnessReq), true).
clause(4, compatible_with(carbonFrame, assemblyReq), true).
clause(6, compatible_with(ribbedHousing, assemblyReq), true).
clause(7, satisfies(r1, stiffnessReq), true).
clause(8, satisfies(r1, assemblyReq), true).
clause(9, realizes(r1, aluminumFrame), true).
clause(10, achieves(r1, approvedBaseline), true).
clause(11, derives_from(r2, r1), true).
clause(12, design_goal(r2, reduceWeight), true).
clause(13, derives_from(r3, r2), true).
clause(14, design_goal(r3, improveCooling), true).
clause(15, inherits_requirement(var('Later'), var('Req')), (derives_from(var('Later'), var('Earlier')), satisfies(var('Earlier'), var('Req')))).
clause(16, considers(var('Rev'), var('Opt')), (design_goal(var('Rev'), var('Goal')), suggests(var('Goal'), var('Opt')))).
clause(17, preserves(var('Rev'), var('Req')), (inherits_requirement(var('Rev'), var('Req')), considers(var('Rev'), var('Opt')), compatible_with(var('Opt'), var('Req')))).
clause(18, integrates(var('Rev'), var('Opt')), (inherits_requirement(var('Rev'), var('Req')), considers(var('Rev'), var('Opt')), compatible_with(var('Opt'), var('Req')))).
clause(19, satisfies(var('Rev'), var('Req')), preserves(var('Rev'), var('Req'))).
clause(20, realizes(var('Rev'), var('Opt')), integrates(var('Rev'), var('Opt'))).
clause(21, achieves(var('Rev'), approvedBaseline), realizes(var('Rev'), var('Opt'))).
clause(22, available_for_future_iteration(var('Rev'), yes), realizes(var('Rev'), var('Opt'))).
clause(23, status(var('Rev'), approvedBaseline), achieves(var('Rev'), approvedBaseline)).
substitution(1, []).
proof(1, derives_from(r2, r1), rule(11), []).
substitution(2, []).
proof(2, derives_from(r3, r2), rule(13), []).
substitution(3, []).
proof(3, satisfies(r1, stiffnessReq), rule(7), []).
substitution(4, []).
proof(4, satisfies(r1, assemblyReq), rule(8), []).
substitution(5, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(5, inherits_requirement(r2, stiffnessReq), rule(15), [uses(1, derives_from(r2, r1)), uses(3, satisfies(r1, stiffnessReq))]).
substitution(6, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(6, inherits_requirement(r2, assemblyReq), rule(15), [uses(1, derives_from(r2, r1)), uses(4, satisfies(r1, assemblyReq))]).
substitution(7, ['L' = r2, 'R' = stiffnessReq]).
proof(7, solution([r2, stiffnessReq]), query, [uses(5, inherits_requirement(r2, stiffnessReq))]).
substitution(8, ['L' = r2, 'R' = assemblyReq]).
proof(8, solution([r2, assemblyReq]), query, [uses(6, inherits_requirement(r2, assemblyReq))]).
substitution(9, []).
proof(9, derives_from(r2, r1), rule(11), []).
substitution(10, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(10, inherits_requirement(r2, stiffnessReq), rule(15), [uses(9, derives_from(r2, r1)), uses(3, satisfies(r1, stiffnessReq))]).
substitution(11, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(11, inherits_requirement(r2, assemblyReq), rule(15), [uses(9, derives_from(r2, r1)), uses(4, satisfies(r1, assemblyReq))]).
substitution(12, []).
proof(12, design_goal(r2, reduceWeight), rule(12), []).
substitution(13, []).
proof(13, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(14, ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight]).
proof(14, considers(r2, carbonFrame), rule(16), [uses(12, design_goal(r2, reduceWeight)), uses(13, suggests(reduceWeight, carbonFrame))]).
substitution(15, []).
proof(15, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(16, []).
proof(16, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(17, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(17, preserves(r2, stiffnessReq), rule(17), [uses(10, inherits_requirement(r2, stiffnessReq)), uses(14, considers(r2, carbonFrame)), uses(15, compatible_with(carbonFrame, stiffnessReq))]).
substitution(18, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(18, preserves(r2, assemblyReq), rule(17), [uses(11, inherits_requirement(r2, assemblyReq)), uses(14, considers(r2, carbonFrame)), uses(16, compatible_with(carbonFrame, assemblyReq))]).
substitution(19, ['Rev' = r2, 'Req' = stiffnessReq]).
proof(19, satisfies(r2, stiffnessReq), rule(19), [uses(17, preserves(r2, stiffnessReq))]).
substitution(20, ['Rev' = r2, 'Req' = assemblyReq]).
proof(20, satisfies(r2, assemblyReq), rule(19), [uses(18, preserves(r2, assemblyReq))]).
substitution(21, ['Later' = r3, 'Req' = stiffnessReq, 'Earlier' = r2]).
proof(21, inherits_requirement(r3, stiffnessReq), rule(15), [uses(2, derives_from(r3, r2)), uses(19, satisfies(r2, stiffnessReq))]).
substitution(22, ['Later' = r3, 'Req' = assemblyReq, 'Earlier' = r2]).
proof(22, inherits_requirement(r3, assemblyReq), rule(15), [uses(2, derives_from(r3, r2)), uses(20, satisfies(r2, assemblyReq))]).
substitution(23, ['L' = r3, 'R' = stiffnessReq]).
proof(23, solution([r3, stiffnessReq]), query, [uses(21, inherits_requirement(r3, stiffnessReq))]).
substitution(24, ['L' = r3, 'R' = assemblyReq]).
proof(24, solution([r3, assemblyReq]), query, [uses(22, inherits_requirement(r3, assemblyReq))]).
substitution(25, []).
proof(25, design_goal(r2, reduceWeight), rule(12), []).
substitution(26, []).
proof(26, design_goal(r3, improveCooling), rule(14), []).
substitution(27, []).
proof(27, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(28, []).
proof(28, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(29, ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight]).
proof(29, considers(r2, carbonFrame), rule(16), [uses(25, design_goal(r2, reduceWeight)), uses(27, suggests(reduceWeight, carbonFrame))]).
substitution(30, ['Rev' = r3, 'Opt' = ribbedHousing, 'Goal' = improveCooling]).
proof(30, considers(r3, ribbedHousing), rule(16), [uses(26, design_goal(r3, improveCooling)), uses(28, suggests(improveCooling, ribbedHousing))]).
substitution(31, ['Rev' = r2, 'O' = carbonFrame]).
proof(31, solution([r2, carbonFrame]), query, [uses(29, considers(r2, carbonFrame))]).
substitution(32, ['Rev' = r3, 'O' = ribbedHousing]).
proof(32, solution([r3, ribbedHousing]), query, [uses(30, considers(r3, ribbedHousing))]).
substitution(33, []).
proof(33, derives_from(r2, r1), rule(11), []).
substitution(34, []).
proof(34, derives_from(r3, r2), rule(13), []).
substitution(35, []).
proof(35, satisfies(r1, stiffnessReq), rule(7), []).
substitution(36, []).
proof(36, satisfies(r1, assemblyReq), rule(8), []).
substitution(37, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(37, inherits_requirement(r2, stiffnessReq), rule(15), [uses(33, derives_from(r2, r1)), uses(35, satisfies(r1, stiffnessReq))]).
substitution(38, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(38, inherits_requirement(r2, assemblyReq), rule(15), [uses(33, derives_from(r2, r1)), uses(36, satisfies(r1, assemblyReq))]).
substitution(39, []).
proof(39, derives_from(r2, r1), rule(11), []).
substitution(40, []).
proof(40, design_goal(r2, reduceWeight), rule(12), []).
substitution(41, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(41, inherits_requirement(r2, stiffnessReq), rule(15), [uses(39, derives_from(r2, r1)), uses(35, satisfies(r1, stiffnessReq))]).
substitution(42, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(42, inherits_requirement(r2, assemblyReq), rule(15), [uses(39, derives_from(r2, r1)), uses(36, satisfies(r1, assemblyReq))]).
substitution(43, []).
proof(43, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(44, ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight]).
proof(44, considers(r2, carbonFrame), rule(16), [uses(40, design_goal(r2, reduceWeight)), uses(43, suggests(reduceWeight, carbonFrame))]).
substitution(45, []).
proof(45, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(46, []).
proof(46, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(47, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(47, preserves(r2, stiffnessReq), rule(17), [uses(37, inherits_requirement(r2, stiffnessReq)), uses(44, considers(r2, carbonFrame)), uses(45, compatible_with(carbonFrame, stiffnessReq))]).
substitution(48, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(48, preserves(r2, assemblyReq), rule(17), [uses(38, inherits_requirement(r2, assemblyReq)), uses(44, considers(r2, carbonFrame)), uses(46, compatible_with(carbonFrame, assemblyReq))]).
substitution(49, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(49, preserves(r2, stiffnessReq), rule(17), [uses(41, inherits_requirement(r2, stiffnessReq)), uses(44, considers(r2, carbonFrame)), uses(45, compatible_with(carbonFrame, stiffnessReq))]).
substitution(50, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(50, preserves(r2, assemblyReq), rule(17), [uses(42, inherits_requirement(r2, assemblyReq)), uses(44, considers(r2, carbonFrame)), uses(46, compatible_with(carbonFrame, assemblyReq))]).
substitution(51, ['Rev' = r2, 'R' = stiffnessReq]).
proof(51, solution([r2, stiffnessReq]), query, [uses(47, preserves(r2, stiffnessReq))]).
substitution(52, ['Rev' = r2, 'R' = assemblyReq]).
proof(52, solution([r2, assemblyReq]), query, [uses(48, preserves(r2, assemblyReq))]).
substitution(53, ['Rev' = r2, 'Req' = stiffnessReq]).
proof(53, satisfies(r2, stiffnessReq), rule(19), [uses(49, preserves(r2, stiffnessReq))]).
substitution(54, ['Rev' = r2, 'Req' = assemblyReq]).
proof(54, satisfies(r2, assemblyReq), rule(19), [uses(50, preserves(r2, assemblyReq))]).
substitution(55, ['Later' = r3, 'Req' = stiffnessReq, 'Earlier' = r2]).
proof(55, inherits_requirement(r3, stiffnessReq), rule(15), [uses(34, derives_from(r3, r2)), uses(53, satisfies(r2, stiffnessReq))]).
substitution(56, ['Later' = r3, 'Req' = assemblyReq, 'Earlier' = r2]).
proof(56, inherits_requirement(r3, assemblyReq), rule(15), [uses(34, derives_from(r3, r2)), uses(54, satisfies(r2, assemblyReq))]).
substitution(57, []).
proof(57, design_goal(r3, improveCooling), rule(14), []).
substitution(58, []).
proof(58, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(59, ['Rev' = r3, 'Opt' = ribbedHousing, 'Goal' = improveCooling]).
proof(59, considers(r3, ribbedHousing), rule(16), [uses(57, design_goal(r3, improveCooling)), uses(58, suggests(improveCooling, ribbedHousing))]).
substitution(60, []).
proof(60, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(61, ['Rev' = r3, 'Req' = assemblyReq, 'Opt' = ribbedHousing]).
proof(61, preserves(r3, assemblyReq), rule(17), [uses(56, inherits_requirement(r3, assemblyReq)), uses(59, considers(r3, ribbedHousing)), uses(60, compatible_with(ribbedHousing, assemblyReq))]).
substitution(62, ['Rev' = r3, 'R' = assemblyReq]).
proof(62, solution([r3, assemblyReq]), query, [uses(61, preserves(r3, assemblyReq))]).
substitution(63, []).
proof(63, derives_from(r2, r1), rule(11), []).
substitution(64, []).
proof(64, derives_from(r3, r2), rule(13), []).
substitution(65, []).
proof(65, satisfies(r1, stiffnessReq), rule(7), []).
substitution(66, []).
proof(66, satisfies(r1, assemblyReq), rule(8), []).
substitution(67, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(67, inherits_requirement(r2, stiffnessReq), rule(15), [uses(63, derives_from(r2, r1)), uses(65, satisfies(r1, stiffnessReq))]).
substitution(68, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(68, inherits_requirement(r2, assemblyReq), rule(15), [uses(63, derives_from(r2, r1)), uses(66, satisfies(r1, assemblyReq))]).
substitution(69, []).
proof(69, derives_from(r2, r1), rule(11), []).
substitution(70, []).
proof(70, design_goal(r2, reduceWeight), rule(12), []).
substitution(71, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(71, inherits_requirement(r2, stiffnessReq), rule(15), [uses(69, derives_from(r2, r1)), uses(65, satisfies(r1, stiffnessReq))]).
substitution(72, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(72, inherits_requirement(r2, assemblyReq), rule(15), [uses(69, derives_from(r2, r1)), uses(66, satisfies(r1, assemblyReq))]).
substitution(73, []).
proof(73, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(74, ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight]).
proof(74, considers(r2, carbonFrame), rule(16), [uses(70, design_goal(r2, reduceWeight)), uses(73, suggests(reduceWeight, carbonFrame))]).
substitution(75, []).
proof(75, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(76, []).
proof(76, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(77, ['Rev' = r2, 'Opt' = carbonFrame, 'Req' = stiffnessReq]).
proof(77, integrates(r2, carbonFrame), rule(18), [uses(67, inherits_requirement(r2, stiffnessReq)), uses(74, considers(r2, carbonFrame)), uses(75, compatible_with(carbonFrame, stiffnessReq))]).
substitution(78, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(78, preserves(r2, stiffnessReq), rule(17), [uses(71, inherits_requirement(r2, stiffnessReq)), uses(74, considers(r2, carbonFrame)), uses(75, compatible_with(carbonFrame, stiffnessReq))]).
substitution(79, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(79, preserves(r2, assemblyReq), rule(17), [uses(72, inherits_requirement(r2, assemblyReq)), uses(74, considers(r2, carbonFrame)), uses(76, compatible_with(carbonFrame, assemblyReq))]).
substitution(80, ['Rev' = r2, 'O' = carbonFrame]).
proof(80, solution([r2, carbonFrame]), query, [uses(77, integrates(r2, carbonFrame))]).
substitution(81, ['Rev' = r2, 'Req' = stiffnessReq]).
proof(81, satisfies(r2, stiffnessReq), rule(19), [uses(78, preserves(r2, stiffnessReq))]).
substitution(82, ['Rev' = r2, 'Req' = assemblyReq]).
proof(82, satisfies(r2, assemblyReq), rule(19), [uses(79, preserves(r2, assemblyReq))]).
substitution(83, ['Later' = r3, 'Req' = stiffnessReq, 'Earlier' = r2]).
proof(83, inherits_requirement(r3, stiffnessReq), rule(15), [uses(64, derives_from(r3, r2)), uses(81, satisfies(r2, stiffnessReq))]).
substitution(84, ['Later' = r3, 'Req' = assemblyReq, 'Earlier' = r2]).
proof(84, inherits_requirement(r3, assemblyReq), rule(15), [uses(64, derives_from(r3, r2)), uses(82, satisfies(r2, assemblyReq))]).
substitution(85, []).
proof(85, design_goal(r3, improveCooling), rule(14), []).
substitution(86, []).
proof(86, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(87, ['Rev' = r3, 'Opt' = ribbedHousing, 'Goal' = improveCooling]).
proof(87, considers(r3, ribbedHousing), rule(16), [uses(85, design_goal(r3, improveCooling)), uses(86, suggests(improveCooling, ribbedHousing))]).
substitution(88, []).
proof(88, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(89, ['Rev' = r3, 'Opt' = ribbedHousing, 'Req' = assemblyReq]).
proof(89, integrates(r3, ribbedHousing), rule(18), [uses(84, inherits_requirement(r3, assemblyReq)), uses(87, considers(r3, ribbedHousing)), uses(88, compatible_with(ribbedHousing, assemblyReq))]).
substitution(90, ['Rev' = r3, 'O' = ribbedHousing]).
proof(90, solution([r3, ribbedHousing]), query, [uses(89, integrates(r3, ribbedHousing))]).
substitution(91, []).
proof(91, satisfies(r1, stiffnessReq), rule(7), []).
substitution(92, []).
proof(92, satisfies(r1, assemblyReq), rule(8), []).
substitution(93, ['Rev' = r1, 'R' = stiffnessReq]).
proof(93, solution([r1, stiffnessReq]), query, [uses(91, satisfies(r1, stiffnessReq))]).
substitution(94, ['Rev' = r1, 'R' = assemblyReq]).
proof(94, solution([r1, assemblyReq]), query, [uses(92, satisfies(r1, assemblyReq))]).
substitution(95, []).
proof(95, derives_from(r2, r1), rule(11), []).
substitution(96, []).
proof(96, derives_from(r3, r2), rule(13), []).
substitution(97, []).
proof(97, satisfies(r1, stiffnessReq), rule(7), []).
substitution(98, []).
proof(98, satisfies(r1, assemblyReq), rule(8), []).
substitution(99, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(99, inherits_requirement(r2, stiffnessReq), rule(15), [uses(95, derives_from(r2, r1)), uses(97, satisfies(r1, stiffnessReq))]).
substitution(100, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(100, inherits_requirement(r2, assemblyReq), rule(15), [uses(95, derives_from(r2, r1)), uses(98, satisfies(r1, assemblyReq))]).
substitution(101, []).
proof(101, derives_from(r2, r1), rule(11), []).
substitution(102, []).
proof(102, design_goal(r2, reduceWeight), rule(12), []).
substitution(103, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(103, inherits_requirement(r2, stiffnessReq), rule(15), [uses(101, derives_from(r2, r1)), uses(97, satisfies(r1, stiffnessReq))]).
substitution(104, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(104, inherits_requirement(r2, assemblyReq), rule(15), [uses(101, derives_from(r2, r1)), uses(98, satisfies(r1, assemblyReq))]).
substitution(105, []).
proof(105, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(106, ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight]).
proof(106, considers(r2, carbonFrame), rule(16), [uses(102, design_goal(r2, reduceWeight)), uses(105, suggests(reduceWeight, carbonFrame))]).
substitution(107, []).
proof(107, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(108, []).
proof(108, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(109, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(109, preserves(r2, stiffnessReq), rule(17), [uses(99, inherits_requirement(r2, stiffnessReq)), uses(106, considers(r2, carbonFrame)), uses(107, compatible_with(carbonFrame, stiffnessReq))]).
substitution(110, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(110, preserves(r2, assemblyReq), rule(17), [uses(100, inherits_requirement(r2, assemblyReq)), uses(106, considers(r2, carbonFrame)), uses(108, compatible_with(carbonFrame, assemblyReq))]).
substitution(111, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(111, preserves(r2, stiffnessReq), rule(17), [uses(103, inherits_requirement(r2, stiffnessReq)), uses(106, considers(r2, carbonFrame)), uses(107, compatible_with(carbonFrame, stiffnessReq))]).
substitution(112, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(112, preserves(r2, assemblyReq), rule(17), [uses(104, inherits_requirement(r2, assemblyReq)), uses(106, considers(r2, carbonFrame)), uses(108, compatible_with(carbonFrame, assemblyReq))]).
substitution(113, ['Rev' = r2, 'Req' = stiffnessReq]).
proof(113, satisfies(r2, stiffnessReq), rule(19), [uses(109, preserves(r2, stiffnessReq))]).
substitution(114, ['Rev' = r2, 'Req' = assemblyReq]).
proof(114, satisfies(r2, assemblyReq), rule(19), [uses(110, preserves(r2, assemblyReq))]).
substitution(115, ['Rev' = r2, 'Req' = stiffnessReq]).
proof(115, satisfies(r2, stiffnessReq), rule(19), [uses(111, preserves(r2, stiffnessReq))]).
substitution(116, ['Rev' = r2, 'Req' = assemblyReq]).
proof(116, satisfies(r2, assemblyReq), rule(19), [uses(112, preserves(r2, assemblyReq))]).
substitution(117, ['Rev' = r2, 'R' = stiffnessReq]).
proof(117, solution([r2, stiffnessReq]), query, [uses(113, satisfies(r2, stiffnessReq))]).
substitution(118, ['Rev' = r2, 'R' = assemblyReq]).
proof(118, solution([r2, assemblyReq]), query, [uses(114, satisfies(r2, assemblyReq))]).
substitution(119, ['Later' = r3, 'Req' = stiffnessReq, 'Earlier' = r2]).
proof(119, inherits_requirement(r3, stiffnessReq), rule(15), [uses(96, derives_from(r3, r2)), uses(115, satisfies(r2, stiffnessReq))]).
substitution(120, ['Later' = r3, 'Req' = assemblyReq, 'Earlier' = r2]).
proof(120, inherits_requirement(r3, assemblyReq), rule(15), [uses(96, derives_from(r3, r2)), uses(116, satisfies(r2, assemblyReq))]).
substitution(121, []).
proof(121, design_goal(r3, improveCooling), rule(14), []).
substitution(122, []).
proof(122, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(123, ['Rev' = r3, 'Opt' = ribbedHousing, 'Goal' = improveCooling]).
proof(123, considers(r3, ribbedHousing), rule(16), [uses(121, design_goal(r3, improveCooling)), uses(122, suggests(improveCooling, ribbedHousing))]).
substitution(124, []).
proof(124, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(125, ['Rev' = r3, 'Req' = assemblyReq, 'Opt' = ribbedHousing]).
proof(125, preserves(r3, assemblyReq), rule(17), [uses(120, inherits_requirement(r3, assemblyReq)), uses(123, considers(r3, ribbedHousing)), uses(124, compatible_with(ribbedHousing, assemblyReq))]).
substitution(126, ['Rev' = r3, 'Req' = assemblyReq]).
proof(126, satisfies(r3, assemblyReq), rule(19), [uses(125, preserves(r3, assemblyReq))]).
substitution(127, ['Rev' = r3, 'R' = assemblyReq]).
proof(127, solution([r3, assemblyReq]), query, [uses(126, satisfies(r3, assemblyReq))]).
substitution(128, []).
proof(128, realizes(r1, aluminumFrame), rule(9), []).
substitution(129, ['Rev' = r1, 'O' = aluminumFrame]).
proof(129, solution([r1, aluminumFrame]), query, [uses(128, realizes(r1, aluminumFrame))]).
substitution(130, []).
proof(130, derives_from(r2, r1), rule(11), []).
substitution(131, []).
proof(131, derives_from(r3, r2), rule(13), []).
substitution(132, []).
proof(132, satisfies(r1, stiffnessReq), rule(7), []).
substitution(133, []).
proof(133, satisfies(r1, assemblyReq), rule(8), []).
substitution(134, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(134, inherits_requirement(r2, stiffnessReq), rule(15), [uses(130, derives_from(r2, r1)), uses(132, satisfies(r1, stiffnessReq))]).
substitution(135, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(135, inherits_requirement(r2, assemblyReq), rule(15), [uses(130, derives_from(r2, r1)), uses(133, satisfies(r1, assemblyReq))]).
substitution(136, []).
proof(136, derives_from(r2, r1), rule(11), []).
substitution(137, []).
proof(137, design_goal(r2, reduceWeight), rule(12), []).
substitution(138, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(138, inherits_requirement(r2, stiffnessReq), rule(15), [uses(136, derives_from(r2, r1)), uses(132, satisfies(r1, stiffnessReq))]).
substitution(139, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(139, inherits_requirement(r2, assemblyReq), rule(15), [uses(136, derives_from(r2, r1)), uses(133, satisfies(r1, assemblyReq))]).
substitution(140, []).
proof(140, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(141, ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight]).
proof(141, considers(r2, carbonFrame), rule(16), [uses(137, design_goal(r2, reduceWeight)), uses(140, suggests(reduceWeight, carbonFrame))]).
substitution(142, []).
proof(142, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(143, []).
proof(143, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(144, ['Rev' = r2, 'Opt' = carbonFrame, 'Req' = stiffnessReq]).
proof(144, integrates(r2, carbonFrame), rule(18), [uses(134, inherits_requirement(r2, stiffnessReq)), uses(141, considers(r2, carbonFrame)), uses(142, compatible_with(carbonFrame, stiffnessReq))]).
substitution(145, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(145, preserves(r2, stiffnessReq), rule(17), [uses(138, inherits_requirement(r2, stiffnessReq)), uses(141, considers(r2, carbonFrame)), uses(142, compatible_with(carbonFrame, stiffnessReq))]).
substitution(146, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(146, preserves(r2, assemblyReq), rule(17), [uses(139, inherits_requirement(r2, assemblyReq)), uses(141, considers(r2, carbonFrame)), uses(143, compatible_with(carbonFrame, assemblyReq))]).
substitution(147, ['Rev' = r2, 'Opt' = carbonFrame]).
proof(147, realizes(r2, carbonFrame), rule(20), [uses(144, integrates(r2, carbonFrame))]).
substitution(148, ['Rev' = r2, 'Req' = stiffnessReq]).
proof(148, satisfies(r2, stiffnessReq), rule(19), [uses(145, preserves(r2, stiffnessReq))]).
substitution(149, ['Rev' = r2, 'Req' = assemblyReq]).
proof(149, satisfies(r2, assemblyReq), rule(19), [uses(146, preserves(r2, assemblyReq))]).
substitution(150, ['Rev' = r2, 'O' = carbonFrame]).
proof(150, solution([r2, carbonFrame]), query, [uses(147, realizes(r2, carbonFrame))]).
substitution(151, ['Later' = r3, 'Req' = stiffnessReq, 'Earlier' = r2]).
proof(151, inherits_requirement(r3, stiffnessReq), rule(15), [uses(131, derives_from(r3, r2)), uses(148, satisfies(r2, stiffnessReq))]).
substitution(152, ['Later' = r3, 'Req' = assemblyReq, 'Earlier' = r2]).
proof(152, inherits_requirement(r3, assemblyReq), rule(15), [uses(131, derives_from(r3, r2)), uses(149, satisfies(r2, assemblyReq))]).
substitution(153, []).
proof(153, design_goal(r3, improveCooling), rule(14), []).
substitution(154, []).
proof(154, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(155, ['Rev' = r3, 'Opt' = ribbedHousing, 'Goal' = improveCooling]).
proof(155, considers(r3, ribbedHousing), rule(16), [uses(153, design_goal(r3, improveCooling)), uses(154, suggests(improveCooling, ribbedHousing))]).
substitution(156, []).
proof(156, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(157, ['Rev' = r3, 'Opt' = ribbedHousing, 'Req' = assemblyReq]).
proof(157, integrates(r3, ribbedHousing), rule(18), [uses(152, inherits_requirement(r3, assemblyReq)), uses(155, considers(r3, ribbedHousing)), uses(156, compatible_with(ribbedHousing, assemblyReq))]).
substitution(158, ['Rev' = r3, 'Opt' = ribbedHousing]).
proof(158, realizes(r3, ribbedHousing), rule(20), [uses(157, integrates(r3, ribbedHousing))]).
substitution(159, ['Rev' = r3, 'O' = ribbedHousing]).
proof(159, solution([r3, ribbedHousing]), query, [uses(158, realizes(r3, ribbedHousing))]).
substitution(160, []).
proof(160, achieves(r1, approvedBaseline), rule(10), []).
substitution(161, ['Rev' = r1]).
proof(161, status(r1, approvedBaseline), rule(23), [uses(160, achieves(r1, approvedBaseline))]).
substitution(162, []).
proof(162, realizes(r1, aluminumFrame), rule(9), []).
substitution(163, ['Rev' = r1, 'S' = approvedBaseline]).
proof(163, solution([r1, approvedBaseline]), query, [uses(161, status(r1, approvedBaseline))]).
substitution(164, []).
proof(164, derives_from(r2, r1), rule(11), []).
substitution(165, []).
proof(165, derives_from(r3, r2), rule(13), []).
substitution(166, []).
proof(166, satisfies(r1, stiffnessReq), rule(7), []).
substitution(167, []).
proof(167, satisfies(r1, assemblyReq), rule(8), []).
substitution(168, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(168, inherits_requirement(r2, stiffnessReq), rule(15), [uses(164, derives_from(r2, r1)), uses(166, satisfies(r1, stiffnessReq))]).
substitution(169, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(169, inherits_requirement(r2, assemblyReq), rule(15), [uses(164, derives_from(r2, r1)), uses(167, satisfies(r1, assemblyReq))]).
substitution(170, []).
proof(170, derives_from(r2, r1), rule(11), []).
substitution(171, []).
proof(171, design_goal(r2, reduceWeight), rule(12), []).
substitution(172, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(172, inherits_requirement(r2, stiffnessReq), rule(15), [uses(170, derives_from(r2, r1)), uses(166, satisfies(r1, stiffnessReq))]).
substitution(173, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(173, inherits_requirement(r2, assemblyReq), rule(15), [uses(170, derives_from(r2, r1)), uses(167, satisfies(r1, assemblyReq))]).
substitution(174, []).
proof(174, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(175, ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight]).
proof(175, considers(r2, carbonFrame), rule(16), [uses(171, design_goal(r2, reduceWeight)), uses(174, suggests(reduceWeight, carbonFrame))]).
substitution(176, []).
proof(176, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(177, []).
proof(177, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(178, ['Rev' = r2, 'Opt' = carbonFrame, 'Req' = stiffnessReq]).
proof(178, integrates(r2, carbonFrame), rule(18), [uses(168, inherits_requirement(r2, stiffnessReq)), uses(175, considers(r2, carbonFrame)), uses(176, compatible_with(carbonFrame, stiffnessReq))]).
substitution(179, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(179, preserves(r2, stiffnessReq), rule(17), [uses(172, inherits_requirement(r2, stiffnessReq)), uses(175, considers(r2, carbonFrame)), uses(176, compatible_with(carbonFrame, stiffnessReq))]).
substitution(180, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(180, preserves(r2, assemblyReq), rule(17), [uses(173, inherits_requirement(r2, assemblyReq)), uses(175, considers(r2, carbonFrame)), uses(177, compatible_with(carbonFrame, assemblyReq))]).
substitution(181, ['Rev' = r2, 'Opt' = carbonFrame]).
proof(181, realizes(r2, carbonFrame), rule(20), [uses(178, integrates(r2, carbonFrame))]).
substitution(182, ['Rev' = r2, 'Req' = stiffnessReq]).
proof(182, satisfies(r2, stiffnessReq), rule(19), [uses(179, preserves(r2, stiffnessReq))]).
substitution(183, ['Rev' = r2, 'Req' = assemblyReq]).
proof(183, satisfies(r2, assemblyReq), rule(19), [uses(180, preserves(r2, assemblyReq))]).
substitution(184, ['Rev' = r2, 'Opt' = carbonFrame]).
proof(184, achieves(r2, approvedBaseline), rule(21), [uses(181, realizes(r2, carbonFrame))]).
substitution(185, ['Later' = r3, 'Req' = stiffnessReq, 'Earlier' = r2]).
proof(185, inherits_requirement(r3, stiffnessReq), rule(15), [uses(165, derives_from(r3, r2)), uses(182, satisfies(r2, stiffnessReq))]).
substitution(186, ['Later' = r3, 'Req' = assemblyReq, 'Earlier' = r2]).
proof(186, inherits_requirement(r3, assemblyReq), rule(15), [uses(165, derives_from(r3, r2)), uses(183, satisfies(r2, assemblyReq))]).
substitution(187, ['Rev' = r2]).
proof(187, status(r2, approvedBaseline), rule(23), [uses(184, achieves(r2, approvedBaseline))]).
substitution(188, ['Rev' = r2, 'S' = approvedBaseline]).
proof(188, solution([r2, approvedBaseline]), query, [uses(187, status(r2, approvedBaseline))]).
substitution(189, []).
proof(189, design_goal(r3, improveCooling), rule(14), []).
substitution(190, []).
proof(190, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(191, ['Rev' = r3, 'Opt' = ribbedHousing, 'Goal' = improveCooling]).
proof(191, considers(r3, ribbedHousing), rule(16), [uses(189, design_goal(r3, improveCooling)), uses(190, suggests(improveCooling, ribbedHousing))]).
substitution(192, []).
proof(192, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(193, ['Rev' = r3, 'Opt' = ribbedHousing, 'Req' = assemblyReq]).
proof(193, integrates(r3, ribbedHousing), rule(18), [uses(186, inherits_requirement(r3, assemblyReq)), uses(191, considers(r3, ribbedHousing)), uses(192, compatible_with(ribbedHousing, assemblyReq))]).
substitution(194, ['Rev' = r3, 'Opt' = ribbedHousing]).
proof(194, realizes(r3, ribbedHousing), rule(20), [uses(193, integrates(r3, ribbedHousing))]).
substitution(195, ['Rev' = r3, 'Opt' = ribbedHousing]).
proof(195, achieves(r3, approvedBaseline), rule(21), [uses(194, realizes(r3, ribbedHousing))]).
substitution(196, ['Rev' = r3]).
proof(196, status(r3, approvedBaseline), rule(23), [uses(195, achieves(r3, approvedBaseline))]).
substitution(197, ['Rev' = r3, 'S' = approvedBaseline]).
proof(197, solution([r3, approvedBaseline]), query, [uses(196, status(r3, approvedBaseline))]).
substitution(198, []).
proof(198, realizes(r1, aluminumFrame), rule(9), []).
substitution(199, ['Rev' = r1, 'Opt' = aluminumFrame]).
proof(199, available_for_future_iteration(r1, yes), rule(22), [uses(198, realizes(r1, aluminumFrame))]).
substitution(200, ['Rev' = r1, 'Y' = yes]).
proof(200, solution([r1, yes]), query, [uses(199, available_for_future_iteration(r1, yes))]).
substitution(201, []).
proof(201, derives_from(r2, r1), rule(11), []).
substitution(202, []).
proof(202, derives_from(r3, r2), rule(13), []).
substitution(203, []).
proof(203, satisfies(r1, stiffnessReq), rule(7), []).
substitution(204, []).
proof(204, satisfies(r1, assemblyReq), rule(8), []).
substitution(205, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(205, inherits_requirement(r2, stiffnessReq), rule(15), [uses(201, derives_from(r2, r1)), uses(203, satisfies(r1, stiffnessReq))]).
substitution(206, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(206, inherits_requirement(r2, assemblyReq), rule(15), [uses(201, derives_from(r2, r1)), uses(204, satisfies(r1, assemblyReq))]).
substitution(207, []).
proof(207, derives_from(r2, r1), rule(11), []).
substitution(208, []).
proof(208, design_goal(r2, reduceWeight), rule(12), []).
substitution(209, ['Later' = r2, 'Req' = stiffnessReq, 'Earlier' = r1]).
proof(209, inherits_requirement(r2, stiffnessReq), rule(15), [uses(207, derives_from(r2, r1)), uses(203, satisfies(r1, stiffnessReq))]).
substitution(210, ['Later' = r2, 'Req' = assemblyReq, 'Earlier' = r1]).
proof(210, inherits_requirement(r2, assemblyReq), rule(15), [uses(207, derives_from(r2, r1)), uses(204, satisfies(r1, assemblyReq))]).
substitution(211, []).
proof(211, suggests(reduceWeight, carbonFrame), rule(1), []).
substitution(212, ['Rev' = r2, 'Opt' = carbonFrame, 'Goal' = reduceWeight]).
proof(212, considers(r2, carbonFrame), rule(16), [uses(208, design_goal(r2, reduceWeight)), uses(211, suggests(reduceWeight, carbonFrame))]).
substitution(213, []).
proof(213, compatible_with(carbonFrame, stiffnessReq), rule(3), []).
substitution(214, []).
proof(214, compatible_with(carbonFrame, assemblyReq), rule(4), []).
substitution(215, ['Rev' = r2, 'Opt' = carbonFrame, 'Req' = stiffnessReq]).
proof(215, integrates(r2, carbonFrame), rule(18), [uses(205, inherits_requirement(r2, stiffnessReq)), uses(212, considers(r2, carbonFrame)), uses(213, compatible_with(carbonFrame, stiffnessReq))]).
substitution(216, ['Rev' = r2, 'Req' = stiffnessReq, 'Opt' = carbonFrame]).
proof(216, preserves(r2, stiffnessReq), rule(17), [uses(209, inherits_requirement(r2, stiffnessReq)), uses(212, considers(r2, carbonFrame)), uses(213, compatible_with(carbonFrame, stiffnessReq))]).
substitution(217, ['Rev' = r2, 'Req' = assemblyReq, 'Opt' = carbonFrame]).
proof(217, preserves(r2, assemblyReq), rule(17), [uses(210, inherits_requirement(r2, assemblyReq)), uses(212, considers(r2, carbonFrame)), uses(214, compatible_with(carbonFrame, assemblyReq))]).
substitution(218, ['Rev' = r2, 'Opt' = carbonFrame]).
proof(218, realizes(r2, carbonFrame), rule(20), [uses(215, integrates(r2, carbonFrame))]).
substitution(219, ['Rev' = r2, 'Req' = stiffnessReq]).
proof(219, satisfies(r2, stiffnessReq), rule(19), [uses(216, preserves(r2, stiffnessReq))]).
substitution(220, ['Rev' = r2, 'Req' = assemblyReq]).
proof(220, satisfies(r2, assemblyReq), rule(19), [uses(217, preserves(r2, assemblyReq))]).
substitution(221, ['Rev' = r2, 'Opt' = carbonFrame]).
proof(221, available_for_future_iteration(r2, yes), rule(22), [uses(218, realizes(r2, carbonFrame))]).
substitution(222, ['Later' = r3, 'Req' = stiffnessReq, 'Earlier' = r2]).
proof(222, inherits_requirement(r3, stiffnessReq), rule(15), [uses(202, derives_from(r3, r2)), uses(219, satisfies(r2, stiffnessReq))]).
substitution(223, ['Later' = r3, 'Req' = assemblyReq, 'Earlier' = r2]).
proof(223, inherits_requirement(r3, assemblyReq), rule(15), [uses(202, derives_from(r3, r2)), uses(220, satisfies(r2, assemblyReq))]).
substitution(224, ['Rev' = r2, 'Y' = yes]).
proof(224, solution([r2, yes]), query, [uses(221, available_for_future_iteration(r2, yes))]).
substitution(225, []).
proof(225, design_goal(r3, improveCooling), rule(14), []).
substitution(226, []).
proof(226, suggests(improveCooling, ribbedHousing), rule(2), []).
substitution(227, ['Rev' = r3, 'Opt' = ribbedHousing, 'Goal' = improveCooling]).
proof(227, considers(r3, ribbedHousing), rule(16), [uses(225, design_goal(r3, improveCooling)), uses(226, suggests(improveCooling, ribbedHousing))]).
substitution(228, []).
proof(228, compatible_with(ribbedHousing, assemblyReq), rule(6), []).
substitution(229, ['Rev' = r3, 'Opt' = ribbedHousing, 'Req' = assemblyReq]).
proof(229, integrates(r3, ribbedHousing), rule(18), [uses(223, inherits_requirement(r3, assemblyReq)), uses(227, considers(r3, ribbedHousing)), uses(228, compatible_with(ribbedHousing, assemblyReq))]).
substitution(230, ['Rev' = r3, 'Opt' = ribbedHousing]).
proof(230, realizes(r3, ribbedHousing), rule(20), [uses(229, integrates(r3, ribbedHousing))]).
substitution(231, ['Rev' = r3, 'Opt' = ribbedHousing]).
proof(231, available_for_future_iteration(r3, yes), rule(22), [uses(230, realizes(r3, ribbedHousing))]).
substitution(232, ['Rev' = r3, 'Y' = yes]).
proof(232, solution([r3, yes]), query, [uses(231, available_for_future_iteration(r3, yes))]).
