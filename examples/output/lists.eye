# Eyelang result format 2
query(1, [call(append(?v0, ?v1, [a, b]))], [binding("left", ?v0), binding("right", ?v1)]).
result(1, complete, 3).
answer(1, [binding("left", []), binding("right", [a, b])]).
answer(1, [binding("left", [a]), binding("right", [b])]).
answer(1, [binding("left", [a, b]), binding("right", [])]).
query(2, [call(member(?v0, [a, b, a]))], [binding("x", ?v0)]).
result(2, complete, 2).
answer(2, [binding("x", a)]).
answer(2, [binding("x", b)]).
