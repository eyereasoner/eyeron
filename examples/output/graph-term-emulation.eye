# Eyelang result format 2
query(1, [call(social(?v0))], [binding("graph", ?v0)]).
result(1, complete, 1).
answer(1, [binding("graph", g1)]).
query(2, [call(mentions(?v0, ?v1))], [binding("graph", ?v0), binding("resource", ?v1)]).
result(2, complete, 5).
answer(2, [binding("graph", g1), binding("resource", alice)]).
answer(2, [binding("graph", g2), binding("resource", alice)]).
answer(2, [binding("graph", g1), binding("resource", bob)]).
answer(2, [binding("graph", g2), binding("resource", tea)]).
answer(2, [binding("graph", g1), binding("resource", carol)]).
