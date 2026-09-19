# RDF 1.2 N-Quads is imported as ordinary rdf/4 facts. The companion
# rdf12-interoperability.nq file supplies this program's data.

name(?person, ?text) if
    rdf(?person, iri("https://example/name"),
        literal(?text, datatype(iri("http://www.w3.org/2001/XMLSchema#string"))),
        default_graph).

annotation(?subject, ?predicate, ?object, ?source, ?graph) if
    rdf(?reifier, iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"),
        triple(?subject, ?predicate, ?object), ?graph),
    rdf(?reifier, iri("https://example/source"), ?source, ?graph).

# Inferred rdf/4 facts are included when the result is exported as N-Quads.
rdf(?person, iri("https://example/displayName"), ?label, ?graph) if
    rdf(?person, iri("https://example/label"), ?label, ?graph).

ask name(?person, ?text).
ask annotation(?subject, ?predicate, ?object, ?source, ?graph).
ask rdf(iri("https://example/document"), iri("https://example/title"), ?title, ?graph).
