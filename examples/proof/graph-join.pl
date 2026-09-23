trusted(iri("https://example/claim1")).

clause(1,
       quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")),
       true).
clause(2,
       quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")),
       true).
clause(3,
       trusted(var('Claim')),
       (quad(var('Person'), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")),
        quad(var('Person'), iri("https://example/approved"), var('Claim'), iri("https://example/reviews")))).

step(trusted(iri("https://example/claim1")),
     rule(3),
     ['Claim' = iri("https://example/claim1"), 'Person' = iri("https://example/alice")],
     [quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")),
      quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews"))]).
step(quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")),
     fact(1),
     [],
     []).
step(quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")),
     fact(2),
     [],
     []).
