% Prolog result format 3
query(1, uri_str(iri("https://www.w3.org"), _0), ['S' = _0]).
result(1, complete, 1).
answer(1, ['S' = "https://www.w3.org"]).
why(1, ['S' = "https://www.w3.org"], 2).
query(2, uri_str(_0, "https://www.w3.org"), ['R' = _0]).
result(2, complete, 1).
answer(2, ['R' = iri("https://www.w3.org")]).
why(2, ['R' = iri("https://www.w3.org")], 4).
clause(1, uri_str(iri("https://www.w3.org"), "https://www.w3.org"), true).
substitution(1, []).
proof(1, uri_str(iri("https://www.w3.org"), "https://www.w3.org"), rule(1), []).
substitution(2, ['S' = "https://www.w3.org"]).
proof(2, solution(["https://www.w3.org"]), query, [uses(1, uri_str(iri("https://www.w3.org"), "https://www.w3.org"))]).
substitution(3, []).
proof(3, uri_str(iri("https://www.w3.org"), "https://www.w3.org"), rule(1), []).
substitution(4, ['R' = iri("https://www.w3.org")]).
proof(4, solution([iri("https://www.w3.org")]), query, [uses(3, uri_str(iri("https://www.w3.org"), "https://www.w3.org"))]).
