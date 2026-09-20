# Eyelang result format 2
query(1, [call(must_have(?v0, ?v1))], [binding("person", ?v0), binding("license", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", alice), binding("license", dogLicense)]).
query(2, [call(dog_count(?v0, ?v1))], [binding("person", ?v0), binding("count", ?v1)]).
result(2, complete, 2).
answer(2, [binding("person", alice), binding("count", 5)]).
answer(2, [binding("person", bob), binding("count", 2)]).
