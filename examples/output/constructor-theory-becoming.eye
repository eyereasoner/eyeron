# Eyelang result format 2
query(1, [call(status(?v0, ?v1))], [binding("x", ?v0), binding("s", ?v1)]).
result(1, complete, 4).
answer(1, [binding("x", perfectRestoreTask), binding("s", impossibleTask)]).
answer(1, [binding("x", writeTask), binding("s", possibleTask)]).
answer(1, [binding("x", stabilizeTask), binding("s", possibleTask)]).
answer(1, [binding("x", vBad), binding("s", blockedTransition)]).
query(2, [call(retains_capacity_for(?v0, ?v1))], [binding("c", ?v0), binding("t", ?v1)]).
result(2, complete, 2).
answer(2, [binding("c", writer), binding("t", writeTask)]).
answer(2, [binding("c", stabilizer), binding("t", stabilizeTask)]).
query(3, [call(can_undergo(?v0, ?v1))], [binding("next", ?v0), binding("task", ?v1)]).
result(3, complete, 2).
answer(3, [binding("next", v2), binding("task", writeTask)]).
answer(3, [binding("next", v3), binding("task", stabilizeTask)]).
query(4, [call(becomes_from(?v0, ?v1))], [binding("next", ?v0), binding("prev", ?v1)]).
result(4, complete, 2).
answer(4, [binding("next", v2), binding("prev", v1)]).
answer(4, [binding("next", v3), binding("prev", v2)]).
query(5, [call(has_attribute(?v0, ?v1))], [binding("x", ?v0), binding("attr", ?v1)]).
result(5, complete, 4).
answer(5, [binding("x", v1), binding("attr", blankMemory)]).
answer(5, [binding("x", damaged1), binding("attr", damagedMemory)]).
answer(5, [binding("x", v2), binding("attr", encodedMemory)]).
answer(5, [binding("x", v3), binding("attr", stabilizedMemory)]).
query(6, [call(available_for_further_task(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(6, complete, 4).
answer(6, [binding("x", v1), binding("y", yes)]).
answer(6, [binding("x", damaged1), binding("y", yes)]).
answer(6, [binding("x", v2), binding("y", yes)]).
answer(6, [binding("x", v3), binding("y", yes)]).
