% Prolog result format 4
query(1, uri_str(iri("https://www.w3.org"), _0), ['S' = _0]).
result(1, complete, 1).
answer(1, ['S' = "https://www.w3.org"]).
why(1, ['S' = "https://www.w3.org"], [uri_str(iri("https://www.w3.org"), "https://www.w3.org")]).
query(2, uri_str(_0, "https://www.w3.org"), ['R' = _0]).
result(2, complete, 1).
answer(2, ['R' = iri("https://www.w3.org")]).
why(2,
    ['R' = iri("https://www.w3.org")],
    [uri_str(iri("https://www.w3.org"), "https://www.w3.org")]).

clause(1, uri_str(iri("https://www.w3.org"), "https://www.w3.org"), true).

step(uri_str(iri("https://www.w3.org"), "https://www.w3.org"), fact(1), [], []).
