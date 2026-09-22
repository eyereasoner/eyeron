% RDF-shaped values are ordinary constructors in this prototype.
% This is a named-graph join, not an RDF parser or complete RDF adapter.
quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")).
quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")).

trusted(Claim) :-
    quad(Person, iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")),
    quad(Person, iri("https://example/approved"), Claim, iri("https://example/reviews")).

?- trusted(Claim).
