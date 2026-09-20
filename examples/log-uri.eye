# Eyelang example: log-uri.
# Companion to log-uri.n3/.srl: log:uri converts between an IRI and its
# lexical string form, in either direction. Eyelang isn't an RDF triple
# language, so this represents the IRI with the RDF bridge's own
# `iri("...")` wrapper (see docs/eyelang.md's RDF 1.2 N-Quads bridge) and
# asserts the string/IRI correspondence as one fact, queried both ways.
uri_str(iri("https://www.w3.org"), "https://www.w3.org").

ask uri_str(iri("https://www.w3.org"), ?s).
ask uri_str(?r, "https://www.w3.org").
