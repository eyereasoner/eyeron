# Eyelang result format 2
query(1, [call(report(?v0))], [binding("statement", ?v0)]).
result(1, complete, 1).
answer(1, [binding("statement", quoted([triple(joe, is, [good, Cobbler])]))]).
query(2, [call(is(joe, good))], []).
result(2, complete, 0).
