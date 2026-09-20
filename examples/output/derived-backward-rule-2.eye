# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
query(2, [call(type_(?v0, ?v1))], [binding("s", ?v0), binding("t", ?v1)]).
result(2, complete, 2).
answer(2, [binding("s", socrates), binding("t", human)]).
answer(2, [binding("s", socrates), binding("t", mortal)]).
