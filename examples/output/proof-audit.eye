# Eyelang result format 2
query(1, [call(query_dependency(1, ?v0))], [binding("ancestor", ?v0)]).
result(1, complete, 3).
answer(1, [binding("ancestor", 5)]).
answer(1, [binding("ancestor", 1)]).
answer(1, [binding("ancestor", 3)]).
query(2, [call(support(1, ?v0))], [binding("fact", ?v0)]).
result(2, complete, 2).
answer(2, [binding("fact", instance_of(socrates, human))]).
answer(2, [binding("fact", subclass_of(human, mortal))]).
query(3, [call(answer_applied(1, ?v0, ?v1, ?v2))], [binding("proof", ?v0), binding("name", ?v1), binding("value", ?v2)]).
result(3, complete, 3).
answer(3, [binding("proof", 5), binding("name", "individual"), binding("value", socrates)]).
answer(3, [binding("proof", 5), binding("name", "superclass"), binding("value", mortal)]).
answer(3, [binding("proof", 5), binding("name", "class"), binding("value", human)]).
