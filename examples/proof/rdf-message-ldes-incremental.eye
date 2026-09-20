# Eyelang result format 2
query(1, [call(already_committed(?v0))], [binding("m", ?v0)]).
result(1, complete, 2).
answer(1, [binding("m", obs033)]).
why(1, [binding("m", obs033)], 12).
answer(1, [binding("m", obs034)]).
why(1, [binding("m", obs034)], 13).
query(2, [call(newly_emitted(?v0))], [binding("m", ?v0)]).
result(2, complete, 6).
answer(2, [binding("m", obs035)]).
why(2, [binding("m", obs035)], 29).
answer(2, [binding("m", obs036)]).
why(2, [binding("m", obs036)], 30).
answer(2, [binding("m", obs037)]).
why(2, [binding("m", obs037)], 31).
answer(2, [binding("m", obs038)]).
why(2, [binding("m", obs038)], 32).
answer(2, [binding("m", obs039)]).
why(2, [binding("m", obs039)], 33).
answer(2, [binding("m", obs040)]).
why(2, [binding("m", obs040)], 34).
query(3, [call(in_window(?v0))], [binding("m", ?v0)]).
result(3, complete, 6).
answer(3, [binding("m", obs035)]).
why(3, [binding("m", obs035)], 63).
answer(3, [binding("m", obs036)]).
why(3, [binding("m", obs036)], 64).
answer(3, [binding("m", obs037)]).
why(3, [binding("m", obs037)], 65).
answer(3, [binding("m", obs038)]).
why(3, [binding("m", obs038)], 66).
answer(3, [binding("m", obs039)]).
why(3, [binding("m", obs039)], 67).
answer(3, [binding("m", obs040)]).
why(3, [binding("m", obs040)], 68).
query(4, [call(raw_conflict(?v0))], [binding("door", ?v0)]).
result(4, complete, 1).
answer(4, [binding("door", doorA)]).
why(4, [binding("door", doorA)], 104).
query(5, [call(preferred_repair(?v0, ?v1, ?v2, ?v3))], [binding("m", ?v0), binding("state", ?v1), binding("priority", ?v2), binding("source", ?v3)]).
result(5, complete, 1).
answer(5, [binding("m", obs040), binding("state", closed), binding("priority", 5), binding("source", "safety-controller")]).
why(5, [binding("m", obs040), binding("state", closed), binding("priority", 5), binding("source", "safety-controller")], 134).
query(6, [call(materialized_action(?v0))], [binding("text", ?v0)]).
result(6, complete, 1).
answer(6, [binding("text", "keep the compartment sealed and continue monitoring")]).
why(6, [binding("text", "keep the compartment sealed and continue monitoring")], 166).
clause(1, member(obs033, 33, closed, 1, "hallway-latch"), []).
clause(2, member(obs034, 34, closed, 1, "hallway-latch"), []).
clause(3, member(obs035, 35, closed, 1, "hallway-latch"), []).
clause(4, member(obs036, 36, closed, 1, "hallway-latch"), []).
clause(5, member(obs037, 37, open, 1, "corridor-camera"), []).
clause(6, member(obs038, 38, open, 1, "thermal-edge-camera"), []).
clause(7, member(obs039, 39, closed, 1, "hallway-latch"), []).
clause(8, member(obs040, 40, closed, 5, "safety-controller"), []).
clause(10, action_text(closed, "keep the compartment sealed and continue monitoring"), []).
clause(11, bookmark(34), []).
clause(12, window_start(35), []).
clause(13, already_committed(var("m")), [call(member(var("m"), var("seq"), anonymous(1), anonymous(2), anonymous(3))), call(bookmark(var("b"))), compare("<=", var("seq"), var("b"))]).
clause(14, newly_emitted(var("m")), [call(member(var("m"), var("seq"), anonymous(1), anonymous(2), anonymous(3))), call(bookmark(var("b"))), compare(">", var("seq"), var("b"))]).
clause(15, in_window(var("m")), [call(newly_emitted(var("m"))), call(member(var("m"), var("seq"), anonymous(1), anonymous(2), anonymous(3))), call(window_start(var("w"))), compare(">=", var("seq"), var("w"))]).
clause(16, raw_conflict(doorA), [call(in_window(var("m1"))), call(member(var("m1"), anonymous(1), open, anonymous(2), anonymous(3))), call(in_window(var("m2"))), call(member(var("m2"), anonymous(4), closed, anonymous(5), anonymous(6)))]).
clause(17, preferred_repair(var("m"), var("state"), var("priority"), var("source")), [call(in_window(var("m"))), call(member(var("m"), anonymous(1), var("state"), var("priority"), var("source"))), call(in_window(var("other"))), call(member(var("other"), anonymous(2), var("otherState"), var("otherPriority"), anonymous(3))), compare("!=", var("state"), var("otherState")), compare(">", var("priority"), var("otherPriority"))]).
clause(18, materialized_action(var("text")), [call(preferred_repair(anonymous(1), var("state"), anonymous(2), anonymous(3))), call(action_text(var("state"), var("text")))]).
substitution(1, []).
proof(1, member(obs033, 33, closed, 1, "hallway-latch"), rule(1), []).
substitution(2, []).
proof(2, member(obs034, 34, closed, 1, "hallway-latch"), rule(2), []).
substitution(3, []).
proof(3, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(4, []).
proof(4, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(5, []).
proof(5, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(6, []).
proof(6, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(7, []).
proof(7, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(8, []).
proof(8, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(9, []).
proof(9, bookmark(34), rule(11), []).
substitution(10, [binding("m", obs033), binding("seq", 33), binding("b", 34)]).
proof(10, already_committed(obs033), rule(13), [uses(1, member(obs033, 33, closed, 1, "hallway-latch")), uses(9, bookmark(34)), compared("<=", 33, 34)]).
substitution(11, [binding("m", obs034), binding("seq", 34), binding("b", 34)]).
proof(11, already_committed(obs034), rule(13), [uses(2, member(obs034, 34, closed, 1, "hallway-latch")), uses(9, bookmark(34)), compared("<=", 34, 34)]).
substitution(12, [binding("m", obs033)]).
proof(12, solution([obs033]), query, [uses(10, already_committed(obs033))]).
substitution(13, [binding("m", obs034)]).
proof(13, solution([obs034]), query, [uses(11, already_committed(obs034))]).
substitution(14, []).
proof(14, member(obs033, 33, closed, 1, "hallway-latch"), rule(1), []).
substitution(15, []).
proof(15, member(obs034, 34, closed, 1, "hallway-latch"), rule(2), []).
substitution(16, []).
proof(16, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(17, []).
proof(17, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(18, []).
proof(18, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(19, []).
proof(19, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(20, []).
proof(20, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(21, []).
proof(21, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(22, []).
proof(22, bookmark(34), rule(11), []).
substitution(23, [binding("m", obs035), binding("seq", 35), binding("b", 34)]).
proof(23, newly_emitted(obs035), rule(14), [uses(16, member(obs035, 35, closed, 1, "hallway-latch")), uses(22, bookmark(34)), compared(">", 35, 34)]).
substitution(24, [binding("m", obs036), binding("seq", 36), binding("b", 34)]).
proof(24, newly_emitted(obs036), rule(14), [uses(17, member(obs036, 36, closed, 1, "hallway-latch")), uses(22, bookmark(34)), compared(">", 36, 34)]).
substitution(25, [binding("m", obs037), binding("seq", 37), binding("b", 34)]).
proof(25, newly_emitted(obs037), rule(14), [uses(18, member(obs037, 37, open, 1, "corridor-camera")), uses(22, bookmark(34)), compared(">", 37, 34)]).
substitution(26, [binding("m", obs038), binding("seq", 38), binding("b", 34)]).
proof(26, newly_emitted(obs038), rule(14), [uses(19, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(22, bookmark(34)), compared(">", 38, 34)]).
substitution(27, [binding("m", obs039), binding("seq", 39), binding("b", 34)]).
proof(27, newly_emitted(obs039), rule(14), [uses(20, member(obs039, 39, closed, 1, "hallway-latch")), uses(22, bookmark(34)), compared(">", 39, 34)]).
substitution(28, [binding("m", obs040), binding("seq", 40), binding("b", 34)]).
proof(28, newly_emitted(obs040), rule(14), [uses(21, member(obs040, 40, closed, 5, "safety-controller")), uses(22, bookmark(34)), compared(">", 40, 34)]).
substitution(29, [binding("m", obs035)]).
proof(29, solution([obs035]), query, [uses(23, newly_emitted(obs035))]).
substitution(30, [binding("m", obs036)]).
proof(30, solution([obs036]), query, [uses(24, newly_emitted(obs036))]).
substitution(31, [binding("m", obs037)]).
proof(31, solution([obs037]), query, [uses(25, newly_emitted(obs037))]).
substitution(32, [binding("m", obs038)]).
proof(32, solution([obs038]), query, [uses(26, newly_emitted(obs038))]).
substitution(33, [binding("m", obs039)]).
proof(33, solution([obs039]), query, [uses(27, newly_emitted(obs039))]).
substitution(34, [binding("m", obs040)]).
proof(34, solution([obs040]), query, [uses(28, newly_emitted(obs040))]).
substitution(35, []).
proof(35, member(obs033, 33, closed, 1, "hallway-latch"), rule(1), []).
substitution(36, []).
proof(36, member(obs034, 34, closed, 1, "hallway-latch"), rule(2), []).
substitution(37, []).
proof(37, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(38, []).
proof(38, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(39, []).
proof(39, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(40, []).
proof(40, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(41, []).
proof(41, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(42, []).
proof(42, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(43, []).
proof(43, bookmark(34), rule(11), []).
substitution(44, [binding("m", obs035), binding("seq", 35), binding("b", 34)]).
proof(44, newly_emitted(obs035), rule(14), [uses(37, member(obs035, 35, closed, 1, "hallway-latch")), uses(43, bookmark(34)), compared(">", 35, 34)]).
substitution(45, [binding("m", obs036), binding("seq", 36), binding("b", 34)]).
proof(45, newly_emitted(obs036), rule(14), [uses(38, member(obs036, 36, closed, 1, "hallway-latch")), uses(43, bookmark(34)), compared(">", 36, 34)]).
substitution(46, [binding("m", obs037), binding("seq", 37), binding("b", 34)]).
proof(46, newly_emitted(obs037), rule(14), [uses(39, member(obs037, 37, open, 1, "corridor-camera")), uses(43, bookmark(34)), compared(">", 37, 34)]).
substitution(47, [binding("m", obs038), binding("seq", 38), binding("b", 34)]).
proof(47, newly_emitted(obs038), rule(14), [uses(40, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(43, bookmark(34)), compared(">", 38, 34)]).
substitution(48, [binding("m", obs039), binding("seq", 39), binding("b", 34)]).
proof(48, newly_emitted(obs039), rule(14), [uses(41, member(obs039, 39, closed, 1, "hallway-latch")), uses(43, bookmark(34)), compared(">", 39, 34)]).
substitution(49, [binding("m", obs040), binding("seq", 40), binding("b", 34)]).
proof(49, newly_emitted(obs040), rule(14), [uses(42, member(obs040, 40, closed, 5, "safety-controller")), uses(43, bookmark(34)), compared(">", 40, 34)]).
substitution(50, []).
proof(50, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(51, []).
proof(51, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(52, []).
proof(52, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(53, []).
proof(53, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(54, []).
proof(54, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(55, []).
proof(55, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(56, []).
proof(56, window_start(35), rule(12), []).
substitution(57, [binding("m", obs035), binding("seq", 35), binding("w", 35)]).
proof(57, in_window(obs035), rule(15), [uses(44, newly_emitted(obs035)), uses(50, member(obs035, 35, closed, 1, "hallway-latch")), uses(56, window_start(35)), compared(">=", 35, 35)]).
substitution(58, [binding("m", obs036), binding("seq", 36), binding("w", 35)]).
proof(58, in_window(obs036), rule(15), [uses(45, newly_emitted(obs036)), uses(51, member(obs036, 36, closed, 1, "hallway-latch")), uses(56, window_start(35)), compared(">=", 36, 35)]).
substitution(59, [binding("m", obs037), binding("seq", 37), binding("w", 35)]).
proof(59, in_window(obs037), rule(15), [uses(46, newly_emitted(obs037)), uses(52, member(obs037, 37, open, 1, "corridor-camera")), uses(56, window_start(35)), compared(">=", 37, 35)]).
substitution(60, [binding("m", obs038), binding("seq", 38), binding("w", 35)]).
proof(60, in_window(obs038), rule(15), [uses(47, newly_emitted(obs038)), uses(53, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(56, window_start(35)), compared(">=", 38, 35)]).
substitution(61, [binding("m", obs039), binding("seq", 39), binding("w", 35)]).
proof(61, in_window(obs039), rule(15), [uses(48, newly_emitted(obs039)), uses(54, member(obs039, 39, closed, 1, "hallway-latch")), uses(56, window_start(35)), compared(">=", 39, 35)]).
substitution(62, [binding("m", obs040), binding("seq", 40), binding("w", 35)]).
proof(62, in_window(obs040), rule(15), [uses(49, newly_emitted(obs040)), uses(55, member(obs040, 40, closed, 5, "safety-controller")), uses(56, window_start(35)), compared(">=", 40, 35)]).
substitution(63, [binding("m", obs035)]).
proof(63, solution([obs035]), query, [uses(57, in_window(obs035))]).
substitution(64, [binding("m", obs036)]).
proof(64, solution([obs036]), query, [uses(58, in_window(obs036))]).
substitution(65, [binding("m", obs037)]).
proof(65, solution([obs037]), query, [uses(59, in_window(obs037))]).
substitution(66, [binding("m", obs038)]).
proof(66, solution([obs038]), query, [uses(60, in_window(obs038))]).
substitution(67, [binding("m", obs039)]).
proof(67, solution([obs039]), query, [uses(61, in_window(obs039))]).
substitution(68, [binding("m", obs040)]).
proof(68, solution([obs040]), query, [uses(62, in_window(obs040))]).
substitution(69, []).
proof(69, member(obs033, 33, closed, 1, "hallway-latch"), rule(1), []).
substitution(70, []).
proof(70, member(obs034, 34, closed, 1, "hallway-latch"), rule(2), []).
substitution(71, []).
proof(71, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(72, []).
proof(72, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(73, []).
proof(73, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(74, []).
proof(74, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(75, []).
proof(75, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(76, []).
proof(76, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(77, []).
proof(77, bookmark(34), rule(11), []).
substitution(78, [binding("m", obs035), binding("seq", 35), binding("b", 34)]).
proof(78, newly_emitted(obs035), rule(14), [uses(71, member(obs035, 35, closed, 1, "hallway-latch")), uses(77, bookmark(34)), compared(">", 35, 34)]).
substitution(79, [binding("m", obs036), binding("seq", 36), binding("b", 34)]).
proof(79, newly_emitted(obs036), rule(14), [uses(72, member(obs036, 36, closed, 1, "hallway-latch")), uses(77, bookmark(34)), compared(">", 36, 34)]).
substitution(80, [binding("m", obs037), binding("seq", 37), binding("b", 34)]).
proof(80, newly_emitted(obs037), rule(14), [uses(73, member(obs037, 37, open, 1, "corridor-camera")), uses(77, bookmark(34)), compared(">", 37, 34)]).
substitution(81, [binding("m", obs038), binding("seq", 38), binding("b", 34)]).
proof(81, newly_emitted(obs038), rule(14), [uses(74, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(77, bookmark(34)), compared(">", 38, 34)]).
substitution(82, [binding("m", obs039), binding("seq", 39), binding("b", 34)]).
proof(82, newly_emitted(obs039), rule(14), [uses(75, member(obs039, 39, closed, 1, "hallway-latch")), uses(77, bookmark(34)), compared(">", 39, 34)]).
substitution(83, [binding("m", obs040), binding("seq", 40), binding("b", 34)]).
proof(83, newly_emitted(obs040), rule(14), [uses(76, member(obs040, 40, closed, 5, "safety-controller")), uses(77, bookmark(34)), compared(">", 40, 34)]).
substitution(84, []).
proof(84, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(85, []).
proof(85, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(86, []).
proof(86, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(87, []).
proof(87, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(88, []).
proof(88, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(89, []).
proof(89, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(90, []).
proof(90, window_start(35), rule(12), []).
substitution(91, [binding("m", obs035), binding("seq", 35), binding("w", 35)]).
proof(91, in_window(obs035), rule(15), [uses(78, newly_emitted(obs035)), uses(84, member(obs035, 35, closed, 1, "hallway-latch")), uses(90, window_start(35)), compared(">=", 35, 35)]).
substitution(92, [binding("m", obs036), binding("seq", 36), binding("w", 35)]).
proof(92, in_window(obs036), rule(15), [uses(79, newly_emitted(obs036)), uses(85, member(obs036, 36, closed, 1, "hallway-latch")), uses(90, window_start(35)), compared(">=", 36, 35)]).
substitution(93, [binding("m", obs037), binding("seq", 37), binding("w", 35)]).
proof(93, in_window(obs037), rule(15), [uses(80, newly_emitted(obs037)), uses(86, member(obs037, 37, open, 1, "corridor-camera")), uses(90, window_start(35)), compared(">=", 37, 35)]).
substitution(94, [binding("m", obs038), binding("seq", 38), binding("w", 35)]).
proof(94, in_window(obs038), rule(15), [uses(81, newly_emitted(obs038)), uses(87, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(90, window_start(35)), compared(">=", 38, 35)]).
substitution(95, [binding("m", obs039), binding("seq", 39), binding("w", 35)]).
proof(95, in_window(obs039), rule(15), [uses(82, newly_emitted(obs039)), uses(88, member(obs039, 39, closed, 1, "hallway-latch")), uses(90, window_start(35)), compared(">=", 39, 35)]).
substitution(96, [binding("m", obs040), binding("seq", 40), binding("w", 35)]).
proof(96, in_window(obs040), rule(15), [uses(83, newly_emitted(obs040)), uses(89, member(obs040, 40, closed, 5, "safety-controller")), uses(90, window_start(35)), compared(">=", 40, 35)]).
substitution(97, []).
proof(97, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(98, []).
proof(98, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(99, []).
proof(99, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(100, []).
proof(100, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(101, []).
proof(101, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(102, []).
proof(102, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(103, [binding("m1", obs037), binding("m2", obs035)]).
proof(103, raw_conflict(doorA), rule(16), [uses(93, in_window(obs037)), uses(97, member(obs037, 37, open, 1, "corridor-camera")), uses(91, in_window(obs035)), uses(99, member(obs035, 35, closed, 1, "hallway-latch"))]).
substitution(104, [binding("door", doorA)]).
proof(104, solution([doorA]), query, [uses(103, raw_conflict(doorA))]).
substitution(105, []).
proof(105, member(obs033, 33, closed, 1, "hallway-latch"), rule(1), []).
substitution(106, []).
proof(106, member(obs034, 34, closed, 1, "hallway-latch"), rule(2), []).
substitution(107, []).
proof(107, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(108, []).
proof(108, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(109, []).
proof(109, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(110, []).
proof(110, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(111, []).
proof(111, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(112, []).
proof(112, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(113, []).
proof(113, bookmark(34), rule(11), []).
substitution(114, [binding("m", obs035), binding("seq", 35), binding("b", 34)]).
proof(114, newly_emitted(obs035), rule(14), [uses(107, member(obs035, 35, closed, 1, "hallway-latch")), uses(113, bookmark(34)), compared(">", 35, 34)]).
substitution(115, [binding("m", obs036), binding("seq", 36), binding("b", 34)]).
proof(115, newly_emitted(obs036), rule(14), [uses(108, member(obs036, 36, closed, 1, "hallway-latch")), uses(113, bookmark(34)), compared(">", 36, 34)]).
substitution(116, [binding("m", obs037), binding("seq", 37), binding("b", 34)]).
proof(116, newly_emitted(obs037), rule(14), [uses(109, member(obs037, 37, open, 1, "corridor-camera")), uses(113, bookmark(34)), compared(">", 37, 34)]).
substitution(117, [binding("m", obs038), binding("seq", 38), binding("b", 34)]).
proof(117, newly_emitted(obs038), rule(14), [uses(110, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(113, bookmark(34)), compared(">", 38, 34)]).
substitution(118, [binding("m", obs039), binding("seq", 39), binding("b", 34)]).
proof(118, newly_emitted(obs039), rule(14), [uses(111, member(obs039, 39, closed, 1, "hallway-latch")), uses(113, bookmark(34)), compared(">", 39, 34)]).
substitution(119, [binding("m", obs040), binding("seq", 40), binding("b", 34)]).
proof(119, newly_emitted(obs040), rule(14), [uses(112, member(obs040, 40, closed, 5, "safety-controller")), uses(113, bookmark(34)), compared(">", 40, 34)]).
substitution(120, []).
proof(120, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(121, []).
proof(121, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(122, []).
proof(122, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(123, []).
proof(123, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(124, []).
proof(124, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(125, []).
proof(125, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(126, []).
proof(126, window_start(35), rule(12), []).
substitution(127, [binding("m", obs035), binding("seq", 35), binding("w", 35)]).
proof(127, in_window(obs035), rule(15), [uses(114, newly_emitted(obs035)), uses(120, member(obs035, 35, closed, 1, "hallway-latch")), uses(126, window_start(35)), compared(">=", 35, 35)]).
substitution(128, [binding("m", obs036), binding("seq", 36), binding("w", 35)]).
proof(128, in_window(obs036), rule(15), [uses(115, newly_emitted(obs036)), uses(121, member(obs036, 36, closed, 1, "hallway-latch")), uses(126, window_start(35)), compared(">=", 36, 35)]).
substitution(129, [binding("m", obs037), binding("seq", 37), binding("w", 35)]).
proof(129, in_window(obs037), rule(15), [uses(116, newly_emitted(obs037)), uses(122, member(obs037, 37, open, 1, "corridor-camera")), uses(126, window_start(35)), compared(">=", 37, 35)]).
substitution(130, [binding("m", obs038), binding("seq", 38), binding("w", 35)]).
proof(130, in_window(obs038), rule(15), [uses(117, newly_emitted(obs038)), uses(123, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(126, window_start(35)), compared(">=", 38, 35)]).
substitution(131, [binding("m", obs039), binding("seq", 39), binding("w", 35)]).
proof(131, in_window(obs039), rule(15), [uses(118, newly_emitted(obs039)), uses(124, member(obs039, 39, closed, 1, "hallway-latch")), uses(126, window_start(35)), compared(">=", 39, 35)]).
substitution(132, [binding("m", obs040), binding("seq", 40), binding("w", 35)]).
proof(132, in_window(obs040), rule(15), [uses(119, newly_emitted(obs040)), uses(125, member(obs040, 40, closed, 5, "safety-controller")), uses(126, window_start(35)), compared(">=", 40, 35)]).
substitution(133, [binding("m", obs040), binding("state", closed), binding("priority", 5), binding("source", "safety-controller"), binding("other", obs037), binding("otherState", open), binding("otherPriority", 1)]).
proof(133, preferred_repair(obs040, closed, 5, "safety-controller"), rule(17), [uses(132, in_window(obs040)), uses(125, member(obs040, 40, closed, 5, "safety-controller")), uses(129, in_window(obs037)), uses(122, member(obs037, 37, open, 1, "corridor-camera")), compared("!=", closed, open), compared(">", 5, 1)]).
substitution(134, [binding("m", obs040), binding("state", closed), binding("priority", 5), binding("source", "safety-controller")]).
proof(134, solution([obs040, closed, 5, "safety-controller"]), query, [uses(133, preferred_repair(obs040, closed, 5, "safety-controller"))]).
substitution(135, []).
proof(135, member(obs033, 33, closed, 1, "hallway-latch"), rule(1), []).
substitution(136, []).
proof(136, member(obs034, 34, closed, 1, "hallway-latch"), rule(2), []).
substitution(137, []).
proof(137, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(138, []).
proof(138, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(139, []).
proof(139, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(140, []).
proof(140, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(141, []).
proof(141, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(142, []).
proof(142, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(143, []).
proof(143, bookmark(34), rule(11), []).
substitution(144, [binding("m", obs035), binding("seq", 35), binding("b", 34)]).
proof(144, newly_emitted(obs035), rule(14), [uses(137, member(obs035, 35, closed, 1, "hallway-latch")), uses(143, bookmark(34)), compared(">", 35, 34)]).
substitution(145, [binding("m", obs036), binding("seq", 36), binding("b", 34)]).
proof(145, newly_emitted(obs036), rule(14), [uses(138, member(obs036, 36, closed, 1, "hallway-latch")), uses(143, bookmark(34)), compared(">", 36, 34)]).
substitution(146, [binding("m", obs037), binding("seq", 37), binding("b", 34)]).
proof(146, newly_emitted(obs037), rule(14), [uses(139, member(obs037, 37, open, 1, "corridor-camera")), uses(143, bookmark(34)), compared(">", 37, 34)]).
substitution(147, [binding("m", obs038), binding("seq", 38), binding("b", 34)]).
proof(147, newly_emitted(obs038), rule(14), [uses(140, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(143, bookmark(34)), compared(">", 38, 34)]).
substitution(148, [binding("m", obs039), binding("seq", 39), binding("b", 34)]).
proof(148, newly_emitted(obs039), rule(14), [uses(141, member(obs039, 39, closed, 1, "hallway-latch")), uses(143, bookmark(34)), compared(">", 39, 34)]).
substitution(149, [binding("m", obs040), binding("seq", 40), binding("b", 34)]).
proof(149, newly_emitted(obs040), rule(14), [uses(142, member(obs040, 40, closed, 5, "safety-controller")), uses(143, bookmark(34)), compared(">", 40, 34)]).
substitution(150, []).
proof(150, member(obs035, 35, closed, 1, "hallway-latch"), rule(3), []).
substitution(151, []).
proof(151, member(obs036, 36, closed, 1, "hallway-latch"), rule(4), []).
substitution(152, []).
proof(152, member(obs037, 37, open, 1, "corridor-camera"), rule(5), []).
substitution(153, []).
proof(153, member(obs038, 38, open, 1, "thermal-edge-camera"), rule(6), []).
substitution(154, []).
proof(154, member(obs039, 39, closed, 1, "hallway-latch"), rule(7), []).
substitution(155, []).
proof(155, member(obs040, 40, closed, 5, "safety-controller"), rule(8), []).
substitution(156, []).
proof(156, window_start(35), rule(12), []).
substitution(157, [binding("m", obs035), binding("seq", 35), binding("w", 35)]).
proof(157, in_window(obs035), rule(15), [uses(144, newly_emitted(obs035)), uses(150, member(obs035, 35, closed, 1, "hallway-latch")), uses(156, window_start(35)), compared(">=", 35, 35)]).
substitution(158, [binding("m", obs036), binding("seq", 36), binding("w", 35)]).
proof(158, in_window(obs036), rule(15), [uses(145, newly_emitted(obs036)), uses(151, member(obs036, 36, closed, 1, "hallway-latch")), uses(156, window_start(35)), compared(">=", 36, 35)]).
substitution(159, [binding("m", obs037), binding("seq", 37), binding("w", 35)]).
proof(159, in_window(obs037), rule(15), [uses(146, newly_emitted(obs037)), uses(152, member(obs037, 37, open, 1, "corridor-camera")), uses(156, window_start(35)), compared(">=", 37, 35)]).
substitution(160, [binding("m", obs038), binding("seq", 38), binding("w", 35)]).
proof(160, in_window(obs038), rule(15), [uses(147, newly_emitted(obs038)), uses(153, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(156, window_start(35)), compared(">=", 38, 35)]).
substitution(161, [binding("m", obs039), binding("seq", 39), binding("w", 35)]).
proof(161, in_window(obs039), rule(15), [uses(148, newly_emitted(obs039)), uses(154, member(obs039, 39, closed, 1, "hallway-latch")), uses(156, window_start(35)), compared(">=", 39, 35)]).
substitution(162, [binding("m", obs040), binding("seq", 40), binding("w", 35)]).
proof(162, in_window(obs040), rule(15), [uses(149, newly_emitted(obs040)), uses(155, member(obs040, 40, closed, 5, "safety-controller")), uses(156, window_start(35)), compared(">=", 40, 35)]).
substitution(163, [binding("m", obs040), binding("state", closed), binding("priority", 5), binding("source", "safety-controller"), binding("other", obs037), binding("otherState", open), binding("otherPriority", 1)]).
proof(163, preferred_repair(obs040, closed, 5, "safety-controller"), rule(17), [uses(162, in_window(obs040)), uses(155, member(obs040, 40, closed, 5, "safety-controller")), uses(159, in_window(obs037)), uses(152, member(obs037, 37, open, 1, "corridor-camera")), compared("!=", closed, open), compared(">", 5, 1)]).
substitution(164, []).
proof(164, action_text(closed, "keep the compartment sealed and continue monitoring"), rule(10), []).
substitution(165, [binding("text", "keep the compartment sealed and continue monitoring"), binding("state", closed)]).
proof(165, materialized_action("keep the compartment sealed and continue monitoring"), rule(18), [uses(163, preferred_repair(obs040, closed, 5, "safety-controller")), uses(164, action_text(closed, "keep the compartment sealed and continue monitoring"))]).
substitution(166, [binding("text", "keep the compartment sealed and continue monitoring")]).
proof(166, solution(["keep the compartment sealed and continue monitoring"]), query, [uses(165, materialized_action("keep the compartment sealed and continue monitoring"))]).
