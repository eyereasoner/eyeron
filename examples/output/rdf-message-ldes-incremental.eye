# Eyelang result format 2
query(1, [call(already_committed(?v0))], [binding("m", ?v0)]).
result(1, complete, 2).
answer(1, [binding("m", obs033)]).
answer(1, [binding("m", obs034)]).
query(2, [call(newly_emitted(?v0))], [binding("m", ?v0)]).
result(2, complete, 6).
answer(2, [binding("m", obs035)]).
answer(2, [binding("m", obs036)]).
answer(2, [binding("m", obs037)]).
answer(2, [binding("m", obs038)]).
answer(2, [binding("m", obs039)]).
answer(2, [binding("m", obs040)]).
query(3, [call(in_window(?v0))], [binding("m", ?v0)]).
result(3, complete, 6).
answer(3, [binding("m", obs035)]).
answer(3, [binding("m", obs036)]).
answer(3, [binding("m", obs037)]).
answer(3, [binding("m", obs038)]).
answer(3, [binding("m", obs039)]).
answer(3, [binding("m", obs040)]).
query(4, [call(raw_conflict(?v0))], [binding("door", ?v0)]).
result(4, complete, 1).
answer(4, [binding("door", doorA)]).
query(5, [call(preferred_repair(?v0, ?v1, ?v2, ?v3))], [binding("m", ?v0), binding("state", ?v1), binding("priority", ?v2), binding("source", ?v3)]).
result(5, complete, 1).
answer(5, [binding("m", obs040), binding("state", closed), binding("priority", 5), binding("source", "safety-controller")]).
query(6, [call(materialized_action(?v0))], [binding("text", ?v0)]).
result(6, complete, 1).
answer(6, [binding("text", "keep the compartment sealed and continue monitoring")]).
