# Eyelang result format 2
query(1, [call(a_b_c(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
query(2, [call(test_is(?v0))], [binding("r", ?v0)]).
result(2, complete, 0).
