# Eyelang result format 2
query(1, [call(animal(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", bobos_kind)]).
query(2, [call(test())], []).
result(2, complete, 1).
answer(2, []).
