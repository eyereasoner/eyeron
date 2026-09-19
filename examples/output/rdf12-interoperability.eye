# Eyelang result format 2
query(1, [call(name(?v0, ?v1))], [binding("person", ?v0), binding("text", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", iri("https://example/alice")), binding("text", "Alice")]).
query(2, [call(annotation(?v0, ?v1, ?v2, ?v3, ?v4))], [binding("subject", ?v0), binding("predicate", ?v1), binding("object", ?v2), binding("source", ?v3), binding("graph", ?v4)]).
result(2, complete, 1).
answer(2, [binding("subject", iri("https://example/alice")), binding("predicate", iri("https://example/knows")), binding("object", iri("https://example/bob")), binding("source", iri("https://example/chat")), binding("graph", iri("https://example/graph"))]).
query(3, [call(rdf(iri("https://example/document"), iri("https://example/title"), ?v0, ?v1))], [binding("title", ?v0), binding("graph", ?v1)]).
result(3, complete, 1).
answer(3, [binding("title", literal("HTML و CSS", language("ar", rtl))), binding("graph", iri("https://example/graph"))]).
