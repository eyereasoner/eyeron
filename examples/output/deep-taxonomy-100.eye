# Eyelang result format 2
query(1, [call(arc(?v0, ?v1))], [binding("check", ?v0), binding("message", ?v1)]).
result(1, complete, 6).
answer(1, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")]).
answer(1, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")]).
answer(1, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n50 and still carries both side-label branches.")]).
answer(1, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n99 to n100 was completed.")]).
answer(1, [binding("check", check5), binding("message", "C5 OK - once n100 is reached, the terminal class a2 is derived.")]).
answer(1, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")]).
query(2, [call(holds_result(test, true))], []).
result(2, complete, 1).
answer(2, []).
