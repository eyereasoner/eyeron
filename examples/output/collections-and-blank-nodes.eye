# Eyelang result format 2
query(1, [call(knows_named(?v0, ?v1))], [binding("person", ?v0), binding("name", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", alice), binding("name", "Bob")]).
query(2, [call(first_member(?v0))], [binding("first", ?v0)]).
result(2, complete, 1).
answer(2, [binding("first", alice)]).
