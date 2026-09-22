% Prolog result format 3
query(1, status(_0, _1), ['X' = _0, 'S' = _1]).
result(1, complete, 4).
answer(1, ['X' = perfectRestoreTask, 'S' = impossibleTask]).
answer(1, ['X' = writeTask, 'S' = possibleTask]).
answer(1, ['X' = stabilizeTask, 'S' = possibleTask]).
answer(1, ['X' = vBad, 'S' = blockedTransition]).
query(2, retains_capacity_for(_0, _1), ['C' = _0, 'T' = _1]).
result(2, complete, 2).
answer(2, ['C' = writer, 'T' = writeTask]).
answer(2, ['C' = stabilizer, 'T' = stabilizeTask]).
query(3, can_undergo(_0, _1), ['Next' = _0, 'Task' = _1]).
result(3, complete, 2).
answer(3, ['Next' = v2, 'Task' = writeTask]).
answer(3, ['Next' = v3, 'Task' = stabilizeTask]).
query(4, becomes_from(_0, _1), ['Next' = _0, 'Prev' = _1]).
result(4, complete, 2).
answer(4, ['Next' = v2, 'Prev' = v1]).
answer(4, ['Next' = v3, 'Prev' = v2]).
query(5, has_attribute(_0, _1), ['X' = _0, 'Attr' = _1]).
result(5, complete, 4).
answer(5, ['X' = v1, 'Attr' = blankMemory]).
answer(5, ['X' = damaged1, 'Attr' = damagedMemory]).
answer(5, ['X' = v2, 'Attr' = encodedMemory]).
answer(5, ['X' = v3, 'Attr' = stabilizedMemory]).
query(6, available_for_further_task(_0, _1), ['X' = _0, 'Y' = _1]).
result(6, complete, 4).
answer(6, ['X' = v1, 'Y' = yes]).
answer(6, ['X' = damaged1, 'Y' = yes]).
answer(6, ['X' = v2, 'Y' = yes]).
answer(6, ['X' = v3, 'Y' = yes]).
