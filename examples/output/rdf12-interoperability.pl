% Prolog result format 3
query(1, name(_0, _1), ['Person' = _0, 'Text' = _1]).
result(1, complete, 1).
answer(1, ['Person' = iri("https://example/alice"), 'Text' = "Alice"]).
query(2, annotation(_0, _1, _2, _3, _4), ['Subject' = _0, 'Predicate' = _1, 'Object' = _2, 'Source' = _3, 'Graph' = _4]).
result(2, complete, 1).
answer(2, ['Subject' = iri("https://example/alice"), 'Predicate' = iri("https://example/knows"), 'Object' = iri("https://example/bob"), 'Source' = iri("https://example/chat"), 'Graph' = iri("https://example/graph")]).
query(3, rdf(iri("https://example/document"), iri("https://example/title"), _0, _1), ['Title' = _0, 'Graph' = _1]).
result(3, complete, 1).
answer(3, ['Title' = literal("HTML و CSS", language("ar", rtl)), 'Graph' = iri("https://example/graph")]).
