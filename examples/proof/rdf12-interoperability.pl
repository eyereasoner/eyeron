% Prolog result format 3
query(1, name(_0, _1), ['Person' = _0, 'Text' = _1]).
result(1, complete, 1).
answer(1, ['Person' = iri("https://example/alice"), 'Text' = "Alice"]).
why(1, ['Person' = iri("https://example/alice"), 'Text' = "Alice"], 3).
query(2, annotation(_0, _1, _2, _3, _4), ['Subject' = _0, 'Predicate' = _1, 'Object' = _2, 'Source' = _3, 'Graph' = _4]).
result(2, complete, 1).
answer(2, ['Subject' = iri("https://example/alice"), 'Predicate' = iri("https://example/knows"), 'Object' = iri("https://example/bob"), 'Source' = iri("https://example/chat"), 'Graph' = iri("https://example/graph")]).
why(2, ['Subject' = iri("https://example/alice"), 'Predicate' = iri("https://example/knows"), 'Object' = iri("https://example/bob"), 'Source' = iri("https://example/chat"), 'Graph' = iri("https://example/graph")], 7).
query(3, rdf(iri("https://example/document"), iri("https://example/title"), _0, _1), ['Title' = _0, 'Graph' = _1]).
result(3, complete, 1).
answer(3, ['Title' = literal("HTML و CSS", language("ar", rtl)), 'Graph' = iri("https://example/graph")]).
why(3, ['Title' = literal("HTML و CSS", language("ar", rtl)), 'Graph' = iri("https://example/graph")], 9).
clause(1, rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph), true).
clause(4, rdf(iri("https://example/document"), iri("https://example/title"), literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")), true).
clause(5, rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph")), true).
clause(6, rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph")), true).
clause(7, name(var('Person'), var('Text')), rdf(var('Person'), iri("https://example/name"), literal(var('Text'), datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph)).
clause(8, annotation(var('Subject'), var('Predicate'), var('Object'), var('Source'), var('Graph')), (rdf(var('Reifier'), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(var('Subject'), var('Predicate'), var('Object')), var('Graph')), rdf(var('Reifier'), iri("https://example/source"), var('Source'), var('Graph')))).
substitution(1, []).
proof(1, rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph), rule(1), []).
substitution(2, ['Person' = iri("https://example/alice"), 'Text' = "Alice"]).
proof(2, name(iri("https://example/alice"), "Alice"), rule(7), [uses(1, rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph))]).
substitution(3, ['Person' = iri("https://example/alice"), 'Text' = "Alice"]).
proof(3, solution([iri("https://example/alice"), "Alice"]), query, [uses(2, name(iri("https://example/alice"), "Alice"))]).
substitution(4, []).
proof(4, rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph")), rule(5), []).
substitution(5, []).
proof(5, rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph")), rule(6), []).
substitution(6, ['Subject' = iri("https://example/alice"), 'Predicate' = iri("https://example/knows"), 'Object' = iri("https://example/bob"), 'Source' = iri("https://example/chat"), 'Graph' = iri("https://example/graph"), 'Reifier' = blank("d0_claim")]).
proof(6, annotation(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob"), iri("https://example/chat"), iri("https://example/graph")), rule(8), [uses(4, rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph"))), uses(5, rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph")))]).
substitution(7, ['Subject' = iri("https://example/alice"), 'Predicate' = iri("https://example/knows"), 'Object' = iri("https://example/bob"), 'Source' = iri("https://example/chat"), 'Graph' = iri("https://example/graph")]).
proof(7, solution([iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob"), iri("https://example/chat"), iri("https://example/graph")]), query, [uses(6, annotation(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob"), iri("https://example/chat"), iri("https://example/graph")))]).
substitution(8, []).
proof(8, rdf(iri("https://example/document"), iri("https://example/title"), literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")), rule(4), []).
substitution(9, ['Title' = literal("HTML و CSS", language("ar", rtl)), 'Graph' = iri("https://example/graph")]).
proof(9, solution([literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")]), query, [uses(8, rdf(iri("https://example/document"), iri("https://example/title"), literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")))]).
