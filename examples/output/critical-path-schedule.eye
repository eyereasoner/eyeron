# Eyelang result format 2
query(1, [call(project_finish(?v0))], [binding("finish", ?v0)]).
result(1, complete, 1).
answer(1, [binding("finish", 23)]).
query(2, [call(critical_task(?v0))], [binding("task", ?v0)]).
result(2, complete, 7).
answer(2, [binding("task", launch)]).
answer(2, [binding("task", security_review)]).
answer(2, [binding("task", integration)]).
answer(2, [binding("task", backend)]).
answer(2, [binding("task", database)]).
answer(2, [binding("task", architecture)]).
answer(2, [binding("task", requirements)]).
query(3, [call(schedule(?v0, ?v1, ?v2))], [binding("task", ?v0), binding("start", ?v1), binding("finish", ?v2)]).
result(3, complete, 11).
answer(3, [binding("task", requirements), binding("start", 0), binding("finish", 2)]).
answer(3, [binding("task", architecture), binding("start", 2), binding("finish", 5)]).
answer(3, [binding("task", api_design), binding("start", 2), binding("finish", 4)]).
answer(3, [binding("task", database), binding("start", 5), binding("finish", 9)]).
answer(3, [binding("task", backend), binding("start", 9), binding("finish", 15)]).
answer(3, [binding("task", frontend), binding("start", 4), binding("finish", 9)]).
answer(3, [binding("task", auth), binding("start", 5), binding("finish", 8)]).
answer(3, [binding("task", integration), binding("start", 15), binding("finish", 19)]).
answer(3, [binding("task", security_review), binding("start", 19), binding("finish", 22)]).
answer(3, [binding("task", load_test), binding("start", 19), binding("finish", 21)]).
answer(3, [binding("task", launch), binding("start", 22), binding("finish", 23)]).
