# Eyelang result format 2
query(1, [call(inherits_requirement(?v0, ?v1))], [binding("l", ?v0), binding("r", ?v1)]).
result(1, complete, 4).
answer(1, [binding("l", r2), binding("r", stiffnessReq)]).
answer(1, [binding("l", r2), binding("r", assemblyReq)]).
answer(1, [binding("l", r3), binding("r", stiffnessReq)]).
answer(1, [binding("l", r3), binding("r", assemblyReq)]).
query(2, [call(considers(?v0, ?v1))], [binding("rev", ?v0), binding("o", ?v1)]).
result(2, complete, 2).
answer(2, [binding("rev", r2), binding("o", carbonFrame)]).
answer(2, [binding("rev", r3), binding("o", ribbedHousing)]).
query(3, [call(preserves(?v0, ?v1))], [binding("rev", ?v0), binding("r", ?v1)]).
result(3, complete, 3).
answer(3, [binding("rev", r2), binding("r", stiffnessReq)]).
answer(3, [binding("rev", r2), binding("r", assemblyReq)]).
answer(3, [binding("rev", r3), binding("r", assemblyReq)]).
query(4, [call(integrates(?v0, ?v1))], [binding("rev", ?v0), binding("o", ?v1)]).
result(4, complete, 2).
answer(4, [binding("rev", r2), binding("o", carbonFrame)]).
answer(4, [binding("rev", r3), binding("o", ribbedHousing)]).
query(5, [call(satisfies(?v0, ?v1))], [binding("rev", ?v0), binding("r", ?v1)]).
result(5, complete, 5).
answer(5, [binding("rev", r1), binding("r", stiffnessReq)]).
answer(5, [binding("rev", r1), binding("r", assemblyReq)]).
answer(5, [binding("rev", r2), binding("r", stiffnessReq)]).
answer(5, [binding("rev", r2), binding("r", assemblyReq)]).
answer(5, [binding("rev", r3), binding("r", assemblyReq)]).
query(6, [call(realizes(?v0, ?v1))], [binding("rev", ?v0), binding("o", ?v1)]).
result(6, complete, 3).
answer(6, [binding("rev", r1), binding("o", aluminumFrame)]).
answer(6, [binding("rev", r2), binding("o", carbonFrame)]).
answer(6, [binding("rev", r3), binding("o", ribbedHousing)]).
query(7, [call(status(?v0, ?v1))], [binding("rev", ?v0), binding("s", ?v1)]).
result(7, complete, 3).
answer(7, [binding("rev", r1), binding("s", approvedBaseline)]).
answer(7, [binding("rev", r2), binding("s", approvedBaseline)]).
answer(7, [binding("rev", r3), binding("s", approvedBaseline)]).
query(8, [call(available_for_future_iteration(?v0, ?v1))], [binding("rev", ?v0), binding("y", ?v1)]).
result(8, complete, 3).
answer(8, [binding("rev", r1), binding("y", yes)]).
answer(8, [binding("rev", r2), binding("y", yes)]).
answer(8, [binding("rev", r3), binding("y", yes)]).
