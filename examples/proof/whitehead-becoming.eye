# Eyelang result format 2
query(1, [call(becomes_from(?v0, ?v1))], [binding("later", ?v0), binding("earlier", ?v1)]).
result(1, complete, 2).
answer(1, [binding("later", o2), binding("earlier", o1)]).
why(1, [binding("later", o2), binding("earlier", o1)], 5).
answer(1, [binding("later", o3), binding("earlier", o2)]).
why(1, [binding("later", o3), binding("earlier", o2)], 6).
query(2, [call(inherits(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(2, complete, 5).
answer(2, [binding("o", o2), binding("form", red)]).
why(2, [binding("o", o2), binding("form", red)], 13).
answer(2, [binding("o", o2), binding("form", warm)]).
why(2, [binding("o", o2), binding("form", warm)], 14).
answer(2, [binding("o", o3), binding("form", red)]).
why(2, [binding("o", o3), binding("form", red)], 31).
answer(2, [binding("o", o3), binding("form", warm)]).
why(2, [binding("o", o3), binding("form", warm)], 32).
answer(2, [binding("o", o3), binding("form", bright)]).
why(2, [binding("o", o3), binding("form", bright)], 33).
query(3, [call(may_realize(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(3, complete, 2).
answer(3, [binding("o", o2), binding("form", bright)]).
why(3, [binding("o", o2), binding("form", bright)], 40).
answer(3, [binding("o", o3), binding("form", dark)]).
why(3, [binding("o", o3), binding("form", dark)], 41).
query(4, [call(integrates(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(4, complete, 7).
answer(4, [binding("o", o2), binding("form", red)]).
why(4, [binding("o", o2), binding("form", red)], 60).
answer(4, [binding("o", o2), binding("form", warm)]).
why(4, [binding("o", o2), binding("form", warm)], 61).
answer(4, [binding("o", o2), binding("form", bright)]).
why(4, [binding("o", o2), binding("form", bright)], 62).
answer(4, [binding("o", o3), binding("form", red)]).
why(4, [binding("o", o3), binding("form", red)], 77).
answer(4, [binding("o", o3), binding("form", warm)]).
why(4, [binding("o", o3), binding("form", warm)], 78).
answer(4, [binding("o", o3), binding("form", bright)]).
why(4, [binding("o", o3), binding("form", bright)], 79).
answer(4, [binding("o", o3), binding("form", dark)]).
why(4, [binding("o", o3), binding("form", dark)], 80).
query(5, [call(realizes(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(5, complete, 9).
answer(5, [binding("o", o1), binding("form", red)]).
why(5, [binding("o", o1), binding("form", red)], 83).
answer(5, [binding("o", o1), binding("form", warm)]).
why(5, [binding("o", o1), binding("form", warm)], 84).
answer(5, [binding("o", o2), binding("form", red)]).
why(5, [binding("o", o2), binding("form", red)], 110).
answer(5, [binding("o", o2), binding("form", warm)]).
why(5, [binding("o", o2), binding("form", warm)], 111).
answer(5, [binding("o", o2), binding("form", bright)]).
why(5, [binding("o", o2), binding("form", bright)], 112).
answer(5, [binding("o", o3), binding("form", red)]).
why(5, [binding("o", o3), binding("form", red)], 132).
answer(5, [binding("o", o3), binding("form", warm)]).
why(5, [binding("o", o3), binding("form", warm)], 133).
answer(5, [binding("o", o3), binding("form", bright)]).
why(5, [binding("o", o3), binding("form", bright)], 134).
answer(5, [binding("o", o3), binding("form", dark)]).
why(5, [binding("o", o3), binding("form", dark)], 135).
query(6, [call(ingresses(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(6, complete, 9).
answer(6, [binding("o", o1), binding("form", red)]).
why(6, [binding("o", o1), binding("form", red)], 144).
answer(6, [binding("o", o1), binding("form", warm)]).
why(6, [binding("o", o1), binding("form", warm)], 145).
answer(6, [binding("o", o2), binding("form", red)]).
why(6, [binding("o", o2), binding("form", red)], 174).
answer(6, [binding("o", o2), binding("form", warm)]).
why(6, [binding("o", o2), binding("form", warm)], 175).
answer(6, [binding("o", o2), binding("form", bright)]).
why(6, [binding("o", o2), binding("form", bright)], 178).
answer(6, [binding("o", o3), binding("form", red)]).
why(6, [binding("o", o3), binding("form", red)], 198).
answer(6, [binding("o", o3), binding("form", warm)]).
why(6, [binding("o", o3), binding("form", warm)], 199).
answer(6, [binding("o", o3), binding("form", bright)]).
why(6, [binding("o", o3), binding("form", bright)], 200).
answer(6, [binding("o", o3), binding("form", dark)]).
why(6, [binding("o", o3), binding("form", dark)], 203).
query(7, [call(status(?v0, ?v1))], [binding("o", ?v0), binding("s", ?v1)]).
result(7, complete, 3).
answer(7, [binding("o", o1), binding("s", objectivelyAvailable)]).
why(7, [binding("o", o1), binding("s", objectivelyAvailable)], 206).
answer(7, [binding("o", o2), binding("s", objectivelyAvailable)]).
why(7, [binding("o", o2), binding("s", objectivelyAvailable)], 224).
answer(7, [binding("o", o3), binding("s", objectivelyAvailable)]).
why(7, [binding("o", o3), binding("s", objectivelyAvailable)], 237).
clause(1, pure_potential(red), []).
clause(2, pure_potential(warm), []).
clause(3, pure_potential(bright), []).
clause(4, pure_potential(dark), []).
clause(7, lures(intensity, bright), []).
clause(8, lures(contrast, dark), []).
clause(11, realizes(o1, red), []).
clause(12, realizes(o1, warm), []).
clause(13, achieves(o1, satisfaction), []).
clause(16, prehends(o2, o1), []).
clause(17, subjective_aim_of(o2, intensity), []).
clause(20, prehends(o3, o2), []).
clause(21, subjective_aim_of(o3, contrast), []).
clause(22, becomes_from(var("later"), var("earlier")), [call(prehends(var("later"), var("earlier")))]).
clause(23, inherits(var("later"), var("form")), [call(prehends(var("later"), var("earlier"))), call(realizes(var("earlier"), var("form")))]).
clause(24, may_realize(var("o"), var("form")), [call(subjective_aim_of(var("o"), var("aim"))), call(lures(var("aim"), var("form")))]).
clause(25, integrates(var("o"), var("pastForm")), [call(inherits(var("o"), var("pastForm"))), call(may_realize(var("o"), var("novelForm")))]).
clause(26, integrates(var("o"), var("novelForm")), [call(inherits(var("o"), var("pastForm"))), call(may_realize(var("o"), var("novelForm")))]).
clause(27, achieves(var("o"), satisfaction), [call(inherits(var("o"), var("pastForm"))), call(may_realize(var("o"), var("novelForm")))]).
clause(28, realizes(var("o"), var("form")), [call(integrates(var("o"), var("form"))), call(achieves(var("o"), satisfaction))]).
clause(29, ingresses(var("o"), var("form")), [call(realizes(var("o"), var("form"))), call(pure_potential(var("form")))]).
clause(30, status(var("o"), objectivelyAvailable), [call(achieves(var("o"), satisfaction))]).
substitution(1, []).
proof(1, prehends(o2, o1), rule(16), []).
substitution(2, []).
proof(2, prehends(o3, o2), rule(20), []).
substitution(3, [binding("later", o2), binding("earlier", o1)]).
proof(3, becomes_from(o2, o1), rule(22), [uses(1, prehends(o2, o1))]).
substitution(4, [binding("later", o3), binding("earlier", o2)]).
proof(4, becomes_from(o3, o2), rule(22), [uses(2, prehends(o3, o2))]).
substitution(5, [binding("later", o2), binding("earlier", o1)]).
proof(5, solution([o2, o1]), query, [uses(3, becomes_from(o2, o1))]).
substitution(6, [binding("later", o3), binding("earlier", o2)]).
proof(6, solution([o3, o2]), query, [uses(4, becomes_from(o3, o2))]).
substitution(7, []).
proof(7, prehends(o2, o1), rule(16), []).
substitution(8, []).
proof(8, prehends(o3, o2), rule(20), []).
substitution(9, []).
proof(9, realizes(o1, red), rule(11), []).
substitution(10, []).
proof(10, realizes(o1, warm), rule(12), []).
substitution(11, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(11, inherits(o2, red), rule(23), [uses(7, prehends(o2, o1)), uses(9, realizes(o1, red))]).
substitution(12, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(12, inherits(o2, warm), rule(23), [uses(7, prehends(o2, o1)), uses(10, realizes(o1, warm))]).
substitution(13, [binding("o", o2), binding("form", red)]).
proof(13, solution([o2, red]), query, [uses(11, inherits(o2, red))]).
substitution(14, [binding("o", o2), binding("form", warm)]).
proof(14, solution([o2, warm]), query, [uses(12, inherits(o2, warm))]).
substitution(15, []).
proof(15, prehends(o2, o1), rule(16), []).
substitution(16, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(16, inherits(o2, red), rule(23), [uses(15, prehends(o2, o1)), uses(9, realizes(o1, red))]).
substitution(17, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(17, inherits(o2, warm), rule(23), [uses(15, prehends(o2, o1)), uses(10, realizes(o1, warm))]).
substitution(18, []).
proof(18, subjective_aim_of(o2, intensity), rule(17), []).
substitution(19, []).
proof(19, lures(intensity, bright), rule(7), []).
substitution(20, [binding("o", o2), binding("form", bright), binding("aim", intensity)]).
proof(20, may_realize(o2, bright), rule(24), [uses(18, subjective_aim_of(o2, intensity)), uses(19, lures(intensity, bright))]).
substitution(21, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(21, integrates(o2, red), rule(25), [uses(16, inherits(o2, red)), uses(20, may_realize(o2, bright))]).
substitution(22, [binding("o", o2), binding("pastForm", warm), binding("novelForm", bright)]).
proof(22, integrates(o2, warm), rule(25), [uses(17, inherits(o2, warm)), uses(20, may_realize(o2, bright))]).
substitution(23, [binding("o", o2), binding("novelForm", bright), binding("pastForm", red)]).
proof(23, integrates(o2, bright), rule(26), [uses(16, inherits(o2, red)), uses(20, may_realize(o2, bright))]).
substitution(24, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(24, achieves(o2, satisfaction), rule(27), [uses(16, inherits(o2, red)), uses(20, may_realize(o2, bright))]).
substitution(25, [binding("o", o2), binding("form", red)]).
proof(25, realizes(o2, red), rule(28), [uses(21, integrates(o2, red)), uses(24, achieves(o2, satisfaction))]).
substitution(26, [binding("o", o2), binding("form", warm)]).
proof(26, realizes(o2, warm), rule(28), [uses(22, integrates(o2, warm)), uses(24, achieves(o2, satisfaction))]).
substitution(27, [binding("o", o2), binding("form", bright)]).
proof(27, realizes(o2, bright), rule(28), [uses(23, integrates(o2, bright)), uses(24, achieves(o2, satisfaction))]).
substitution(28, [binding("later", o3), binding("form", red), binding("earlier", o2)]).
proof(28, inherits(o3, red), rule(23), [uses(8, prehends(o3, o2)), uses(25, realizes(o2, red))]).
substitution(29, [binding("later", o3), binding("form", warm), binding("earlier", o2)]).
proof(29, inherits(o3, warm), rule(23), [uses(8, prehends(o3, o2)), uses(26, realizes(o2, warm))]).
substitution(30, [binding("later", o3), binding("form", bright), binding("earlier", o2)]).
proof(30, inherits(o3, bright), rule(23), [uses(8, prehends(o3, o2)), uses(27, realizes(o2, bright))]).
substitution(31, [binding("o", o3), binding("form", red)]).
proof(31, solution([o3, red]), query, [uses(28, inherits(o3, red))]).
substitution(32, [binding("o", o3), binding("form", warm)]).
proof(32, solution([o3, warm]), query, [uses(29, inherits(o3, warm))]).
substitution(33, [binding("o", o3), binding("form", bright)]).
proof(33, solution([o3, bright]), query, [uses(30, inherits(o3, bright))]).
substitution(34, []).
proof(34, subjective_aim_of(o2, intensity), rule(17), []).
substitution(35, []).
proof(35, subjective_aim_of(o3, contrast), rule(21), []).
substitution(36, []).
proof(36, lures(intensity, bright), rule(7), []).
substitution(37, []).
proof(37, lures(contrast, dark), rule(8), []).
substitution(38, [binding("o", o2), binding("form", bright), binding("aim", intensity)]).
proof(38, may_realize(o2, bright), rule(24), [uses(34, subjective_aim_of(o2, intensity)), uses(36, lures(intensity, bright))]).
substitution(39, [binding("o", o3), binding("form", dark), binding("aim", contrast)]).
proof(39, may_realize(o3, dark), rule(24), [uses(35, subjective_aim_of(o3, contrast)), uses(37, lures(contrast, dark))]).
substitution(40, [binding("o", o2), binding("form", bright)]).
proof(40, solution([o2, bright]), query, [uses(38, may_realize(o2, bright))]).
substitution(41, [binding("o", o3), binding("form", dark)]).
proof(41, solution([o3, dark]), query, [uses(39, may_realize(o3, dark))]).
substitution(42, []).
proof(42, prehends(o2, o1), rule(16), []).
substitution(43, []).
proof(43, prehends(o3, o2), rule(20), []).
substitution(44, []).
proof(44, realizes(o1, red), rule(11), []).
substitution(45, []).
proof(45, realizes(o1, warm), rule(12), []).
substitution(46, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(46, inherits(o2, red), rule(23), [uses(42, prehends(o2, o1)), uses(44, realizes(o1, red))]).
substitution(47, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(47, inherits(o2, warm), rule(23), [uses(42, prehends(o2, o1)), uses(45, realizes(o1, warm))]).
substitution(48, []).
proof(48, prehends(o2, o1), rule(16), []).
substitution(49, []).
proof(49, subjective_aim_of(o2, intensity), rule(17), []).
substitution(50, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(50, inherits(o2, red), rule(23), [uses(48, prehends(o2, o1)), uses(44, realizes(o1, red))]).
substitution(51, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(51, inherits(o2, warm), rule(23), [uses(48, prehends(o2, o1)), uses(45, realizes(o1, warm))]).
substitution(52, []).
proof(52, lures(intensity, bright), rule(7), []).
substitution(53, [binding("o", o2), binding("form", bright), binding("aim", intensity)]).
proof(53, may_realize(o2, bright), rule(24), [uses(49, subjective_aim_of(o2, intensity)), uses(52, lures(intensity, bright))]).
substitution(54, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(54, integrates(o2, red), rule(25), [uses(46, inherits(o2, red)), uses(53, may_realize(o2, bright))]).
substitution(55, [binding("o", o2), binding("pastForm", warm), binding("novelForm", bright)]).
proof(55, integrates(o2, warm), rule(25), [uses(47, inherits(o2, warm)), uses(53, may_realize(o2, bright))]).
substitution(56, [binding("o", o2), binding("novelForm", bright), binding("pastForm", red)]).
proof(56, integrates(o2, bright), rule(26), [uses(46, inherits(o2, red)), uses(53, may_realize(o2, bright))]).
substitution(57, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(57, integrates(o2, red), rule(25), [uses(50, inherits(o2, red)), uses(53, may_realize(o2, bright))]).
substitution(58, [binding("o", o2), binding("pastForm", warm), binding("novelForm", bright)]).
proof(58, integrates(o2, warm), rule(25), [uses(51, inherits(o2, warm)), uses(53, may_realize(o2, bright))]).
substitution(59, [binding("o", o2), binding("novelForm", bright), binding("pastForm", red)]).
proof(59, integrates(o2, bright), rule(26), [uses(50, inherits(o2, red)), uses(53, may_realize(o2, bright))]).
substitution(60, [binding("o", o2), binding("form", red)]).
proof(60, solution([o2, red]), query, [uses(54, integrates(o2, red))]).
substitution(61, [binding("o", o2), binding("form", warm)]).
proof(61, solution([o2, warm]), query, [uses(55, integrates(o2, warm))]).
substitution(62, [binding("o", o2), binding("form", bright)]).
proof(62, solution([o2, bright]), query, [uses(56, integrates(o2, bright))]).
substitution(63, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(63, achieves(o2, satisfaction), rule(27), [uses(50, inherits(o2, red)), uses(53, may_realize(o2, bright))]).
substitution(64, [binding("o", o2), binding("form", red)]).
proof(64, realizes(o2, red), rule(28), [uses(57, integrates(o2, red)), uses(63, achieves(o2, satisfaction))]).
substitution(65, [binding("o", o2), binding("form", warm)]).
proof(65, realizes(o2, warm), rule(28), [uses(58, integrates(o2, warm)), uses(63, achieves(o2, satisfaction))]).
substitution(66, [binding("o", o2), binding("form", bright)]).
proof(66, realizes(o2, bright), rule(28), [uses(59, integrates(o2, bright)), uses(63, achieves(o2, satisfaction))]).
substitution(67, [binding("later", o3), binding("form", red), binding("earlier", o2)]).
proof(67, inherits(o3, red), rule(23), [uses(43, prehends(o3, o2)), uses(64, realizes(o2, red))]).
substitution(68, [binding("later", o3), binding("form", warm), binding("earlier", o2)]).
proof(68, inherits(o3, warm), rule(23), [uses(43, prehends(o3, o2)), uses(65, realizes(o2, warm))]).
substitution(69, [binding("later", o3), binding("form", bright), binding("earlier", o2)]).
proof(69, inherits(o3, bright), rule(23), [uses(43, prehends(o3, o2)), uses(66, realizes(o2, bright))]).
substitution(70, []).
proof(70, subjective_aim_of(o3, contrast), rule(21), []).
substitution(71, []).
proof(71, lures(contrast, dark), rule(8), []).
substitution(72, [binding("o", o3), binding("form", dark), binding("aim", contrast)]).
proof(72, may_realize(o3, dark), rule(24), [uses(70, subjective_aim_of(o3, contrast)), uses(71, lures(contrast, dark))]).
substitution(73, [binding("o", o3), binding("pastForm", red), binding("novelForm", dark)]).
proof(73, integrates(o3, red), rule(25), [uses(67, inherits(o3, red)), uses(72, may_realize(o3, dark))]).
substitution(74, [binding("o", o3), binding("pastForm", warm), binding("novelForm", dark)]).
proof(74, integrates(o3, warm), rule(25), [uses(68, inherits(o3, warm)), uses(72, may_realize(o3, dark))]).
substitution(75, [binding("o", o3), binding("pastForm", bright), binding("novelForm", dark)]).
proof(75, integrates(o3, bright), rule(25), [uses(69, inherits(o3, bright)), uses(72, may_realize(o3, dark))]).
substitution(76, [binding("o", o3), binding("novelForm", dark), binding("pastForm", red)]).
proof(76, integrates(o3, dark), rule(26), [uses(67, inherits(o3, red)), uses(72, may_realize(o3, dark))]).
substitution(77, [binding("o", o3), binding("form", red)]).
proof(77, solution([o3, red]), query, [uses(73, integrates(o3, red))]).
substitution(78, [binding("o", o3), binding("form", warm)]).
proof(78, solution([o3, warm]), query, [uses(74, integrates(o3, warm))]).
substitution(79, [binding("o", o3), binding("form", bright)]).
proof(79, solution([o3, bright]), query, [uses(75, integrates(o3, bright))]).
substitution(80, [binding("o", o3), binding("form", dark)]).
proof(80, solution([o3, dark]), query, [uses(76, integrates(o3, dark))]).
substitution(81, []).
proof(81, realizes(o1, red), rule(11), []).
substitution(82, []).
proof(82, realizes(o1, warm), rule(12), []).
substitution(83, [binding("o", o1), binding("form", red)]).
proof(83, solution([o1, red]), query, [uses(81, realizes(o1, red))]).
substitution(84, [binding("o", o1), binding("form", warm)]).
proof(84, solution([o1, warm]), query, [uses(82, realizes(o1, warm))]).
substitution(85, []).
proof(85, prehends(o2, o1), rule(16), []).
substitution(86, []).
proof(86, prehends(o3, o2), rule(20), []).
substitution(87, []).
proof(87, realizes(o1, red), rule(11), []).
substitution(88, []).
proof(88, realizes(o1, warm), rule(12), []).
substitution(89, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(89, inherits(o2, red), rule(23), [uses(85, prehends(o2, o1)), uses(87, realizes(o1, red))]).
substitution(90, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(90, inherits(o2, warm), rule(23), [uses(85, prehends(o2, o1)), uses(88, realizes(o1, warm))]).
substitution(91, []).
proof(91, prehends(o2, o1), rule(16), []).
substitution(92, []).
proof(92, subjective_aim_of(o2, intensity), rule(17), []).
substitution(93, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(93, inherits(o2, red), rule(23), [uses(91, prehends(o2, o1)), uses(87, realizes(o1, red))]).
substitution(94, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(94, inherits(o2, warm), rule(23), [uses(91, prehends(o2, o1)), uses(88, realizes(o1, warm))]).
substitution(95, []).
proof(95, lures(intensity, bright), rule(7), []).
substitution(96, [binding("o", o2), binding("form", bright), binding("aim", intensity)]).
proof(96, may_realize(o2, bright), rule(24), [uses(92, subjective_aim_of(o2, intensity)), uses(95, lures(intensity, bright))]).
substitution(97, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(97, integrates(o2, red), rule(25), [uses(89, inherits(o2, red)), uses(96, may_realize(o2, bright))]).
substitution(98, [binding("o", o2), binding("pastForm", warm), binding("novelForm", bright)]).
proof(98, integrates(o2, warm), rule(25), [uses(90, inherits(o2, warm)), uses(96, may_realize(o2, bright))]).
substitution(99, [binding("o", o2), binding("novelForm", bright), binding("pastForm", red)]).
proof(99, integrates(o2, bright), rule(26), [uses(89, inherits(o2, red)), uses(96, may_realize(o2, bright))]).
substitution(100, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(100, integrates(o2, red), rule(25), [uses(93, inherits(o2, red)), uses(96, may_realize(o2, bright))]).
substitution(101, [binding("o", o2), binding("pastForm", warm), binding("novelForm", bright)]).
proof(101, integrates(o2, warm), rule(25), [uses(94, inherits(o2, warm)), uses(96, may_realize(o2, bright))]).
substitution(102, [binding("o", o2), binding("novelForm", bright), binding("pastForm", red)]).
proof(102, integrates(o2, bright), rule(26), [uses(93, inherits(o2, red)), uses(96, may_realize(o2, bright))]).
substitution(103, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(103, achieves(o2, satisfaction), rule(27), [uses(93, inherits(o2, red)), uses(96, may_realize(o2, bright))]).
substitution(104, [binding("o", o2), binding("form", red)]).
proof(104, realizes(o2, red), rule(28), [uses(97, integrates(o2, red)), uses(103, achieves(o2, satisfaction))]).
substitution(105, [binding("o", o2), binding("form", warm)]).
proof(105, realizes(o2, warm), rule(28), [uses(98, integrates(o2, warm)), uses(103, achieves(o2, satisfaction))]).
substitution(106, [binding("o", o2), binding("form", bright)]).
proof(106, realizes(o2, bright), rule(28), [uses(99, integrates(o2, bright)), uses(103, achieves(o2, satisfaction))]).
substitution(107, [binding("o", o2), binding("form", red)]).
proof(107, realizes(o2, red), rule(28), [uses(100, integrates(o2, red)), uses(103, achieves(o2, satisfaction))]).
substitution(108, [binding("o", o2), binding("form", warm)]).
proof(108, realizes(o2, warm), rule(28), [uses(101, integrates(o2, warm)), uses(103, achieves(o2, satisfaction))]).
substitution(109, [binding("o", o2), binding("form", bright)]).
proof(109, realizes(o2, bright), rule(28), [uses(102, integrates(o2, bright)), uses(103, achieves(o2, satisfaction))]).
substitution(110, [binding("o", o2), binding("form", red)]).
proof(110, solution([o2, red]), query, [uses(104, realizes(o2, red))]).
substitution(111, [binding("o", o2), binding("form", warm)]).
proof(111, solution([o2, warm]), query, [uses(105, realizes(o2, warm))]).
substitution(112, [binding("o", o2), binding("form", bright)]).
proof(112, solution([o2, bright]), query, [uses(106, realizes(o2, bright))]).
substitution(113, [binding("later", o3), binding("form", red), binding("earlier", o2)]).
proof(113, inherits(o3, red), rule(23), [uses(86, prehends(o3, o2)), uses(107, realizes(o2, red))]).
substitution(114, [binding("later", o3), binding("form", warm), binding("earlier", o2)]).
proof(114, inherits(o3, warm), rule(23), [uses(86, prehends(o3, o2)), uses(108, realizes(o2, warm))]).
substitution(115, [binding("later", o3), binding("form", bright), binding("earlier", o2)]).
proof(115, inherits(o3, bright), rule(23), [uses(86, prehends(o3, o2)), uses(109, realizes(o2, bright))]).
substitution(116, []).
proof(116, subjective_aim_of(o3, contrast), rule(21), []).
substitution(117, []).
proof(117, lures(contrast, dark), rule(8), []).
substitution(118, [binding("o", o3), binding("form", dark), binding("aim", contrast)]).
proof(118, may_realize(o3, dark), rule(24), [uses(116, subjective_aim_of(o3, contrast)), uses(117, lures(contrast, dark))]).
substitution(119, [binding("o", o3), binding("pastForm", red), binding("novelForm", dark)]).
proof(119, integrates(o3, red), rule(25), [uses(113, inherits(o3, red)), uses(118, may_realize(o3, dark))]).
substitution(120, [binding("o", o3), binding("pastForm", warm), binding("novelForm", dark)]).
proof(120, integrates(o3, warm), rule(25), [uses(114, inherits(o3, warm)), uses(118, may_realize(o3, dark))]).
substitution(121, [binding("o", o3), binding("pastForm", bright), binding("novelForm", dark)]).
proof(121, integrates(o3, bright), rule(25), [uses(115, inherits(o3, bright)), uses(118, may_realize(o3, dark))]).
substitution(122, [binding("o", o3), binding("novelForm", dark), binding("pastForm", red)]).
proof(122, integrates(o3, dark), rule(26), [uses(113, inherits(o3, red)), uses(118, may_realize(o3, dark))]).
substitution(123, []).
proof(123, prehends(o3, o2), rule(20), []).
substitution(124, [binding("later", o3), binding("form", red), binding("earlier", o2)]).
proof(124, inherits(o3, red), rule(23), [uses(123, prehends(o3, o2)), uses(107, realizes(o2, red))]).
substitution(125, [binding("later", o3), binding("form", warm), binding("earlier", o2)]).
proof(125, inherits(o3, warm), rule(23), [uses(123, prehends(o3, o2)), uses(108, realizes(o2, warm))]).
substitution(126, [binding("later", o3), binding("form", bright), binding("earlier", o2)]).
proof(126, inherits(o3, bright), rule(23), [uses(123, prehends(o3, o2)), uses(109, realizes(o2, bright))]).
substitution(127, [binding("o", o3), binding("pastForm", red), binding("novelForm", dark)]).
proof(127, achieves(o3, satisfaction), rule(27), [uses(124, inherits(o3, red)), uses(118, may_realize(o3, dark))]).
substitution(128, [binding("o", o3), binding("form", red)]).
proof(128, realizes(o3, red), rule(28), [uses(119, integrates(o3, red)), uses(127, achieves(o3, satisfaction))]).
substitution(129, [binding("o", o3), binding("form", warm)]).
proof(129, realizes(o3, warm), rule(28), [uses(120, integrates(o3, warm)), uses(127, achieves(o3, satisfaction))]).
substitution(130, [binding("o", o3), binding("form", bright)]).
proof(130, realizes(o3, bright), rule(28), [uses(121, integrates(o3, bright)), uses(127, achieves(o3, satisfaction))]).
substitution(131, [binding("o", o3), binding("form", dark)]).
proof(131, realizes(o3, dark), rule(28), [uses(122, integrates(o3, dark)), uses(127, achieves(o3, satisfaction))]).
substitution(132, [binding("o", o3), binding("form", red)]).
proof(132, solution([o3, red]), query, [uses(128, realizes(o3, red))]).
substitution(133, [binding("o", o3), binding("form", warm)]).
proof(133, solution([o3, warm]), query, [uses(129, realizes(o3, warm))]).
substitution(134, [binding("o", o3), binding("form", bright)]).
proof(134, solution([o3, bright]), query, [uses(130, realizes(o3, bright))]).
substitution(135, [binding("o", o3), binding("form", dark)]).
proof(135, solution([o3, dark]), query, [uses(131, realizes(o3, dark))]).
substitution(136, []).
proof(136, realizes(o1, red), rule(11), []).
substitution(137, []).
proof(137, realizes(o1, warm), rule(12), []).
substitution(138, []).
proof(138, pure_potential(red), rule(1), []).
substitution(139, []).
proof(139, pure_potential(warm), rule(2), []).
substitution(140, [binding("o", o1), binding("form", red)]).
proof(140, ingresses(o1, red), rule(29), [uses(136, realizes(o1, red)), uses(138, pure_potential(red))]).
substitution(141, [binding("o", o1), binding("form", warm)]).
proof(141, ingresses(o1, warm), rule(29), [uses(137, realizes(o1, warm)), uses(139, pure_potential(warm))]).
substitution(142, []).
proof(142, prehends(o2, o1), rule(16), []).
substitution(143, []).
proof(143, prehends(o3, o2), rule(20), []).
substitution(144, [binding("o", o1), binding("form", red)]).
proof(144, solution([o1, red]), query, [uses(140, ingresses(o1, red))]).
substitution(145, [binding("o", o1), binding("form", warm)]).
proof(145, solution([o1, warm]), query, [uses(141, ingresses(o1, warm))]).
substitution(146, []).
proof(146, realizes(o1, red), rule(11), []).
substitution(147, []).
proof(147, realizes(o1, warm), rule(12), []).
substitution(148, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(148, inherits(o2, red), rule(23), [uses(142, prehends(o2, o1)), uses(146, realizes(o1, red))]).
substitution(149, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(149, inherits(o2, warm), rule(23), [uses(142, prehends(o2, o1)), uses(147, realizes(o1, warm))]).
substitution(150, []).
proof(150, prehends(o2, o1), rule(16), []).
substitution(151, []).
proof(151, subjective_aim_of(o2, intensity), rule(17), []).
substitution(152, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(152, inherits(o2, red), rule(23), [uses(150, prehends(o2, o1)), uses(146, realizes(o1, red))]).
substitution(153, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(153, inherits(o2, warm), rule(23), [uses(150, prehends(o2, o1)), uses(147, realizes(o1, warm))]).
substitution(154, []).
proof(154, lures(intensity, bright), rule(7), []).
substitution(155, [binding("o", o2), binding("form", bright), binding("aim", intensity)]).
proof(155, may_realize(o2, bright), rule(24), [uses(151, subjective_aim_of(o2, intensity)), uses(154, lures(intensity, bright))]).
substitution(156, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(156, integrates(o2, red), rule(25), [uses(148, inherits(o2, red)), uses(155, may_realize(o2, bright))]).
substitution(157, [binding("o", o2), binding("pastForm", warm), binding("novelForm", bright)]).
proof(157, integrates(o2, warm), rule(25), [uses(149, inherits(o2, warm)), uses(155, may_realize(o2, bright))]).
substitution(158, [binding("o", o2), binding("novelForm", bright), binding("pastForm", red)]).
proof(158, integrates(o2, bright), rule(26), [uses(148, inherits(o2, red)), uses(155, may_realize(o2, bright))]).
substitution(159, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(159, integrates(o2, red), rule(25), [uses(152, inherits(o2, red)), uses(155, may_realize(o2, bright))]).
substitution(160, [binding("o", o2), binding("pastForm", warm), binding("novelForm", bright)]).
proof(160, integrates(o2, warm), rule(25), [uses(153, inherits(o2, warm)), uses(155, may_realize(o2, bright))]).
substitution(161, [binding("o", o2), binding("novelForm", bright), binding("pastForm", red)]).
proof(161, integrates(o2, bright), rule(26), [uses(152, inherits(o2, red)), uses(155, may_realize(o2, bright))]).
substitution(162, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(162, achieves(o2, satisfaction), rule(27), [uses(152, inherits(o2, red)), uses(155, may_realize(o2, bright))]).
substitution(163, [binding("o", o2), binding("form", red)]).
proof(163, realizes(o2, red), rule(28), [uses(156, integrates(o2, red)), uses(162, achieves(o2, satisfaction))]).
substitution(164, [binding("o", o2), binding("form", warm)]).
proof(164, realizes(o2, warm), rule(28), [uses(157, integrates(o2, warm)), uses(162, achieves(o2, satisfaction))]).
substitution(165, [binding("o", o2), binding("form", bright)]).
proof(165, realizes(o2, bright), rule(28), [uses(158, integrates(o2, bright)), uses(162, achieves(o2, satisfaction))]).
substitution(166, [binding("o", o2), binding("form", red)]).
proof(166, realizes(o2, red), rule(28), [uses(159, integrates(o2, red)), uses(162, achieves(o2, satisfaction))]).
substitution(167, [binding("o", o2), binding("form", warm)]).
proof(167, realizes(o2, warm), rule(28), [uses(160, integrates(o2, warm)), uses(162, achieves(o2, satisfaction))]).
substitution(168, [binding("o", o2), binding("form", bright)]).
proof(168, realizes(o2, bright), rule(28), [uses(161, integrates(o2, bright)), uses(162, achieves(o2, satisfaction))]).
substitution(169, [binding("o", o2), binding("form", red)]).
proof(169, ingresses(o2, red), rule(29), [uses(163, realizes(o2, red)), uses(138, pure_potential(red))]).
substitution(170, [binding("o", o2), binding("form", warm)]).
proof(170, ingresses(o2, warm), rule(29), [uses(164, realizes(o2, warm)), uses(139, pure_potential(warm))]).
substitution(171, [binding("later", o3), binding("form", red), binding("earlier", o2)]).
proof(171, inherits(o3, red), rule(23), [uses(143, prehends(o3, o2)), uses(166, realizes(o2, red))]).
substitution(172, [binding("later", o3), binding("form", warm), binding("earlier", o2)]).
proof(172, inherits(o3, warm), rule(23), [uses(143, prehends(o3, o2)), uses(167, realizes(o2, warm))]).
substitution(173, [binding("later", o3), binding("form", bright), binding("earlier", o2)]).
proof(173, inherits(o3, bright), rule(23), [uses(143, prehends(o3, o2)), uses(168, realizes(o2, bright))]).
substitution(174, [binding("o", o2), binding("form", red)]).
proof(174, solution([o2, red]), query, [uses(169, ingresses(o2, red))]).
substitution(175, [binding("o", o2), binding("form", warm)]).
proof(175, solution([o2, warm]), query, [uses(170, ingresses(o2, warm))]).
substitution(176, []).
proof(176, pure_potential(bright), rule(3), []).
substitution(177, [binding("o", o2), binding("form", bright)]).
proof(177, ingresses(o2, bright), rule(29), [uses(165, realizes(o2, bright)), uses(176, pure_potential(bright))]).
substitution(178, [binding("o", o2), binding("form", bright)]).
proof(178, solution([o2, bright]), query, [uses(177, ingresses(o2, bright))]).
substitution(179, []).
proof(179, subjective_aim_of(o3, contrast), rule(21), []).
substitution(180, []).
proof(180, lures(contrast, dark), rule(8), []).
substitution(181, [binding("o", o3), binding("form", dark), binding("aim", contrast)]).
proof(181, may_realize(o3, dark), rule(24), [uses(179, subjective_aim_of(o3, contrast)), uses(180, lures(contrast, dark))]).
substitution(182, [binding("o", o3), binding("pastForm", red), binding("novelForm", dark)]).
proof(182, integrates(o3, red), rule(25), [uses(171, inherits(o3, red)), uses(181, may_realize(o3, dark))]).
substitution(183, [binding("o", o3), binding("pastForm", warm), binding("novelForm", dark)]).
proof(183, integrates(o3, warm), rule(25), [uses(172, inherits(o3, warm)), uses(181, may_realize(o3, dark))]).
substitution(184, [binding("o", o3), binding("pastForm", bright), binding("novelForm", dark)]).
proof(184, integrates(o3, bright), rule(25), [uses(173, inherits(o3, bright)), uses(181, may_realize(o3, dark))]).
substitution(185, [binding("o", o3), binding("novelForm", dark), binding("pastForm", red)]).
proof(185, integrates(o3, dark), rule(26), [uses(171, inherits(o3, red)), uses(181, may_realize(o3, dark))]).
substitution(186, []).
proof(186, prehends(o3, o2), rule(20), []).
substitution(187, [binding("later", o3), binding("form", red), binding("earlier", o2)]).
proof(187, inherits(o3, red), rule(23), [uses(186, prehends(o3, o2)), uses(166, realizes(o2, red))]).
substitution(188, [binding("later", o3), binding("form", warm), binding("earlier", o2)]).
proof(188, inherits(o3, warm), rule(23), [uses(186, prehends(o3, o2)), uses(167, realizes(o2, warm))]).
substitution(189, [binding("later", o3), binding("form", bright), binding("earlier", o2)]).
proof(189, inherits(o3, bright), rule(23), [uses(186, prehends(o3, o2)), uses(168, realizes(o2, bright))]).
substitution(190, [binding("o", o3), binding("pastForm", red), binding("novelForm", dark)]).
proof(190, achieves(o3, satisfaction), rule(27), [uses(187, inherits(o3, red)), uses(181, may_realize(o3, dark))]).
substitution(191, [binding("o", o3), binding("form", red)]).
proof(191, realizes(o3, red), rule(28), [uses(182, integrates(o3, red)), uses(190, achieves(o3, satisfaction))]).
substitution(192, [binding("o", o3), binding("form", warm)]).
proof(192, realizes(o3, warm), rule(28), [uses(183, integrates(o3, warm)), uses(190, achieves(o3, satisfaction))]).
substitution(193, [binding("o", o3), binding("form", bright)]).
proof(193, realizes(o3, bright), rule(28), [uses(184, integrates(o3, bright)), uses(190, achieves(o3, satisfaction))]).
substitution(194, [binding("o", o3), binding("form", dark)]).
proof(194, realizes(o3, dark), rule(28), [uses(185, integrates(o3, dark)), uses(190, achieves(o3, satisfaction))]).
substitution(195, [binding("o", o3), binding("form", red)]).
proof(195, ingresses(o3, red), rule(29), [uses(191, realizes(o3, red)), uses(138, pure_potential(red))]).
substitution(196, [binding("o", o3), binding("form", warm)]).
proof(196, ingresses(o3, warm), rule(29), [uses(192, realizes(o3, warm)), uses(139, pure_potential(warm))]).
substitution(197, [binding("o", o3), binding("form", bright)]).
proof(197, ingresses(o3, bright), rule(29), [uses(193, realizes(o3, bright)), uses(176, pure_potential(bright))]).
substitution(198, [binding("o", o3), binding("form", red)]).
proof(198, solution([o3, red]), query, [uses(195, ingresses(o3, red))]).
substitution(199, [binding("o", o3), binding("form", warm)]).
proof(199, solution([o3, warm]), query, [uses(196, ingresses(o3, warm))]).
substitution(200, [binding("o", o3), binding("form", bright)]).
proof(200, solution([o3, bright]), query, [uses(197, ingresses(o3, bright))]).
substitution(201, []).
proof(201, pure_potential(dark), rule(4), []).
substitution(202, [binding("o", o3), binding("form", dark)]).
proof(202, ingresses(o3, dark), rule(29), [uses(194, realizes(o3, dark)), uses(201, pure_potential(dark))]).
substitution(203, [binding("o", o3), binding("form", dark)]).
proof(203, solution([o3, dark]), query, [uses(202, ingresses(o3, dark))]).
substitution(204, []).
proof(204, achieves(o1, satisfaction), rule(13), []).
substitution(205, [binding("o", o1)]).
proof(205, status(o1, objectivelyAvailable), rule(30), [uses(204, achieves(o1, satisfaction))]).
substitution(206, [binding("o", o1), binding("s", objectivelyAvailable)]).
proof(206, solution([o1, objectivelyAvailable]), query, [uses(205, status(o1, objectivelyAvailable))]).
substitution(207, []).
proof(207, prehends(o2, o1), rule(16), []).
substitution(208, []).
proof(208, prehends(o3, o2), rule(20), []).
substitution(209, []).
proof(209, realizes(o1, red), rule(11), []).
substitution(210, []).
proof(210, realizes(o1, warm), rule(12), []).
substitution(211, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(211, inherits(o2, red), rule(23), [uses(207, prehends(o2, o1)), uses(209, realizes(o1, red))]).
substitution(212, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(212, inherits(o2, warm), rule(23), [uses(207, prehends(o2, o1)), uses(210, realizes(o1, warm))]).
substitution(213, []).
proof(213, prehends(o2, o1), rule(16), []).
substitution(214, []).
proof(214, subjective_aim_of(o2, intensity), rule(17), []).
substitution(215, [binding("later", o2), binding("form", red), binding("earlier", o1)]).
proof(215, inherits(o2, red), rule(23), [uses(213, prehends(o2, o1)), uses(209, realizes(o1, red))]).
substitution(216, [binding("later", o2), binding("form", warm), binding("earlier", o1)]).
proof(216, inherits(o2, warm), rule(23), [uses(213, prehends(o2, o1)), uses(210, realizes(o1, warm))]).
substitution(217, []).
proof(217, lures(intensity, bright), rule(7), []).
substitution(218, [binding("o", o2), binding("form", bright), binding("aim", intensity)]).
proof(218, may_realize(o2, bright), rule(24), [uses(214, subjective_aim_of(o2, intensity)), uses(217, lures(intensity, bright))]).
substitution(219, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(219, achieves(o2, satisfaction), rule(27), [uses(211, inherits(o2, red)), uses(218, may_realize(o2, bright))]).
substitution(220, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(220, integrates(o2, red), rule(25), [uses(215, inherits(o2, red)), uses(218, may_realize(o2, bright))]).
substitution(221, [binding("o", o2), binding("pastForm", warm), binding("novelForm", bright)]).
proof(221, integrates(o2, warm), rule(25), [uses(216, inherits(o2, warm)), uses(218, may_realize(o2, bright))]).
substitution(222, [binding("o", o2), binding("novelForm", bright), binding("pastForm", red)]).
proof(222, integrates(o2, bright), rule(26), [uses(215, inherits(o2, red)), uses(218, may_realize(o2, bright))]).
substitution(223, [binding("o", o2)]).
proof(223, status(o2, objectivelyAvailable), rule(30), [uses(219, achieves(o2, satisfaction))]).
substitution(224, [binding("o", o2), binding("s", objectivelyAvailable)]).
proof(224, solution([o2, objectivelyAvailable]), query, [uses(223, status(o2, objectivelyAvailable))]).
substitution(225, [binding("o", o2), binding("pastForm", red), binding("novelForm", bright)]).
proof(225, achieves(o2, satisfaction), rule(27), [uses(215, inherits(o2, red)), uses(218, may_realize(o2, bright))]).
substitution(226, [binding("o", o2), binding("form", red)]).
proof(226, realizes(o2, red), rule(28), [uses(220, integrates(o2, red)), uses(225, achieves(o2, satisfaction))]).
substitution(227, [binding("o", o2), binding("form", warm)]).
proof(227, realizes(o2, warm), rule(28), [uses(221, integrates(o2, warm)), uses(225, achieves(o2, satisfaction))]).
substitution(228, [binding("o", o2), binding("form", bright)]).
proof(228, realizes(o2, bright), rule(28), [uses(222, integrates(o2, bright)), uses(225, achieves(o2, satisfaction))]).
substitution(229, [binding("later", o3), binding("form", red), binding("earlier", o2)]).
proof(229, inherits(o3, red), rule(23), [uses(208, prehends(o3, o2)), uses(226, realizes(o2, red))]).
substitution(230, [binding("later", o3), binding("form", warm), binding("earlier", o2)]).
proof(230, inherits(o3, warm), rule(23), [uses(208, prehends(o3, o2)), uses(227, realizes(o2, warm))]).
substitution(231, [binding("later", o3), binding("form", bright), binding("earlier", o2)]).
proof(231, inherits(o3, bright), rule(23), [uses(208, prehends(o3, o2)), uses(228, realizes(o2, bright))]).
substitution(232, []).
proof(232, subjective_aim_of(o3, contrast), rule(21), []).
substitution(233, []).
proof(233, lures(contrast, dark), rule(8), []).
substitution(234, [binding("o", o3), binding("form", dark), binding("aim", contrast)]).
proof(234, may_realize(o3, dark), rule(24), [uses(232, subjective_aim_of(o3, contrast)), uses(233, lures(contrast, dark))]).
substitution(235, [binding("o", o3), binding("pastForm", red), binding("novelForm", dark)]).
proof(235, achieves(o3, satisfaction), rule(27), [uses(229, inherits(o3, red)), uses(234, may_realize(o3, dark))]).
substitution(236, [binding("o", o3)]).
proof(236, status(o3, objectivelyAvailable), rule(30), [uses(235, achieves(o3, satisfaction))]).
substitution(237, [binding("o", o3), binding("s", objectivelyAvailable)]).
proof(237, solution([o3, objectivelyAvailable]), query, [uses(236, status(o3, objectivelyAvailable))]).
