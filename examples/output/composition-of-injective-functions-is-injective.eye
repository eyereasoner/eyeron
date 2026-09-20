# Eyelang result format 2
query(1, [call(result_query(?v0, ?v1, ?v2))], [binding("h", ?v0), binding("x", ?v1), binding("y", ?v2)]).
result(1, complete, 2).
answer(1, [binding("h", h), binding("x", a), binding("y", b)]).
answer(1, [binding("h", h), binding("x", b), binding("y", a)]).
