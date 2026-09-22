% Prolog result format 3
query(1, already_committed(_0), ['M' = _0]).
result(1, complete, 2).
answer(1, ['M' = obs033]).
why(1, ['M' = obs033], 12).
answer(1, ['M' = obs034]).
why(1, ['M' = obs034], 13).
query(2, newly_emitted(_0), ['M' = _0]).
result(2, complete, 6).
answer(2, ['M' = obs035]).
why(2, ['M' = obs035], 29).
answer(2, ['M' = obs036]).
why(2, ['M' = obs036], 30).
answer(2, ['M' = obs037]).
why(2, ['M' = obs037], 31).
answer(2, ['M' = obs038]).
why(2, ['M' = obs038], 32).
answer(2, ['M' = obs039]).
why(2, ['M' = obs039], 33).
answer(2, ['M' = obs040]).
why(2, ['M' = obs040], 34).
query(3, in_window(_0), ['M' = _0]).
result(3, complete, 6).
answer(3, ['M' = obs035]).
why(3, ['M' = obs035], 63).
answer(3, ['M' = obs036]).
why(3, ['M' = obs036], 64).
answer(3, ['M' = obs037]).
why(3, ['M' = obs037], 65).
answer(3, ['M' = obs038]).
why(3, ['M' = obs038], 66).
answer(3, ['M' = obs039]).
why(3, ['M' = obs039], 67).
answer(3, ['M' = obs040]).
why(3, ['M' = obs040], 68).
query(4, raw_conflict(_0), ['Door' = _0]).
result(4, complete, 1).
answer(4, ['Door' = doorA]).
why(4, ['Door' = doorA], 104).
query(5, preferred_repair(_0, _1, _2, _3), ['M' = _0, 'State' = _1, 'Priority' = _2, 'Source' = _3]).
result(5, complete, 1).
answer(5, ['M' = obs040, 'State' = closed, 'Priority' = 5, 'Source' = "safety-controller"]).
why(5, ['M' = obs040, 'State' = closed, 'Priority' = 5, 'Source' = "safety-controller"], 134).
query(6, materialized_action(_0), ['Text' = _0]).
result(6, complete, 1).
answer(6, ['Text' = "keep the compartment sealed and continue monitoring"]).
why(6, ['Text' = "keep the compartment sealed and continue monitoring"], 166).
clause(1, member(obs033, 33, closed, 1, "hallway-latch"), true).
clause(2, member(obs034, 34, closed, 1, "hallway-latch"), true).
clause(3, member(obs035, 35, closed, 1, "hallway-latch"), true).
clause(4, member(obs036, 36, closed, 1, "hallway-latch"), true).
clause(5, member(obs037, 37, open, 1, "corridor-camera"), true).
clause(6, member(obs038, 38, open, 1, "thermal-edge-camera"), true).
clause(7, member(obs039, 39, closed, 1, "hallway-latch"), true).
clause(8, member(obs040, 40, closed, 5, "safety-controller"), true).
clause(10, action_text(closed, "keep the compartment sealed and continue monitoring"), true).
clause(11, bookmark(34), true).
clause(12, window_start(35), true).
clause(13, already_committed(var('M')), (member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3)), bookmark(var('B')), var('Seq') =< var('B'))).
clause(14, newly_emitted(var('M')), (member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3)), bookmark(var('B')), var('Seq') > var('B'))).
clause(15, in_window(var('M')), (newly_emitted(var('M')), member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3)), window_start(var('W')), var('Seq') >= var('W'))).
clause(16, raw_conflict(doorA), (in_window(var('M1')), member(var('M1'), anonymous(1), open, anonymous(2), anonymous(3)), in_window(var('M2')), member(var('M2'), anonymous(4), closed, anonymous(5), anonymous(6)))).
clause(17, preferred_repair(var('M'), var('State'), var('Priority'), var('Source')), (in_window(var('M')), member(var('M'), anonymous(1), var('State'), var('Priority'), var('Source')), in_window(var('Other')), member(var('Other'), anonymous(2), var('OtherState'), var('OtherPriority'), anonymous(3)), var('State') \== var('OtherState'), var('Priority') > var('OtherPriority'))).
clause(18, materialized_action(var('Text')), (preferred_repair(anonymous(1), var('State'), anonymous(2), anonymous(3)), action_text(var('State'), var('Text')))).
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
substitution(10, ['M' = obs033, 'Seq' = 33, 'B' = 34]).
proof(10, already_committed(obs033), rule(13), [uses(1, member(obs033, 33, closed, 1, "hallway-latch")), uses(9, bookmark(34)), builtin(33 =< 34)]).
substitution(11, ['M' = obs034, 'Seq' = 34, 'B' = 34]).
proof(11, already_committed(obs034), rule(13), [uses(2, member(obs034, 34, closed, 1, "hallway-latch")), uses(9, bookmark(34)), builtin(34 =< 34)]).
substitution(12, ['M' = obs033]).
proof(12, solution([obs033]), query, [uses(10, already_committed(obs033))]).
substitution(13, ['M' = obs034]).
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
substitution(23, ['M' = obs035, 'Seq' = 35, 'B' = 34]).
proof(23, newly_emitted(obs035), rule(14), [uses(16, member(obs035, 35, closed, 1, "hallway-latch")), uses(22, bookmark(34)), builtin(35 > 34)]).
substitution(24, ['M' = obs036, 'Seq' = 36, 'B' = 34]).
proof(24, newly_emitted(obs036), rule(14), [uses(17, member(obs036, 36, closed, 1, "hallway-latch")), uses(22, bookmark(34)), builtin(36 > 34)]).
substitution(25, ['M' = obs037, 'Seq' = 37, 'B' = 34]).
proof(25, newly_emitted(obs037), rule(14), [uses(18, member(obs037, 37, open, 1, "corridor-camera")), uses(22, bookmark(34)), builtin(37 > 34)]).
substitution(26, ['M' = obs038, 'Seq' = 38, 'B' = 34]).
proof(26, newly_emitted(obs038), rule(14), [uses(19, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(22, bookmark(34)), builtin(38 > 34)]).
substitution(27, ['M' = obs039, 'Seq' = 39, 'B' = 34]).
proof(27, newly_emitted(obs039), rule(14), [uses(20, member(obs039, 39, closed, 1, "hallway-latch")), uses(22, bookmark(34)), builtin(39 > 34)]).
substitution(28, ['M' = obs040, 'Seq' = 40, 'B' = 34]).
proof(28, newly_emitted(obs040), rule(14), [uses(21, member(obs040, 40, closed, 5, "safety-controller")), uses(22, bookmark(34)), builtin(40 > 34)]).
substitution(29, ['M' = obs035]).
proof(29, solution([obs035]), query, [uses(23, newly_emitted(obs035))]).
substitution(30, ['M' = obs036]).
proof(30, solution([obs036]), query, [uses(24, newly_emitted(obs036))]).
substitution(31, ['M' = obs037]).
proof(31, solution([obs037]), query, [uses(25, newly_emitted(obs037))]).
substitution(32, ['M' = obs038]).
proof(32, solution([obs038]), query, [uses(26, newly_emitted(obs038))]).
substitution(33, ['M' = obs039]).
proof(33, solution([obs039]), query, [uses(27, newly_emitted(obs039))]).
substitution(34, ['M' = obs040]).
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
substitution(44, ['M' = obs035, 'Seq' = 35, 'B' = 34]).
proof(44, newly_emitted(obs035), rule(14), [uses(37, member(obs035, 35, closed, 1, "hallway-latch")), uses(43, bookmark(34)), builtin(35 > 34)]).
substitution(45, ['M' = obs036, 'Seq' = 36, 'B' = 34]).
proof(45, newly_emitted(obs036), rule(14), [uses(38, member(obs036, 36, closed, 1, "hallway-latch")), uses(43, bookmark(34)), builtin(36 > 34)]).
substitution(46, ['M' = obs037, 'Seq' = 37, 'B' = 34]).
proof(46, newly_emitted(obs037), rule(14), [uses(39, member(obs037, 37, open, 1, "corridor-camera")), uses(43, bookmark(34)), builtin(37 > 34)]).
substitution(47, ['M' = obs038, 'Seq' = 38, 'B' = 34]).
proof(47, newly_emitted(obs038), rule(14), [uses(40, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(43, bookmark(34)), builtin(38 > 34)]).
substitution(48, ['M' = obs039, 'Seq' = 39, 'B' = 34]).
proof(48, newly_emitted(obs039), rule(14), [uses(41, member(obs039, 39, closed, 1, "hallway-latch")), uses(43, bookmark(34)), builtin(39 > 34)]).
substitution(49, ['M' = obs040, 'Seq' = 40, 'B' = 34]).
proof(49, newly_emitted(obs040), rule(14), [uses(42, member(obs040, 40, closed, 5, "safety-controller")), uses(43, bookmark(34)), builtin(40 > 34)]).
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
substitution(57, ['M' = obs035, 'Seq' = 35, 'W' = 35]).
proof(57, in_window(obs035), rule(15), [uses(44, newly_emitted(obs035)), uses(50, member(obs035, 35, closed, 1, "hallway-latch")), uses(56, window_start(35)), builtin(35 >= 35)]).
substitution(58, ['M' = obs036, 'Seq' = 36, 'W' = 35]).
proof(58, in_window(obs036), rule(15), [uses(45, newly_emitted(obs036)), uses(51, member(obs036, 36, closed, 1, "hallway-latch")), uses(56, window_start(35)), builtin(36 >= 35)]).
substitution(59, ['M' = obs037, 'Seq' = 37, 'W' = 35]).
proof(59, in_window(obs037), rule(15), [uses(46, newly_emitted(obs037)), uses(52, member(obs037, 37, open, 1, "corridor-camera")), uses(56, window_start(35)), builtin(37 >= 35)]).
substitution(60, ['M' = obs038, 'Seq' = 38, 'W' = 35]).
proof(60, in_window(obs038), rule(15), [uses(47, newly_emitted(obs038)), uses(53, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(56, window_start(35)), builtin(38 >= 35)]).
substitution(61, ['M' = obs039, 'Seq' = 39, 'W' = 35]).
proof(61, in_window(obs039), rule(15), [uses(48, newly_emitted(obs039)), uses(54, member(obs039, 39, closed, 1, "hallway-latch")), uses(56, window_start(35)), builtin(39 >= 35)]).
substitution(62, ['M' = obs040, 'Seq' = 40, 'W' = 35]).
proof(62, in_window(obs040), rule(15), [uses(49, newly_emitted(obs040)), uses(55, member(obs040, 40, closed, 5, "safety-controller")), uses(56, window_start(35)), builtin(40 >= 35)]).
substitution(63, ['M' = obs035]).
proof(63, solution([obs035]), query, [uses(57, in_window(obs035))]).
substitution(64, ['M' = obs036]).
proof(64, solution([obs036]), query, [uses(58, in_window(obs036))]).
substitution(65, ['M' = obs037]).
proof(65, solution([obs037]), query, [uses(59, in_window(obs037))]).
substitution(66, ['M' = obs038]).
proof(66, solution([obs038]), query, [uses(60, in_window(obs038))]).
substitution(67, ['M' = obs039]).
proof(67, solution([obs039]), query, [uses(61, in_window(obs039))]).
substitution(68, ['M' = obs040]).
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
substitution(78, ['M' = obs035, 'Seq' = 35, 'B' = 34]).
proof(78, newly_emitted(obs035), rule(14), [uses(71, member(obs035, 35, closed, 1, "hallway-latch")), uses(77, bookmark(34)), builtin(35 > 34)]).
substitution(79, ['M' = obs036, 'Seq' = 36, 'B' = 34]).
proof(79, newly_emitted(obs036), rule(14), [uses(72, member(obs036, 36, closed, 1, "hallway-latch")), uses(77, bookmark(34)), builtin(36 > 34)]).
substitution(80, ['M' = obs037, 'Seq' = 37, 'B' = 34]).
proof(80, newly_emitted(obs037), rule(14), [uses(73, member(obs037, 37, open, 1, "corridor-camera")), uses(77, bookmark(34)), builtin(37 > 34)]).
substitution(81, ['M' = obs038, 'Seq' = 38, 'B' = 34]).
proof(81, newly_emitted(obs038), rule(14), [uses(74, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(77, bookmark(34)), builtin(38 > 34)]).
substitution(82, ['M' = obs039, 'Seq' = 39, 'B' = 34]).
proof(82, newly_emitted(obs039), rule(14), [uses(75, member(obs039, 39, closed, 1, "hallway-latch")), uses(77, bookmark(34)), builtin(39 > 34)]).
substitution(83, ['M' = obs040, 'Seq' = 40, 'B' = 34]).
proof(83, newly_emitted(obs040), rule(14), [uses(76, member(obs040, 40, closed, 5, "safety-controller")), uses(77, bookmark(34)), builtin(40 > 34)]).
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
substitution(91, ['M' = obs035, 'Seq' = 35, 'W' = 35]).
proof(91, in_window(obs035), rule(15), [uses(78, newly_emitted(obs035)), uses(84, member(obs035, 35, closed, 1, "hallway-latch")), uses(90, window_start(35)), builtin(35 >= 35)]).
substitution(92, ['M' = obs036, 'Seq' = 36, 'W' = 35]).
proof(92, in_window(obs036), rule(15), [uses(79, newly_emitted(obs036)), uses(85, member(obs036, 36, closed, 1, "hallway-latch")), uses(90, window_start(35)), builtin(36 >= 35)]).
substitution(93, ['M' = obs037, 'Seq' = 37, 'W' = 35]).
proof(93, in_window(obs037), rule(15), [uses(80, newly_emitted(obs037)), uses(86, member(obs037, 37, open, 1, "corridor-camera")), uses(90, window_start(35)), builtin(37 >= 35)]).
substitution(94, ['M' = obs038, 'Seq' = 38, 'W' = 35]).
proof(94, in_window(obs038), rule(15), [uses(81, newly_emitted(obs038)), uses(87, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(90, window_start(35)), builtin(38 >= 35)]).
substitution(95, ['M' = obs039, 'Seq' = 39, 'W' = 35]).
proof(95, in_window(obs039), rule(15), [uses(82, newly_emitted(obs039)), uses(88, member(obs039, 39, closed, 1, "hallway-latch")), uses(90, window_start(35)), builtin(39 >= 35)]).
substitution(96, ['M' = obs040, 'Seq' = 40, 'W' = 35]).
proof(96, in_window(obs040), rule(15), [uses(83, newly_emitted(obs040)), uses(89, member(obs040, 40, closed, 5, "safety-controller")), uses(90, window_start(35)), builtin(40 >= 35)]).
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
substitution(103, ['M1' = obs037, 'M2' = obs035]).
proof(103, raw_conflict(doorA), rule(16), [uses(93, in_window(obs037)), uses(97, member(obs037, 37, open, 1, "corridor-camera")), uses(91, in_window(obs035)), uses(99, member(obs035, 35, closed, 1, "hallway-latch"))]).
substitution(104, ['Door' = doorA]).
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
substitution(114, ['M' = obs035, 'Seq' = 35, 'B' = 34]).
proof(114, newly_emitted(obs035), rule(14), [uses(107, member(obs035, 35, closed, 1, "hallway-latch")), uses(113, bookmark(34)), builtin(35 > 34)]).
substitution(115, ['M' = obs036, 'Seq' = 36, 'B' = 34]).
proof(115, newly_emitted(obs036), rule(14), [uses(108, member(obs036, 36, closed, 1, "hallway-latch")), uses(113, bookmark(34)), builtin(36 > 34)]).
substitution(116, ['M' = obs037, 'Seq' = 37, 'B' = 34]).
proof(116, newly_emitted(obs037), rule(14), [uses(109, member(obs037, 37, open, 1, "corridor-camera")), uses(113, bookmark(34)), builtin(37 > 34)]).
substitution(117, ['M' = obs038, 'Seq' = 38, 'B' = 34]).
proof(117, newly_emitted(obs038), rule(14), [uses(110, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(113, bookmark(34)), builtin(38 > 34)]).
substitution(118, ['M' = obs039, 'Seq' = 39, 'B' = 34]).
proof(118, newly_emitted(obs039), rule(14), [uses(111, member(obs039, 39, closed, 1, "hallway-latch")), uses(113, bookmark(34)), builtin(39 > 34)]).
substitution(119, ['M' = obs040, 'Seq' = 40, 'B' = 34]).
proof(119, newly_emitted(obs040), rule(14), [uses(112, member(obs040, 40, closed, 5, "safety-controller")), uses(113, bookmark(34)), builtin(40 > 34)]).
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
substitution(127, ['M' = obs035, 'Seq' = 35, 'W' = 35]).
proof(127, in_window(obs035), rule(15), [uses(114, newly_emitted(obs035)), uses(120, member(obs035, 35, closed, 1, "hallway-latch")), uses(126, window_start(35)), builtin(35 >= 35)]).
substitution(128, ['M' = obs036, 'Seq' = 36, 'W' = 35]).
proof(128, in_window(obs036), rule(15), [uses(115, newly_emitted(obs036)), uses(121, member(obs036, 36, closed, 1, "hallway-latch")), uses(126, window_start(35)), builtin(36 >= 35)]).
substitution(129, ['M' = obs037, 'Seq' = 37, 'W' = 35]).
proof(129, in_window(obs037), rule(15), [uses(116, newly_emitted(obs037)), uses(122, member(obs037, 37, open, 1, "corridor-camera")), uses(126, window_start(35)), builtin(37 >= 35)]).
substitution(130, ['M' = obs038, 'Seq' = 38, 'W' = 35]).
proof(130, in_window(obs038), rule(15), [uses(117, newly_emitted(obs038)), uses(123, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(126, window_start(35)), builtin(38 >= 35)]).
substitution(131, ['M' = obs039, 'Seq' = 39, 'W' = 35]).
proof(131, in_window(obs039), rule(15), [uses(118, newly_emitted(obs039)), uses(124, member(obs039, 39, closed, 1, "hallway-latch")), uses(126, window_start(35)), builtin(39 >= 35)]).
substitution(132, ['M' = obs040, 'Seq' = 40, 'W' = 35]).
proof(132, in_window(obs040), rule(15), [uses(119, newly_emitted(obs040)), uses(125, member(obs040, 40, closed, 5, "safety-controller")), uses(126, window_start(35)), builtin(40 >= 35)]).
substitution(133, ['M' = obs040, 'State' = closed, 'Priority' = 5, 'Source' = "safety-controller", 'Other' = obs037, 'OtherState' = open, 'OtherPriority' = 1]).
proof(133, preferred_repair(obs040, closed, 5, "safety-controller"), rule(17), [uses(132, in_window(obs040)), uses(125, member(obs040, 40, closed, 5, "safety-controller")), uses(129, in_window(obs037)), uses(122, member(obs037, 37, open, 1, "corridor-camera")), builtin(closed \== open), builtin(5 > 1)]).
substitution(134, ['M' = obs040, 'State' = closed, 'Priority' = 5, 'Source' = "safety-controller"]).
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
substitution(144, ['M' = obs035, 'Seq' = 35, 'B' = 34]).
proof(144, newly_emitted(obs035), rule(14), [uses(137, member(obs035, 35, closed, 1, "hallway-latch")), uses(143, bookmark(34)), builtin(35 > 34)]).
substitution(145, ['M' = obs036, 'Seq' = 36, 'B' = 34]).
proof(145, newly_emitted(obs036), rule(14), [uses(138, member(obs036, 36, closed, 1, "hallway-latch")), uses(143, bookmark(34)), builtin(36 > 34)]).
substitution(146, ['M' = obs037, 'Seq' = 37, 'B' = 34]).
proof(146, newly_emitted(obs037), rule(14), [uses(139, member(obs037, 37, open, 1, "corridor-camera")), uses(143, bookmark(34)), builtin(37 > 34)]).
substitution(147, ['M' = obs038, 'Seq' = 38, 'B' = 34]).
proof(147, newly_emitted(obs038), rule(14), [uses(140, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(143, bookmark(34)), builtin(38 > 34)]).
substitution(148, ['M' = obs039, 'Seq' = 39, 'B' = 34]).
proof(148, newly_emitted(obs039), rule(14), [uses(141, member(obs039, 39, closed, 1, "hallway-latch")), uses(143, bookmark(34)), builtin(39 > 34)]).
substitution(149, ['M' = obs040, 'Seq' = 40, 'B' = 34]).
proof(149, newly_emitted(obs040), rule(14), [uses(142, member(obs040, 40, closed, 5, "safety-controller")), uses(143, bookmark(34)), builtin(40 > 34)]).
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
substitution(157, ['M' = obs035, 'Seq' = 35, 'W' = 35]).
proof(157, in_window(obs035), rule(15), [uses(144, newly_emitted(obs035)), uses(150, member(obs035, 35, closed, 1, "hallway-latch")), uses(156, window_start(35)), builtin(35 >= 35)]).
substitution(158, ['M' = obs036, 'Seq' = 36, 'W' = 35]).
proof(158, in_window(obs036), rule(15), [uses(145, newly_emitted(obs036)), uses(151, member(obs036, 36, closed, 1, "hallway-latch")), uses(156, window_start(35)), builtin(36 >= 35)]).
substitution(159, ['M' = obs037, 'Seq' = 37, 'W' = 35]).
proof(159, in_window(obs037), rule(15), [uses(146, newly_emitted(obs037)), uses(152, member(obs037, 37, open, 1, "corridor-camera")), uses(156, window_start(35)), builtin(37 >= 35)]).
substitution(160, ['M' = obs038, 'Seq' = 38, 'W' = 35]).
proof(160, in_window(obs038), rule(15), [uses(147, newly_emitted(obs038)), uses(153, member(obs038, 38, open, 1, "thermal-edge-camera")), uses(156, window_start(35)), builtin(38 >= 35)]).
substitution(161, ['M' = obs039, 'Seq' = 39, 'W' = 35]).
proof(161, in_window(obs039), rule(15), [uses(148, newly_emitted(obs039)), uses(154, member(obs039, 39, closed, 1, "hallway-latch")), uses(156, window_start(35)), builtin(39 >= 35)]).
substitution(162, ['M' = obs040, 'Seq' = 40, 'W' = 35]).
proof(162, in_window(obs040), rule(15), [uses(149, newly_emitted(obs040)), uses(155, member(obs040, 40, closed, 5, "safety-controller")), uses(156, window_start(35)), builtin(40 >= 35)]).
substitution(163, ['M' = obs040, 'State' = closed, 'Priority' = 5, 'Source' = "safety-controller", 'Other' = obs037, 'OtherState' = open, 'OtherPriority' = 1]).
proof(163, preferred_repair(obs040, closed, 5, "safety-controller"), rule(17), [uses(162, in_window(obs040)), uses(155, member(obs040, 40, closed, 5, "safety-controller")), uses(159, in_window(obs037)), uses(152, member(obs037, 37, open, 1, "corridor-camera")), builtin(closed \== open), builtin(5 > 1)]).
substitution(164, []).
proof(164, action_text(closed, "keep the compartment sealed and continue monitoring"), rule(10), []).
substitution(165, ['Text' = "keep the compartment sealed and continue monitoring", 'State' = closed]).
proof(165, materialized_action("keep the compartment sealed and continue monitoring"), rule(18), [uses(163, preferred_repair(obs040, closed, 5, "safety-controller")), uses(164, action_text(closed, "keep the compartment sealed and continue monitoring"))]).
substitution(166, ['Text' = "keep the compartment sealed and continue monitoring"]).
proof(166, solution(["keep the compartment sealed and continue monitoring"]), query, [uses(165, materialized_action("keep the compartment sealed and continue monitoring"))]).
