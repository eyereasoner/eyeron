# RDF-shaped values are ordinary constructors in this prototype.
# This is a named-graph join, not an RDF parser or complete RDF adapter.
quad(iri("https://example/alice"), iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")).
quad(iri("https://example/alice"), iri("https://example/approved"), iri("https://example/claim1"), iri("https://example/reviews")).
trusted(?claim) if
    quad(?person, iri("https://example/role"), iri("https://example/reviewer"), iri("https://example/staff")),
    quad(?person, iri("https://example/approved"), ?claim, iri("https://example/reviews")).
ask trusted(?claim).
