% Prolog result format 3
query(1, inherits_marker(_0, _1), ['L' = _0, 'M' = _1]).
result(1, complete, 5).
answer(1, ['L' = s2, 'M' = sox2]).
answer(1, ['L' = s2, 'M' = pax6]).
answer(1, ['L' = s3, 'M' = neuroD1]).
answer(1, ['L' = s3, 'M' = sox2]).
answer(1, ['L' = s3, 'M' = pax6]).
query(2, considers(_0, _1), ['C' = _0, 'P' = _1]).
result(2, complete, 2).
answer(2, ['C' = s2, 'P' = proneuralProgram]).
answer(2, ['C' = s3, 'P' = neuronalMaturationProgram]).
query(3, targets_marker(_0, _1), ['C' = _0, 'M' = _1]).
result(3, complete, 2).
answer(3, ['C' = s2, 'M' = neuroD1]).
answer(3, ['C' = s3, 'M' = tubb3]).
query(4, preserves_marker(_0, _1), ['C' = _0, 'M' = _1]).
result(4, complete, 4).
answer(4, ['C' = s2, 'M' = sox2]).
answer(4, ['C' = s2, 'M' = pax6]).
answer(4, ['C' = s3, 'M' = neuroD1]).
answer(4, ['C' = s3, 'M' = pax6]).
query(5, integrates(_0, _1), ['C' = _0, 'P' = _1]).
result(5, complete, 2).
answer(5, ['C' = s2, 'P' = proneuralProgram]).
answer(5, ['C' = s3, 'P' = neuronalMaturationProgram]).
query(6, expresses(_0, _1), ['C' = _0, 'M' = _1]).
result(6, complete, 8).
answer(6, ['C' = s1, 'M' = sox2]).
answer(6, ['C' = s1, 'M' = pax6]).
answer(6, ['C' = s2, 'M' = neuroD1]).
answer(6, ['C' = s3, 'M' = tubb3]).
answer(6, ['C' = s2, 'M' = sox2]).
answer(6, ['C' = s2, 'M' = pax6]).
answer(6, ['C' = s3, 'M' = neuroD1]).
answer(6, ['C' = s3, 'M' = pax6]).
query(7, realizes(_0, _1), ['C' = _0, 'P' = _1]).
result(7, complete, 2).
answer(7, ['C' = s2, 'P' = proneuralProgram]).
answer(7, ['C' = s3, 'P' = neuronalMaturationProgram]).
query(8, status(_0, _1), ['C' = _0, 'S' = _1]).
result(8, complete, 3).
answer(8, ['C' = s1, 'S' = stableCellState]).
answer(8, ['C' = s2, 'S' = stableCellState]).
answer(8, ['C' = s3, 'S' = stableCellState]).
query(9, available_for_further_differentiation(_0, _1), ['C' = _0, 'Y' = _1]).
result(9, complete, 2).
answer(9, ['C' = s2, 'Y' = yes]).
answer(9, ['C' = s3, 'Y' = yes]).
