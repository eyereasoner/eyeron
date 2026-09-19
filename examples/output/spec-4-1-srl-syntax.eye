# Eyelang result format 2
query(1, [call(both_positive(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", x)]).
query(2, [call(one_zero(?v0))], [binding("x", ?v0)]).
result(2, complete, 0).
