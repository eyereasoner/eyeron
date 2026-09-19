# Eyelang result format 2
query(1, [call(grandparent_of(?v0, ?v1))], [binding("person", ?v0), binding("grandchild", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", alice), binding("grandchild", carol)]).
query(2, [call(has_parent(?v0, ?v1))], [binding("child", ?v0), binding("parent", ?v1)]).
result(2, complete, 2).
answer(2, [binding("child", bob), binding("parent", alice)]).
answer(2, [binding("child", carol), binding("parent", bob)]).
