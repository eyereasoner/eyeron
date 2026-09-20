# Eyelang result format 2
query(1, [call(foaf_person(?v0))], [binding("p", ?v0)]).
result(1, complete, 1).
answer(1, [binding("p", alice)]).
query(2, [call(foaf_name(?v0, ?v1))], [binding("p", ?v0), binding("name", ?v1)]).
result(2, complete, 1).
answer(2, [binding("p", alice), binding("name", "Alice Example")]).
query(3, [call(foaf_given_name(?v0, ?v1))], [binding("p", ?v0), binding("given", ?v1)]).
result(3, complete, 1).
answer(3, [binding("p", alice), binding("given", "Alice")]).
query(4, [call(foaf_family_name(?v0, ?v1))], [binding("p", ?v0), binding("family", ?v1)]).
result(4, complete, 1).
answer(4, [binding("p", alice), binding("family", "Example")]).
