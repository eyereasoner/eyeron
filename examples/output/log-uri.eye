# Eyelang result format 2
query(1, [call(uri_str(iri("https://www.w3.org"), ?v0))], [binding("s", ?v0)]).
result(1, complete, 1).
answer(1, [binding("s", "https://www.w3.org")]).
query(2, [call(uri_str(?v0, "https://www.w3.org"))], [binding("r", ?v0)]).
result(2, complete, 1).
answer(2, [binding("r", iri("https://www.w3.org"))]).
