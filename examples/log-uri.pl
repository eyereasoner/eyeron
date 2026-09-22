% Prolog example: log-uri.
% Companion to log-uri.n3/.srl: log:uri converts between an IRI and its
% lexical string form, in either direction. Prolog isn't an RDF triple
% language, so this represents the IRI with the RDF bridge's own
% `iri("...")` wrapper (see docs/Prolog.md's RDF 1.2 N-Quads bridge) and
% asserts the string/IRI correspondence as one fact, queried both ways.
uri_str(iri("https://www.w3.org"), "https://www.w3.org").

?- uri_str(iri("https://www.w3.org"), S).
?- uri_str(R, "https://www.w3.org").
