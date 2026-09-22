% Prolog result format 3
query(1, trusted(_0), ['Claim' = _0]).
result(1, complete, 1).
answer(1, ['Claim' = iri("https://example/claim1")]).
why(1, ['Claim' = iri("https://example/claim1")], 4).
clause(1, quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")), true).
clause(2, quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")), true).
clause(3, trusted(var('Claim')), (quad(var('Person'), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")), quad(var('Person'), iri("https://example/approved"), var('Claim'), iri("https://example/reviews")))).
substitution(1, []).
proof(1, quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")), rule(1), []).
substitution(2, []).
proof(2, quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")), rule(2), []).
substitution(3, ['Claim' = iri("https://example/claim1"), 'Person' = iri("https://example/alice")]).
proof(3, trusted(iri("https://example/claim1")), rule(3), [uses(1, quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff"))), uses(2, quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")))]).
substitution(4, ['Claim' = iri("https://example/claim1")]).
proof(4, solution([iri("https://example/claim1")]), query, [uses(3, trusted(iri("https://example/claim1")))]).
