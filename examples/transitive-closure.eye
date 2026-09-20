# Eyelang example: transitive-closure.
# Companion to transitive-closure.n3/.srl: the same 70-node chain and its
# transitive reachability closure. Eyelang's built-in `range/3` replaces
# the N3 source's own recursive :range generator, and each node is the
# compound term n(N) rather than a string-concatenated IRI
# ("http://example.org/closure#n1", ...), since Eyelang isn't an RDF
# triple language.
link(n(?n), n(?next)) if range(1, 69, ?n), let ?next = ?n + 1.
reaches(?from, ?to) if link(?from, ?to).
reaches(?from, ?to) if link(?from, ?via), reaches(?via, ?to).

direct_links(?links) if let ?links = 70 - 1.
reachable_pairs(?pairs) if let ?max = 70, let ?previous = ?max - 1, let ?twice = ?max * ?previous, let ?pairs = ?twice // 2.

test_is(true) if reaches(n(1), n(70)).

ask direct_links(?links).
ask reachable_pairs(?pairs).
ask test_is(?r).
