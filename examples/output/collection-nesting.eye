# Eyelang result format 2
query(1, [call(first(?v0))], [binding("value", ?v0)]).
result(1, complete, 1).
answer(1, [binding("value", 1)]).
query(2, [call(second_property(?v0))], [binding("value", ?v0)]).
result(2, complete, 1).
answer(2, [binding("value", q)]).
query(3, [call(third_first(?v0))], [binding("value", ?v0)]).
result(3, complete, 1).
answer(3, [binding("value", 2)]).
