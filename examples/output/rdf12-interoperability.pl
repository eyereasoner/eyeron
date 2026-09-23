name(iri("https://example/alice"), "Alice").
annotation(iri("https://example/alice"),
           iri("https://example/knows"),
           iri("https://example/bob"),
           iri("https://example/chat"),
           iri("https://example/graph")).
rdf(iri("https://example/document"),
    iri("https://example/title"),
    literal("HTML و CSS", language("ar", rtl)),
    iri("https://example/graph")).
