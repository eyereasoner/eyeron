# Eyelang result format 2
query(1, [call(negative(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", n1)]).
query(2, [call(language_direction(msg, ?v0))], [binding("direction", ?v0)]).
result(2, complete, 1).
answer(2, [binding("direction", ltr)]).
