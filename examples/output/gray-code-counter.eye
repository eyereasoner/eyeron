# Eyelang result format 2
query(1, [call(counter([1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0], ?v0))], [binding("states", ?v0)]).
result(1, complete, 1).
answer(1, [binding("states", [[0, 0, 1], [0, 1, 1], [0, 1, 0], [1, 1, 0], [1, 1, 1], [1, 0, 1], [1, 0, 0], [0, 0, 0], [0, 0, 1]])]).
query(2, [call(gcc(0, [1, 0, 1], ?v0))], [binding("state", ?v0)]).
result(2, complete, 1).
answer(2, [binding("state", [1, 0, 1])]).
