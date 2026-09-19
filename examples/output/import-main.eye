# Eyelang result format 2
query(1, [call(ancestor(alice, ?v0))], [binding("who", ?v0)]).
result(1, complete, 2).
answer(1, [binding("who", bob)]).
answer(1, [binding("who", carol)]).
