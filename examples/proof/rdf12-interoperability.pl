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

clause(1,
       rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph),
       true).
clause(4,
       rdf(iri("https://example/document"), iri("https://example/title"), literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")),
       true).
clause(5,
       rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph")),
       true).
clause(6,
       rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph")),
       true).
clause(7,
       name(var('Person'), var('Text')),
       rdf(var('Person'), iri("https://example/name"), literal(var('Text'), datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph)).
clause(8,
       annotation(var('Subject'), var('Predicate'), var('Object'), var('Source'), var('Graph')),
       (rdf(var('Reifier'), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(var('Subject'), var('Predicate'), var('Object')), var('Graph')),
        rdf(var('Reifier'), iri("https://example/source"), var('Source'), var('Graph')))).

step(name(iri("https://example/alice"), "Alice"),
     rule(7),
     ['Person' = iri("https://example/alice"), 'Text' = "Alice"],
     [rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph)]).
step(rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph),
     fact(1),
     [],
     []).
step(annotation(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob"), iri("https://example/chat"), iri("https://example/graph")),
     rule(8),
     ['Subject' = iri("https://example/alice"),
      'Predicate' = iri("https://example/knows"),
      'Object' = iri("https://example/bob"),
      'Source' = iri("https://example/chat"),
      'Graph' = iri("https://example/graph"),
      'Reifier' = blank("d0_claim")],
     [rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph")),
      rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph"))]).
step(rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph")),
     fact(5),
     [],
     []).
step(rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph")),
     fact(6),
     [],
     []).
step(rdf(iri("https://example/document"), iri("https://example/title"), literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")),
     fact(4),
     [],
     []).
