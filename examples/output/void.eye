# Eyelang result format 2
query(1, [call(made(?v0, ?v1))], [binding("person", ?v0), binding("book", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", jamesWeatherall), binding("book", book2016)]).
query(2, [call(subject_of(?v0, ?v1))], [binding("person", ?v0), binding("book", ?v1)]).
result(2, complete, 2).
answer(2, [binding("person", isaacNewton), binding("book", book2016)]).
answer(2, [binding("person", albertEinstein), binding("book", book2016)]).
query(3, [call(subject(?v0, ?v1))], [binding("book", ?v0), binding("topic", ?v1)]).
result(3, complete, 1).
answer(3, [binding("book", book2016), binding("topic", quantumTheory)]).
query(4, [call(recommended_for(?v0, ?v1))], [binding("book", ?v0), binding("reader", ?v1)]).
result(4, complete, 1).
answer(4, [binding("book", book2016), binding("reader", curiousPhysicsReaderEn)]).
