# Eyelang result format 2
query(1, [call(test_concatenation(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
query(2, [call(test_equal(?v0))], [binding("r", ?v0)]).
result(2, complete, 1).
answer(2, [binding("r", true)]).
query(3, [call(test_not_equal(?v0))], [binding("r", ?v0)]).
result(3, complete, 1).
answer(3, [binding("r", true)]).
