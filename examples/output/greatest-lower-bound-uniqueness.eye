# Eyelang result format 2
query(1, [call(result_query(?v0, ?v1, ?v2, ?v3))], [binding("a", ?v0), binding("b", ?v1), binding("m", ?v2), binding("n", ?v3)]).
result(1, complete, 2).
answer(1, [binding("a", a), binding("b", b), binding("m", g1), binding("n", g2)]).
answer(1, [binding("a", a), binding("b", b), binding("m", g2), binding("n", g1)]).
