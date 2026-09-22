% RDF 1.2 N-Quads is imported as ordinary rdf/4 facts. The companion
% rdf12-interoperability.nq file supplies this program's data.

name(Person, Text) :-
    rdf(Person, iri("https://example/name"), literal(Text, datatype(iri("http://www.w3.org/2001/XMLSchema#string"))), default_graph).

annotation(Subject, Predicate, Object, Source, Graph) :-
    rdf(Reifier, iri("http://www.w3.org/1999/02/22-rdf-syntax-ns#reifies"), triple(Subject, Predicate, Object), Graph),
    rdf(Reifier, iri("https://example/source"), Source, Graph).

% Inferred rdf/4 facts are included when the result is exported as N-Quads.
rdf(Person, iri("https://example/displayName"), Label, Graph) :-
    rdf(Person, iri("https://example/label"), Label, Graph).

?- name(Person, Text).
?- annotation(Subject, Predicate, Object, Source, Graph).
?- rdf(iri("https://example/document"), iri("https://example/title"), Title, Graph).
