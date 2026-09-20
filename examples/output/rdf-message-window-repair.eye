# Eyelang result format 2
query(1, [call(raw_conflict(?v0))], [binding("door", ?v0)]).
result(1, complete, 1).
answer(1, [binding("door", doorA)]).
query(2, [call(preferred_repair(?v0, ?v1, ?v2, ?v3))], [binding("evidence", ?v0), binding("state", ?v1), binding("priority", ?v2), binding("source", ?v3)]).
result(2, complete, 1).
answer(2, [binding("evidence", reading004), binding("state", closed), binding("priority", 3), binding("source", "safety-controller")]).
query(3, [call(materialized_action(?v0))], [binding("text", ?v0)]).
result(3, complete, 1).
answer(3, [binding("text", "mark the fire compartment as sealed")]).
