% Prolog result format 3
query(1, inherits_marker(_0, _1), ['L' = _0, 'M' = _1]).
result(1, complete, 5).
answer(1, ['L' = s2, 'M' = sox2]).
why(1, ['L' = s2, 'M' = sox2], 7).
answer(1, ['L' = s2, 'M' = pax6]).
why(1, ['L' = s2, 'M' = pax6], 8).
answer(1, ['L' = s3, 'M' = neuroD1]).
why(1, ['L' = s3, 'M' = neuroD1], 28).
answer(1, ['L' = s3, 'M' = sox2]).
why(1, ['L' = s3, 'M' = sox2], 29).
answer(1, ['L' = s3, 'M' = pax6]).
why(1, ['L' = s3, 'M' = pax6], 30).
query(2, considers(_0, _1), ['C' = _0, 'P' = _1]).
result(2, complete, 2).
answer(2, ['C' = s2, 'P' = proneuralProgram]).
why(2, ['C' = s2, 'P' = proneuralProgram], 37).
answer(2, ['C' = s3, 'P' = neuronalMaturationProgram]).
why(2, ['C' = s3, 'P' = neuronalMaturationProgram], 38).
query(3, targets_marker(_0, _1), ['C' = _0, 'M' = _1]).
result(3, complete, 2).
answer(3, ['C' = s2, 'M' = neuroD1]).
why(3, ['C' = s2, 'M' = neuroD1], 45).
answer(3, ['C' = s3, 'M' = tubb3]).
why(3, ['C' = s3, 'M' = tubb3], 46).
query(4, preserves_marker(_0, _1), ['C' = _0, 'M' = _1]).
result(4, complete, 4).
answer(4, ['C' = s2, 'M' = sox2]).
why(4, ['C' = s2, 'M' = sox2], 71).
answer(4, ['C' = s2, 'M' = pax6]).
why(4, ['C' = s2, 'M' = pax6], 72).
answer(4, ['C' = s3, 'M' = neuroD1]).
why(4, ['C' = s3, 'M' = neuroD1], 83).
answer(4, ['C' = s3, 'M' = pax6]).
why(4, ['C' = s3, 'M' = pax6], 84).
query(5, integrates(_0, _1), ['C' = _0, 'P' = _1]).
result(5, complete, 2).
answer(5, ['C' = s2, 'P' = proneuralProgram]).
why(5, ['C' = s2, 'P' = proneuralProgram], 116).
answer(5, ['C' = s3, 'P' = neuronalMaturationProgram]).
why(5, ['C' = s3, 'P' = neuronalMaturationProgram], 124).
query(6, expresses(_0, _1), ['C' = _0, 'M' = _1]).
result(6, complete, 8).
answer(6, ['C' = s1, 'M' = sox2]).
why(6, ['C' = s1, 'M' = sox2], 127).
answer(6, ['C' = s1, 'M' = pax6]).
why(6, ['C' = s1, 'M' = pax6], 128).
answer(6, ['C' = s2, 'M' = neuroD1]).
why(6, ['C' = s2, 'M' = neuroD1], 166).
answer(6, ['C' = s3, 'M' = tubb3]).
why(6, ['C' = s3, 'M' = tubb3], 167).
answer(6, ['C' = s2, 'M' = sox2]).
why(6, ['C' = s2, 'M' = sox2], 168).
answer(6, ['C' = s2, 'M' = pax6]).
why(6, ['C' = s2, 'M' = pax6], 169).
answer(6, ['C' = s3, 'M' = neuroD1]).
why(6, ['C' = s3, 'M' = neuroD1], 179).
answer(6, ['C' = s3, 'M' = pax6]).
why(6, ['C' = s3, 'M' = pax6], 180).
query(7, realizes(_0, _1), ['C' = _0, 'P' = _1]).
result(7, complete, 2).
answer(7, ['C' = s2, 'P' = proneuralProgram]).
why(7, ['C' = s2, 'P' = proneuralProgram], 217).
answer(7, ['C' = s3, 'P' = neuronalMaturationProgram]).
why(7, ['C' = s3, 'P' = neuronalMaturationProgram], 222).
query(8, status(_0, _1), ['C' = _0, 'S' = _1]).
result(8, complete, 3).
answer(8, ['C' = s1, 'S' = stableCellState]).
why(8, ['C' = s1, 'S' = stableCellState], 225).
answer(8, ['C' = s2, 'S' = stableCellState]).
why(8, ['C' = s2, 'S' = stableCellState], 268).
answer(8, ['C' = s3, 'S' = stableCellState]).
why(8, ['C' = s3, 'S' = stableCellState], 271).
query(9, available_for_further_differentiation(_0, _1), ['C' = _0, 'Y' = _1]).
result(9, complete, 2).
answer(9, ['C' = s2, 'Y' = yes]).
why(9, ['C' = s2, 'Y' = yes], 310).
answer(9, ['C' = s3, 'Y' = yes]).
why(9, ['C' = s3, 'Y' = yes], 315).
clause(1, suggests(neurogenicSignal, proneuralProgram), true).
clause(2, introduces_marker(neurogenicSignal, neuroD1), true).
clause(3, suggests(maturationSignal, neuronalMaturationProgram), true).
clause(4, introduces_marker(maturationSignal, tubb3), true).
clause(5, compatible_with(proneuralProgram, sox2), true).
clause(6, compatible_with(proneuralProgram, pax6), true).
clause(7, enables(proneuralProgram, neuroD1), true).
clause(8, compatible_with(neuronalMaturationProgram, pax6), true).
clause(9, compatible_with(neuronalMaturationProgram, neuroD1), true).
clause(10, enables(neuronalMaturationProgram, tubb3), true).
clause(11, expresses(s1, sox2), true).
clause(12, expresses(s1, pax6), true).
clause(13, achieves(s1, stableCellState), true).
clause(14, derives_from(s2, s1), true).
clause(15, receives(s2, neurogenicSignal), true).
clause(16, derives_from(s3, s2), true).
clause(17, receives(s3, maturationSignal), true).
clause(18, inherits_marker(var('Later'), var('Marker')), (derives_from(var('Later'), var('Earlier')), expresses(var('Earlier'), var('Marker')))).
clause(19, considers(var('Cell'), var('Program')), (receives(var('Cell'), var('Signal')), suggests(var('Signal'), var('Program')))).
clause(20, targets_marker(var('Cell'), var('Marker')), (receives(var('Cell'), var('Signal')), introduces_marker(var('Signal'), var('Marker')))).
clause(21, preserves_marker(var('Cell'), var('Marker')), (inherits_marker(var('Cell'), var('Marker')), considers(var('Cell'), var('Program')), compatible_with(var('Program'), var('Marker')))).
clause(22, integrates(var('Cell'), var('Program')), (inherits_marker(var('Cell'), var('Marker')), considers(var('Cell'), var('Program')), compatible_with(var('Program'), var('Marker')))).
clause(23, expresses(var('Cell'), var('Marker')), (targets_marker(var('Cell'), var('Marker')), considers(var('Cell'), var('Program')), enables(var('Program'), var('Marker')))).
clause(24, integrates(var('Cell'), var('Program')), (targets_marker(var('Cell'), var('Marker')), considers(var('Cell'), var('Program')), enables(var('Program'), var('Marker')))).
clause(25, expresses(var('Cell'), var('Marker')), preserves_marker(var('Cell'), var('Marker'))).
clause(26, realizes(var('Cell'), var('Program')), integrates(var('Cell'), var('Program'))).
clause(27, achieves(var('Cell'), stableCellState), realizes(var('Cell'), var('Program'))).
clause(28, available_for_further_differentiation(var('Cell'), yes), realizes(var('Cell'), var('Program'))).
clause(29, status(var('Cell'), stableCellState), achieves(var('Cell'), stableCellState)).
substitution(1, []).
proof(1, derives_from(s2, s1), rule(14), []).
substitution(2, []).
proof(2, derives_from(s3, s2), rule(16), []).
substitution(3, []).
proof(3, expresses(s1, sox2), rule(11), []).
substitution(4, []).
proof(4, expresses(s1, pax6), rule(12), []).
substitution(5, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(5, inherits_marker(s2, sox2), rule(18), [uses(1, derives_from(s2, s1)), uses(3, expresses(s1, sox2))]).
substitution(6, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(6, inherits_marker(s2, pax6), rule(18), [uses(1, derives_from(s2, s1)), uses(4, expresses(s1, pax6))]).
substitution(7, ['L' = s2, 'M' = sox2]).
proof(7, solution([s2, sox2]), query, [uses(5, inherits_marker(s2, sox2))]).
substitution(8, ['L' = s2, 'M' = pax6]).
proof(8, solution([s2, pax6]), query, [uses(6, inherits_marker(s2, pax6))]).
substitution(9, []).
proof(9, receives(s2, neurogenicSignal), rule(15), []).
substitution(10, []).
proof(10, derives_from(s2, s1), rule(14), []).
substitution(11, []).
proof(11, introduces_marker(neurogenicSignal, neuroD1), rule(2), []).
substitution(12, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(12, inherits_marker(s2, sox2), rule(18), [uses(10, derives_from(s2, s1)), uses(3, expresses(s1, sox2))]).
substitution(13, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(13, inherits_marker(s2, pax6), rule(18), [uses(10, derives_from(s2, s1)), uses(4, expresses(s1, pax6))]).
substitution(14, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(14, targets_marker(s2, neuroD1), rule(20), [uses(9, receives(s2, neurogenicSignal)), uses(11, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(15, []).
proof(15, suggests(neurogenicSignal, proneuralProgram), rule(1), []).
substitution(16, ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal]).
proof(16, considers(s2, proneuralProgram), rule(19), [uses(9, receives(s2, neurogenicSignal)), uses(15, suggests(neurogenicSignal, proneuralProgram))]).
substitution(17, []).
proof(17, compatible_with(proneuralProgram, sox2), rule(5), []).
substitution(18, []).
proof(18, compatible_with(proneuralProgram, pax6), rule(6), []).
substitution(19, []).
proof(19, enables(proneuralProgram, neuroD1), rule(7), []).
substitution(20, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(20, preserves_marker(s2, sox2), rule(21), [uses(12, inherits_marker(s2, sox2)), uses(16, considers(s2, proneuralProgram)), uses(17, compatible_with(proneuralProgram, sox2))]).
substitution(21, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(21, preserves_marker(s2, pax6), rule(21), [uses(13, inherits_marker(s2, pax6)), uses(16, considers(s2, proneuralProgram)), uses(18, compatible_with(proneuralProgram, pax6))]).
substitution(22, ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram]).
proof(22, expresses(s2, neuroD1), rule(23), [uses(14, targets_marker(s2, neuroD1)), uses(16, considers(s2, proneuralProgram)), uses(19, enables(proneuralProgram, neuroD1))]).
substitution(23, ['Cell' = s2, 'Marker' = sox2]).
proof(23, expresses(s2, sox2), rule(25), [uses(20, preserves_marker(s2, sox2))]).
substitution(24, ['Cell' = s2, 'Marker' = pax6]).
proof(24, expresses(s2, pax6), rule(25), [uses(21, preserves_marker(s2, pax6))]).
substitution(25, ['Later' = s3, 'Marker' = neuroD1, 'Earlier' = s2]).
proof(25, inherits_marker(s3, neuroD1), rule(18), [uses(2, derives_from(s3, s2)), uses(22, expresses(s2, neuroD1))]).
substitution(26, ['Later' = s3, 'Marker' = sox2, 'Earlier' = s2]).
proof(26, inherits_marker(s3, sox2), rule(18), [uses(2, derives_from(s3, s2)), uses(23, expresses(s2, sox2))]).
substitution(27, ['Later' = s3, 'Marker' = pax6, 'Earlier' = s2]).
proof(27, inherits_marker(s3, pax6), rule(18), [uses(2, derives_from(s3, s2)), uses(24, expresses(s2, pax6))]).
substitution(28, ['L' = s3, 'M' = neuroD1]).
proof(28, solution([s3, neuroD1]), query, [uses(25, inherits_marker(s3, neuroD1))]).
substitution(29, ['L' = s3, 'M' = sox2]).
proof(29, solution([s3, sox2]), query, [uses(26, inherits_marker(s3, sox2))]).
substitution(30, ['L' = s3, 'M' = pax6]).
proof(30, solution([s3, pax6]), query, [uses(27, inherits_marker(s3, pax6))]).
substitution(31, []).
proof(31, receives(s2, neurogenicSignal), rule(15), []).
substitution(32, []).
proof(32, receives(s3, maturationSignal), rule(17), []).
substitution(33, []).
proof(33, suggests(neurogenicSignal, proneuralProgram), rule(1), []).
substitution(34, []).
proof(34, suggests(maturationSignal, neuronalMaturationProgram), rule(3), []).
substitution(35, ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal]).
proof(35, considers(s2, proneuralProgram), rule(19), [uses(31, receives(s2, neurogenicSignal)), uses(33, suggests(neurogenicSignal, proneuralProgram))]).
substitution(36, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Signal' = maturationSignal]).
proof(36, considers(s3, neuronalMaturationProgram), rule(19), [uses(32, receives(s3, maturationSignal)), uses(34, suggests(maturationSignal, neuronalMaturationProgram))]).
substitution(37, ['C' = s2, 'P' = proneuralProgram]).
proof(37, solution([s2, proneuralProgram]), query, [uses(35, considers(s2, proneuralProgram))]).
substitution(38, ['C' = s3, 'P' = neuronalMaturationProgram]).
proof(38, solution([s3, neuronalMaturationProgram]), query, [uses(36, considers(s3, neuronalMaturationProgram))]).
substitution(39, []).
proof(39, receives(s2, neurogenicSignal), rule(15), []).
substitution(40, []).
proof(40, receives(s3, maturationSignal), rule(17), []).
substitution(41, []).
proof(41, introduces_marker(neurogenicSignal, neuroD1), rule(2), []).
substitution(42, []).
proof(42, introduces_marker(maturationSignal, tubb3), rule(4), []).
substitution(43, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(43, targets_marker(s2, neuroD1), rule(20), [uses(39, receives(s2, neurogenicSignal)), uses(41, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(44, ['Cell' = s3, 'Marker' = tubb3, 'Signal' = maturationSignal]).
proof(44, targets_marker(s3, tubb3), rule(20), [uses(40, receives(s3, maturationSignal)), uses(42, introduces_marker(maturationSignal, tubb3))]).
substitution(45, ['C' = s2, 'M' = neuroD1]).
proof(45, solution([s2, neuroD1]), query, [uses(43, targets_marker(s2, neuroD1))]).
substitution(46, ['C' = s3, 'M' = tubb3]).
proof(46, solution([s3, tubb3]), query, [uses(44, targets_marker(s3, tubb3))]).
substitution(47, []).
proof(47, derives_from(s2, s1), rule(14), []).
substitution(48, []).
proof(48, derives_from(s3, s2), rule(16), []).
substitution(49, []).
proof(49, expresses(s1, sox2), rule(11), []).
substitution(50, []).
proof(50, expresses(s1, pax6), rule(12), []).
substitution(51, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(51, inherits_marker(s2, sox2), rule(18), [uses(47, derives_from(s2, s1)), uses(49, expresses(s1, sox2))]).
substitution(52, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(52, inherits_marker(s2, pax6), rule(18), [uses(47, derives_from(s2, s1)), uses(50, expresses(s1, pax6))]).
substitution(53, []).
proof(53, receives(s2, neurogenicSignal), rule(15), []).
substitution(54, []).
proof(54, derives_from(s2, s1), rule(14), []).
substitution(55, []).
proof(55, suggests(neurogenicSignal, proneuralProgram), rule(1), []).
substitution(56, []).
proof(56, introduces_marker(neurogenicSignal, neuroD1), rule(2), []).
substitution(57, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(57, inherits_marker(s2, sox2), rule(18), [uses(54, derives_from(s2, s1)), uses(49, expresses(s1, sox2))]).
substitution(58, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(58, inherits_marker(s2, pax6), rule(18), [uses(54, derives_from(s2, s1)), uses(50, expresses(s1, pax6))]).
substitution(59, ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal]).
proof(59, considers(s2, proneuralProgram), rule(19), [uses(53, receives(s2, neurogenicSignal)), uses(55, suggests(neurogenicSignal, proneuralProgram))]).
substitution(60, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(60, targets_marker(s2, neuroD1), rule(20), [uses(53, receives(s2, neurogenicSignal)), uses(56, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(61, []).
proof(61, compatible_with(proneuralProgram, sox2), rule(5), []).
substitution(62, []).
proof(62, compatible_with(proneuralProgram, pax6), rule(6), []).
substitution(63, []).
proof(63, enables(proneuralProgram, neuroD1), rule(7), []).
substitution(64, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(64, preserves_marker(s2, sox2), rule(21), [uses(57, inherits_marker(s2, sox2)), uses(59, considers(s2, proneuralProgram)), uses(61, compatible_with(proneuralProgram, sox2))]).
substitution(65, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(65, preserves_marker(s2, pax6), rule(21), [uses(58, inherits_marker(s2, pax6)), uses(59, considers(s2, proneuralProgram)), uses(62, compatible_with(proneuralProgram, pax6))]).
substitution(66, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(66, preserves_marker(s2, sox2), rule(21), [uses(51, inherits_marker(s2, sox2)), uses(59, considers(s2, proneuralProgram)), uses(61, compatible_with(proneuralProgram, sox2))]).
substitution(67, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(67, preserves_marker(s2, pax6), rule(21), [uses(52, inherits_marker(s2, pax6)), uses(59, considers(s2, proneuralProgram)), uses(62, compatible_with(proneuralProgram, pax6))]).
substitution(68, ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram]).
proof(68, expresses(s2, neuroD1), rule(23), [uses(60, targets_marker(s2, neuroD1)), uses(59, considers(s2, proneuralProgram)), uses(63, enables(proneuralProgram, neuroD1))]).
substitution(69, ['Cell' = s2, 'Marker' = sox2]).
proof(69, expresses(s2, sox2), rule(25), [uses(64, preserves_marker(s2, sox2))]).
substitution(70, ['Cell' = s2, 'Marker' = pax6]).
proof(70, expresses(s2, pax6), rule(25), [uses(65, preserves_marker(s2, pax6))]).
substitution(71, ['C' = s2, 'M' = sox2]).
proof(71, solution([s2, sox2]), query, [uses(66, preserves_marker(s2, sox2))]).
substitution(72, ['C' = s2, 'M' = pax6]).
proof(72, solution([s2, pax6]), query, [uses(67, preserves_marker(s2, pax6))]).
substitution(73, ['Later' = s3, 'Marker' = neuroD1, 'Earlier' = s2]).
proof(73, inherits_marker(s3, neuroD1), rule(18), [uses(48, derives_from(s3, s2)), uses(68, expresses(s2, neuroD1))]).
substitution(74, ['Later' = s3, 'Marker' = sox2, 'Earlier' = s2]).
proof(74, inherits_marker(s3, sox2), rule(18), [uses(48, derives_from(s3, s2)), uses(69, expresses(s2, sox2))]).
substitution(75, ['Later' = s3, 'Marker' = pax6, 'Earlier' = s2]).
proof(75, inherits_marker(s3, pax6), rule(18), [uses(48, derives_from(s3, s2)), uses(70, expresses(s2, pax6))]).
substitution(76, []).
proof(76, receives(s3, maturationSignal), rule(17), []).
substitution(77, []).
proof(77, suggests(maturationSignal, neuronalMaturationProgram), rule(3), []).
substitution(78, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Signal' = maturationSignal]).
proof(78, considers(s3, neuronalMaturationProgram), rule(19), [uses(76, receives(s3, maturationSignal)), uses(77, suggests(maturationSignal, neuronalMaturationProgram))]).
substitution(79, []).
proof(79, compatible_with(neuronalMaturationProgram, neuroD1), rule(9), []).
substitution(80, []).
proof(80, compatible_with(neuronalMaturationProgram, pax6), rule(8), []).
substitution(81, ['Cell' = s3, 'Marker' = neuroD1, 'Program' = neuronalMaturationProgram]).
proof(81, preserves_marker(s3, neuroD1), rule(21), [uses(73, inherits_marker(s3, neuroD1)), uses(78, considers(s3, neuronalMaturationProgram)), uses(79, compatible_with(neuronalMaturationProgram, neuroD1))]).
substitution(82, ['Cell' = s3, 'Marker' = pax6, 'Program' = neuronalMaturationProgram]).
proof(82, preserves_marker(s3, pax6), rule(21), [uses(75, inherits_marker(s3, pax6)), uses(78, considers(s3, neuronalMaturationProgram)), uses(80, compatible_with(neuronalMaturationProgram, pax6))]).
substitution(83, ['C' = s3, 'M' = neuroD1]).
proof(83, solution([s3, neuroD1]), query, [uses(81, preserves_marker(s3, neuroD1))]).
substitution(84, ['C' = s3, 'M' = pax6]).
proof(84, solution([s3, pax6]), query, [uses(82, preserves_marker(s3, pax6))]).
substitution(85, []).
proof(85, derives_from(s2, s1), rule(14), []).
substitution(86, []).
proof(86, derives_from(s3, s2), rule(16), []).
substitution(87, []).
proof(87, receives(s2, neurogenicSignal), rule(15), []).
substitution(88, []).
proof(88, receives(s3, maturationSignal), rule(17), []).
substitution(89, []).
proof(89, expresses(s1, sox2), rule(11), []).
substitution(90, []).
proof(90, expresses(s1, pax6), rule(12), []).
substitution(91, []).
proof(91, introduces_marker(neurogenicSignal, neuroD1), rule(2), []).
substitution(92, []).
proof(92, introduces_marker(maturationSignal, tubb3), rule(4), []).
substitution(93, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(93, inherits_marker(s2, sox2), rule(18), [uses(85, derives_from(s2, s1)), uses(89, expresses(s1, sox2))]).
substitution(94, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(94, inherits_marker(s2, pax6), rule(18), [uses(85, derives_from(s2, s1)), uses(90, expresses(s1, pax6))]).
substitution(95, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(95, targets_marker(s2, neuroD1), rule(20), [uses(87, receives(s2, neurogenicSignal)), uses(91, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(96, ['Cell' = s3, 'Marker' = tubb3, 'Signal' = maturationSignal]).
proof(96, targets_marker(s3, tubb3), rule(20), [uses(88, receives(s3, maturationSignal)), uses(92, introduces_marker(maturationSignal, tubb3))]).
substitution(97, []).
proof(97, receives(s2, neurogenicSignal), rule(15), []).
substitution(98, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(98, targets_marker(s2, neuroD1), rule(20), [uses(97, receives(s2, neurogenicSignal)), uses(91, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(99, []).
proof(99, derives_from(s2, s1), rule(14), []).
substitution(100, []).
proof(100, suggests(neurogenicSignal, proneuralProgram), rule(1), []).
substitution(101, []).
proof(101, receives(s3, maturationSignal), rule(17), []).
substitution(102, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(102, inherits_marker(s2, sox2), rule(18), [uses(99, derives_from(s2, s1)), uses(89, expresses(s1, sox2))]).
substitution(103, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(103, inherits_marker(s2, pax6), rule(18), [uses(99, derives_from(s2, s1)), uses(90, expresses(s1, pax6))]).
substitution(104, ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal]).
proof(104, considers(s2, proneuralProgram), rule(19), [uses(97, receives(s2, neurogenicSignal)), uses(100, suggests(neurogenicSignal, proneuralProgram))]).
substitution(105, []).
proof(105, suggests(maturationSignal, neuronalMaturationProgram), rule(3), []).
substitution(106, []).
proof(106, compatible_with(proneuralProgram, sox2), rule(5), []).
substitution(107, []).
proof(107, compatible_with(proneuralProgram, pax6), rule(6), []).
substitution(108, []).
proof(108, enables(proneuralProgram, neuroD1), rule(7), []).
substitution(109, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Signal' = maturationSignal]).
proof(109, considers(s3, neuronalMaturationProgram), rule(19), [uses(101, receives(s3, maturationSignal)), uses(105, suggests(maturationSignal, neuronalMaturationProgram))]).
substitution(110, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(110, preserves_marker(s2, sox2), rule(21), [uses(102, inherits_marker(s2, sox2)), uses(104, considers(s2, proneuralProgram)), uses(106, compatible_with(proneuralProgram, sox2))]).
substitution(111, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(111, preserves_marker(s2, pax6), rule(21), [uses(103, inherits_marker(s2, pax6)), uses(104, considers(s2, proneuralProgram)), uses(107, compatible_with(proneuralProgram, pax6))]).
substitution(112, ['Cell' = s2, 'Program' = proneuralProgram, 'Marker' = sox2]).
proof(112, integrates(s2, proneuralProgram), rule(22), [uses(93, inherits_marker(s2, sox2)), uses(104, considers(s2, proneuralProgram)), uses(106, compatible_with(proneuralProgram, sox2))]).
substitution(113, ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram]).
proof(113, expresses(s2, neuroD1), rule(23), [uses(98, targets_marker(s2, neuroD1)), uses(104, considers(s2, proneuralProgram)), uses(108, enables(proneuralProgram, neuroD1))]).
substitution(114, ['Cell' = s2, 'Marker' = sox2]).
proof(114, expresses(s2, sox2), rule(25), [uses(110, preserves_marker(s2, sox2))]).
substitution(115, ['Cell' = s2, 'Marker' = pax6]).
proof(115, expresses(s2, pax6), rule(25), [uses(111, preserves_marker(s2, pax6))]).
substitution(116, ['C' = s2, 'P' = proneuralProgram]).
proof(116, solution([s2, proneuralProgram]), query, [uses(112, integrates(s2, proneuralProgram))]).
substitution(117, []).
proof(117, enables(neuronalMaturationProgram, tubb3), rule(10), []).
substitution(118, ['Later' = s3, 'Marker' = neuroD1, 'Earlier' = s2]).
proof(118, inherits_marker(s3, neuroD1), rule(18), [uses(86, derives_from(s3, s2)), uses(113, expresses(s2, neuroD1))]).
substitution(119, ['Later' = s3, 'Marker' = sox2, 'Earlier' = s2]).
proof(119, inherits_marker(s3, sox2), rule(18), [uses(86, derives_from(s3, s2)), uses(114, expresses(s2, sox2))]).
substitution(120, ['Later' = s3, 'Marker' = pax6, 'Earlier' = s2]).
proof(120, inherits_marker(s3, pax6), rule(18), [uses(86, derives_from(s3, s2)), uses(115, expresses(s2, pax6))]).
substitution(121, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Marker' = tubb3]).
proof(121, integrates(s3, neuronalMaturationProgram), rule(24), [uses(96, targets_marker(s3, tubb3)), uses(109, considers(s3, neuronalMaturationProgram)), uses(117, enables(neuronalMaturationProgram, tubb3))]).
substitution(122, []).
proof(122, compatible_with(neuronalMaturationProgram, neuroD1), rule(9), []).
substitution(123, []).
proof(123, compatible_with(neuronalMaturationProgram, pax6), rule(8), []).
substitution(124, ['C' = s3, 'P' = neuronalMaturationProgram]).
proof(124, solution([s3, neuronalMaturationProgram]), query, [uses(121, integrates(s3, neuronalMaturationProgram))]).
substitution(125, []).
proof(125, expresses(s1, sox2), rule(11), []).
substitution(126, []).
proof(126, expresses(s1, pax6), rule(12), []).
substitution(127, ['C' = s1, 'M' = sox2]).
proof(127, solution([s1, sox2]), query, [uses(125, expresses(s1, sox2))]).
substitution(128, ['C' = s1, 'M' = pax6]).
proof(128, solution([s1, pax6]), query, [uses(126, expresses(s1, pax6))]).
substitution(129, []).
proof(129, receives(s2, neurogenicSignal), rule(15), []).
substitution(130, []).
proof(130, receives(s3, maturationSignal), rule(17), []).
substitution(131, []).
proof(131, derives_from(s2, s1), rule(14), []).
substitution(132, []).
proof(132, derives_from(s3, s2), rule(16), []).
substitution(133, []).
proof(133, introduces_marker(neurogenicSignal, neuroD1), rule(2), []).
substitution(134, []).
proof(134, introduces_marker(maturationSignal, tubb3), rule(4), []).
substitution(135, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(135, targets_marker(s2, neuroD1), rule(20), [uses(129, receives(s2, neurogenicSignal)), uses(133, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(136, ['Cell' = s3, 'Marker' = tubb3, 'Signal' = maturationSignal]).
proof(136, targets_marker(s3, tubb3), rule(20), [uses(130, receives(s3, maturationSignal)), uses(134, introduces_marker(maturationSignal, tubb3))]).
substitution(137, []).
proof(137, expresses(s1, sox2), rule(11), []).
substitution(138, []).
proof(138, expresses(s1, pax6), rule(12), []).
substitution(139, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(139, inherits_marker(s2, sox2), rule(18), [uses(131, derives_from(s2, s1)), uses(137, expresses(s1, sox2))]).
substitution(140, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(140, inherits_marker(s2, pax6), rule(18), [uses(131, derives_from(s2, s1)), uses(138, expresses(s1, pax6))]).
substitution(141, []).
proof(141, receives(s2, neurogenicSignal), rule(15), []).
substitution(142, []).
proof(142, receives(s3, maturationSignal), rule(17), []).
substitution(143, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(143, targets_marker(s2, neuroD1), rule(20), [uses(141, receives(s2, neurogenicSignal)), uses(133, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(144, []).
proof(144, derives_from(s2, s1), rule(14), []).
substitution(145, []).
proof(145, suggests(neurogenicSignal, proneuralProgram), rule(1), []).
substitution(146, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(146, inherits_marker(s2, sox2), rule(18), [uses(144, derives_from(s2, s1)), uses(137, expresses(s1, sox2))]).
substitution(147, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(147, inherits_marker(s2, pax6), rule(18), [uses(144, derives_from(s2, s1)), uses(138, expresses(s1, pax6))]).
substitution(148, []).
proof(148, suggests(maturationSignal, neuronalMaturationProgram), rule(3), []).
substitution(149, ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal]).
proof(149, considers(s2, proneuralProgram), rule(19), [uses(141, receives(s2, neurogenicSignal)), uses(145, suggests(neurogenicSignal, proneuralProgram))]).
substitution(150, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Signal' = maturationSignal]).
proof(150, considers(s3, neuronalMaturationProgram), rule(19), [uses(142, receives(s3, maturationSignal)), uses(148, suggests(maturationSignal, neuronalMaturationProgram))]).
substitution(151, []).
proof(151, compatible_with(proneuralProgram, sox2), rule(5), []).
substitution(152, []).
proof(152, compatible_with(proneuralProgram, pax6), rule(6), []).
substitution(153, []).
proof(153, enables(proneuralProgram, neuroD1), rule(7), []).
substitution(154, []).
proof(154, enables(neuronalMaturationProgram, tubb3), rule(10), []).
substitution(155, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(155, preserves_marker(s2, sox2), rule(21), [uses(146, inherits_marker(s2, sox2)), uses(149, considers(s2, proneuralProgram)), uses(151, compatible_with(proneuralProgram, sox2))]).
substitution(156, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(156, preserves_marker(s2, pax6), rule(21), [uses(147, inherits_marker(s2, pax6)), uses(149, considers(s2, proneuralProgram)), uses(152, compatible_with(proneuralProgram, pax6))]).
substitution(157, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(157, preserves_marker(s2, sox2), rule(21), [uses(139, inherits_marker(s2, sox2)), uses(149, considers(s2, proneuralProgram)), uses(151, compatible_with(proneuralProgram, sox2))]).
substitution(158, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(158, preserves_marker(s2, pax6), rule(21), [uses(140, inherits_marker(s2, pax6)), uses(149, considers(s2, proneuralProgram)), uses(152, compatible_with(proneuralProgram, pax6))]).
substitution(159, ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram]).
proof(159, expresses(s2, neuroD1), rule(23), [uses(135, targets_marker(s2, neuroD1)), uses(149, considers(s2, proneuralProgram)), uses(153, enables(proneuralProgram, neuroD1))]).
substitution(160, ['Cell' = s3, 'Marker' = tubb3, 'Program' = neuronalMaturationProgram]).
proof(160, expresses(s3, tubb3), rule(23), [uses(136, targets_marker(s3, tubb3)), uses(150, considers(s3, neuronalMaturationProgram)), uses(154, enables(neuronalMaturationProgram, tubb3))]).
substitution(161, ['Cell' = s2, 'Marker' = sox2]).
proof(161, expresses(s2, sox2), rule(25), [uses(157, preserves_marker(s2, sox2))]).
substitution(162, ['Cell' = s2, 'Marker' = pax6]).
proof(162, expresses(s2, pax6), rule(25), [uses(158, preserves_marker(s2, pax6))]).
substitution(163, ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram]).
proof(163, expresses(s2, neuroD1), rule(23), [uses(143, targets_marker(s2, neuroD1)), uses(149, considers(s2, proneuralProgram)), uses(153, enables(proneuralProgram, neuroD1))]).
substitution(164, ['Cell' = s2, 'Marker' = sox2]).
proof(164, expresses(s2, sox2), rule(25), [uses(155, preserves_marker(s2, sox2))]).
substitution(165, ['Cell' = s2, 'Marker' = pax6]).
proof(165, expresses(s2, pax6), rule(25), [uses(156, preserves_marker(s2, pax6))]).
substitution(166, ['C' = s2, 'M' = neuroD1]).
proof(166, solution([s2, neuroD1]), query, [uses(159, expresses(s2, neuroD1))]).
substitution(167, ['C' = s3, 'M' = tubb3]).
proof(167, solution([s3, tubb3]), query, [uses(160, expresses(s3, tubb3))]).
substitution(168, ['C' = s2, 'M' = sox2]).
proof(168, solution([s2, sox2]), query, [uses(161, expresses(s2, sox2))]).
substitution(169, ['C' = s2, 'M' = pax6]).
proof(169, solution([s2, pax6]), query, [uses(162, expresses(s2, pax6))]).
substitution(170, ['Later' = s3, 'Marker' = neuroD1, 'Earlier' = s2]).
proof(170, inherits_marker(s3, neuroD1), rule(18), [uses(132, derives_from(s3, s2)), uses(163, expresses(s2, neuroD1))]).
substitution(171, ['Later' = s3, 'Marker' = sox2, 'Earlier' = s2]).
proof(171, inherits_marker(s3, sox2), rule(18), [uses(132, derives_from(s3, s2)), uses(164, expresses(s2, sox2))]).
substitution(172, ['Later' = s3, 'Marker' = pax6, 'Earlier' = s2]).
proof(172, inherits_marker(s3, pax6), rule(18), [uses(132, derives_from(s3, s2)), uses(165, expresses(s2, pax6))]).
substitution(173, []).
proof(173, compatible_with(neuronalMaturationProgram, neuroD1), rule(9), []).
substitution(174, []).
proof(174, compatible_with(neuronalMaturationProgram, pax6), rule(8), []).
substitution(175, ['Cell' = s3, 'Marker' = neuroD1, 'Program' = neuronalMaturationProgram]).
proof(175, preserves_marker(s3, neuroD1), rule(21), [uses(170, inherits_marker(s3, neuroD1)), uses(150, considers(s3, neuronalMaturationProgram)), uses(173, compatible_with(neuronalMaturationProgram, neuroD1))]).
substitution(176, ['Cell' = s3, 'Marker' = pax6, 'Program' = neuronalMaturationProgram]).
proof(176, preserves_marker(s3, pax6), rule(21), [uses(172, inherits_marker(s3, pax6)), uses(150, considers(s3, neuronalMaturationProgram)), uses(174, compatible_with(neuronalMaturationProgram, pax6))]).
substitution(177, ['Cell' = s3, 'Marker' = neuroD1]).
proof(177, expresses(s3, neuroD1), rule(25), [uses(175, preserves_marker(s3, neuroD1))]).
substitution(178, ['Cell' = s3, 'Marker' = pax6]).
proof(178, expresses(s3, pax6), rule(25), [uses(176, preserves_marker(s3, pax6))]).
substitution(179, ['C' = s3, 'M' = neuroD1]).
proof(179, solution([s3, neuroD1]), query, [uses(177, expresses(s3, neuroD1))]).
substitution(180, ['C' = s3, 'M' = pax6]).
proof(180, solution([s3, pax6]), query, [uses(178, expresses(s3, pax6))]).
substitution(181, []).
proof(181, derives_from(s2, s1), rule(14), []).
substitution(182, []).
proof(182, derives_from(s3, s2), rule(16), []).
substitution(183, []).
proof(183, receives(s2, neurogenicSignal), rule(15), []).
substitution(184, []).
proof(184, receives(s3, maturationSignal), rule(17), []).
substitution(185, []).
proof(185, expresses(s1, sox2), rule(11), []).
substitution(186, []).
proof(186, expresses(s1, pax6), rule(12), []).
substitution(187, []).
proof(187, introduces_marker(neurogenicSignal, neuroD1), rule(2), []).
substitution(188, []).
proof(188, introduces_marker(maturationSignal, tubb3), rule(4), []).
substitution(189, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(189, inherits_marker(s2, sox2), rule(18), [uses(181, derives_from(s2, s1)), uses(185, expresses(s1, sox2))]).
substitution(190, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(190, inherits_marker(s2, pax6), rule(18), [uses(181, derives_from(s2, s1)), uses(186, expresses(s1, pax6))]).
substitution(191, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(191, targets_marker(s2, neuroD1), rule(20), [uses(183, receives(s2, neurogenicSignal)), uses(187, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(192, ['Cell' = s3, 'Marker' = tubb3, 'Signal' = maturationSignal]).
proof(192, targets_marker(s3, tubb3), rule(20), [uses(184, receives(s3, maturationSignal)), uses(188, introduces_marker(maturationSignal, tubb3))]).
substitution(193, []).
proof(193, receives(s2, neurogenicSignal), rule(15), []).
substitution(194, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(194, targets_marker(s2, neuroD1), rule(20), [uses(193, receives(s2, neurogenicSignal)), uses(187, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(195, []).
proof(195, derives_from(s2, s1), rule(14), []).
substitution(196, []).
proof(196, suggests(neurogenicSignal, proneuralProgram), rule(1), []).
substitution(197, []).
proof(197, receives(s3, maturationSignal), rule(17), []).
substitution(198, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(198, inherits_marker(s2, sox2), rule(18), [uses(195, derives_from(s2, s1)), uses(185, expresses(s1, sox2))]).
substitution(199, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(199, inherits_marker(s2, pax6), rule(18), [uses(195, derives_from(s2, s1)), uses(186, expresses(s1, pax6))]).
substitution(200, ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal]).
proof(200, considers(s2, proneuralProgram), rule(19), [uses(193, receives(s2, neurogenicSignal)), uses(196, suggests(neurogenicSignal, proneuralProgram))]).
substitution(201, []).
proof(201, suggests(maturationSignal, neuronalMaturationProgram), rule(3), []).
substitution(202, []).
proof(202, compatible_with(proneuralProgram, sox2), rule(5), []).
substitution(203, []).
proof(203, compatible_with(proneuralProgram, pax6), rule(6), []).
substitution(204, []).
proof(204, enables(proneuralProgram, neuroD1), rule(7), []).
substitution(205, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Signal' = maturationSignal]).
proof(205, considers(s3, neuronalMaturationProgram), rule(19), [uses(197, receives(s3, maturationSignal)), uses(201, suggests(maturationSignal, neuronalMaturationProgram))]).
substitution(206, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(206, preserves_marker(s2, sox2), rule(21), [uses(198, inherits_marker(s2, sox2)), uses(200, considers(s2, proneuralProgram)), uses(202, compatible_with(proneuralProgram, sox2))]).
substitution(207, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(207, preserves_marker(s2, pax6), rule(21), [uses(199, inherits_marker(s2, pax6)), uses(200, considers(s2, proneuralProgram)), uses(203, compatible_with(proneuralProgram, pax6))]).
substitution(208, ['Cell' = s2, 'Program' = proneuralProgram, 'Marker' = sox2]).
proof(208, integrates(s2, proneuralProgram), rule(22), [uses(189, inherits_marker(s2, sox2)), uses(200, considers(s2, proneuralProgram)), uses(202, compatible_with(proneuralProgram, sox2))]).
substitution(209, ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram]).
proof(209, expresses(s2, neuroD1), rule(23), [uses(194, targets_marker(s2, neuroD1)), uses(200, considers(s2, proneuralProgram)), uses(204, enables(proneuralProgram, neuroD1))]).
substitution(210, ['Cell' = s2, 'Marker' = sox2]).
proof(210, expresses(s2, sox2), rule(25), [uses(206, preserves_marker(s2, sox2))]).
substitution(211, ['Cell' = s2, 'Marker' = pax6]).
proof(211, expresses(s2, pax6), rule(25), [uses(207, preserves_marker(s2, pax6))]).
substitution(212, ['Cell' = s2, 'Program' = proneuralProgram]).
proof(212, realizes(s2, proneuralProgram), rule(26), [uses(208, integrates(s2, proneuralProgram))]).
substitution(213, []).
proof(213, enables(neuronalMaturationProgram, tubb3), rule(10), []).
substitution(214, ['Later' = s3, 'Marker' = neuroD1, 'Earlier' = s2]).
proof(214, inherits_marker(s3, neuroD1), rule(18), [uses(182, derives_from(s3, s2)), uses(209, expresses(s2, neuroD1))]).
substitution(215, ['Later' = s3, 'Marker' = sox2, 'Earlier' = s2]).
proof(215, inherits_marker(s3, sox2), rule(18), [uses(182, derives_from(s3, s2)), uses(210, expresses(s2, sox2))]).
substitution(216, ['Later' = s3, 'Marker' = pax6, 'Earlier' = s2]).
proof(216, inherits_marker(s3, pax6), rule(18), [uses(182, derives_from(s3, s2)), uses(211, expresses(s2, pax6))]).
substitution(217, ['C' = s2, 'P' = proneuralProgram]).
proof(217, solution([s2, proneuralProgram]), query, [uses(212, realizes(s2, proneuralProgram))]).
substitution(218, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Marker' = tubb3]).
proof(218, integrates(s3, neuronalMaturationProgram), rule(24), [uses(192, targets_marker(s3, tubb3)), uses(205, considers(s3, neuronalMaturationProgram)), uses(213, enables(neuronalMaturationProgram, tubb3))]).
substitution(219, []).
proof(219, compatible_with(neuronalMaturationProgram, neuroD1), rule(9), []).
substitution(220, []).
proof(220, compatible_with(neuronalMaturationProgram, pax6), rule(8), []).
substitution(221, ['Cell' = s3, 'Program' = neuronalMaturationProgram]).
proof(221, realizes(s3, neuronalMaturationProgram), rule(26), [uses(218, integrates(s3, neuronalMaturationProgram))]).
substitution(222, ['C' = s3, 'P' = neuronalMaturationProgram]).
proof(222, solution([s3, neuronalMaturationProgram]), query, [uses(221, realizes(s3, neuronalMaturationProgram))]).
substitution(223, []).
proof(223, achieves(s1, stableCellState), rule(13), []).
substitution(224, ['Cell' = s1]).
proof(224, status(s1, stableCellState), rule(29), [uses(223, achieves(s1, stableCellState))]).
substitution(225, ['C' = s1, 'S' = stableCellState]).
proof(225, solution([s1, stableCellState]), query, [uses(224, status(s1, stableCellState))]).
substitution(226, []).
proof(226, derives_from(s2, s1), rule(14), []).
substitution(227, []).
proof(227, derives_from(s3, s2), rule(16), []).
substitution(228, []).
proof(228, receives(s2, neurogenicSignal), rule(15), []).
substitution(229, []).
proof(229, receives(s3, maturationSignal), rule(17), []).
substitution(230, []).
proof(230, expresses(s1, sox2), rule(11), []).
substitution(231, []).
proof(231, expresses(s1, pax6), rule(12), []).
substitution(232, []).
proof(232, introduces_marker(neurogenicSignal, neuroD1), rule(2), []).
substitution(233, []).
proof(233, introduces_marker(maturationSignal, tubb3), rule(4), []).
substitution(234, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(234, inherits_marker(s2, sox2), rule(18), [uses(226, derives_from(s2, s1)), uses(230, expresses(s1, sox2))]).
substitution(235, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(235, inherits_marker(s2, pax6), rule(18), [uses(226, derives_from(s2, s1)), uses(231, expresses(s1, pax6))]).
substitution(236, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(236, targets_marker(s2, neuroD1), rule(20), [uses(228, receives(s2, neurogenicSignal)), uses(232, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(237, ['Cell' = s3, 'Marker' = tubb3, 'Signal' = maturationSignal]).
proof(237, targets_marker(s3, tubb3), rule(20), [uses(229, receives(s3, maturationSignal)), uses(233, introduces_marker(maturationSignal, tubb3))]).
substitution(238, []).
proof(238, receives(s2, neurogenicSignal), rule(15), []).
substitution(239, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(239, targets_marker(s2, neuroD1), rule(20), [uses(238, receives(s2, neurogenicSignal)), uses(232, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(240, []).
proof(240, derives_from(s2, s1), rule(14), []).
substitution(241, []).
proof(241, suggests(neurogenicSignal, proneuralProgram), rule(1), []).
substitution(242, []).
proof(242, receives(s3, maturationSignal), rule(17), []).
substitution(243, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(243, inherits_marker(s2, sox2), rule(18), [uses(240, derives_from(s2, s1)), uses(230, expresses(s1, sox2))]).
substitution(244, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(244, inherits_marker(s2, pax6), rule(18), [uses(240, derives_from(s2, s1)), uses(231, expresses(s1, pax6))]).
substitution(245, ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal]).
proof(245, considers(s2, proneuralProgram), rule(19), [uses(238, receives(s2, neurogenicSignal)), uses(241, suggests(neurogenicSignal, proneuralProgram))]).
substitution(246, []).
proof(246, suggests(maturationSignal, neuronalMaturationProgram), rule(3), []).
substitution(247, []).
proof(247, compatible_with(proneuralProgram, sox2), rule(5), []).
substitution(248, []).
proof(248, compatible_with(proneuralProgram, pax6), rule(6), []).
substitution(249, []).
proof(249, enables(proneuralProgram, neuroD1), rule(7), []).
substitution(250, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Signal' = maturationSignal]).
proof(250, considers(s3, neuronalMaturationProgram), rule(19), [uses(242, receives(s3, maturationSignal)), uses(246, suggests(maturationSignal, neuronalMaturationProgram))]).
substitution(251, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(251, preserves_marker(s2, sox2), rule(21), [uses(243, inherits_marker(s2, sox2)), uses(245, considers(s2, proneuralProgram)), uses(247, compatible_with(proneuralProgram, sox2))]).
substitution(252, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(252, preserves_marker(s2, pax6), rule(21), [uses(244, inherits_marker(s2, pax6)), uses(245, considers(s2, proneuralProgram)), uses(248, compatible_with(proneuralProgram, pax6))]).
substitution(253, ['Cell' = s2, 'Program' = proneuralProgram, 'Marker' = sox2]).
proof(253, integrates(s2, proneuralProgram), rule(22), [uses(234, inherits_marker(s2, sox2)), uses(245, considers(s2, proneuralProgram)), uses(247, compatible_with(proneuralProgram, sox2))]).
substitution(254, ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram]).
proof(254, expresses(s2, neuroD1), rule(23), [uses(239, targets_marker(s2, neuroD1)), uses(245, considers(s2, proneuralProgram)), uses(249, enables(proneuralProgram, neuroD1))]).
substitution(255, ['Cell' = s2, 'Marker' = sox2]).
proof(255, expresses(s2, sox2), rule(25), [uses(251, preserves_marker(s2, sox2))]).
substitution(256, ['Cell' = s2, 'Marker' = pax6]).
proof(256, expresses(s2, pax6), rule(25), [uses(252, preserves_marker(s2, pax6))]).
substitution(257, ['Cell' = s2, 'Program' = proneuralProgram]).
proof(257, realizes(s2, proneuralProgram), rule(26), [uses(253, integrates(s2, proneuralProgram))]).
substitution(258, []).
proof(258, enables(neuronalMaturationProgram, tubb3), rule(10), []).
substitution(259, ['Later' = s3, 'Marker' = neuroD1, 'Earlier' = s2]).
proof(259, inherits_marker(s3, neuroD1), rule(18), [uses(227, derives_from(s3, s2)), uses(254, expresses(s2, neuroD1))]).
substitution(260, ['Later' = s3, 'Marker' = sox2, 'Earlier' = s2]).
proof(260, inherits_marker(s3, sox2), rule(18), [uses(227, derives_from(s3, s2)), uses(255, expresses(s2, sox2))]).
substitution(261, ['Later' = s3, 'Marker' = pax6, 'Earlier' = s2]).
proof(261, inherits_marker(s3, pax6), rule(18), [uses(227, derives_from(s3, s2)), uses(256, expresses(s2, pax6))]).
substitution(262, ['Cell' = s2, 'Program' = proneuralProgram]).
proof(262, achieves(s2, stableCellState), rule(27), [uses(257, realizes(s2, proneuralProgram))]).
substitution(263, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Marker' = tubb3]).
proof(263, integrates(s3, neuronalMaturationProgram), rule(24), [uses(237, targets_marker(s3, tubb3)), uses(250, considers(s3, neuronalMaturationProgram)), uses(258, enables(neuronalMaturationProgram, tubb3))]).
substitution(264, ['Cell' = s2]).
proof(264, status(s2, stableCellState), rule(29), [uses(262, achieves(s2, stableCellState))]).
substitution(265, []).
proof(265, compatible_with(neuronalMaturationProgram, neuroD1), rule(9), []).
substitution(266, []).
proof(266, compatible_with(neuronalMaturationProgram, pax6), rule(8), []).
substitution(267, ['Cell' = s3, 'Program' = neuronalMaturationProgram]).
proof(267, realizes(s3, neuronalMaturationProgram), rule(26), [uses(263, integrates(s3, neuronalMaturationProgram))]).
substitution(268, ['C' = s2, 'S' = stableCellState]).
proof(268, solution([s2, stableCellState]), query, [uses(264, status(s2, stableCellState))]).
substitution(269, ['Cell' = s3, 'Program' = neuronalMaturationProgram]).
proof(269, achieves(s3, stableCellState), rule(27), [uses(267, realizes(s3, neuronalMaturationProgram))]).
substitution(270, ['Cell' = s3]).
proof(270, status(s3, stableCellState), rule(29), [uses(269, achieves(s3, stableCellState))]).
substitution(271, ['C' = s3, 'S' = stableCellState]).
proof(271, solution([s3, stableCellState]), query, [uses(270, status(s3, stableCellState))]).
substitution(272, []).
proof(272, derives_from(s2, s1), rule(14), []).
substitution(273, []).
proof(273, derives_from(s3, s2), rule(16), []).
substitution(274, []).
proof(274, receives(s2, neurogenicSignal), rule(15), []).
substitution(275, []).
proof(275, receives(s3, maturationSignal), rule(17), []).
substitution(276, []).
proof(276, expresses(s1, sox2), rule(11), []).
substitution(277, []).
proof(277, expresses(s1, pax6), rule(12), []).
substitution(278, []).
proof(278, introduces_marker(neurogenicSignal, neuroD1), rule(2), []).
substitution(279, []).
proof(279, introduces_marker(maturationSignal, tubb3), rule(4), []).
substitution(280, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(280, inherits_marker(s2, sox2), rule(18), [uses(272, derives_from(s2, s1)), uses(276, expresses(s1, sox2))]).
substitution(281, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(281, inherits_marker(s2, pax6), rule(18), [uses(272, derives_from(s2, s1)), uses(277, expresses(s1, pax6))]).
substitution(282, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(282, targets_marker(s2, neuroD1), rule(20), [uses(274, receives(s2, neurogenicSignal)), uses(278, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(283, ['Cell' = s3, 'Marker' = tubb3, 'Signal' = maturationSignal]).
proof(283, targets_marker(s3, tubb3), rule(20), [uses(275, receives(s3, maturationSignal)), uses(279, introduces_marker(maturationSignal, tubb3))]).
substitution(284, []).
proof(284, receives(s2, neurogenicSignal), rule(15), []).
substitution(285, ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal]).
proof(285, targets_marker(s2, neuroD1), rule(20), [uses(284, receives(s2, neurogenicSignal)), uses(278, introduces_marker(neurogenicSignal, neuroD1))]).
substitution(286, []).
proof(286, derives_from(s2, s1), rule(14), []).
substitution(287, []).
proof(287, suggests(neurogenicSignal, proneuralProgram), rule(1), []).
substitution(288, []).
proof(288, receives(s3, maturationSignal), rule(17), []).
substitution(289, ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1]).
proof(289, inherits_marker(s2, sox2), rule(18), [uses(286, derives_from(s2, s1)), uses(276, expresses(s1, sox2))]).
substitution(290, ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1]).
proof(290, inherits_marker(s2, pax6), rule(18), [uses(286, derives_from(s2, s1)), uses(277, expresses(s1, pax6))]).
substitution(291, ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal]).
proof(291, considers(s2, proneuralProgram), rule(19), [uses(284, receives(s2, neurogenicSignal)), uses(287, suggests(neurogenicSignal, proneuralProgram))]).
substitution(292, []).
proof(292, suggests(maturationSignal, neuronalMaturationProgram), rule(3), []).
substitution(293, []).
proof(293, compatible_with(proneuralProgram, sox2), rule(5), []).
substitution(294, []).
proof(294, compatible_with(proneuralProgram, pax6), rule(6), []).
substitution(295, []).
proof(295, enables(proneuralProgram, neuroD1), rule(7), []).
substitution(296, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Signal' = maturationSignal]).
proof(296, considers(s3, neuronalMaturationProgram), rule(19), [uses(288, receives(s3, maturationSignal)), uses(292, suggests(maturationSignal, neuronalMaturationProgram))]).
substitution(297, ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram]).
proof(297, preserves_marker(s2, sox2), rule(21), [uses(289, inherits_marker(s2, sox2)), uses(291, considers(s2, proneuralProgram)), uses(293, compatible_with(proneuralProgram, sox2))]).
substitution(298, ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram]).
proof(298, preserves_marker(s2, pax6), rule(21), [uses(290, inherits_marker(s2, pax6)), uses(291, considers(s2, proneuralProgram)), uses(294, compatible_with(proneuralProgram, pax6))]).
substitution(299, ['Cell' = s2, 'Program' = proneuralProgram, 'Marker' = sox2]).
proof(299, integrates(s2, proneuralProgram), rule(22), [uses(280, inherits_marker(s2, sox2)), uses(291, considers(s2, proneuralProgram)), uses(293, compatible_with(proneuralProgram, sox2))]).
substitution(300, ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram]).
proof(300, expresses(s2, neuroD1), rule(23), [uses(285, targets_marker(s2, neuroD1)), uses(291, considers(s2, proneuralProgram)), uses(295, enables(proneuralProgram, neuroD1))]).
substitution(301, ['Cell' = s2, 'Marker' = sox2]).
proof(301, expresses(s2, sox2), rule(25), [uses(297, preserves_marker(s2, sox2))]).
substitution(302, ['Cell' = s2, 'Marker' = pax6]).
proof(302, expresses(s2, pax6), rule(25), [uses(298, preserves_marker(s2, pax6))]).
substitution(303, ['Cell' = s2, 'Program' = proneuralProgram]).
proof(303, realizes(s2, proneuralProgram), rule(26), [uses(299, integrates(s2, proneuralProgram))]).
substitution(304, []).
proof(304, enables(neuronalMaturationProgram, tubb3), rule(10), []).
substitution(305, ['Later' = s3, 'Marker' = neuroD1, 'Earlier' = s2]).
proof(305, inherits_marker(s3, neuroD1), rule(18), [uses(273, derives_from(s3, s2)), uses(300, expresses(s2, neuroD1))]).
substitution(306, ['Later' = s3, 'Marker' = sox2, 'Earlier' = s2]).
proof(306, inherits_marker(s3, sox2), rule(18), [uses(273, derives_from(s3, s2)), uses(301, expresses(s2, sox2))]).
substitution(307, ['Later' = s3, 'Marker' = pax6, 'Earlier' = s2]).
proof(307, inherits_marker(s3, pax6), rule(18), [uses(273, derives_from(s3, s2)), uses(302, expresses(s2, pax6))]).
substitution(308, ['Cell' = s2, 'Program' = proneuralProgram]).
proof(308, available_for_further_differentiation(s2, yes), rule(28), [uses(303, realizes(s2, proneuralProgram))]).
substitution(309, ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Marker' = tubb3]).
proof(309, integrates(s3, neuronalMaturationProgram), rule(24), [uses(283, targets_marker(s3, tubb3)), uses(296, considers(s3, neuronalMaturationProgram)), uses(304, enables(neuronalMaturationProgram, tubb3))]).
substitution(310, ['C' = s2, 'Y' = yes]).
proof(310, solution([s2, yes]), query, [uses(308, available_for_further_differentiation(s2, yes))]).
substitution(311, []).
proof(311, compatible_with(neuronalMaturationProgram, neuroD1), rule(9), []).
substitution(312, []).
proof(312, compatible_with(neuronalMaturationProgram, pax6), rule(8), []).
substitution(313, ['Cell' = s3, 'Program' = neuronalMaturationProgram]).
proof(313, realizes(s3, neuronalMaturationProgram), rule(26), [uses(309, integrates(s3, neuronalMaturationProgram))]).
substitution(314, ['Cell' = s3, 'Program' = neuronalMaturationProgram]).
proof(314, available_for_further_differentiation(s3, yes), rule(28), [uses(313, realizes(s3, neuronalMaturationProgram))]).
substitution(315, ['C' = s3, 'Y' = yes]).
proof(315, solution([s3, yes]), query, [uses(314, available_for_further_differentiation(s3, yes))]).
