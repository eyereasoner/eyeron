# Eyelang result format 2
query(1, [call(first(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", 1)]).
query(2, [call(blank_property(?v0))], [binding("x", ?v0)]).
result(2, complete, 1).
answer(2, [binding("x", q)]).
query(3, [call(nested_first(?v0))], [binding("x", ?v0)]).
result(3, complete, 1).
answer(3, [binding("x", 2)]).
