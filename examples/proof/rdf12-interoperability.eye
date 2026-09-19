# Eyelang result format 2
query(1, [call(name(?v0, ?v1))], [binding("person", ?v0), binding("text", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", iri("https://example/alice")), binding("text", "Alice")]).
why(1, [binding("person", iri("https://example/alice")), binding("text", "Alice")], 3).
query(2, [call(annotation(?v0, ?v1, ?v2, ?v3, ?v4))], [binding("subject", ?v0), binding("predicate", ?v1), binding("object", ?v2), binding("source", ?v3), binding("graph", ?v4)]).
result(2, complete, 1).
answer(2, [binding("subject", iri("https://example/alice")), binding("predicate", iri("https://example/knows")), binding("object", iri("https://example/bob")), binding("source", iri("https://example/chat")), binding("graph", iri("https://example/graph"))]).
why(2, [binding("subject", iri("https://example/alice")), binding("predicate", iri("https://example/knows")), binding("object", iri("https://example/bob")), binding("source", iri("https://example/chat")), binding("graph", iri("https://example/graph"))], 7).
query(3, [call(rdf(iri("https://example/document"), iri("https://example/title"), ?v0, ?v1))], [binding("title", ?v0), binding("graph", ?v1)]).
result(3, complete, 1).
answer(3, [binding("title", literal("HTML و CSS", language("ar", rtl))), binding("graph", iri("https://example/graph"))]).
why(3, [binding("title", literal("HTML و CSS", language("ar", rtl))), binding("graph", iri("https://example/graph"))], 9).
clause(1, rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph), []).
clause(4, rdf(iri("https://example/document"), iri("https://example/title"), literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")), []).
clause(5, rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph")), []).
clause(6, rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph")), []).
clause(7, name(var("person"), var("text")), [call(rdf(var("person"), iri("https://example/name"), literal(var("text"), datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph))]).
clause(8, annotation(var("subject"), var("predicate"), var("object"), var("source"), var("graph")), [call(rdf(var("reifier"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(var("subject"), var("predicate"), var("object")), var("graph"))), call(rdf(var("reifier"), iri("https://example/source"), var("source"), var("graph")))]).
substitution(1, []).
proof(1, rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph), rule(1), []).
substitution(2, [binding("person", iri("https://example/alice")), binding("text", "Alice")]).
proof(2, name(iri("https://example/alice"), "Alice"), rule(7), [uses(1, rdf(iri("https://example/alice"), iri("https://example/name"), literal("Alice", datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph))]).
substitution(3, [binding("person", iri("https://example/alice")), binding("text", "Alice")]).
proof(3, solution([iri("https://example/alice"), "Alice"]), query, [uses(2, name(iri("https://example/alice"), "Alice"))]).
substitution(4, []).
proof(4, rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph")), rule(5), []).
substitution(5, []).
proof(5, rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph")), rule(6), []).
substitution(6, [binding("subject", iri("https://example/alice")), binding("predicate", iri("https://example/knows")), binding("object", iri("https://example/bob")), binding("source", iri("https://example/chat")), binding("graph", iri("https://example/graph")), binding("reifier", blank("d0_claim"))]).
proof(6, annotation(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob"), iri("https://example/chat"), iri("https://example/graph")), rule(8), [uses(4, rdf(blank("d0_claim"), iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob")), iri("https://example/graph"))), uses(5, rdf(blank("d0_claim"), iri("https://example/source"), iri("https://example/chat"), iri("https://example/graph")))]).
substitution(7, [binding("subject", iri("https://example/alice")), binding("predicate", iri("https://example/knows")), binding("object", iri("https://example/bob")), binding("source", iri("https://example/chat")), binding("graph", iri("https://example/graph"))]).
proof(7, solution([iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob"), iri("https://example/chat"), iri("https://example/graph")]), query, [uses(6, annotation(iri("https://example/alice"), iri("https://example/knows"), iri("https://example/bob"), iri("https://example/chat"), iri("https://example/graph")))]).
substitution(8, []).
proof(8, rdf(iri("https://example/document"), iri("https://example/title"), literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")), rule(4), []).
substitution(9, [binding("title", literal("HTML و CSS", language("ar", rtl))), binding("graph", iri("https://example/graph"))]).
proof(9, solution([literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")]), query, [uses(8, rdf(iri("https://example/document"), iri("https://example/title"), literal("HTML و CSS", language("ar", rtl)), iri("https://example/graph")))]).
