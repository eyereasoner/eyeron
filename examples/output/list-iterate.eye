# Eyelang result format 2
query(1, [call(test_iterate(?v0, ?v1, ?v2))], [binding("x", ?v0), binding("i", ?v1), binding("y", ?v2)]).
result(1, complete, 3).
answer(1, [binding("x", [huey, dewey, louie]), binding("i", 0), binding("y", huey)]).
answer(1, [binding("x", [huey, dewey, louie]), binding("i", 1), binding("y", dewey)]).
answer(1, [binding("x", [huey, dewey, louie]), binding("i", 2), binding("y", louie)]).
query(2, [call(test_is(?v0))], [binding("r", ?v0)]).
result(2, complete, 1).
answer(2, [binding("r", true)]).
