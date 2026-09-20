# Eyelang example: similar.
# Companion to similar.n3/.srl: two things are "similar" if they share
# any predicate/object pair, reified here as `fact/3` triples (matching
# N3's own fully generic `?A ?Pred ?Obj` pattern) so the relation stays
# generic rather than hardcoded to the one shared property (being human)
# this particular data happens to have.
fact(alice, type, human).
fact(bob, type, human).

similar(?a, ?b) if fact(?a, ?pred, ?obj), fact(?b, ?pred, ?obj), ?a != ?b.
test_is(true) if similar(alice, bob).
ask test_is(?r).
