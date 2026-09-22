% Prolog result format 4
query(1, inherits_requirement(_0, _1), ['L' = _0, 'R' = _1]).
result(1, complete, 4).
answer(1, ['L' = r2, 'R' = stiffnessReq]).
answer(1, ['L' = r2, 'R' = assemblyReq]).
answer(1, ['L' = r3, 'R' = stiffnessReq]).
answer(1, ['L' = r3, 'R' = assemblyReq]).
query(2, considers(_0, _1), ['Rev' = _0, 'O' = _1]).
result(2, complete, 2).
answer(2, ['Rev' = r2, 'O' = carbonFrame]).
answer(2, ['Rev' = r3, 'O' = ribbedHousing]).
query(3, preserves(_0, _1), ['Rev' = _0, 'R' = _1]).
result(3, complete, 3).
answer(3, ['Rev' = r2, 'R' = stiffnessReq]).
answer(3, ['Rev' = r2, 'R' = assemblyReq]).
answer(3, ['Rev' = r3, 'R' = assemblyReq]).
query(4, integrates(_0, _1), ['Rev' = _0, 'O' = _1]).
result(4, complete, 2).
answer(4, ['Rev' = r2, 'O' = carbonFrame]).
answer(4, ['Rev' = r3, 'O' = ribbedHousing]).
query(5, satisfies(_0, _1), ['Rev' = _0, 'R' = _1]).
result(5, complete, 5).
answer(5, ['Rev' = r1, 'R' = stiffnessReq]).
answer(5, ['Rev' = r1, 'R' = assemblyReq]).
answer(5, ['Rev' = r2, 'R' = stiffnessReq]).
answer(5, ['Rev' = r2, 'R' = assemblyReq]).
answer(5, ['Rev' = r3, 'R' = assemblyReq]).
query(6, realizes(_0, _1), ['Rev' = _0, 'O' = _1]).
result(6, complete, 3).
answer(6, ['Rev' = r1, 'O' = aluminumFrame]).
answer(6, ['Rev' = r2, 'O' = carbonFrame]).
answer(6, ['Rev' = r3, 'O' = ribbedHousing]).
query(7, status(_0, _1), ['Rev' = _0, 'S' = _1]).
result(7, complete, 3).
answer(7, ['Rev' = r1, 'S' = approvedBaseline]).
answer(7, ['Rev' = r2, 'S' = approvedBaseline]).
answer(7, ['Rev' = r3, 'S' = approvedBaseline]).
query(8, available_for_future_iteration(_0, _1), ['Rev' = _0, 'Y' = _1]).
result(8, complete, 3).
answer(8, ['Rev' = r1, 'Y' = yes]).
answer(8, ['Rev' = r2, 'Y' = yes]).
answer(8, ['Rev' = r3, 'Y' = yes]).
