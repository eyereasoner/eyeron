% Prolog result format 4
query(1, inherits_marker(_0, _1), ['L' = _0, 'M' = _1]).
result(1, complete, 5).
answer(1, ['L' = s2, 'M' = sox2]).
why(1, ['L' = s2, 'M' = sox2], [inherits_marker(s2, sox2)]).
answer(1, ['L' = s2, 'M' = pax6]).
why(1, ['L' = s2, 'M' = pax6], [inherits_marker(s2, pax6)]).
answer(1, ['L' = s3, 'M' = neuroD1]).
why(1, ['L' = s3, 'M' = neuroD1], [inherits_marker(s3, neuroD1)]).
answer(1, ['L' = s3, 'M' = sox2]).
why(1, ['L' = s3, 'M' = sox2], [inherits_marker(s3, sox2)]).
answer(1, ['L' = s3, 'M' = pax6]).
why(1, ['L' = s3, 'M' = pax6], [inherits_marker(s3, pax6)]).
query(2, considers(_0, _1), ['C' = _0, 'P' = _1]).
result(2, complete, 2).
answer(2, ['C' = s2, 'P' = proneuralProgram]).
why(2, ['C' = s2, 'P' = proneuralProgram], [considers(s2, proneuralProgram)]).
answer(2, ['C' = s3, 'P' = neuronalMaturationProgram]).
why(2, ['C' = s3, 'P' = neuronalMaturationProgram], [considers(s3, neuronalMaturationProgram)]).
query(3, targets_marker(_0, _1), ['C' = _0, 'M' = _1]).
result(3, complete, 2).
answer(3, ['C' = s2, 'M' = neuroD1]).
why(3, ['C' = s2, 'M' = neuroD1], [targets_marker(s2, neuroD1)]).
answer(3, ['C' = s3, 'M' = tubb3]).
why(3, ['C' = s3, 'M' = tubb3], [targets_marker(s3, tubb3)]).
query(4, preserves_marker(_0, _1), ['C' = _0, 'M' = _1]).
result(4, complete, 4).
answer(4, ['C' = s2, 'M' = sox2]).
why(4, ['C' = s2, 'M' = sox2], [preserves_marker(s2, sox2)]).
answer(4, ['C' = s2, 'M' = pax6]).
why(4, ['C' = s2, 'M' = pax6], [preserves_marker(s2, pax6)]).
answer(4, ['C' = s3, 'M' = neuroD1]).
why(4, ['C' = s3, 'M' = neuroD1], [preserves_marker(s3, neuroD1)]).
answer(4, ['C' = s3, 'M' = pax6]).
why(4, ['C' = s3, 'M' = pax6], [preserves_marker(s3, pax6)]).
query(5, integrates(_0, _1), ['C' = _0, 'P' = _1]).
result(5, complete, 2).
answer(5, ['C' = s2, 'P' = proneuralProgram]).
why(5, ['C' = s2, 'P' = proneuralProgram], [integrates(s2, proneuralProgram)]).
answer(5, ['C' = s3, 'P' = neuronalMaturationProgram]).
why(5, ['C' = s3, 'P' = neuronalMaturationProgram], [integrates(s3, neuronalMaturationProgram)]).
query(6, expresses(_0, _1), ['C' = _0, 'M' = _1]).
result(6, complete, 8).
answer(6, ['C' = s1, 'M' = sox2]).
why(6, ['C' = s1, 'M' = sox2], [expresses(s1, sox2)]).
answer(6, ['C' = s1, 'M' = pax6]).
why(6, ['C' = s1, 'M' = pax6], [expresses(s1, pax6)]).
answer(6, ['C' = s2, 'M' = neuroD1]).
why(6, ['C' = s2, 'M' = neuroD1], [expresses(s2, neuroD1)]).
answer(6, ['C' = s3, 'M' = tubb3]).
why(6, ['C' = s3, 'M' = tubb3], [expresses(s3, tubb3)]).
answer(6, ['C' = s2, 'M' = sox2]).
why(6, ['C' = s2, 'M' = sox2], [expresses(s2, sox2)]).
answer(6, ['C' = s2, 'M' = pax6]).
why(6, ['C' = s2, 'M' = pax6], [expresses(s2, pax6)]).
answer(6, ['C' = s3, 'M' = neuroD1]).
why(6, ['C' = s3, 'M' = neuroD1], [expresses(s3, neuroD1)]).
answer(6, ['C' = s3, 'M' = pax6]).
why(6, ['C' = s3, 'M' = pax6], [expresses(s3, pax6)]).
query(7, realizes(_0, _1), ['C' = _0, 'P' = _1]).
result(7, complete, 2).
answer(7, ['C' = s2, 'P' = proneuralProgram]).
why(7, ['C' = s2, 'P' = proneuralProgram], [realizes(s2, proneuralProgram)]).
answer(7, ['C' = s3, 'P' = neuronalMaturationProgram]).
why(7, ['C' = s3, 'P' = neuronalMaturationProgram], [realizes(s3, neuronalMaturationProgram)]).
query(8, status(_0, _1), ['C' = _0, 'S' = _1]).
result(8, complete, 3).
answer(8, ['C' = s1, 'S' = stableCellState]).
why(8, ['C' = s1, 'S' = stableCellState], [status(s1, stableCellState)]).
answer(8, ['C' = s2, 'S' = stableCellState]).
why(8, ['C' = s2, 'S' = stableCellState], [status(s2, stableCellState)]).
answer(8, ['C' = s3, 'S' = stableCellState]).
why(8, ['C' = s3, 'S' = stableCellState], [status(s3, stableCellState)]).
query(9, available_for_further_differentiation(_0, _1), ['C' = _0, 'Y' = _1]).
result(9, complete, 2).
answer(9, ['C' = s2, 'Y' = yes]).
why(9, ['C' = s2, 'Y' = yes], [available_for_further_differentiation(s2, yes)]).
answer(9, ['C' = s3, 'Y' = yes]).
why(9, ['C' = s3, 'Y' = yes], [available_for_further_differentiation(s3, yes)]).

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
clause(18,
       inherits_marker(var('Later'), var('Marker')),
       (derives_from(var('Later'), var('Earlier')), expresses(var('Earlier'), var('Marker')))).
clause(19,
       considers(var('Cell'), var('Program')),
       (receives(var('Cell'), var('Signal')), suggests(var('Signal'), var('Program')))).
clause(20,
       targets_marker(var('Cell'), var('Marker')),
       (receives(var('Cell'), var('Signal')), introduces_marker(var('Signal'), var('Marker')))).
clause(21,
       preserves_marker(var('Cell'), var('Marker')),
       (inherits_marker(var('Cell'), var('Marker')),
        considers(var('Cell'), var('Program')),
        compatible_with(var('Program'), var('Marker')))).
clause(22,
       integrates(var('Cell'), var('Program')),
       (inherits_marker(var('Cell'), var('Marker')),
        considers(var('Cell'), var('Program')),
        compatible_with(var('Program'), var('Marker')))).
clause(23,
       expresses(var('Cell'), var('Marker')),
       (targets_marker(var('Cell'), var('Marker')),
        considers(var('Cell'), var('Program')),
        enables(var('Program'), var('Marker')))).
clause(24,
       integrates(var('Cell'), var('Program')),
       (targets_marker(var('Cell'), var('Marker')),
        considers(var('Cell'), var('Program')),
        enables(var('Program'), var('Marker')))).
clause(25, expresses(var('Cell'), var('Marker')), preserves_marker(var('Cell'), var('Marker'))).
clause(26, realizes(var('Cell'), var('Program')), integrates(var('Cell'), var('Program'))).
clause(27, achieves(var('Cell'), stableCellState), realizes(var('Cell'), var('Program'))).
clause(28,
       available_for_further_differentiation(var('Cell'), yes),
       realizes(var('Cell'), var('Program'))).
clause(29, status(var('Cell'), stableCellState), achieves(var('Cell'), stableCellState)).

step(inherits_marker(s2, sox2),
     rule(18),
     ['Later' = s2, 'Marker' = sox2, 'Earlier' = s1],
     [derives_from(s2, s1), expresses(s1, sox2)]).
step(derives_from(s2, s1), fact(14), [], []).
step(expresses(s1, sox2), fact(11), [], []).
step(inherits_marker(s2, pax6),
     rule(18),
     ['Later' = s2, 'Marker' = pax6, 'Earlier' = s1],
     [derives_from(s2, s1), expresses(s1, pax6)]).
step(expresses(s1, pax6), fact(12), [], []).
step(inherits_marker(s3, neuroD1),
     rule(18),
     ['Later' = s3, 'Marker' = neuroD1, 'Earlier' = s2],
     [derives_from(s3, s2), expresses(s2, neuroD1)]).
step(derives_from(s3, s2), fact(16), [], []).
step(expresses(s2, neuroD1),
     rule(23),
     ['Cell' = s2, 'Marker' = neuroD1, 'Program' = proneuralProgram],
     [targets_marker(s2, neuroD1),
      considers(s2, proneuralProgram),
      enables(proneuralProgram, neuroD1)]).
step(targets_marker(s2, neuroD1),
     rule(20),
     ['Cell' = s2, 'Marker' = neuroD1, 'Signal' = neurogenicSignal],
     [receives(s2, neurogenicSignal), introduces_marker(neurogenicSignal, neuroD1)]).
step(receives(s2, neurogenicSignal), fact(15), [], []).
step(introduces_marker(neurogenicSignal, neuroD1), fact(2), [], []).
step(considers(s2, proneuralProgram),
     rule(19),
     ['Cell' = s2, 'Program' = proneuralProgram, 'Signal' = neurogenicSignal],
     [receives(s2, neurogenicSignal), suggests(neurogenicSignal, proneuralProgram)]).
step(suggests(neurogenicSignal, proneuralProgram), fact(1), [], []).
step(enables(proneuralProgram, neuroD1), fact(7), [], []).
step(inherits_marker(s3, sox2),
     rule(18),
     ['Later' = s3, 'Marker' = sox2, 'Earlier' = s2],
     [derives_from(s3, s2), expresses(s2, sox2)]).
step(expresses(s2, sox2),
     rule(25),
     ['Cell' = s2, 'Marker' = sox2],
     [preserves_marker(s2, sox2)]).
step(preserves_marker(s2, sox2),
     rule(21),
     ['Cell' = s2, 'Marker' = sox2, 'Program' = proneuralProgram],
     [inherits_marker(s2, sox2),
      considers(s2, proneuralProgram),
      compatible_with(proneuralProgram, sox2)]).
step(compatible_with(proneuralProgram, sox2), fact(5), [], []).
step(inherits_marker(s3, pax6),
     rule(18),
     ['Later' = s3, 'Marker' = pax6, 'Earlier' = s2],
     [derives_from(s3, s2), expresses(s2, pax6)]).
step(expresses(s2, pax6),
     rule(25),
     ['Cell' = s2, 'Marker' = pax6],
     [preserves_marker(s2, pax6)]).
step(preserves_marker(s2, pax6),
     rule(21),
     ['Cell' = s2, 'Marker' = pax6, 'Program' = proneuralProgram],
     [inherits_marker(s2, pax6),
      considers(s2, proneuralProgram),
      compatible_with(proneuralProgram, pax6)]).
step(compatible_with(proneuralProgram, pax6), fact(6), [], []).
step(considers(s3, neuronalMaturationProgram),
     rule(19),
     ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Signal' = maturationSignal],
     [receives(s3, maturationSignal), suggests(maturationSignal, neuronalMaturationProgram)]).
step(receives(s3, maturationSignal), fact(17), [], []).
step(suggests(maturationSignal, neuronalMaturationProgram), fact(3), [], []).
step(targets_marker(s3, tubb3),
     rule(20),
     ['Cell' = s3, 'Marker' = tubb3, 'Signal' = maturationSignal],
     [receives(s3, maturationSignal), introduces_marker(maturationSignal, tubb3)]).
step(introduces_marker(maturationSignal, tubb3), fact(4), [], []).
step(preserves_marker(s3, neuroD1),
     rule(21),
     ['Cell' = s3, 'Marker' = neuroD1, 'Program' = neuronalMaturationProgram],
     [inherits_marker(s3, neuroD1),
      considers(s3, neuronalMaturationProgram),
      compatible_with(neuronalMaturationProgram, neuroD1)]).
step(compatible_with(neuronalMaturationProgram, neuroD1), fact(9), [], []).
step(preserves_marker(s3, pax6),
     rule(21),
     ['Cell' = s3, 'Marker' = pax6, 'Program' = neuronalMaturationProgram],
     [inherits_marker(s3, pax6),
      considers(s3, neuronalMaturationProgram),
      compatible_with(neuronalMaturationProgram, pax6)]).
step(compatible_with(neuronalMaturationProgram, pax6), fact(8), [], []).
step(integrates(s2, proneuralProgram),
     rule(22),
     ['Cell' = s2, 'Program' = proneuralProgram, 'Marker' = sox2],
     [inherits_marker(s2, sox2),
      considers(s2, proneuralProgram),
      compatible_with(proneuralProgram, sox2)]).
step(integrates(s3, neuronalMaturationProgram),
     rule(24),
     ['Cell' = s3, 'Program' = neuronalMaturationProgram, 'Marker' = tubb3],
     [targets_marker(s3, tubb3),
      considers(s3, neuronalMaturationProgram),
      enables(neuronalMaturationProgram, tubb3)]).
step(enables(neuronalMaturationProgram, tubb3), fact(10), [], []).
step(expresses(s3, tubb3),
     rule(23),
     ['Cell' = s3, 'Marker' = tubb3, 'Program' = neuronalMaturationProgram],
     [targets_marker(s3, tubb3),
      considers(s3, neuronalMaturationProgram),
      enables(neuronalMaturationProgram, tubb3)]).
step(expresses(s3, neuroD1),
     rule(25),
     ['Cell' = s3, 'Marker' = neuroD1],
     [preserves_marker(s3, neuroD1)]).
step(expresses(s3, pax6),
     rule(25),
     ['Cell' = s3, 'Marker' = pax6],
     [preserves_marker(s3, pax6)]).
step(realizes(s2, proneuralProgram),
     rule(26),
     ['Cell' = s2, 'Program' = proneuralProgram],
     [integrates(s2, proneuralProgram)]).
step(realizes(s3, neuronalMaturationProgram),
     rule(26),
     ['Cell' = s3, 'Program' = neuronalMaturationProgram],
     [integrates(s3, neuronalMaturationProgram)]).
step(status(s1, stableCellState), rule(29), ['Cell' = s1], [achieves(s1, stableCellState)]).
step(achieves(s1, stableCellState), fact(13), [], []).
step(status(s2, stableCellState), rule(29), ['Cell' = s2], [achieves(s2, stableCellState)]).
step(achieves(s2, stableCellState),
     rule(27),
     ['Cell' = s2, 'Program' = proneuralProgram],
     [realizes(s2, proneuralProgram)]).
step(status(s3, stableCellState), rule(29), ['Cell' = s3], [achieves(s3, stableCellState)]).
step(achieves(s3, stableCellState),
     rule(27),
     ['Cell' = s3, 'Program' = neuronalMaturationProgram],
     [realizes(s3, neuronalMaturationProgram)]).
step(available_for_further_differentiation(s2, yes),
     rule(28),
     ['Cell' = s2, 'Program' = proneuralProgram],
     [realizes(s2, proneuralProgram)]).
step(available_for_further_differentiation(s3, yes),
     rule(28),
     ['Cell' = s3, 'Program' = neuronalMaturationProgram],
     [realizes(s3, neuronalMaturationProgram)]).
