# Eyelang result format 2
query(1, [call(already_committed(?v0))], [binding("m", ?v0)]).
result(1, complete, 3).
answer(1, [binding("m", obs040)]).
answer(1, [binding("m", obs041)]).
answer(1, [binding("m", obs042)]).
query(2, [call(newly_emitted(?v0))], [binding("m", ?v0)]).
result(2, complete, 6).
answer(2, [binding("m", obs043)]).
answer(2, [binding("m", obs044)]).
answer(2, [binding("m", obs045)]).
answer(2, [binding("m", obs046)]).
answer(2, [binding("m", obs047)]).
answer(2, [binding("m", obs048)]).
query(3, [call(in_window(?v0))], [binding("m", ?v0)]).
result(3, complete, 6).
answer(3, [binding("m", obs043)]).
answer(3, [binding("m", obs044)]).
answer(3, [binding("m", obs045)]).
answer(3, [binding("m", obs046)]).
answer(3, [binding("m", obs047)]).
answer(3, [binding("m", obs048)]).
query(4, [call(raw_conflict(?v0))], [binding("batch", ?v0)]).
result(4, complete, 1).
answer(4, [binding("batch", batchA)]).
query(5, [call(preferred_repair(?v0, ?v1, ?v2, ?v3))], [binding("m", ?v0), binding("temp", ?v1), binding("priority", ?v2), binding("source", ?v3)]).
result(5, complete, 1).
answer(5, [binding("m", obs047), binding("temp", 118), binding("priority", 5), binding("source", "calibrated-cold-chain-logger")]).
query(6, [call(quarantine_decision(?v0))], [binding("text", ?v0)]).
result(6, complete, 1).
answer(6, [binding("text", "quarantine batchA, notify QA, and hold shipment")]).
