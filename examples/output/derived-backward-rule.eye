# Eyelang result format 2
query(1, [call(has_parent(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(1, complete, 1).
answer(1, [binding("x", bob), binding("y", alice)]).
query(2, [call(child_of(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(2, complete, 1).
answer(2, [binding("x", bob), binding("y", alice)]).
