# Eyelang result format 2
query(1, [call(direct_links(?v0))], [binding("links", ?v0)]).
result(1, complete, 1).
answer(1, [binding("links", 69)]).
query(2, [call(reachable_pairs(?v0))], [binding("pairs", ?v0)]).
result(2, complete, 1).
answer(2, [binding("pairs", 2415)]).
query(3, [call(test_is(?v0))], [binding("r", ?v0)]).
result(3, complete, 1).
answer(3, [binding("r", true)]).
