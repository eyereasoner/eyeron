# Eyelang result format 2
query(1, [call(status(?v0, ?v1))], [binding("x", ?v0), binding("s", ?v1)]).
result(1, complete, 4).
answer(1, [binding("x", perfectRestoreTask), binding("s", impossibleTask)]).
why(1, [binding("x", perfectRestoreTask), binding("s", impossibleTask)], 10).
answer(1, [binding("x", writeTask), binding("s", possibleTask)]).
why(1, [binding("x", writeTask), binding("s", possibleTask)], 11).
answer(1, [binding("x", stabilizeTask), binding("s", possibleTask)]).
why(1, [binding("x", stabilizeTask), binding("s", possibleTask)], 12).
answer(1, [binding("x", vBad), binding("s", blockedTransition)]).
why(1, [binding("x", vBad), binding("s", blockedTransition)], 16).
query(2, [call(retains_capacity_for(?v0, ?v1))], [binding("c", ?v0), binding("t", ?v1)]).
result(2, complete, 2).
answer(2, [binding("c", writer), binding("t", writeTask)]).
why(2, [binding("c", writer), binding("t", writeTask)], 21).
answer(2, [binding("c", stabilizer), binding("t", stabilizeTask)]).
why(2, [binding("c", stabilizer), binding("t", stabilizeTask)], 22).
query(3, [call(can_undergo(?v0, ?v1))], [binding("next", ?v0), binding("task", ?v1)]).
result(3, complete, 2).
answer(3, [binding("next", v2), binding("task", writeTask)]).
why(3, [binding("next", v2), binding("task", writeTask)], 37).
answer(3, [binding("next", v3), binding("task", stabilizeTask)]).
why(3, [binding("next", v3), binding("task", stabilizeTask)], 43).
query(4, [call(becomes_from(?v0, ?v1))], [binding("next", ?v0), binding("prev", ?v1)]).
result(4, complete, 2).
answer(4, [binding("next", v2), binding("prev", v1)]).
why(4, [binding("next", v2), binding("prev", v1)], 58).
answer(4, [binding("next", v3), binding("prev", v2)]).
why(4, [binding("next", v3), binding("prev", v2)], 64).
query(5, [call(has_attribute(?v0, ?v1))], [binding("x", ?v0), binding("attr", ?v1)]).
result(5, complete, 4).
answer(5, [binding("x", v1), binding("attr", blankMemory)]).
why(5, [binding("x", v1), binding("attr", blankMemory)], 67).
answer(5, [binding("x", damaged1), binding("attr", damagedMemory)]).
why(5, [binding("x", damaged1), binding("attr", damagedMemory)], 68).
answer(5, [binding("x", v2), binding("attr", encodedMemory)]).
why(5, [binding("x", v2), binding("attr", encodedMemory)], 87).
answer(5, [binding("x", v3), binding("attr", stabilizedMemory)]).
why(5, [binding("x", v3), binding("attr", stabilizedMemory)], 93).
query(6, [call(available_for_further_task(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(6, complete, 4).
answer(6, [binding("x", v1), binding("y", yes)]).
why(6, [binding("x", v1), binding("y", yes)], 98).
answer(6, [binding("x", damaged1), binding("y", yes)]).
why(6, [binding("x", damaged1), binding("y", yes)], 99).
answer(6, [binding("x", v2), binding("y", yes)]).
why(6, [binding("x", v2), binding("y", yes)], 120).
answer(6, [binding("x", v3), binding("y", yes)]).
why(6, [binding("x", v3), binding("y", yes)], 126).
clause(1, task_input(writeTask, blankMemory), []).
clause(2, task_output(writeTask, encodedMemory), []).
clause(3, task_input(stabilizeTask, encodedMemory), []).
clause(4, task_output(stabilizeTask, stabilizedMemory), []).
clause(7, forbidden_by(perfectRestoreTask, noMiraclePrinciple), []).
clause(8, can_perform(writer, writeTask), []).
clause(9, can_perform(stabilizer, stabilizeTask), []).
clause(10, has_attribute(v1, blankMemory), []).
clause(11, derives_from(v2, v1), []).
clause(12, intends_task(v2, writeTask), []).
clause(13, derives_from(v3, v2), []).
clause(14, intends_task(v3, stabilizeTask), []).
clause(15, has_attribute(damaged1, damagedMemory), []).
clause(16, derives_from(vBad, damaged1), []).
clause(17, intends_task(vBad, perfectRestoreTask), []).
clause(18, status(var("task"), impossibleTask), [call(forbidden_by(var("task"), var("principle")))]).
clause(19, status(var("task"), possibleTask), [call(can_perform(var("constructor"), var("task")))]).
clause(20, retains_capacity_for(var("constructor"), var("task")), [call(can_perform(var("constructor"), var("task")))]).
clause(21, can_undergo(var("next"), var("task")), [call(derives_from(var("next"), var("prev"))), call(intends_task(var("next"), var("task"))), call(status(var("task"), possibleTask)), call(task_input(var("task"), var("in"))), call(has_attribute(var("prev"), var("in")))]).
clause(22, becomes_from(var("next"), var("prev")), [call(derives_from(var("next"), var("prev"))), call(intends_task(var("next"), var("task"))), call(status(var("task"), possibleTask)), call(task_input(var("task"), var("in"))), call(has_attribute(var("prev"), var("in")))]).
clause(23, has_attribute(var("next"), var("out")), [call(can_undergo(var("next"), var("task"))), call(task_output(var("task"), var("out")))]).
clause(24, status(var("next"), blockedTransition), [call(intends_task(var("next"), var("task"))), call(status(var("task"), impossibleTask))]).
clause(25, available_for_further_task(var("next"), yes), [call(has_attribute(var("next"), var("attr")))]).
substitution(1, []).
proof(1, forbidden_by(perfectRestoreTask, noMiraclePrinciple), rule(7), []).
substitution(2, []).
proof(2, can_perform(writer, writeTask), rule(8), []).
substitution(3, []).
proof(3, can_perform(stabilizer, stabilizeTask), rule(9), []).
substitution(4, []).
proof(4, intends_task(v2, writeTask), rule(12), []).
substitution(5, []).
proof(5, intends_task(v3, stabilizeTask), rule(14), []).
substitution(6, []).
proof(6, intends_task(vBad, perfectRestoreTask), rule(17), []).
substitution(7, [binding("task", perfectRestoreTask), binding("principle", noMiraclePrinciple)]).
proof(7, status(perfectRestoreTask, impossibleTask), rule(18), [uses(1, forbidden_by(perfectRestoreTask, noMiraclePrinciple))]).
substitution(8, [binding("task", writeTask), binding("constructor", writer)]).
proof(8, status(writeTask, possibleTask), rule(19), [uses(2, can_perform(writer, writeTask))]).
substitution(9, [binding("task", stabilizeTask), binding("constructor", stabilizer)]).
proof(9, status(stabilizeTask, possibleTask), rule(19), [uses(3, can_perform(stabilizer, stabilizeTask))]).
substitution(10, [binding("x", perfectRestoreTask), binding("s", impossibleTask)]).
proof(10, solution([perfectRestoreTask, impossibleTask]), query, [uses(7, status(perfectRestoreTask, impossibleTask))]).
substitution(11, [binding("x", writeTask), binding("s", possibleTask)]).
proof(11, solution([writeTask, possibleTask]), query, [uses(8, status(writeTask, possibleTask))]).
substitution(12, [binding("x", stabilizeTask), binding("s", possibleTask)]).
proof(12, solution([stabilizeTask, possibleTask]), query, [uses(9, status(stabilizeTask, possibleTask))]).
substitution(13, []).
proof(13, forbidden_by(perfectRestoreTask, noMiraclePrinciple), rule(7), []).
substitution(14, [binding("task", perfectRestoreTask), binding("principle", noMiraclePrinciple)]).
proof(14, status(perfectRestoreTask, impossibleTask), rule(18), [uses(13, forbidden_by(perfectRestoreTask, noMiraclePrinciple))]).
substitution(15, [binding("next", vBad), binding("task", perfectRestoreTask)]).
proof(15, status(vBad, blockedTransition), rule(24), [uses(6, intends_task(vBad, perfectRestoreTask)), uses(14, status(perfectRestoreTask, impossibleTask))]).
substitution(16, [binding("x", vBad), binding("s", blockedTransition)]).
proof(16, solution([vBad, blockedTransition]), query, [uses(15, status(vBad, blockedTransition))]).
substitution(17, []).
proof(17, can_perform(writer, writeTask), rule(8), []).
substitution(18, []).
proof(18, can_perform(stabilizer, stabilizeTask), rule(9), []).
substitution(19, [binding("constructor", writer), binding("task", writeTask)]).
proof(19, retains_capacity_for(writer, writeTask), rule(20), [uses(17, can_perform(writer, writeTask))]).
substitution(20, [binding("constructor", stabilizer), binding("task", stabilizeTask)]).
proof(20, retains_capacity_for(stabilizer, stabilizeTask), rule(20), [uses(18, can_perform(stabilizer, stabilizeTask))]).
substitution(21, [binding("c", writer), binding("t", writeTask)]).
proof(21, solution([writer, writeTask]), query, [uses(19, retains_capacity_for(writer, writeTask))]).
substitution(22, [binding("c", stabilizer), binding("t", stabilizeTask)]).
proof(22, solution([stabilizer, stabilizeTask]), query, [uses(20, retains_capacity_for(stabilizer, stabilizeTask))]).
substitution(23, []).
proof(23, derives_from(v2, v1), rule(11), []).
substitution(24, []).
proof(24, derives_from(v3, v2), rule(13), []).
substitution(25, []).
proof(25, derives_from(vBad, damaged1), rule(16), []).
substitution(26, []).
proof(26, intends_task(v2, writeTask), rule(12), []).
substitution(27, []).
proof(27, intends_task(v3, stabilizeTask), rule(14), []).
substitution(28, []).
proof(28, intends_task(vBad, perfectRestoreTask), rule(17), []).
substitution(29, []).
proof(29, can_perform(writer, writeTask), rule(8), []).
substitution(30, []).
proof(30, can_perform(stabilizer, stabilizeTask), rule(9), []).
substitution(31, [binding("task", writeTask), binding("constructor", writer)]).
proof(31, status(writeTask, possibleTask), rule(19), [uses(29, can_perform(writer, writeTask))]).
substitution(32, [binding("task", stabilizeTask), binding("constructor", stabilizer)]).
proof(32, status(stabilizeTask, possibleTask), rule(19), [uses(30, can_perform(stabilizer, stabilizeTask))]).
substitution(33, []).
proof(33, task_input(writeTask, blankMemory), rule(1), []).
substitution(34, []).
proof(34, task_input(stabilizeTask, encodedMemory), rule(3), []).
substitution(35, []).
proof(35, has_attribute(v1, blankMemory), rule(10), []).
substitution(36, [binding("next", v2), binding("task", writeTask), binding("prev", v1), binding("in", blankMemory)]).
proof(36, can_undergo(v2, writeTask), rule(21), [uses(23, derives_from(v2, v1)), uses(26, intends_task(v2, writeTask)), uses(31, status(writeTask, possibleTask)), uses(33, task_input(writeTask, blankMemory)), uses(35, has_attribute(v1, blankMemory))]).
substitution(37, [binding("next", v2), binding("task", writeTask)]).
proof(37, solution([v2, writeTask]), query, [uses(36, can_undergo(v2, writeTask))]).
substitution(38, []).
proof(38, derives_from(v2, v1), rule(11), []).
substitution(39, [binding("next", v2), binding("task", writeTask), binding("prev", v1), binding("in", blankMemory)]).
proof(39, can_undergo(v2, writeTask), rule(21), [uses(38, derives_from(v2, v1)), uses(26, intends_task(v2, writeTask)), uses(31, status(writeTask, possibleTask)), uses(33, task_input(writeTask, blankMemory)), uses(35, has_attribute(v1, blankMemory))]).
substitution(40, []).
proof(40, task_output(writeTask, encodedMemory), rule(2), []).
substitution(41, [binding("next", v2), binding("out", encodedMemory), binding("task", writeTask)]).
proof(41, has_attribute(v2, encodedMemory), rule(23), [uses(39, can_undergo(v2, writeTask)), uses(40, task_output(writeTask, encodedMemory))]).
substitution(42, [binding("next", v3), binding("task", stabilizeTask), binding("prev", v2), binding("in", encodedMemory)]).
proof(42, can_undergo(v3, stabilizeTask), rule(21), [uses(24, derives_from(v3, v2)), uses(27, intends_task(v3, stabilizeTask)), uses(32, status(stabilizeTask, possibleTask)), uses(34, task_input(stabilizeTask, encodedMemory)), uses(41, has_attribute(v2, encodedMemory))]).
substitution(43, [binding("next", v3), binding("task", stabilizeTask)]).
proof(43, solution([v3, stabilizeTask]), query, [uses(42, can_undergo(v3, stabilizeTask))]).
substitution(44, []).
proof(44, derives_from(v2, v1), rule(11), []).
substitution(45, []).
proof(45, derives_from(v3, v2), rule(13), []).
substitution(46, []).
proof(46, derives_from(vBad, damaged1), rule(16), []).
substitution(47, []).
proof(47, intends_task(v2, writeTask), rule(12), []).
substitution(48, []).
proof(48, intends_task(v3, stabilizeTask), rule(14), []).
substitution(49, []).
proof(49, intends_task(vBad, perfectRestoreTask), rule(17), []).
substitution(50, []).
proof(50, can_perform(writer, writeTask), rule(8), []).
substitution(51, []).
proof(51, can_perform(stabilizer, stabilizeTask), rule(9), []).
substitution(52, [binding("task", writeTask), binding("constructor", writer)]).
proof(52, status(writeTask, possibleTask), rule(19), [uses(50, can_perform(writer, writeTask))]).
substitution(53, [binding("task", stabilizeTask), binding("constructor", stabilizer)]).
proof(53, status(stabilizeTask, possibleTask), rule(19), [uses(51, can_perform(stabilizer, stabilizeTask))]).
substitution(54, []).
proof(54, task_input(writeTask, blankMemory), rule(1), []).
substitution(55, []).
proof(55, task_input(stabilizeTask, encodedMemory), rule(3), []).
substitution(56, []).
proof(56, has_attribute(v1, blankMemory), rule(10), []).
substitution(57, [binding("next", v2), binding("prev", v1), binding("task", writeTask), binding("in", blankMemory)]).
proof(57, becomes_from(v2, v1), rule(22), [uses(44, derives_from(v2, v1)), uses(47, intends_task(v2, writeTask)), uses(52, status(writeTask, possibleTask)), uses(54, task_input(writeTask, blankMemory)), uses(56, has_attribute(v1, blankMemory))]).
substitution(58, [binding("next", v2), binding("prev", v1)]).
proof(58, solution([v2, v1]), query, [uses(57, becomes_from(v2, v1))]).
substitution(59, []).
proof(59, derives_from(v2, v1), rule(11), []).
substitution(60, [binding("next", v2), binding("task", writeTask), binding("prev", v1), binding("in", blankMemory)]).
proof(60, can_undergo(v2, writeTask), rule(21), [uses(59, derives_from(v2, v1)), uses(47, intends_task(v2, writeTask)), uses(52, status(writeTask, possibleTask)), uses(54, task_input(writeTask, blankMemory)), uses(56, has_attribute(v1, blankMemory))]).
substitution(61, []).
proof(61, task_output(writeTask, encodedMemory), rule(2), []).
substitution(62, [binding("next", v2), binding("out", encodedMemory), binding("task", writeTask)]).
proof(62, has_attribute(v2, encodedMemory), rule(23), [uses(60, can_undergo(v2, writeTask)), uses(61, task_output(writeTask, encodedMemory))]).
substitution(63, [binding("next", v3), binding("prev", v2), binding("task", stabilizeTask), binding("in", encodedMemory)]).
proof(63, becomes_from(v3, v2), rule(22), [uses(45, derives_from(v3, v2)), uses(48, intends_task(v3, stabilizeTask)), uses(53, status(stabilizeTask, possibleTask)), uses(55, task_input(stabilizeTask, encodedMemory)), uses(62, has_attribute(v2, encodedMemory))]).
substitution(64, [binding("next", v3), binding("prev", v2)]).
proof(64, solution([v3, v2]), query, [uses(63, becomes_from(v3, v2))]).
substitution(65, []).
proof(65, has_attribute(v1, blankMemory), rule(10), []).
substitution(66, []).
proof(66, has_attribute(damaged1, damagedMemory), rule(15), []).
substitution(67, [binding("x", v1), binding("attr", blankMemory)]).
proof(67, solution([v1, blankMemory]), query, [uses(65, has_attribute(v1, blankMemory))]).
substitution(68, [binding("x", damaged1), binding("attr", damagedMemory)]).
proof(68, solution([damaged1, damagedMemory]), query, [uses(66, has_attribute(damaged1, damagedMemory))]).
substitution(69, []).
proof(69, derives_from(v2, v1), rule(11), []).
substitution(70, []).
proof(70, derives_from(v3, v2), rule(13), []).
substitution(71, []).
proof(71, derives_from(vBad, damaged1), rule(16), []).
substitution(72, []).
proof(72, intends_task(v2, writeTask), rule(12), []).
substitution(73, []).
proof(73, intends_task(v3, stabilizeTask), rule(14), []).
substitution(74, []).
proof(74, intends_task(vBad, perfectRestoreTask), rule(17), []).
substitution(75, []).
proof(75, can_perform(writer, writeTask), rule(8), []).
substitution(76, []).
proof(76, can_perform(stabilizer, stabilizeTask), rule(9), []).
substitution(77, [binding("task", writeTask), binding("constructor", writer)]).
proof(77, status(writeTask, possibleTask), rule(19), [uses(75, can_perform(writer, writeTask))]).
substitution(78, [binding("task", stabilizeTask), binding("constructor", stabilizer)]).
proof(78, status(stabilizeTask, possibleTask), rule(19), [uses(76, can_perform(stabilizer, stabilizeTask))]).
substitution(79, []).
proof(79, task_input(writeTask, blankMemory), rule(1), []).
substitution(80, []).
proof(80, task_input(stabilizeTask, encodedMemory), rule(3), []).
substitution(81, []).
proof(81, has_attribute(v1, blankMemory), rule(10), []).
substitution(82, [binding("next", v2), binding("task", writeTask), binding("prev", v1), binding("in", blankMemory)]).
proof(82, can_undergo(v2, writeTask), rule(21), [uses(69, derives_from(v2, v1)), uses(72, intends_task(v2, writeTask)), uses(77, status(writeTask, possibleTask)), uses(79, task_input(writeTask, blankMemory)), uses(81, has_attribute(v1, blankMemory))]).
substitution(83, []).
proof(83, derives_from(v2, v1), rule(11), []).
substitution(84, []).
proof(84, task_output(writeTask, encodedMemory), rule(2), []).
substitution(85, [binding("next", v2), binding("task", writeTask), binding("prev", v1), binding("in", blankMemory)]).
proof(85, can_undergo(v2, writeTask), rule(21), [uses(83, derives_from(v2, v1)), uses(72, intends_task(v2, writeTask)), uses(77, status(writeTask, possibleTask)), uses(79, task_input(writeTask, blankMemory)), uses(81, has_attribute(v1, blankMemory))]).
substitution(86, [binding("next", v2), binding("out", encodedMemory), binding("task", writeTask)]).
proof(86, has_attribute(v2, encodedMemory), rule(23), [uses(82, can_undergo(v2, writeTask)), uses(84, task_output(writeTask, encodedMemory))]).
substitution(87, [binding("x", v2), binding("attr", encodedMemory)]).
proof(87, solution([v2, encodedMemory]), query, [uses(86, has_attribute(v2, encodedMemory))]).
substitution(88, []).
proof(88, task_output(writeTask, encodedMemory), rule(2), []).
substitution(89, [binding("next", v2), binding("out", encodedMemory), binding("task", writeTask)]).
proof(89, has_attribute(v2, encodedMemory), rule(23), [uses(85, can_undergo(v2, writeTask)), uses(88, task_output(writeTask, encodedMemory))]).
substitution(90, [binding("next", v3), binding("task", stabilizeTask), binding("prev", v2), binding("in", encodedMemory)]).
proof(90, can_undergo(v3, stabilizeTask), rule(21), [uses(70, derives_from(v3, v2)), uses(73, intends_task(v3, stabilizeTask)), uses(78, status(stabilizeTask, possibleTask)), uses(80, task_input(stabilizeTask, encodedMemory)), uses(89, has_attribute(v2, encodedMemory))]).
substitution(91, []).
proof(91, task_output(stabilizeTask, stabilizedMemory), rule(4), []).
substitution(92, [binding("next", v3), binding("out", stabilizedMemory), binding("task", stabilizeTask)]).
proof(92, has_attribute(v3, stabilizedMemory), rule(23), [uses(90, can_undergo(v3, stabilizeTask)), uses(91, task_output(stabilizeTask, stabilizedMemory))]).
substitution(93, [binding("x", v3), binding("attr", stabilizedMemory)]).
proof(93, solution([v3, stabilizedMemory]), query, [uses(92, has_attribute(v3, stabilizedMemory))]).
substitution(94, []).
proof(94, has_attribute(v1, blankMemory), rule(10), []).
substitution(95, []).
proof(95, has_attribute(damaged1, damagedMemory), rule(15), []).
substitution(96, [binding("next", v1), binding("attr", blankMemory)]).
proof(96, available_for_further_task(v1, yes), rule(25), [uses(94, has_attribute(v1, blankMemory))]).
substitution(97, [binding("next", damaged1), binding("attr", damagedMemory)]).
proof(97, available_for_further_task(damaged1, yes), rule(25), [uses(95, has_attribute(damaged1, damagedMemory))]).
substitution(98, [binding("x", v1), binding("y", yes)]).
proof(98, solution([v1, yes]), query, [uses(96, available_for_further_task(v1, yes))]).
substitution(99, [binding("x", damaged1), binding("y", yes)]).
proof(99, solution([damaged1, yes]), query, [uses(97, available_for_further_task(damaged1, yes))]).
substitution(100, []).
proof(100, derives_from(v2, v1), rule(11), []).
substitution(101, []).
proof(101, derives_from(v3, v2), rule(13), []).
substitution(102, []).
proof(102, derives_from(vBad, damaged1), rule(16), []).
substitution(103, []).
proof(103, intends_task(v2, writeTask), rule(12), []).
substitution(104, []).
proof(104, intends_task(v3, stabilizeTask), rule(14), []).
substitution(105, []).
proof(105, intends_task(vBad, perfectRestoreTask), rule(17), []).
substitution(106, []).
proof(106, can_perform(writer, writeTask), rule(8), []).
substitution(107, []).
proof(107, can_perform(stabilizer, stabilizeTask), rule(9), []).
substitution(108, [binding("task", writeTask), binding("constructor", writer)]).
proof(108, status(writeTask, possibleTask), rule(19), [uses(106, can_perform(writer, writeTask))]).
substitution(109, [binding("task", stabilizeTask), binding("constructor", stabilizer)]).
proof(109, status(stabilizeTask, possibleTask), rule(19), [uses(107, can_perform(stabilizer, stabilizeTask))]).
substitution(110, []).
proof(110, task_input(writeTask, blankMemory), rule(1), []).
substitution(111, []).
proof(111, task_input(stabilizeTask, encodedMemory), rule(3), []).
substitution(112, []).
proof(112, has_attribute(v1, blankMemory), rule(10), []).
substitution(113, [binding("next", v2), binding("task", writeTask), binding("prev", v1), binding("in", blankMemory)]).
proof(113, can_undergo(v2, writeTask), rule(21), [uses(100, derives_from(v2, v1)), uses(103, intends_task(v2, writeTask)), uses(108, status(writeTask, possibleTask)), uses(110, task_input(writeTask, blankMemory)), uses(112, has_attribute(v1, blankMemory))]).
substitution(114, []).
proof(114, derives_from(v2, v1), rule(11), []).
substitution(115, []).
proof(115, task_output(writeTask, encodedMemory), rule(2), []).
substitution(116, [binding("next", v2), binding("task", writeTask), binding("prev", v1), binding("in", blankMemory)]).
proof(116, can_undergo(v2, writeTask), rule(21), [uses(114, derives_from(v2, v1)), uses(103, intends_task(v2, writeTask)), uses(108, status(writeTask, possibleTask)), uses(110, task_input(writeTask, blankMemory)), uses(112, has_attribute(v1, blankMemory))]).
substitution(117, [binding("next", v2), binding("out", encodedMemory), binding("task", writeTask)]).
proof(117, has_attribute(v2, encodedMemory), rule(23), [uses(113, can_undergo(v2, writeTask)), uses(115, task_output(writeTask, encodedMemory))]).
substitution(118, [binding("next", v2), binding("attr", encodedMemory)]).
proof(118, available_for_further_task(v2, yes), rule(25), [uses(117, has_attribute(v2, encodedMemory))]).
substitution(119, []).
proof(119, task_output(writeTask, encodedMemory), rule(2), []).
substitution(120, [binding("x", v2), binding("y", yes)]).
proof(120, solution([v2, yes]), query, [uses(118, available_for_further_task(v2, yes))]).
substitution(121, [binding("next", v2), binding("out", encodedMemory), binding("task", writeTask)]).
proof(121, has_attribute(v2, encodedMemory), rule(23), [uses(116, can_undergo(v2, writeTask)), uses(119, task_output(writeTask, encodedMemory))]).
substitution(122, [binding("next", v3), binding("task", stabilizeTask), binding("prev", v2), binding("in", encodedMemory)]).
proof(122, can_undergo(v3, stabilizeTask), rule(21), [uses(101, derives_from(v3, v2)), uses(104, intends_task(v3, stabilizeTask)), uses(109, status(stabilizeTask, possibleTask)), uses(111, task_input(stabilizeTask, encodedMemory)), uses(121, has_attribute(v2, encodedMemory))]).
substitution(123, []).
proof(123, task_output(stabilizeTask, stabilizedMemory), rule(4), []).
substitution(124, [binding("next", v3), binding("out", stabilizedMemory), binding("task", stabilizeTask)]).
proof(124, has_attribute(v3, stabilizedMemory), rule(23), [uses(122, can_undergo(v3, stabilizeTask)), uses(123, task_output(stabilizeTask, stabilizedMemory))]).
substitution(125, [binding("next", v3), binding("attr", stabilizedMemory)]).
proof(125, available_for_further_task(v3, yes), rule(25), [uses(124, has_attribute(v3, stabilizedMemory))]).
substitution(126, [binding("x", v3), binding("y", yes)]).
proof(126, solution([v3, yes]), query, [uses(125, available_for_further_task(v3, yes))]).
