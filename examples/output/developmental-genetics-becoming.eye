# Eyelang result format 2
query(1, [call(inherits_marker(?v0, ?v1))], [binding("l", ?v0), binding("m", ?v1)]).
result(1, complete, 5).
answer(1, [binding("l", s2), binding("m", sox2)]).
answer(1, [binding("l", s2), binding("m", pax6)]).
answer(1, [binding("l", s3), binding("m", neuroD1)]).
answer(1, [binding("l", s3), binding("m", sox2)]).
answer(1, [binding("l", s3), binding("m", pax6)]).
query(2, [call(considers(?v0, ?v1))], [binding("c", ?v0), binding("p", ?v1)]).
result(2, complete, 2).
answer(2, [binding("c", s2), binding("p", proneuralProgram)]).
answer(2, [binding("c", s3), binding("p", neuronalMaturationProgram)]).
query(3, [call(targets_marker(?v0, ?v1))], [binding("c", ?v0), binding("m", ?v1)]).
result(3, complete, 2).
answer(3, [binding("c", s2), binding("m", neuroD1)]).
answer(3, [binding("c", s3), binding("m", tubb3)]).
query(4, [call(preserves_marker(?v0, ?v1))], [binding("c", ?v0), binding("m", ?v1)]).
result(4, complete, 4).
answer(4, [binding("c", s2), binding("m", sox2)]).
answer(4, [binding("c", s2), binding("m", pax6)]).
answer(4, [binding("c", s3), binding("m", neuroD1)]).
answer(4, [binding("c", s3), binding("m", pax6)]).
query(5, [call(integrates(?v0, ?v1))], [binding("c", ?v0), binding("p", ?v1)]).
result(5, complete, 2).
answer(5, [binding("c", s2), binding("p", proneuralProgram)]).
answer(5, [binding("c", s3), binding("p", neuronalMaturationProgram)]).
query(6, [call(expresses(?v0, ?v1))], [binding("c", ?v0), binding("m", ?v1)]).
result(6, complete, 8).
answer(6, [binding("c", s1), binding("m", sox2)]).
answer(6, [binding("c", s1), binding("m", pax6)]).
answer(6, [binding("c", s2), binding("m", neuroD1)]).
answer(6, [binding("c", s3), binding("m", tubb3)]).
answer(6, [binding("c", s2), binding("m", sox2)]).
answer(6, [binding("c", s2), binding("m", pax6)]).
answer(6, [binding("c", s3), binding("m", neuroD1)]).
answer(6, [binding("c", s3), binding("m", pax6)]).
query(7, [call(realizes(?v0, ?v1))], [binding("c", ?v0), binding("p", ?v1)]).
result(7, complete, 2).
answer(7, [binding("c", s2), binding("p", proneuralProgram)]).
answer(7, [binding("c", s3), binding("p", neuronalMaturationProgram)]).
query(8, [call(status(?v0, ?v1))], [binding("c", ?v0), binding("s", ?v1)]).
result(8, complete, 3).
answer(8, [binding("c", s1), binding("s", stableCellState)]).
answer(8, [binding("c", s2), binding("s", stableCellState)]).
answer(8, [binding("c", s3), binding("s", stableCellState)]).
query(9, [call(available_for_further_differentiation(?v0, ?v1))], [binding("c", ?v0), binding("y", ?v1)]).
result(9, complete, 2).
answer(9, [binding("c", s2), binding("y", yes)]).
answer(9, [binding("c", s3), binding("y", yes)]).
