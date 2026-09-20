# Eyelang result format 2
query(1, [call(uri_str(iri("https://www.w3.org"), ?v0))], [binding("s", ?v0)]).
result(1, complete, 1).
answer(1, [binding("s", "https://www.w3.org")]).
why(1, [binding("s", "https://www.w3.org")], 2).
query(2, [call(uri_str(?v0, "https://www.w3.org"))], [binding("r", ?v0)]).
result(2, complete, 1).
answer(2, [binding("r", iri("https://www.w3.org"))]).
why(2, [binding("r", iri("https://www.w3.org"))], 4).
clause(1, uri_str(iri("https://www.w3.org"), "https://www.w3.org"), []).
substitution(1, []).
proof(1, uri_str(iri("https://www.w3.org"), "https://www.w3.org"), rule(1), []).
substitution(2, [binding("s", "https://www.w3.org")]).
proof(2, solution(["https://www.w3.org"]), query, [uses(1, uri_str(iri("https://www.w3.org"), "https://www.w3.org"))]).
substitution(3, []).
proof(3, uri_str(iri("https://www.w3.org"), "https://www.w3.org"), rule(1), []).
substitution(4, [binding("r", iri("https://www.w3.org"))]).
proof(4, solution([iri("https://www.w3.org")]), query, [uses(3, uri_str(iri("https://www.w3.org"), "https://www.w3.org"))]).
