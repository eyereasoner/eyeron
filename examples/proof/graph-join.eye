# Eyelang result format 2
query(1, [call(trusted(?v0))], [binding("claim", ?v0)]).
result(1, complete, 1).
answer(1, [binding("claim", iri("https://example/claim1"))]).
why(1, [binding("claim", iri("https://example/claim1"))], 4).
clause(1, quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")), []).
clause(2, quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")), []).
clause(3, trusted(var("claim")), [call(quad(var("person"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff"))), call(quad(var("person"), iri("https://example/approved"), var("claim"), iri("https://example/reviews")))]).
substitution(1, []).
proof(1, quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")), rule(1), []).
substitution(2, []).
proof(2, quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")), rule(2), []).
substitution(3, [binding("claim", iri("https://example/claim1")), binding("person", iri("https://example/alice"))]).
proof(3, trusted(iri("https://example/claim1")), rule(3), [uses(1, quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff"))), uses(2, quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")))]).
substitution(4, [binding("claim", iri("https://example/claim1"))]).
proof(4, solution([iri("https://example/claim1")]), query, [uses(3, trusted(iri("https://example/claim1")))]).
