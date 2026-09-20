# Eyelang result format 2
query(1, [call(inherits_requirement(?v0, ?v1))], [binding("l", ?v0), binding("r", ?v1)]).
result(1, complete, 5).
answer(1, [binding("l", c2), binding("r", stabilityReq)]).
why(1, [binding("l", c2), binding("r", stabilityReq)], 7).
answer(1, [binding("l", c2), binding("r", trackingReq)]).
why(1, [binding("l", c2), binding("r", trackingReq)], 8).
answer(1, [binding("l", c3), binding("r", overshootReq)]).
why(1, [binding("l", c3), binding("r", overshootReq)], 28).
answer(1, [binding("l", c3), binding("r", stabilityReq)]).
why(1, [binding("l", c3), binding("r", stabilityReq)], 29).
answer(1, [binding("l", c3), binding("r", trackingReq)]).
why(1, [binding("l", c3), binding("r", trackingReq)], 30).
query(2, [call(considers(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(2, complete, 2).
answer(2, [binding("c", c2), binding("s", leadCompensator)]).
why(2, [binding("c", c2), binding("s", leadCompensator)], 37).
answer(2, [binding("c", c3), binding("s", integralAction)]).
why(2, [binding("c", c3), binding("s", integralAction)], 38).
query(3, [call(targets(?v0, ?v1))], [binding("c", ?v0), binding("r", ?v1)]).
result(3, complete, 2).
answer(3, [binding("c", c2), binding("r", overshootReq)]).
why(3, [binding("c", c2), binding("r", overshootReq)], 45).
answer(3, [binding("c", c3), binding("r", disturbanceRejectionReq)]).
why(3, [binding("c", c3), binding("r", disturbanceRejectionReq)], 46).
query(4, [call(preserves(?v0, ?v1))], [binding("c", ?v0), binding("r", ?v1)]).
result(4, complete, 5).
answer(4, [binding("c", c2), binding("r", stabilityReq)]).
why(4, [binding("c", c2), binding("r", stabilityReq)], 71).
answer(4, [binding("c", c2), binding("r", trackingReq)]).
why(4, [binding("c", c2), binding("r", trackingReq)], 72).
answer(4, [binding("c", c3), binding("r", overshootReq)]).
why(4, [binding("c", c3), binding("r", overshootReq)], 85).
answer(4, [binding("c", c3), binding("r", stabilityReq)]).
why(4, [binding("c", c3), binding("r", stabilityReq)], 86).
answer(4, [binding("c", c3), binding("r", trackingReq)]).
why(4, [binding("c", c3), binding("r", trackingReq)], 87).
query(5, [call(integrates(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(5, complete, 2).
answer(5, [binding("c", c2), binding("s", leadCompensator)]).
why(5, [binding("c", c2), binding("s", leadCompensator)], 119).
answer(5, [binding("c", c3), binding("s", integralAction)]).
why(5, [binding("c", c3), binding("s", integralAction)], 128).
query(6, [call(satisfies(?v0, ?v1))], [binding("c", ?v0), binding("r", ?v1)]).
result(6, complete, 9).
answer(6, [binding("c", c1), binding("r", stabilityReq)]).
why(6, [binding("c", c1), binding("r", stabilityReq)], 131).
answer(6, [binding("c", c1), binding("r", trackingReq)]).
why(6, [binding("c", c1), binding("r", trackingReq)], 132).
answer(6, [binding("c", c2), binding("r", overshootReq)]).
why(6, [binding("c", c2), binding("r", overshootReq)], 170).
answer(6, [binding("c", c3), binding("r", disturbanceRejectionReq)]).
why(6, [binding("c", c3), binding("r", disturbanceRejectionReq)], 171).
answer(6, [binding("c", c2), binding("r", stabilityReq)]).
why(6, [binding("c", c2), binding("r", stabilityReq)], 172).
answer(6, [binding("c", c2), binding("r", trackingReq)]).
why(6, [binding("c", c2), binding("r", trackingReq)], 173).
answer(6, [binding("c", c3), binding("r", overshootReq)]).
why(6, [binding("c", c3), binding("r", overshootReq)], 186).
answer(6, [binding("c", c3), binding("r", stabilityReq)]).
why(6, [binding("c", c3), binding("r", stabilityReq)], 187).
answer(6, [binding("c", c3), binding("r", trackingReq)]).
why(6, [binding("c", c3), binding("r", trackingReq)], 188).
query(7, [call(realizes(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(7, complete, 3).
answer(7, [binding("c", c1), binding("s", baselinePID)]).
why(7, [binding("c", c1), binding("s", baselinePID)], 190).
answer(7, [binding("c", c2), binding("s", leadCompensator)]).
why(7, [binding("c", c2), binding("s", leadCompensator)], 227).
answer(7, [binding("c", c3), binding("s", integralAction)]).
why(7, [binding("c", c3), binding("s", integralAction)], 233).
query(8, [call(status(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(8, complete, 3).
answer(8, [binding("c", c1), binding("s", approvedController)]).
why(8, [binding("c", c1), binding("s", approvedController)], 237).
answer(8, [binding("c", c2), binding("s", approvedController)]).
why(8, [binding("c", c2), binding("s", approvedController)], 281).
answer(8, [binding("c", c3), binding("s", approvedController)]).
why(8, [binding("c", c3), binding("s", approvedController)], 284).
query(9, [call(available_for_future_tuning(?v0, ?v1))], [binding("c", ?v0), binding("y", ?v1)]).
result(9, complete, 3).
answer(9, [binding("c", c1), binding("y", yes)]).
why(9, [binding("c", c1), binding("y", yes)], 287).
answer(9, [binding("c", c2), binding("y", yes)]).
why(9, [binding("c", c2), binding("y", yes)], 326).
answer(9, [binding("c", c3), binding("y", yes)]).
why(9, [binding("c", c3), binding("y", yes)], 332).
clause(1, suggests(reduceOvershoot, leadCompensator), []).
clause(2, introduces_requirement(reduceOvershoot, overshootReq), []).
clause(3, suggests(rejectDisturbance, integralAction), []).
clause(4, introduces_requirement(rejectDisturbance, disturbanceRejectionReq), []).
clause(5, compatible_with(leadCompensator, stabilityReq), []).
clause(6, compatible_with(leadCompensator, trackingReq), []).
clause(7, enables(leadCompensator, overshootReq), []).
clause(8, compatible_with(integralAction, stabilityReq), []).
clause(9, compatible_with(integralAction, trackingReq), []).
clause(10, compatible_with(integralAction, overshootReq), []).
clause(11, enables(integralAction, disturbanceRejectionReq), []).
clause(12, satisfies(c1, stabilityReq), []).
clause(13, satisfies(c1, trackingReq), []).
clause(14, realizes(c1, baselinePID), []).
clause(15, achieves(c1, approvedController), []).
clause(16, derives_from(c2, c1), []).
clause(17, design_goal(c2, reduceOvershoot), []).
clause(18, derives_from(c3, c2), []).
clause(19, design_goal(c3, rejectDisturbance), []).
clause(20, inherits_requirement(var("later"), var("req")), [call(derives_from(var("later"), var("earlier"))), call(satisfies(var("earlier"), var("req")))]).
clause(21, considers(var("ctrl"), var("strategy")), [call(design_goal(var("ctrl"), var("goal"))), call(suggests(var("goal"), var("strategy")))]).
clause(22, targets(var("ctrl"), var("req")), [call(design_goal(var("ctrl"), var("goal"))), call(introduces_requirement(var("goal"), var("req")))]).
clause(23, preserves(var("ctrl"), var("req")), [call(inherits_requirement(var("ctrl"), var("req"))), call(considers(var("ctrl"), var("strategy"))), call(compatible_with(var("strategy"), var("req")))]).
clause(24, integrates(var("ctrl"), var("strategy")), [call(inherits_requirement(var("ctrl"), var("req"))), call(considers(var("ctrl"), var("strategy"))), call(compatible_with(var("strategy"), var("req")))]).
clause(25, satisfies(var("ctrl"), var("req")), [call(targets(var("ctrl"), var("req"))), call(considers(var("ctrl"), var("strategy"))), call(enables(var("strategy"), var("req")))]).
clause(26, integrates(var("ctrl"), var("strategy")), [call(targets(var("ctrl"), var("req"))), call(considers(var("ctrl"), var("strategy"))), call(enables(var("strategy"), var("req")))]).
clause(27, satisfies(var("ctrl"), var("req")), [call(preserves(var("ctrl"), var("req")))]).
clause(28, realizes(var("ctrl"), var("strategy")), [call(integrates(var("ctrl"), var("strategy")))]).
clause(29, achieves(var("ctrl"), approvedController), [call(realizes(var("ctrl"), var("strategy")))]).
clause(30, available_for_future_tuning(var("ctrl"), yes), [call(realizes(var("ctrl"), var("strategy")))]).
clause(31, status(var("ctrl"), approvedController), [call(achieves(var("ctrl"), approvedController))]).
substitution(1, []).
proof(1, derives_from(c2, c1), rule(16), []).
substitution(2, []).
proof(2, derives_from(c3, c2), rule(18), []).
substitution(3, []).
proof(3, satisfies(c1, stabilityReq), rule(12), []).
substitution(4, []).
proof(4, satisfies(c1, trackingReq), rule(13), []).
substitution(5, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(5, inherits_requirement(c2, stabilityReq), rule(20), [uses(1, derives_from(c2, c1)), uses(3, satisfies(c1, stabilityReq))]).
substitution(6, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(6, inherits_requirement(c2, trackingReq), rule(20), [uses(1, derives_from(c2, c1)), uses(4, satisfies(c1, trackingReq))]).
substitution(7, [binding("l", c2), binding("r", stabilityReq)]).
proof(7, solution([c2, stabilityReq]), query, [uses(5, inherits_requirement(c2, stabilityReq))]).
substitution(8, [binding("l", c2), binding("r", trackingReq)]).
proof(8, solution([c2, trackingReq]), query, [uses(6, inherits_requirement(c2, trackingReq))]).
substitution(9, []).
proof(9, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(10, []).
proof(10, derives_from(c2, c1), rule(16), []).
substitution(11, []).
proof(11, introduces_requirement(reduceOvershoot, overshootReq), rule(2), []).
substitution(12, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(12, inherits_requirement(c2, stabilityReq), rule(20), [uses(10, derives_from(c2, c1)), uses(3, satisfies(c1, stabilityReq))]).
substitution(13, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(13, inherits_requirement(c2, trackingReq), rule(20), [uses(10, derives_from(c2, c1)), uses(4, satisfies(c1, trackingReq))]).
substitution(14, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(14, targets(c2, overshootReq), rule(22), [uses(9, design_goal(c2, reduceOvershoot)), uses(11, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(15, []).
proof(15, suggests(reduceOvershoot, leadCompensator), rule(1), []).
substitution(16, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("goal", reduceOvershoot)]).
proof(16, considers(c2, leadCompensator), rule(21), [uses(9, design_goal(c2, reduceOvershoot)), uses(15, suggests(reduceOvershoot, leadCompensator))]).
substitution(17, []).
proof(17, compatible_with(leadCompensator, stabilityReq), rule(5), []).
substitution(18, []).
proof(18, compatible_with(leadCompensator, trackingReq), rule(6), []).
substitution(19, []).
proof(19, enables(leadCompensator, overshootReq), rule(7), []).
substitution(20, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(20, preserves(c2, stabilityReq), rule(23), [uses(12, inherits_requirement(c2, stabilityReq)), uses(16, considers(c2, leadCompensator)), uses(17, compatible_with(leadCompensator, stabilityReq))]).
substitution(21, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(21, preserves(c2, trackingReq), rule(23), [uses(13, inherits_requirement(c2, trackingReq)), uses(16, considers(c2, leadCompensator)), uses(18, compatible_with(leadCompensator, trackingReq))]).
substitution(22, [binding("ctrl", c2), binding("req", overshootReq), binding("strategy", leadCompensator)]).
proof(22, satisfies(c2, overshootReq), rule(25), [uses(14, targets(c2, overshootReq)), uses(16, considers(c2, leadCompensator)), uses(19, enables(leadCompensator, overshootReq))]).
substitution(23, [binding("ctrl", c2), binding("req", stabilityReq)]).
proof(23, satisfies(c2, stabilityReq), rule(27), [uses(20, preserves(c2, stabilityReq))]).
substitution(24, [binding("ctrl", c2), binding("req", trackingReq)]).
proof(24, satisfies(c2, trackingReq), rule(27), [uses(21, preserves(c2, trackingReq))]).
substitution(25, [binding("later", c3), binding("req", overshootReq), binding("earlier", c2)]).
proof(25, inherits_requirement(c3, overshootReq), rule(20), [uses(2, derives_from(c3, c2)), uses(22, satisfies(c2, overshootReq))]).
substitution(26, [binding("later", c3), binding("req", stabilityReq), binding("earlier", c2)]).
proof(26, inherits_requirement(c3, stabilityReq), rule(20), [uses(2, derives_from(c3, c2)), uses(23, satisfies(c2, stabilityReq))]).
substitution(27, [binding("later", c3), binding("req", trackingReq), binding("earlier", c2)]).
proof(27, inherits_requirement(c3, trackingReq), rule(20), [uses(2, derives_from(c3, c2)), uses(24, satisfies(c2, trackingReq))]).
substitution(28, [binding("l", c3), binding("r", overshootReq)]).
proof(28, solution([c3, overshootReq]), query, [uses(25, inherits_requirement(c3, overshootReq))]).
substitution(29, [binding("l", c3), binding("r", stabilityReq)]).
proof(29, solution([c3, stabilityReq]), query, [uses(26, inherits_requirement(c3, stabilityReq))]).
substitution(30, [binding("l", c3), binding("r", trackingReq)]).
proof(30, solution([c3, trackingReq]), query, [uses(27, inherits_requirement(c3, trackingReq))]).
substitution(31, []).
proof(31, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(32, []).
proof(32, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(33, []).
proof(33, suggests(reduceOvershoot, leadCompensator), rule(1), []).
substitution(34, []).
proof(34, suggests(rejectDisturbance, integralAction), rule(3), []).
substitution(35, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("goal", reduceOvershoot)]).
proof(35, considers(c2, leadCompensator), rule(21), [uses(31, design_goal(c2, reduceOvershoot)), uses(33, suggests(reduceOvershoot, leadCompensator))]).
substitution(36, [binding("ctrl", c3), binding("strategy", integralAction), binding("goal", rejectDisturbance)]).
proof(36, considers(c3, integralAction), rule(21), [uses(32, design_goal(c3, rejectDisturbance)), uses(34, suggests(rejectDisturbance, integralAction))]).
substitution(37, [binding("c", c2), binding("s", leadCompensator)]).
proof(37, solution([c2, leadCompensator]), query, [uses(35, considers(c2, leadCompensator))]).
substitution(38, [binding("c", c3), binding("s", integralAction)]).
proof(38, solution([c3, integralAction]), query, [uses(36, considers(c3, integralAction))]).
substitution(39, []).
proof(39, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(40, []).
proof(40, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(41, []).
proof(41, introduces_requirement(reduceOvershoot, overshootReq), rule(2), []).
substitution(42, []).
proof(42, introduces_requirement(rejectDisturbance, disturbanceRejectionReq), rule(4), []).
substitution(43, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(43, targets(c2, overshootReq), rule(22), [uses(39, design_goal(c2, reduceOvershoot)), uses(41, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(44, [binding("ctrl", c3), binding("req", disturbanceRejectionReq), binding("goal", rejectDisturbance)]).
proof(44, targets(c3, disturbanceRejectionReq), rule(22), [uses(40, design_goal(c3, rejectDisturbance)), uses(42, introduces_requirement(rejectDisturbance, disturbanceRejectionReq))]).
substitution(45, [binding("c", c2), binding("r", overshootReq)]).
proof(45, solution([c2, overshootReq]), query, [uses(43, targets(c2, overshootReq))]).
substitution(46, [binding("c", c3), binding("r", disturbanceRejectionReq)]).
proof(46, solution([c3, disturbanceRejectionReq]), query, [uses(44, targets(c3, disturbanceRejectionReq))]).
substitution(47, []).
proof(47, derives_from(c2, c1), rule(16), []).
substitution(48, []).
proof(48, derives_from(c3, c2), rule(18), []).
substitution(49, []).
proof(49, satisfies(c1, stabilityReq), rule(12), []).
substitution(50, []).
proof(50, satisfies(c1, trackingReq), rule(13), []).
substitution(51, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(51, inherits_requirement(c2, stabilityReq), rule(20), [uses(47, derives_from(c2, c1)), uses(49, satisfies(c1, stabilityReq))]).
substitution(52, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(52, inherits_requirement(c2, trackingReq), rule(20), [uses(47, derives_from(c2, c1)), uses(50, satisfies(c1, trackingReq))]).
substitution(53, []).
proof(53, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(54, []).
proof(54, derives_from(c2, c1), rule(16), []).
substitution(55, []).
proof(55, suggests(reduceOvershoot, leadCompensator), rule(1), []).
substitution(56, []).
proof(56, introduces_requirement(reduceOvershoot, overshootReq), rule(2), []).
substitution(57, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(57, inherits_requirement(c2, stabilityReq), rule(20), [uses(54, derives_from(c2, c1)), uses(49, satisfies(c1, stabilityReq))]).
substitution(58, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(58, inherits_requirement(c2, trackingReq), rule(20), [uses(54, derives_from(c2, c1)), uses(50, satisfies(c1, trackingReq))]).
substitution(59, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("goal", reduceOvershoot)]).
proof(59, considers(c2, leadCompensator), rule(21), [uses(53, design_goal(c2, reduceOvershoot)), uses(55, suggests(reduceOvershoot, leadCompensator))]).
substitution(60, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(60, targets(c2, overshootReq), rule(22), [uses(53, design_goal(c2, reduceOvershoot)), uses(56, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(61, []).
proof(61, compatible_with(leadCompensator, stabilityReq), rule(5), []).
substitution(62, []).
proof(62, compatible_with(leadCompensator, trackingReq), rule(6), []).
substitution(63, []).
proof(63, enables(leadCompensator, overshootReq), rule(7), []).
substitution(64, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(64, preserves(c2, stabilityReq), rule(23), [uses(57, inherits_requirement(c2, stabilityReq)), uses(59, considers(c2, leadCompensator)), uses(61, compatible_with(leadCompensator, stabilityReq))]).
substitution(65, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(65, preserves(c2, trackingReq), rule(23), [uses(58, inherits_requirement(c2, trackingReq)), uses(59, considers(c2, leadCompensator)), uses(62, compatible_with(leadCompensator, trackingReq))]).
substitution(66, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(66, preserves(c2, stabilityReq), rule(23), [uses(51, inherits_requirement(c2, stabilityReq)), uses(59, considers(c2, leadCompensator)), uses(61, compatible_with(leadCompensator, stabilityReq))]).
substitution(67, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(67, preserves(c2, trackingReq), rule(23), [uses(52, inherits_requirement(c2, trackingReq)), uses(59, considers(c2, leadCompensator)), uses(62, compatible_with(leadCompensator, trackingReq))]).
substitution(68, [binding("ctrl", c2), binding("req", overshootReq), binding("strategy", leadCompensator)]).
proof(68, satisfies(c2, overshootReq), rule(25), [uses(60, targets(c2, overshootReq)), uses(59, considers(c2, leadCompensator)), uses(63, enables(leadCompensator, overshootReq))]).
substitution(69, [binding("ctrl", c2), binding("req", stabilityReq)]).
proof(69, satisfies(c2, stabilityReq), rule(27), [uses(64, preserves(c2, stabilityReq))]).
substitution(70, [binding("ctrl", c2), binding("req", trackingReq)]).
proof(70, satisfies(c2, trackingReq), rule(27), [uses(65, preserves(c2, trackingReq))]).
substitution(71, [binding("c", c2), binding("r", stabilityReq)]).
proof(71, solution([c2, stabilityReq]), query, [uses(66, preserves(c2, stabilityReq))]).
substitution(72, [binding("c", c2), binding("r", trackingReq)]).
proof(72, solution([c2, trackingReq]), query, [uses(67, preserves(c2, trackingReq))]).
substitution(73, [binding("later", c3), binding("req", overshootReq), binding("earlier", c2)]).
proof(73, inherits_requirement(c3, overshootReq), rule(20), [uses(48, derives_from(c3, c2)), uses(68, satisfies(c2, overshootReq))]).
substitution(74, [binding("later", c3), binding("req", stabilityReq), binding("earlier", c2)]).
proof(74, inherits_requirement(c3, stabilityReq), rule(20), [uses(48, derives_from(c3, c2)), uses(69, satisfies(c2, stabilityReq))]).
substitution(75, [binding("later", c3), binding("req", trackingReq), binding("earlier", c2)]).
proof(75, inherits_requirement(c3, trackingReq), rule(20), [uses(48, derives_from(c3, c2)), uses(70, satisfies(c2, trackingReq))]).
substitution(76, []).
proof(76, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(77, []).
proof(77, suggests(rejectDisturbance, integralAction), rule(3), []).
substitution(78, [binding("ctrl", c3), binding("strategy", integralAction), binding("goal", rejectDisturbance)]).
proof(78, considers(c3, integralAction), rule(21), [uses(76, design_goal(c3, rejectDisturbance)), uses(77, suggests(rejectDisturbance, integralAction))]).
substitution(79, []).
proof(79, compatible_with(integralAction, overshootReq), rule(10), []).
substitution(80, []).
proof(80, compatible_with(integralAction, stabilityReq), rule(8), []).
substitution(81, []).
proof(81, compatible_with(integralAction, trackingReq), rule(9), []).
substitution(82, [binding("ctrl", c3), binding("req", overshootReq), binding("strategy", integralAction)]).
proof(82, preserves(c3, overshootReq), rule(23), [uses(73, inherits_requirement(c3, overshootReq)), uses(78, considers(c3, integralAction)), uses(79, compatible_with(integralAction, overshootReq))]).
substitution(83, [binding("ctrl", c3), binding("req", stabilityReq), binding("strategy", integralAction)]).
proof(83, preserves(c3, stabilityReq), rule(23), [uses(74, inherits_requirement(c3, stabilityReq)), uses(78, considers(c3, integralAction)), uses(80, compatible_with(integralAction, stabilityReq))]).
substitution(84, [binding("ctrl", c3), binding("req", trackingReq), binding("strategy", integralAction)]).
proof(84, preserves(c3, trackingReq), rule(23), [uses(75, inherits_requirement(c3, trackingReq)), uses(78, considers(c3, integralAction)), uses(81, compatible_with(integralAction, trackingReq))]).
substitution(85, [binding("c", c3), binding("r", overshootReq)]).
proof(85, solution([c3, overshootReq]), query, [uses(82, preserves(c3, overshootReq))]).
substitution(86, [binding("c", c3), binding("r", stabilityReq)]).
proof(86, solution([c3, stabilityReq]), query, [uses(83, preserves(c3, stabilityReq))]).
substitution(87, [binding("c", c3), binding("r", trackingReq)]).
proof(87, solution([c3, trackingReq]), query, [uses(84, preserves(c3, trackingReq))]).
substitution(88, []).
proof(88, derives_from(c2, c1), rule(16), []).
substitution(89, []).
proof(89, derives_from(c3, c2), rule(18), []).
substitution(90, []).
proof(90, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(91, []).
proof(91, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(92, []).
proof(92, satisfies(c1, stabilityReq), rule(12), []).
substitution(93, []).
proof(93, satisfies(c1, trackingReq), rule(13), []).
substitution(94, []).
proof(94, introduces_requirement(reduceOvershoot, overshootReq), rule(2), []).
substitution(95, []).
proof(95, introduces_requirement(rejectDisturbance, disturbanceRejectionReq), rule(4), []).
substitution(96, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(96, inherits_requirement(c2, stabilityReq), rule(20), [uses(88, derives_from(c2, c1)), uses(92, satisfies(c1, stabilityReq))]).
substitution(97, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(97, inherits_requirement(c2, trackingReq), rule(20), [uses(88, derives_from(c2, c1)), uses(93, satisfies(c1, trackingReq))]).
substitution(98, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(98, targets(c2, overshootReq), rule(22), [uses(90, design_goal(c2, reduceOvershoot)), uses(94, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(99, [binding("ctrl", c3), binding("req", disturbanceRejectionReq), binding("goal", rejectDisturbance)]).
proof(99, targets(c3, disturbanceRejectionReq), rule(22), [uses(91, design_goal(c3, rejectDisturbance)), uses(95, introduces_requirement(rejectDisturbance, disturbanceRejectionReq))]).
substitution(100, []).
proof(100, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(101, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(101, targets(c2, overshootReq), rule(22), [uses(100, design_goal(c2, reduceOvershoot)), uses(94, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(102, []).
proof(102, derives_from(c2, c1), rule(16), []).
substitution(103, []).
proof(103, suggests(reduceOvershoot, leadCompensator), rule(1), []).
substitution(104, []).
proof(104, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(105, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(105, inherits_requirement(c2, stabilityReq), rule(20), [uses(102, derives_from(c2, c1)), uses(92, satisfies(c1, stabilityReq))]).
substitution(106, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(106, inherits_requirement(c2, trackingReq), rule(20), [uses(102, derives_from(c2, c1)), uses(93, satisfies(c1, trackingReq))]).
substitution(107, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("goal", reduceOvershoot)]).
proof(107, considers(c2, leadCompensator), rule(21), [uses(100, design_goal(c2, reduceOvershoot)), uses(103, suggests(reduceOvershoot, leadCompensator))]).
substitution(108, []).
proof(108, suggests(rejectDisturbance, integralAction), rule(3), []).
substitution(109, []).
proof(109, compatible_with(leadCompensator, stabilityReq), rule(5), []).
substitution(110, []).
proof(110, compatible_with(leadCompensator, trackingReq), rule(6), []).
substitution(111, []).
proof(111, enables(leadCompensator, overshootReq), rule(7), []).
substitution(112, [binding("ctrl", c3), binding("strategy", integralAction), binding("goal", rejectDisturbance)]).
proof(112, considers(c3, integralAction), rule(21), [uses(104, design_goal(c3, rejectDisturbance)), uses(108, suggests(rejectDisturbance, integralAction))]).
substitution(113, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(113, preserves(c2, stabilityReq), rule(23), [uses(105, inherits_requirement(c2, stabilityReq)), uses(107, considers(c2, leadCompensator)), uses(109, compatible_with(leadCompensator, stabilityReq))]).
substitution(114, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(114, preserves(c2, trackingReq), rule(23), [uses(106, inherits_requirement(c2, trackingReq)), uses(107, considers(c2, leadCompensator)), uses(110, compatible_with(leadCompensator, trackingReq))]).
substitution(115, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("req", stabilityReq)]).
proof(115, integrates(c2, leadCompensator), rule(24), [uses(96, inherits_requirement(c2, stabilityReq)), uses(107, considers(c2, leadCompensator)), uses(109, compatible_with(leadCompensator, stabilityReq))]).
substitution(116, [binding("ctrl", c2), binding("req", overshootReq), binding("strategy", leadCompensator)]).
proof(116, satisfies(c2, overshootReq), rule(25), [uses(101, targets(c2, overshootReq)), uses(107, considers(c2, leadCompensator)), uses(111, enables(leadCompensator, overshootReq))]).
substitution(117, [binding("ctrl", c2), binding("req", stabilityReq)]).
proof(117, satisfies(c2, stabilityReq), rule(27), [uses(113, preserves(c2, stabilityReq))]).
substitution(118, [binding("ctrl", c2), binding("req", trackingReq)]).
proof(118, satisfies(c2, trackingReq), rule(27), [uses(114, preserves(c2, trackingReq))]).
substitution(119, [binding("c", c2), binding("s", leadCompensator)]).
proof(119, solution([c2, leadCompensator]), query, [uses(115, integrates(c2, leadCompensator))]).
substitution(120, []).
proof(120, enables(integralAction, disturbanceRejectionReq), rule(11), []).
substitution(121, [binding("later", c3), binding("req", overshootReq), binding("earlier", c2)]).
proof(121, inherits_requirement(c3, overshootReq), rule(20), [uses(89, derives_from(c3, c2)), uses(116, satisfies(c2, overshootReq))]).
substitution(122, [binding("later", c3), binding("req", stabilityReq), binding("earlier", c2)]).
proof(122, inherits_requirement(c3, stabilityReq), rule(20), [uses(89, derives_from(c3, c2)), uses(117, satisfies(c2, stabilityReq))]).
substitution(123, [binding("later", c3), binding("req", trackingReq), binding("earlier", c2)]).
proof(123, inherits_requirement(c3, trackingReq), rule(20), [uses(89, derives_from(c3, c2)), uses(118, satisfies(c2, trackingReq))]).
substitution(124, [binding("ctrl", c3), binding("strategy", integralAction), binding("req", disturbanceRejectionReq)]).
proof(124, integrates(c3, integralAction), rule(26), [uses(99, targets(c3, disturbanceRejectionReq)), uses(112, considers(c3, integralAction)), uses(120, enables(integralAction, disturbanceRejectionReq))]).
substitution(125, []).
proof(125, compatible_with(integralAction, overshootReq), rule(10), []).
substitution(126, []).
proof(126, compatible_with(integralAction, stabilityReq), rule(8), []).
substitution(127, []).
proof(127, compatible_with(integralAction, trackingReq), rule(9), []).
substitution(128, [binding("c", c3), binding("s", integralAction)]).
proof(128, solution([c3, integralAction]), query, [uses(124, integrates(c3, integralAction))]).
substitution(129, []).
proof(129, satisfies(c1, stabilityReq), rule(12), []).
substitution(130, []).
proof(130, satisfies(c1, trackingReq), rule(13), []).
substitution(131, [binding("c", c1), binding("r", stabilityReq)]).
proof(131, solution([c1, stabilityReq]), query, [uses(129, satisfies(c1, stabilityReq))]).
substitution(132, [binding("c", c1), binding("r", trackingReq)]).
proof(132, solution([c1, trackingReq]), query, [uses(130, satisfies(c1, trackingReq))]).
substitution(133, []).
proof(133, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(134, []).
proof(134, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(135, []).
proof(135, derives_from(c2, c1), rule(16), []).
substitution(136, []).
proof(136, derives_from(c3, c2), rule(18), []).
substitution(137, []).
proof(137, introduces_requirement(reduceOvershoot, overshootReq), rule(2), []).
substitution(138, []).
proof(138, introduces_requirement(rejectDisturbance, disturbanceRejectionReq), rule(4), []).
substitution(139, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(139, targets(c2, overshootReq), rule(22), [uses(133, design_goal(c2, reduceOvershoot)), uses(137, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(140, [binding("ctrl", c3), binding("req", disturbanceRejectionReq), binding("goal", rejectDisturbance)]).
proof(140, targets(c3, disturbanceRejectionReq), rule(22), [uses(134, design_goal(c3, rejectDisturbance)), uses(138, introduces_requirement(rejectDisturbance, disturbanceRejectionReq))]).
substitution(141, []).
proof(141, satisfies(c1, stabilityReq), rule(12), []).
substitution(142, []).
proof(142, satisfies(c1, trackingReq), rule(13), []).
substitution(143, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(143, inherits_requirement(c2, stabilityReq), rule(20), [uses(135, derives_from(c2, c1)), uses(141, satisfies(c1, stabilityReq))]).
substitution(144, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(144, inherits_requirement(c2, trackingReq), rule(20), [uses(135, derives_from(c2, c1)), uses(142, satisfies(c1, trackingReq))]).
substitution(145, []).
proof(145, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(146, []).
proof(146, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(147, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(147, targets(c2, overshootReq), rule(22), [uses(145, design_goal(c2, reduceOvershoot)), uses(137, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(148, []).
proof(148, derives_from(c2, c1), rule(16), []).
substitution(149, []).
proof(149, suggests(reduceOvershoot, leadCompensator), rule(1), []).
substitution(150, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(150, inherits_requirement(c2, stabilityReq), rule(20), [uses(148, derives_from(c2, c1)), uses(141, satisfies(c1, stabilityReq))]).
substitution(151, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(151, inherits_requirement(c2, trackingReq), rule(20), [uses(148, derives_from(c2, c1)), uses(142, satisfies(c1, trackingReq))]).
substitution(152, []).
proof(152, suggests(rejectDisturbance, integralAction), rule(3), []).
substitution(153, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("goal", reduceOvershoot)]).
proof(153, considers(c2, leadCompensator), rule(21), [uses(145, design_goal(c2, reduceOvershoot)), uses(149, suggests(reduceOvershoot, leadCompensator))]).
substitution(154, [binding("ctrl", c3), binding("strategy", integralAction), binding("goal", rejectDisturbance)]).
proof(154, considers(c3, integralAction), rule(21), [uses(146, design_goal(c3, rejectDisturbance)), uses(152, suggests(rejectDisturbance, integralAction))]).
substitution(155, []).
proof(155, compatible_with(leadCompensator, stabilityReq), rule(5), []).
substitution(156, []).
proof(156, compatible_with(leadCompensator, trackingReq), rule(6), []).
substitution(157, []).
proof(157, enables(leadCompensator, overshootReq), rule(7), []).
substitution(158, []).
proof(158, enables(integralAction, disturbanceRejectionReq), rule(11), []).
substitution(159, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(159, preserves(c2, stabilityReq), rule(23), [uses(150, inherits_requirement(c2, stabilityReq)), uses(153, considers(c2, leadCompensator)), uses(155, compatible_with(leadCompensator, stabilityReq))]).
substitution(160, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(160, preserves(c2, trackingReq), rule(23), [uses(151, inherits_requirement(c2, trackingReq)), uses(153, considers(c2, leadCompensator)), uses(156, compatible_with(leadCompensator, trackingReq))]).
substitution(161, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(161, preserves(c2, stabilityReq), rule(23), [uses(143, inherits_requirement(c2, stabilityReq)), uses(153, considers(c2, leadCompensator)), uses(155, compatible_with(leadCompensator, stabilityReq))]).
substitution(162, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(162, preserves(c2, trackingReq), rule(23), [uses(144, inherits_requirement(c2, trackingReq)), uses(153, considers(c2, leadCompensator)), uses(156, compatible_with(leadCompensator, trackingReq))]).
substitution(163, [binding("ctrl", c2), binding("req", overshootReq), binding("strategy", leadCompensator)]).
proof(163, satisfies(c2, overshootReq), rule(25), [uses(139, targets(c2, overshootReq)), uses(153, considers(c2, leadCompensator)), uses(157, enables(leadCompensator, overshootReq))]).
substitution(164, [binding("ctrl", c3), binding("req", disturbanceRejectionReq), binding("strategy", integralAction)]).
proof(164, satisfies(c3, disturbanceRejectionReq), rule(25), [uses(140, targets(c3, disturbanceRejectionReq)), uses(154, considers(c3, integralAction)), uses(158, enables(integralAction, disturbanceRejectionReq))]).
substitution(165, [binding("ctrl", c2), binding("req", stabilityReq)]).
proof(165, satisfies(c2, stabilityReq), rule(27), [uses(161, preserves(c2, stabilityReq))]).
substitution(166, [binding("ctrl", c2), binding("req", trackingReq)]).
proof(166, satisfies(c2, trackingReq), rule(27), [uses(162, preserves(c2, trackingReq))]).
substitution(167, [binding("ctrl", c2), binding("req", overshootReq), binding("strategy", leadCompensator)]).
proof(167, satisfies(c2, overshootReq), rule(25), [uses(147, targets(c2, overshootReq)), uses(153, considers(c2, leadCompensator)), uses(157, enables(leadCompensator, overshootReq))]).
substitution(168, [binding("ctrl", c2), binding("req", stabilityReq)]).
proof(168, satisfies(c2, stabilityReq), rule(27), [uses(159, preserves(c2, stabilityReq))]).
substitution(169, [binding("ctrl", c2), binding("req", trackingReq)]).
proof(169, satisfies(c2, trackingReq), rule(27), [uses(160, preserves(c2, trackingReq))]).
substitution(170, [binding("c", c2), binding("r", overshootReq)]).
proof(170, solution([c2, overshootReq]), query, [uses(163, satisfies(c2, overshootReq))]).
substitution(171, [binding("c", c3), binding("r", disturbanceRejectionReq)]).
proof(171, solution([c3, disturbanceRejectionReq]), query, [uses(164, satisfies(c3, disturbanceRejectionReq))]).
substitution(172, [binding("c", c2), binding("r", stabilityReq)]).
proof(172, solution([c2, stabilityReq]), query, [uses(165, satisfies(c2, stabilityReq))]).
substitution(173, [binding("c", c2), binding("r", trackingReq)]).
proof(173, solution([c2, trackingReq]), query, [uses(166, satisfies(c2, trackingReq))]).
substitution(174, [binding("later", c3), binding("req", overshootReq), binding("earlier", c2)]).
proof(174, inherits_requirement(c3, overshootReq), rule(20), [uses(136, derives_from(c3, c2)), uses(167, satisfies(c2, overshootReq))]).
substitution(175, [binding("later", c3), binding("req", stabilityReq), binding("earlier", c2)]).
proof(175, inherits_requirement(c3, stabilityReq), rule(20), [uses(136, derives_from(c3, c2)), uses(168, satisfies(c2, stabilityReq))]).
substitution(176, [binding("later", c3), binding("req", trackingReq), binding("earlier", c2)]).
proof(176, inherits_requirement(c3, trackingReq), rule(20), [uses(136, derives_from(c3, c2)), uses(169, satisfies(c2, trackingReq))]).
substitution(177, []).
proof(177, compatible_with(integralAction, overshootReq), rule(10), []).
substitution(178, []).
proof(178, compatible_with(integralAction, stabilityReq), rule(8), []).
substitution(179, []).
proof(179, compatible_with(integralAction, trackingReq), rule(9), []).
substitution(180, [binding("ctrl", c3), binding("req", overshootReq), binding("strategy", integralAction)]).
proof(180, preserves(c3, overshootReq), rule(23), [uses(174, inherits_requirement(c3, overshootReq)), uses(154, considers(c3, integralAction)), uses(177, compatible_with(integralAction, overshootReq))]).
substitution(181, [binding("ctrl", c3), binding("req", stabilityReq), binding("strategy", integralAction)]).
proof(181, preserves(c3, stabilityReq), rule(23), [uses(175, inherits_requirement(c3, stabilityReq)), uses(154, considers(c3, integralAction)), uses(178, compatible_with(integralAction, stabilityReq))]).
substitution(182, [binding("ctrl", c3), binding("req", trackingReq), binding("strategy", integralAction)]).
proof(182, preserves(c3, trackingReq), rule(23), [uses(176, inherits_requirement(c3, trackingReq)), uses(154, considers(c3, integralAction)), uses(179, compatible_with(integralAction, trackingReq))]).
substitution(183, [binding("ctrl", c3), binding("req", overshootReq)]).
proof(183, satisfies(c3, overshootReq), rule(27), [uses(180, preserves(c3, overshootReq))]).
substitution(184, [binding("ctrl", c3), binding("req", stabilityReq)]).
proof(184, satisfies(c3, stabilityReq), rule(27), [uses(181, preserves(c3, stabilityReq))]).
substitution(185, [binding("ctrl", c3), binding("req", trackingReq)]).
proof(185, satisfies(c3, trackingReq), rule(27), [uses(182, preserves(c3, trackingReq))]).
substitution(186, [binding("c", c3), binding("r", overshootReq)]).
proof(186, solution([c3, overshootReq]), query, [uses(183, satisfies(c3, overshootReq))]).
substitution(187, [binding("c", c3), binding("r", stabilityReq)]).
proof(187, solution([c3, stabilityReq]), query, [uses(184, satisfies(c3, stabilityReq))]).
substitution(188, [binding("c", c3), binding("r", trackingReq)]).
proof(188, solution([c3, trackingReq]), query, [uses(185, satisfies(c3, trackingReq))]).
substitution(189, []).
proof(189, realizes(c1, baselinePID), rule(14), []).
substitution(190, [binding("c", c1), binding("s", baselinePID)]).
proof(190, solution([c1, baselinePID]), query, [uses(189, realizes(c1, baselinePID))]).
substitution(191, []).
proof(191, derives_from(c2, c1), rule(16), []).
substitution(192, []).
proof(192, derives_from(c3, c2), rule(18), []).
substitution(193, []).
proof(193, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(194, []).
proof(194, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(195, []).
proof(195, satisfies(c1, stabilityReq), rule(12), []).
substitution(196, []).
proof(196, satisfies(c1, trackingReq), rule(13), []).
substitution(197, []).
proof(197, introduces_requirement(reduceOvershoot, overshootReq), rule(2), []).
substitution(198, []).
proof(198, introduces_requirement(rejectDisturbance, disturbanceRejectionReq), rule(4), []).
substitution(199, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(199, inherits_requirement(c2, stabilityReq), rule(20), [uses(191, derives_from(c2, c1)), uses(195, satisfies(c1, stabilityReq))]).
substitution(200, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(200, inherits_requirement(c2, trackingReq), rule(20), [uses(191, derives_from(c2, c1)), uses(196, satisfies(c1, trackingReq))]).
substitution(201, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(201, targets(c2, overshootReq), rule(22), [uses(193, design_goal(c2, reduceOvershoot)), uses(197, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(202, [binding("ctrl", c3), binding("req", disturbanceRejectionReq), binding("goal", rejectDisturbance)]).
proof(202, targets(c3, disturbanceRejectionReq), rule(22), [uses(194, design_goal(c3, rejectDisturbance)), uses(198, introduces_requirement(rejectDisturbance, disturbanceRejectionReq))]).
substitution(203, []).
proof(203, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(204, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(204, targets(c2, overshootReq), rule(22), [uses(203, design_goal(c2, reduceOvershoot)), uses(197, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(205, []).
proof(205, derives_from(c2, c1), rule(16), []).
substitution(206, []).
proof(206, suggests(reduceOvershoot, leadCompensator), rule(1), []).
substitution(207, []).
proof(207, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(208, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(208, inherits_requirement(c2, stabilityReq), rule(20), [uses(205, derives_from(c2, c1)), uses(195, satisfies(c1, stabilityReq))]).
substitution(209, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(209, inherits_requirement(c2, trackingReq), rule(20), [uses(205, derives_from(c2, c1)), uses(196, satisfies(c1, trackingReq))]).
substitution(210, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("goal", reduceOvershoot)]).
proof(210, considers(c2, leadCompensator), rule(21), [uses(203, design_goal(c2, reduceOvershoot)), uses(206, suggests(reduceOvershoot, leadCompensator))]).
substitution(211, []).
proof(211, suggests(rejectDisturbance, integralAction), rule(3), []).
substitution(212, []).
proof(212, compatible_with(leadCompensator, stabilityReq), rule(5), []).
substitution(213, []).
proof(213, compatible_with(leadCompensator, trackingReq), rule(6), []).
substitution(214, []).
proof(214, enables(leadCompensator, overshootReq), rule(7), []).
substitution(215, [binding("ctrl", c3), binding("strategy", integralAction), binding("goal", rejectDisturbance)]).
proof(215, considers(c3, integralAction), rule(21), [uses(207, design_goal(c3, rejectDisturbance)), uses(211, suggests(rejectDisturbance, integralAction))]).
substitution(216, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(216, preserves(c2, stabilityReq), rule(23), [uses(208, inherits_requirement(c2, stabilityReq)), uses(210, considers(c2, leadCompensator)), uses(212, compatible_with(leadCompensator, stabilityReq))]).
substitution(217, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(217, preserves(c2, trackingReq), rule(23), [uses(209, inherits_requirement(c2, trackingReq)), uses(210, considers(c2, leadCompensator)), uses(213, compatible_with(leadCompensator, trackingReq))]).
substitution(218, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("req", stabilityReq)]).
proof(218, integrates(c2, leadCompensator), rule(24), [uses(199, inherits_requirement(c2, stabilityReq)), uses(210, considers(c2, leadCompensator)), uses(212, compatible_with(leadCompensator, stabilityReq))]).
substitution(219, [binding("ctrl", c2), binding("req", overshootReq), binding("strategy", leadCompensator)]).
proof(219, satisfies(c2, overshootReq), rule(25), [uses(204, targets(c2, overshootReq)), uses(210, considers(c2, leadCompensator)), uses(214, enables(leadCompensator, overshootReq))]).
substitution(220, [binding("ctrl", c2), binding("req", stabilityReq)]).
proof(220, satisfies(c2, stabilityReq), rule(27), [uses(216, preserves(c2, stabilityReq))]).
substitution(221, [binding("ctrl", c2), binding("req", trackingReq)]).
proof(221, satisfies(c2, trackingReq), rule(27), [uses(217, preserves(c2, trackingReq))]).
substitution(222, [binding("ctrl", c2), binding("strategy", leadCompensator)]).
proof(222, realizes(c2, leadCompensator), rule(28), [uses(218, integrates(c2, leadCompensator))]).
substitution(223, []).
proof(223, enables(integralAction, disturbanceRejectionReq), rule(11), []).
substitution(224, [binding("later", c3), binding("req", overshootReq), binding("earlier", c2)]).
proof(224, inherits_requirement(c3, overshootReq), rule(20), [uses(192, derives_from(c3, c2)), uses(219, satisfies(c2, overshootReq))]).
substitution(225, [binding("later", c3), binding("req", stabilityReq), binding("earlier", c2)]).
proof(225, inherits_requirement(c3, stabilityReq), rule(20), [uses(192, derives_from(c3, c2)), uses(220, satisfies(c2, stabilityReq))]).
substitution(226, [binding("later", c3), binding("req", trackingReq), binding("earlier", c2)]).
proof(226, inherits_requirement(c3, trackingReq), rule(20), [uses(192, derives_from(c3, c2)), uses(221, satisfies(c2, trackingReq))]).
substitution(227, [binding("c", c2), binding("s", leadCompensator)]).
proof(227, solution([c2, leadCompensator]), query, [uses(222, realizes(c2, leadCompensator))]).
substitution(228, [binding("ctrl", c3), binding("strategy", integralAction), binding("req", disturbanceRejectionReq)]).
proof(228, integrates(c3, integralAction), rule(26), [uses(202, targets(c3, disturbanceRejectionReq)), uses(215, considers(c3, integralAction)), uses(223, enables(integralAction, disturbanceRejectionReq))]).
substitution(229, []).
proof(229, compatible_with(integralAction, overshootReq), rule(10), []).
substitution(230, []).
proof(230, compatible_with(integralAction, stabilityReq), rule(8), []).
substitution(231, []).
proof(231, compatible_with(integralAction, trackingReq), rule(9), []).
substitution(232, [binding("ctrl", c3), binding("strategy", integralAction)]).
proof(232, realizes(c3, integralAction), rule(28), [uses(228, integrates(c3, integralAction))]).
substitution(233, [binding("c", c3), binding("s", integralAction)]).
proof(233, solution([c3, integralAction]), query, [uses(232, realizes(c3, integralAction))]).
substitution(234, []).
proof(234, achieves(c1, approvedController), rule(15), []).
substitution(235, [binding("ctrl", c1)]).
proof(235, status(c1, approvedController), rule(31), [uses(234, achieves(c1, approvedController))]).
substitution(236, []).
proof(236, realizes(c1, baselinePID), rule(14), []).
substitution(237, [binding("c", c1), binding("s", approvedController)]).
proof(237, solution([c1, approvedController]), query, [uses(235, status(c1, approvedController))]).
substitution(238, []).
proof(238, derives_from(c2, c1), rule(16), []).
substitution(239, []).
proof(239, derives_from(c3, c2), rule(18), []).
substitution(240, []).
proof(240, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(241, []).
proof(241, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(242, []).
proof(242, satisfies(c1, stabilityReq), rule(12), []).
substitution(243, []).
proof(243, satisfies(c1, trackingReq), rule(13), []).
substitution(244, []).
proof(244, introduces_requirement(reduceOvershoot, overshootReq), rule(2), []).
substitution(245, []).
proof(245, introduces_requirement(rejectDisturbance, disturbanceRejectionReq), rule(4), []).
substitution(246, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(246, inherits_requirement(c2, stabilityReq), rule(20), [uses(238, derives_from(c2, c1)), uses(242, satisfies(c1, stabilityReq))]).
substitution(247, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(247, inherits_requirement(c2, trackingReq), rule(20), [uses(238, derives_from(c2, c1)), uses(243, satisfies(c1, trackingReq))]).
substitution(248, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(248, targets(c2, overshootReq), rule(22), [uses(240, design_goal(c2, reduceOvershoot)), uses(244, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(249, [binding("ctrl", c3), binding("req", disturbanceRejectionReq), binding("goal", rejectDisturbance)]).
proof(249, targets(c3, disturbanceRejectionReq), rule(22), [uses(241, design_goal(c3, rejectDisturbance)), uses(245, introduces_requirement(rejectDisturbance, disturbanceRejectionReq))]).
substitution(250, []).
proof(250, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(251, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(251, targets(c2, overshootReq), rule(22), [uses(250, design_goal(c2, reduceOvershoot)), uses(244, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(252, []).
proof(252, derives_from(c2, c1), rule(16), []).
substitution(253, []).
proof(253, suggests(reduceOvershoot, leadCompensator), rule(1), []).
substitution(254, []).
proof(254, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(255, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(255, inherits_requirement(c2, stabilityReq), rule(20), [uses(252, derives_from(c2, c1)), uses(242, satisfies(c1, stabilityReq))]).
substitution(256, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(256, inherits_requirement(c2, trackingReq), rule(20), [uses(252, derives_from(c2, c1)), uses(243, satisfies(c1, trackingReq))]).
substitution(257, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("goal", reduceOvershoot)]).
proof(257, considers(c2, leadCompensator), rule(21), [uses(250, design_goal(c2, reduceOvershoot)), uses(253, suggests(reduceOvershoot, leadCompensator))]).
substitution(258, []).
proof(258, suggests(rejectDisturbance, integralAction), rule(3), []).
substitution(259, []).
proof(259, compatible_with(leadCompensator, stabilityReq), rule(5), []).
substitution(260, []).
proof(260, compatible_with(leadCompensator, trackingReq), rule(6), []).
substitution(261, []).
proof(261, enables(leadCompensator, overshootReq), rule(7), []).
substitution(262, [binding("ctrl", c3), binding("strategy", integralAction), binding("goal", rejectDisturbance)]).
proof(262, considers(c3, integralAction), rule(21), [uses(254, design_goal(c3, rejectDisturbance)), uses(258, suggests(rejectDisturbance, integralAction))]).
substitution(263, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(263, preserves(c2, stabilityReq), rule(23), [uses(255, inherits_requirement(c2, stabilityReq)), uses(257, considers(c2, leadCompensator)), uses(259, compatible_with(leadCompensator, stabilityReq))]).
substitution(264, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(264, preserves(c2, trackingReq), rule(23), [uses(256, inherits_requirement(c2, trackingReq)), uses(257, considers(c2, leadCompensator)), uses(260, compatible_with(leadCompensator, trackingReq))]).
substitution(265, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("req", stabilityReq)]).
proof(265, integrates(c2, leadCompensator), rule(24), [uses(246, inherits_requirement(c2, stabilityReq)), uses(257, considers(c2, leadCompensator)), uses(259, compatible_with(leadCompensator, stabilityReq))]).
substitution(266, [binding("ctrl", c2), binding("req", overshootReq), binding("strategy", leadCompensator)]).
proof(266, satisfies(c2, overshootReq), rule(25), [uses(251, targets(c2, overshootReq)), uses(257, considers(c2, leadCompensator)), uses(261, enables(leadCompensator, overshootReq))]).
substitution(267, [binding("ctrl", c2), binding("req", stabilityReq)]).
proof(267, satisfies(c2, stabilityReq), rule(27), [uses(263, preserves(c2, stabilityReq))]).
substitution(268, [binding("ctrl", c2), binding("req", trackingReq)]).
proof(268, satisfies(c2, trackingReq), rule(27), [uses(264, preserves(c2, trackingReq))]).
substitution(269, [binding("ctrl", c2), binding("strategy", leadCompensator)]).
proof(269, realizes(c2, leadCompensator), rule(28), [uses(265, integrates(c2, leadCompensator))]).
substitution(270, []).
proof(270, enables(integralAction, disturbanceRejectionReq), rule(11), []).
substitution(271, [binding("later", c3), binding("req", overshootReq), binding("earlier", c2)]).
proof(271, inherits_requirement(c3, overshootReq), rule(20), [uses(239, derives_from(c3, c2)), uses(266, satisfies(c2, overshootReq))]).
substitution(272, [binding("later", c3), binding("req", stabilityReq), binding("earlier", c2)]).
proof(272, inherits_requirement(c3, stabilityReq), rule(20), [uses(239, derives_from(c3, c2)), uses(267, satisfies(c2, stabilityReq))]).
substitution(273, [binding("later", c3), binding("req", trackingReq), binding("earlier", c2)]).
proof(273, inherits_requirement(c3, trackingReq), rule(20), [uses(239, derives_from(c3, c2)), uses(268, satisfies(c2, trackingReq))]).
substitution(274, [binding("ctrl", c2), binding("strategy", leadCompensator)]).
proof(274, achieves(c2, approvedController), rule(29), [uses(269, realizes(c2, leadCompensator))]).
substitution(275, [binding("ctrl", c3), binding("strategy", integralAction), binding("req", disturbanceRejectionReq)]).
proof(275, integrates(c3, integralAction), rule(26), [uses(249, targets(c3, disturbanceRejectionReq)), uses(262, considers(c3, integralAction)), uses(270, enables(integralAction, disturbanceRejectionReq))]).
substitution(276, [binding("ctrl", c2)]).
proof(276, status(c2, approvedController), rule(31), [uses(274, achieves(c2, approvedController))]).
substitution(277, []).
proof(277, compatible_with(integralAction, overshootReq), rule(10), []).
substitution(278, []).
proof(278, compatible_with(integralAction, stabilityReq), rule(8), []).
substitution(279, []).
proof(279, compatible_with(integralAction, trackingReq), rule(9), []).
substitution(280, [binding("ctrl", c3), binding("strategy", integralAction)]).
proof(280, realizes(c3, integralAction), rule(28), [uses(275, integrates(c3, integralAction))]).
substitution(281, [binding("c", c2), binding("s", approvedController)]).
proof(281, solution([c2, approvedController]), query, [uses(276, status(c2, approvedController))]).
substitution(282, [binding("ctrl", c3), binding("strategy", integralAction)]).
proof(282, achieves(c3, approvedController), rule(29), [uses(280, realizes(c3, integralAction))]).
substitution(283, [binding("ctrl", c3)]).
proof(283, status(c3, approvedController), rule(31), [uses(282, achieves(c3, approvedController))]).
substitution(284, [binding("c", c3), binding("s", approvedController)]).
proof(284, solution([c3, approvedController]), query, [uses(283, status(c3, approvedController))]).
substitution(285, []).
proof(285, realizes(c1, baselinePID), rule(14), []).
substitution(286, [binding("ctrl", c1), binding("strategy", baselinePID)]).
proof(286, available_for_future_tuning(c1, yes), rule(30), [uses(285, realizes(c1, baselinePID))]).
substitution(287, [binding("c", c1), binding("y", yes)]).
proof(287, solution([c1, yes]), query, [uses(286, available_for_future_tuning(c1, yes))]).
substitution(288, []).
proof(288, derives_from(c2, c1), rule(16), []).
substitution(289, []).
proof(289, derives_from(c3, c2), rule(18), []).
substitution(290, []).
proof(290, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(291, []).
proof(291, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(292, []).
proof(292, satisfies(c1, stabilityReq), rule(12), []).
substitution(293, []).
proof(293, satisfies(c1, trackingReq), rule(13), []).
substitution(294, []).
proof(294, introduces_requirement(reduceOvershoot, overshootReq), rule(2), []).
substitution(295, []).
proof(295, introduces_requirement(rejectDisturbance, disturbanceRejectionReq), rule(4), []).
substitution(296, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(296, inherits_requirement(c2, stabilityReq), rule(20), [uses(288, derives_from(c2, c1)), uses(292, satisfies(c1, stabilityReq))]).
substitution(297, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(297, inherits_requirement(c2, trackingReq), rule(20), [uses(288, derives_from(c2, c1)), uses(293, satisfies(c1, trackingReq))]).
substitution(298, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(298, targets(c2, overshootReq), rule(22), [uses(290, design_goal(c2, reduceOvershoot)), uses(294, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(299, [binding("ctrl", c3), binding("req", disturbanceRejectionReq), binding("goal", rejectDisturbance)]).
proof(299, targets(c3, disturbanceRejectionReq), rule(22), [uses(291, design_goal(c3, rejectDisturbance)), uses(295, introduces_requirement(rejectDisturbance, disturbanceRejectionReq))]).
substitution(300, []).
proof(300, design_goal(c2, reduceOvershoot), rule(17), []).
substitution(301, [binding("ctrl", c2), binding("req", overshootReq), binding("goal", reduceOvershoot)]).
proof(301, targets(c2, overshootReq), rule(22), [uses(300, design_goal(c2, reduceOvershoot)), uses(294, introduces_requirement(reduceOvershoot, overshootReq))]).
substitution(302, []).
proof(302, derives_from(c2, c1), rule(16), []).
substitution(303, []).
proof(303, suggests(reduceOvershoot, leadCompensator), rule(1), []).
substitution(304, []).
proof(304, design_goal(c3, rejectDisturbance), rule(19), []).
substitution(305, [binding("later", c2), binding("req", stabilityReq), binding("earlier", c1)]).
proof(305, inherits_requirement(c2, stabilityReq), rule(20), [uses(302, derives_from(c2, c1)), uses(292, satisfies(c1, stabilityReq))]).
substitution(306, [binding("later", c2), binding("req", trackingReq), binding("earlier", c1)]).
proof(306, inherits_requirement(c2, trackingReq), rule(20), [uses(302, derives_from(c2, c1)), uses(293, satisfies(c1, trackingReq))]).
substitution(307, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("goal", reduceOvershoot)]).
proof(307, considers(c2, leadCompensator), rule(21), [uses(300, design_goal(c2, reduceOvershoot)), uses(303, suggests(reduceOvershoot, leadCompensator))]).
substitution(308, []).
proof(308, suggests(rejectDisturbance, integralAction), rule(3), []).
substitution(309, []).
proof(309, compatible_with(leadCompensator, stabilityReq), rule(5), []).
substitution(310, []).
proof(310, compatible_with(leadCompensator, trackingReq), rule(6), []).
substitution(311, []).
proof(311, enables(leadCompensator, overshootReq), rule(7), []).
substitution(312, [binding("ctrl", c3), binding("strategy", integralAction), binding("goal", rejectDisturbance)]).
proof(312, considers(c3, integralAction), rule(21), [uses(304, design_goal(c3, rejectDisturbance)), uses(308, suggests(rejectDisturbance, integralAction))]).
substitution(313, [binding("ctrl", c2), binding("req", stabilityReq), binding("strategy", leadCompensator)]).
proof(313, preserves(c2, stabilityReq), rule(23), [uses(305, inherits_requirement(c2, stabilityReq)), uses(307, considers(c2, leadCompensator)), uses(309, compatible_with(leadCompensator, stabilityReq))]).
substitution(314, [binding("ctrl", c2), binding("req", trackingReq), binding("strategy", leadCompensator)]).
proof(314, preserves(c2, trackingReq), rule(23), [uses(306, inherits_requirement(c2, trackingReq)), uses(307, considers(c2, leadCompensator)), uses(310, compatible_with(leadCompensator, trackingReq))]).
substitution(315, [binding("ctrl", c2), binding("strategy", leadCompensator), binding("req", stabilityReq)]).
proof(315, integrates(c2, leadCompensator), rule(24), [uses(296, inherits_requirement(c2, stabilityReq)), uses(307, considers(c2, leadCompensator)), uses(309, compatible_with(leadCompensator, stabilityReq))]).
substitution(316, [binding("ctrl", c2), binding("req", overshootReq), binding("strategy", leadCompensator)]).
proof(316, satisfies(c2, overshootReq), rule(25), [uses(301, targets(c2, overshootReq)), uses(307, considers(c2, leadCompensator)), uses(311, enables(leadCompensator, overshootReq))]).
substitution(317, [binding("ctrl", c2), binding("req", stabilityReq)]).
proof(317, satisfies(c2, stabilityReq), rule(27), [uses(313, preserves(c2, stabilityReq))]).
substitution(318, [binding("ctrl", c2), binding("req", trackingReq)]).
proof(318, satisfies(c2, trackingReq), rule(27), [uses(314, preserves(c2, trackingReq))]).
substitution(319, [binding("ctrl", c2), binding("strategy", leadCompensator)]).
proof(319, realizes(c2, leadCompensator), rule(28), [uses(315, integrates(c2, leadCompensator))]).
substitution(320, []).
proof(320, enables(integralAction, disturbanceRejectionReq), rule(11), []).
substitution(321, [binding("later", c3), binding("req", overshootReq), binding("earlier", c2)]).
proof(321, inherits_requirement(c3, overshootReq), rule(20), [uses(289, derives_from(c3, c2)), uses(316, satisfies(c2, overshootReq))]).
substitution(322, [binding("later", c3), binding("req", stabilityReq), binding("earlier", c2)]).
proof(322, inherits_requirement(c3, stabilityReq), rule(20), [uses(289, derives_from(c3, c2)), uses(317, satisfies(c2, stabilityReq))]).
substitution(323, [binding("later", c3), binding("req", trackingReq), binding("earlier", c2)]).
proof(323, inherits_requirement(c3, trackingReq), rule(20), [uses(289, derives_from(c3, c2)), uses(318, satisfies(c2, trackingReq))]).
substitution(324, [binding("ctrl", c2), binding("strategy", leadCompensator)]).
proof(324, available_for_future_tuning(c2, yes), rule(30), [uses(319, realizes(c2, leadCompensator))]).
substitution(325, [binding("ctrl", c3), binding("strategy", integralAction), binding("req", disturbanceRejectionReq)]).
proof(325, integrates(c3, integralAction), rule(26), [uses(299, targets(c3, disturbanceRejectionReq)), uses(312, considers(c3, integralAction)), uses(320, enables(integralAction, disturbanceRejectionReq))]).
substitution(326, [binding("c", c2), binding("y", yes)]).
proof(326, solution([c2, yes]), query, [uses(324, available_for_future_tuning(c2, yes))]).
substitution(327, []).
proof(327, compatible_with(integralAction, overshootReq), rule(10), []).
substitution(328, []).
proof(328, compatible_with(integralAction, stabilityReq), rule(8), []).
substitution(329, []).
proof(329, compatible_with(integralAction, trackingReq), rule(9), []).
substitution(330, [binding("ctrl", c3), binding("strategy", integralAction)]).
proof(330, realizes(c3, integralAction), rule(28), [uses(325, integrates(c3, integralAction))]).
substitution(331, [binding("ctrl", c3), binding("strategy", integralAction)]).
proof(331, available_for_future_tuning(c3, yes), rule(30), [uses(330, realizes(c3, integralAction))]).
substitution(332, [binding("c", c3), binding("y", yes)]).
proof(332, solution([c3, yes]), query, [uses(331, available_for_future_tuning(c3, yes))]).
