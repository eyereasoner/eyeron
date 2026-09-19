# Eyelang result format 2
query(1, [call(ancestor(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(1, complete, 4).
answer(1, [binding("x", alice), binding("y", bob)]).
answer(1, [binding("x", bob), binding("y", carol)]).
answer(1, [binding("x", dora), binding("y", emma)]).
answer(1, [binding("x", alice), binding("y", carol)]).
