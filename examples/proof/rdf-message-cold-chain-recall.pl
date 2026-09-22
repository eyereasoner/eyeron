% Prolog result format 3
query(1, already_committed(_0), ['M' = _0]).
result(1, complete, 3).
answer(1, ['M' = obs040]).
why(1, ['M' = obs040], 14).
answer(1, ['M' = obs041]).
why(1, ['M' = obs041], 15).
answer(1, ['M' = obs042]).
why(1, ['M' = obs042], 16).
query(2, newly_emitted(_0), ['M' = _0]).
result(2, complete, 6).
answer(2, ['M' = obs043]).
why(2, ['M' = obs043], 33).
answer(2, ['M' = obs044]).
why(2, ['M' = obs044], 34).
answer(2, ['M' = obs045]).
why(2, ['M' = obs045], 35).
answer(2, ['M' = obs046]).
why(2, ['M' = obs046], 36).
answer(2, ['M' = obs047]).
why(2, ['M' = obs047], 37).
answer(2, ['M' = obs048]).
why(2, ['M' = obs048], 38).
query(3, in_window(_0), ['M' = _0]).
result(3, complete, 6).
answer(3, ['M' = obs043]).
why(3, ['M' = obs043], 68).
answer(3, ['M' = obs044]).
why(3, ['M' = obs044], 69).
answer(3, ['M' = obs045]).
why(3, ['M' = obs045], 70).
answer(3, ['M' = obs046]).
why(3, ['M' = obs046], 71).
answer(3, ['M' = obs047]).
why(3, ['M' = obs047], 72).
answer(3, ['M' = obs048]).
why(3, ['M' = obs048], 73).
query(4, raw_conflict(_0), ['Batch' = _0]).
result(4, complete, 1).
answer(4, ['Batch' = batchA]).
why(4, ['Batch' = batchA], 105).
query(5, preferred_repair(_0, _1, _2, _3), ['M' = _0, 'Temp' = _1, 'Priority' = _2, 'Source' = _3]).
result(5, complete, 1).
answer(5, ['M' = obs047, 'Temp' = 118, 'Priority' = 5, 'Source' = "calibrated-cold-chain-logger"]).
why(5, ['M' = obs047, 'Temp' = 118, 'Priority' = 5, 'Source' = "calibrated-cold-chain-logger"], 138).
query(6, quarantine_decision(_0), ['Text' = _0]).
result(6, complete, 1).
answer(6, ['Text' = "quarantine batchA, notify QA, and hold shipment"]).
why(6, ['Text' = "quarantine batchA, notify QA, and hold shipment"], 172).
clause(1, member(obs040, 40, 42, 1, "dock-sensor", false), true).
clause(2, member(obs041, 41, 43, 1, "warehouse-reader", false), true).
clause(3, member(obs042, 42, 44, 1, "truck-gateway", false), true).
clause(4, member(obs043, 43, 45, 1, "truck-gateway", false), true).
clause(5, member(obs044, 44, 46, 1, "dock-sensor", false), true).
clause(6, member(obs045, 45, 47, 1, "warehouse-reader", false), true).
clause(7, member(obs046, 46, 121, 2, "truck-gateway", false), true).
clause(8, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), true).
clause(9, member(obs048, 48, 44, 1, "door-proximity-sensor", false), true).
clause(10, bookmark(42), true).
clause(11, window_start(43), true).
clause(12, limit_tenths_c(80), true).
clause(13, already_committed(var('M')), (member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3), anonymous(4)), bookmark(var('B')), var('Seq') =< var('B'))).
clause(14, newly_emitted(var('M')), (member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3), anonymous(4)), bookmark(var('B')), var('Seq') > var('B'))).
clause(15, in_window(var('M')), (newly_emitted(var('M')), member(var('M'), var('Seq'), anonymous(1), anonymous(2), anonymous(3), anonymous(4)), window_start(var('W')), var('Seq') >= var('W'))).
clause(16, raw_conflict(batchA), (in_window(var('M1')), member(var('M1'), anonymous(1), var('T1'), anonymous(2), anonymous(3), anonymous(4)), limit_tenths_c(var('Limit')), var('T1') =< var('Limit'), in_window(var('M2')), member(var('M2'), anonymous(5), var('T2'), anonymous(6), anonymous(7), anonymous(8)), var('T2') > var('Limit'))).
clause(17, preferred_repair(var('M'), var('Temp'), var('Priority'), var('Source')), (in_window(var('M')), member(var('M'), anonymous(1), var('Temp'), var('Priority'), var('Source'), true), limit_tenths_c(var('Limit')), var('Temp') > var('Limit'))).
clause(18, quarantine_decision("quarantine batchA, notify QA, and hold shipment"), preferred_repair(anonymous(1), anonymous(2), anonymous(3), anonymous(4))).
substitution(1, []).
proof(1, member(obs040, 40, 42, 1, "dock-sensor", false), rule(1), []).
substitution(2, []).
proof(2, member(obs041, 41, 43, 1, "warehouse-reader", false), rule(2), []).
substitution(3, []).
proof(3, member(obs042, 42, 44, 1, "truck-gateway", false), rule(3), []).
substitution(4, []).
proof(4, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(5, []).
proof(5, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(6, []).
proof(6, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(7, []).
proof(7, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(8, []).
proof(8, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(9, []).
proof(9, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(10, []).
proof(10, bookmark(42), rule(10), []).
substitution(11, ['M' = obs040, 'Seq' = 40, 'B' = 42]).
proof(11, already_committed(obs040), rule(13), [uses(1, member(obs040, 40, 42, 1, "dock-sensor", false)), uses(10, bookmark(42)), builtin(40 =< 42)]).
substitution(12, ['M' = obs041, 'Seq' = 41, 'B' = 42]).
proof(12, already_committed(obs041), rule(13), [uses(2, member(obs041, 41, 43, 1, "warehouse-reader", false)), uses(10, bookmark(42)), builtin(41 =< 42)]).
substitution(13, ['M' = obs042, 'Seq' = 42, 'B' = 42]).
proof(13, already_committed(obs042), rule(13), [uses(3, member(obs042, 42, 44, 1, "truck-gateway", false)), uses(10, bookmark(42)), builtin(42 =< 42)]).
substitution(14, ['M' = obs040]).
proof(14, solution([obs040]), query, [uses(11, already_committed(obs040))]).
substitution(15, ['M' = obs041]).
proof(15, solution([obs041]), query, [uses(12, already_committed(obs041))]).
substitution(16, ['M' = obs042]).
proof(16, solution([obs042]), query, [uses(13, already_committed(obs042))]).
substitution(17, []).
proof(17, member(obs040, 40, 42, 1, "dock-sensor", false), rule(1), []).
substitution(18, []).
proof(18, member(obs041, 41, 43, 1, "warehouse-reader", false), rule(2), []).
substitution(19, []).
proof(19, member(obs042, 42, 44, 1, "truck-gateway", false), rule(3), []).
substitution(20, []).
proof(20, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(21, []).
proof(21, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(22, []).
proof(22, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(23, []).
proof(23, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(24, []).
proof(24, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(25, []).
proof(25, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(26, []).
proof(26, bookmark(42), rule(10), []).
substitution(27, ['M' = obs043, 'Seq' = 43, 'B' = 42]).
proof(27, newly_emitted(obs043), rule(14), [uses(20, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(26, bookmark(42)), builtin(43 > 42)]).
substitution(28, ['M' = obs044, 'Seq' = 44, 'B' = 42]).
proof(28, newly_emitted(obs044), rule(14), [uses(21, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(26, bookmark(42)), builtin(44 > 42)]).
substitution(29, ['M' = obs045, 'Seq' = 45, 'B' = 42]).
proof(29, newly_emitted(obs045), rule(14), [uses(22, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(26, bookmark(42)), builtin(45 > 42)]).
substitution(30, ['M' = obs046, 'Seq' = 46, 'B' = 42]).
proof(30, newly_emitted(obs046), rule(14), [uses(23, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(26, bookmark(42)), builtin(46 > 42)]).
substitution(31, ['M' = obs047, 'Seq' = 47, 'B' = 42]).
proof(31, newly_emitted(obs047), rule(14), [uses(24, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(26, bookmark(42)), builtin(47 > 42)]).
substitution(32, ['M' = obs048, 'Seq' = 48, 'B' = 42]).
proof(32, newly_emitted(obs048), rule(14), [uses(25, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(26, bookmark(42)), builtin(48 > 42)]).
substitution(33, ['M' = obs043]).
proof(33, solution([obs043]), query, [uses(27, newly_emitted(obs043))]).
substitution(34, ['M' = obs044]).
proof(34, solution([obs044]), query, [uses(28, newly_emitted(obs044))]).
substitution(35, ['M' = obs045]).
proof(35, solution([obs045]), query, [uses(29, newly_emitted(obs045))]).
substitution(36, ['M' = obs046]).
proof(36, solution([obs046]), query, [uses(30, newly_emitted(obs046))]).
substitution(37, ['M' = obs047]).
proof(37, solution([obs047]), query, [uses(31, newly_emitted(obs047))]).
substitution(38, ['M' = obs048]).
proof(38, solution([obs048]), query, [uses(32, newly_emitted(obs048))]).
substitution(39, []).
proof(39, member(obs040, 40, 42, 1, "dock-sensor", false), rule(1), []).
substitution(40, []).
proof(40, member(obs041, 41, 43, 1, "warehouse-reader", false), rule(2), []).
substitution(41, []).
proof(41, member(obs042, 42, 44, 1, "truck-gateway", false), rule(3), []).
substitution(42, []).
proof(42, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(43, []).
proof(43, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(44, []).
proof(44, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(45, []).
proof(45, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(46, []).
proof(46, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(47, []).
proof(47, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(48, []).
proof(48, bookmark(42), rule(10), []).
substitution(49, ['M' = obs043, 'Seq' = 43, 'B' = 42]).
proof(49, newly_emitted(obs043), rule(14), [uses(42, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(48, bookmark(42)), builtin(43 > 42)]).
substitution(50, ['M' = obs044, 'Seq' = 44, 'B' = 42]).
proof(50, newly_emitted(obs044), rule(14), [uses(43, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(48, bookmark(42)), builtin(44 > 42)]).
substitution(51, ['M' = obs045, 'Seq' = 45, 'B' = 42]).
proof(51, newly_emitted(obs045), rule(14), [uses(44, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(48, bookmark(42)), builtin(45 > 42)]).
substitution(52, ['M' = obs046, 'Seq' = 46, 'B' = 42]).
proof(52, newly_emitted(obs046), rule(14), [uses(45, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(48, bookmark(42)), builtin(46 > 42)]).
substitution(53, ['M' = obs047, 'Seq' = 47, 'B' = 42]).
proof(53, newly_emitted(obs047), rule(14), [uses(46, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(48, bookmark(42)), builtin(47 > 42)]).
substitution(54, ['M' = obs048, 'Seq' = 48, 'B' = 42]).
proof(54, newly_emitted(obs048), rule(14), [uses(47, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(48, bookmark(42)), builtin(48 > 42)]).
substitution(55, []).
proof(55, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(56, []).
proof(56, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(57, []).
proof(57, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(58, []).
proof(58, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(59, []).
proof(59, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(60, []).
proof(60, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(61, []).
proof(61, window_start(43), rule(11), []).
substitution(62, ['M' = obs043, 'Seq' = 43, 'W' = 43]).
proof(62, in_window(obs043), rule(15), [uses(49, newly_emitted(obs043)), uses(55, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(61, window_start(43)), builtin(43 >= 43)]).
substitution(63, ['M' = obs044, 'Seq' = 44, 'W' = 43]).
proof(63, in_window(obs044), rule(15), [uses(50, newly_emitted(obs044)), uses(56, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(61, window_start(43)), builtin(44 >= 43)]).
substitution(64, ['M' = obs045, 'Seq' = 45, 'W' = 43]).
proof(64, in_window(obs045), rule(15), [uses(51, newly_emitted(obs045)), uses(57, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(61, window_start(43)), builtin(45 >= 43)]).
substitution(65, ['M' = obs046, 'Seq' = 46, 'W' = 43]).
proof(65, in_window(obs046), rule(15), [uses(52, newly_emitted(obs046)), uses(58, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(61, window_start(43)), builtin(46 >= 43)]).
substitution(66, ['M' = obs047, 'Seq' = 47, 'W' = 43]).
proof(66, in_window(obs047), rule(15), [uses(53, newly_emitted(obs047)), uses(59, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(61, window_start(43)), builtin(47 >= 43)]).
substitution(67, ['M' = obs048, 'Seq' = 48, 'W' = 43]).
proof(67, in_window(obs048), rule(15), [uses(54, newly_emitted(obs048)), uses(60, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(61, window_start(43)), builtin(48 >= 43)]).
substitution(68, ['M' = obs043]).
proof(68, solution([obs043]), query, [uses(62, in_window(obs043))]).
substitution(69, ['M' = obs044]).
proof(69, solution([obs044]), query, [uses(63, in_window(obs044))]).
substitution(70, ['M' = obs045]).
proof(70, solution([obs045]), query, [uses(64, in_window(obs045))]).
substitution(71, ['M' = obs046]).
proof(71, solution([obs046]), query, [uses(65, in_window(obs046))]).
substitution(72, ['M' = obs047]).
proof(72, solution([obs047]), query, [uses(66, in_window(obs047))]).
substitution(73, ['M' = obs048]).
proof(73, solution([obs048]), query, [uses(67, in_window(obs048))]).
substitution(74, []).
proof(74, member(obs040, 40, 42, 1, "dock-sensor", false), rule(1), []).
substitution(75, []).
proof(75, member(obs041, 41, 43, 1, "warehouse-reader", false), rule(2), []).
substitution(76, []).
proof(76, member(obs042, 42, 44, 1, "truck-gateway", false), rule(3), []).
substitution(77, []).
proof(77, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(78, []).
proof(78, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(79, []).
proof(79, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(80, []).
proof(80, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(81, []).
proof(81, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(82, []).
proof(82, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(83, []).
proof(83, bookmark(42), rule(10), []).
substitution(84, ['M' = obs043, 'Seq' = 43, 'B' = 42]).
proof(84, newly_emitted(obs043), rule(14), [uses(77, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(83, bookmark(42)), builtin(43 > 42)]).
substitution(85, ['M' = obs044, 'Seq' = 44, 'B' = 42]).
proof(85, newly_emitted(obs044), rule(14), [uses(78, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(83, bookmark(42)), builtin(44 > 42)]).
substitution(86, ['M' = obs045, 'Seq' = 45, 'B' = 42]).
proof(86, newly_emitted(obs045), rule(14), [uses(79, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(83, bookmark(42)), builtin(45 > 42)]).
substitution(87, ['M' = obs046, 'Seq' = 46, 'B' = 42]).
proof(87, newly_emitted(obs046), rule(14), [uses(80, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(83, bookmark(42)), builtin(46 > 42)]).
substitution(88, ['M' = obs047, 'Seq' = 47, 'B' = 42]).
proof(88, newly_emitted(obs047), rule(14), [uses(81, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(83, bookmark(42)), builtin(47 > 42)]).
substitution(89, ['M' = obs048, 'Seq' = 48, 'B' = 42]).
proof(89, newly_emitted(obs048), rule(14), [uses(82, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(83, bookmark(42)), builtin(48 > 42)]).
substitution(90, []).
proof(90, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(91, []).
proof(91, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(92, []).
proof(92, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(93, []).
proof(93, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(94, []).
proof(94, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(95, []).
proof(95, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(96, []).
proof(96, window_start(43), rule(11), []).
substitution(97, ['M' = obs043, 'Seq' = 43, 'W' = 43]).
proof(97, in_window(obs043), rule(15), [uses(84, newly_emitted(obs043)), uses(90, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(96, window_start(43)), builtin(43 >= 43)]).
substitution(98, ['M' = obs044, 'Seq' = 44, 'W' = 43]).
proof(98, in_window(obs044), rule(15), [uses(85, newly_emitted(obs044)), uses(91, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(96, window_start(43)), builtin(44 >= 43)]).
substitution(99, ['M' = obs045, 'Seq' = 45, 'W' = 43]).
proof(99, in_window(obs045), rule(15), [uses(86, newly_emitted(obs045)), uses(92, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(96, window_start(43)), builtin(45 >= 43)]).
substitution(100, ['M' = obs046, 'Seq' = 46, 'W' = 43]).
proof(100, in_window(obs046), rule(15), [uses(87, newly_emitted(obs046)), uses(93, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(96, window_start(43)), builtin(46 >= 43)]).
substitution(101, ['M' = obs047, 'Seq' = 47, 'W' = 43]).
proof(101, in_window(obs047), rule(15), [uses(88, newly_emitted(obs047)), uses(94, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(96, window_start(43)), builtin(47 >= 43)]).
substitution(102, ['M' = obs048, 'Seq' = 48, 'W' = 43]).
proof(102, in_window(obs048), rule(15), [uses(89, newly_emitted(obs048)), uses(95, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(96, window_start(43)), builtin(48 >= 43)]).
substitution(103, []).
proof(103, limit_tenths_c(80), rule(12), []).
substitution(104, ['M1' = obs043, 'T1' = 45, 'Limit' = 80, 'M2' = obs046, 'T2' = 121]).
proof(104, raw_conflict(batchA), rule(16), [uses(97, in_window(obs043)), uses(90, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(103, limit_tenths_c(80)), builtin(45 =< 80), uses(100, in_window(obs046)), uses(93, member(obs046, 46, 121, 2, "truck-gateway", false)), builtin(121 > 80)]).
substitution(105, ['Batch' = batchA]).
proof(105, solution([batchA]), query, [uses(104, raw_conflict(batchA))]).
substitution(106, []).
proof(106, member(obs040, 40, 42, 1, "dock-sensor", false), rule(1), []).
substitution(107, []).
proof(107, member(obs041, 41, 43, 1, "warehouse-reader", false), rule(2), []).
substitution(108, []).
proof(108, member(obs042, 42, 44, 1, "truck-gateway", false), rule(3), []).
substitution(109, []).
proof(109, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(110, []).
proof(110, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(111, []).
proof(111, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(112, []).
proof(112, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(113, []).
proof(113, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(114, []).
proof(114, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(115, []).
proof(115, bookmark(42), rule(10), []).
substitution(116, ['M' = obs043, 'Seq' = 43, 'B' = 42]).
proof(116, newly_emitted(obs043), rule(14), [uses(109, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(115, bookmark(42)), builtin(43 > 42)]).
substitution(117, ['M' = obs044, 'Seq' = 44, 'B' = 42]).
proof(117, newly_emitted(obs044), rule(14), [uses(110, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(115, bookmark(42)), builtin(44 > 42)]).
substitution(118, ['M' = obs045, 'Seq' = 45, 'B' = 42]).
proof(118, newly_emitted(obs045), rule(14), [uses(111, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(115, bookmark(42)), builtin(45 > 42)]).
substitution(119, ['M' = obs046, 'Seq' = 46, 'B' = 42]).
proof(119, newly_emitted(obs046), rule(14), [uses(112, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(115, bookmark(42)), builtin(46 > 42)]).
substitution(120, ['M' = obs047, 'Seq' = 47, 'B' = 42]).
proof(120, newly_emitted(obs047), rule(14), [uses(113, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(115, bookmark(42)), builtin(47 > 42)]).
substitution(121, ['M' = obs048, 'Seq' = 48, 'B' = 42]).
proof(121, newly_emitted(obs048), rule(14), [uses(114, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(115, bookmark(42)), builtin(48 > 42)]).
substitution(122, []).
proof(122, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(123, []).
proof(123, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(124, []).
proof(124, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(125, []).
proof(125, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(126, []).
proof(126, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(127, []).
proof(127, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(128, []).
proof(128, window_start(43), rule(11), []).
substitution(129, ['M' = obs043, 'Seq' = 43, 'W' = 43]).
proof(129, in_window(obs043), rule(15), [uses(116, newly_emitted(obs043)), uses(122, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(128, window_start(43)), builtin(43 >= 43)]).
substitution(130, ['M' = obs044, 'Seq' = 44, 'W' = 43]).
proof(130, in_window(obs044), rule(15), [uses(117, newly_emitted(obs044)), uses(123, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(128, window_start(43)), builtin(44 >= 43)]).
substitution(131, ['M' = obs045, 'Seq' = 45, 'W' = 43]).
proof(131, in_window(obs045), rule(15), [uses(118, newly_emitted(obs045)), uses(124, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(128, window_start(43)), builtin(45 >= 43)]).
substitution(132, ['M' = obs046, 'Seq' = 46, 'W' = 43]).
proof(132, in_window(obs046), rule(15), [uses(119, newly_emitted(obs046)), uses(125, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(128, window_start(43)), builtin(46 >= 43)]).
substitution(133, ['M' = obs047, 'Seq' = 47, 'W' = 43]).
proof(133, in_window(obs047), rule(15), [uses(120, newly_emitted(obs047)), uses(126, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(128, window_start(43)), builtin(47 >= 43)]).
substitution(134, ['M' = obs048, 'Seq' = 48, 'W' = 43]).
proof(134, in_window(obs048), rule(15), [uses(121, newly_emitted(obs048)), uses(127, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(128, window_start(43)), builtin(48 >= 43)]).
substitution(135, []).
proof(135, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(136, []).
proof(136, limit_tenths_c(80), rule(12), []).
substitution(137, ['M' = obs047, 'Temp' = 118, 'Priority' = 5, 'Source' = "calibrated-cold-chain-logger", 'Limit' = 80]).
proof(137, preferred_repair(obs047, 118, 5, "calibrated-cold-chain-logger"), rule(17), [uses(133, in_window(obs047)), uses(135, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(136, limit_tenths_c(80)), builtin(118 > 80)]).
substitution(138, ['M' = obs047, 'Temp' = 118, 'Priority' = 5, 'Source' = "calibrated-cold-chain-logger"]).
proof(138, solution([obs047, 118, 5, "calibrated-cold-chain-logger"]), query, [uses(137, preferred_repair(obs047, 118, 5, "calibrated-cold-chain-logger"))]).
substitution(139, []).
proof(139, member(obs040, 40, 42, 1, "dock-sensor", false), rule(1), []).
substitution(140, []).
proof(140, member(obs041, 41, 43, 1, "warehouse-reader", false), rule(2), []).
substitution(141, []).
proof(141, member(obs042, 42, 44, 1, "truck-gateway", false), rule(3), []).
substitution(142, []).
proof(142, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(143, []).
proof(143, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(144, []).
proof(144, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(145, []).
proof(145, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(146, []).
proof(146, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(147, []).
proof(147, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(148, []).
proof(148, bookmark(42), rule(10), []).
substitution(149, ['M' = obs043, 'Seq' = 43, 'B' = 42]).
proof(149, newly_emitted(obs043), rule(14), [uses(142, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(148, bookmark(42)), builtin(43 > 42)]).
substitution(150, ['M' = obs044, 'Seq' = 44, 'B' = 42]).
proof(150, newly_emitted(obs044), rule(14), [uses(143, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(148, bookmark(42)), builtin(44 > 42)]).
substitution(151, ['M' = obs045, 'Seq' = 45, 'B' = 42]).
proof(151, newly_emitted(obs045), rule(14), [uses(144, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(148, bookmark(42)), builtin(45 > 42)]).
substitution(152, ['M' = obs046, 'Seq' = 46, 'B' = 42]).
proof(152, newly_emitted(obs046), rule(14), [uses(145, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(148, bookmark(42)), builtin(46 > 42)]).
substitution(153, ['M' = obs047, 'Seq' = 47, 'B' = 42]).
proof(153, newly_emitted(obs047), rule(14), [uses(146, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(148, bookmark(42)), builtin(47 > 42)]).
substitution(154, ['M' = obs048, 'Seq' = 48, 'B' = 42]).
proof(154, newly_emitted(obs048), rule(14), [uses(147, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(148, bookmark(42)), builtin(48 > 42)]).
substitution(155, []).
proof(155, member(obs043, 43, 45, 1, "truck-gateway", false), rule(4), []).
substitution(156, []).
proof(156, member(obs044, 44, 46, 1, "dock-sensor", false), rule(5), []).
substitution(157, []).
proof(157, member(obs045, 45, 47, 1, "warehouse-reader", false), rule(6), []).
substitution(158, []).
proof(158, member(obs046, 46, 121, 2, "truck-gateway", false), rule(7), []).
substitution(159, []).
proof(159, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(160, []).
proof(160, member(obs048, 48, 44, 1, "door-proximity-sensor", false), rule(9), []).
substitution(161, []).
proof(161, window_start(43), rule(11), []).
substitution(162, ['M' = obs043, 'Seq' = 43, 'W' = 43]).
proof(162, in_window(obs043), rule(15), [uses(149, newly_emitted(obs043)), uses(155, member(obs043, 43, 45, 1, "truck-gateway", false)), uses(161, window_start(43)), builtin(43 >= 43)]).
substitution(163, ['M' = obs044, 'Seq' = 44, 'W' = 43]).
proof(163, in_window(obs044), rule(15), [uses(150, newly_emitted(obs044)), uses(156, member(obs044, 44, 46, 1, "dock-sensor", false)), uses(161, window_start(43)), builtin(44 >= 43)]).
substitution(164, ['M' = obs045, 'Seq' = 45, 'W' = 43]).
proof(164, in_window(obs045), rule(15), [uses(151, newly_emitted(obs045)), uses(157, member(obs045, 45, 47, 1, "warehouse-reader", false)), uses(161, window_start(43)), builtin(45 >= 43)]).
substitution(165, ['M' = obs046, 'Seq' = 46, 'W' = 43]).
proof(165, in_window(obs046), rule(15), [uses(152, newly_emitted(obs046)), uses(158, member(obs046, 46, 121, 2, "truck-gateway", false)), uses(161, window_start(43)), builtin(46 >= 43)]).
substitution(166, ['M' = obs047, 'Seq' = 47, 'W' = 43]).
proof(166, in_window(obs047), rule(15), [uses(153, newly_emitted(obs047)), uses(159, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(161, window_start(43)), builtin(47 >= 43)]).
substitution(167, ['M' = obs048, 'Seq' = 48, 'W' = 43]).
proof(167, in_window(obs048), rule(15), [uses(154, newly_emitted(obs048)), uses(160, member(obs048, 48, 44, 1, "door-proximity-sensor", false)), uses(161, window_start(43)), builtin(48 >= 43)]).
substitution(168, []).
proof(168, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true), rule(8), []).
substitution(169, []).
proof(169, limit_tenths_c(80), rule(12), []).
substitution(170, ['M' = obs047, 'Temp' = 118, 'Priority' = 5, 'Source' = "calibrated-cold-chain-logger", 'Limit' = 80]).
proof(170, preferred_repair(obs047, 118, 5, "calibrated-cold-chain-logger"), rule(17), [uses(166, in_window(obs047)), uses(168, member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true)), uses(169, limit_tenths_c(80)), builtin(118 > 80)]).
substitution(171, []).
proof(171, quarantine_decision("quarantine batchA, notify QA, and hold shipment"), rule(18), [uses(170, preferred_repair(obs047, 118, 5, "calibrated-cold-chain-logger"))]).
substitution(172, ['Text' = "quarantine batchA, notify QA, and hold shipment"]).
proof(172, solution(["quarantine batchA, notify QA, and hold shipment"]), query, [uses(171, quarantine_decision("quarantine batchA, notify QA, and hold shipment"))]).
