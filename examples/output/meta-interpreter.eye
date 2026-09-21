# Eyelang result format 2
query(1, [call(demo(ancestor(ann, ?v0)))], [binding("descendant", ?v0)]).
result(1, complete, 2).
answer(1, [binding("descendant", bob)]).
answer(1, [binding("descendant", cid)]).
query(2, [call(steps(ancestor(ann, cid), ?v0))], [binding("clauses", ?v0)]).
result(2, complete, 1).
answer(2, [binding("clauses", 4)]).
query(3, [call(clause(ancestor(?v0, ?v1), ?v2))], [binding("older", ?v0), binding("younger", ?v1), binding("body", ?v2)]).
result(3, complete, 2).
answer(3, [binding("older", ?v0), binding("younger", ?v1), binding("body", [call(parent(?v0, ?v1))])]).
answer(3, [binding("older", ?v0), binding("younger", ?v1), binding("body", [call(parent(?v0, ?v2)), call(ancestor(?v2, ?v1))])]).
