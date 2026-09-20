# Eyelang example: patch.
# Companion to patch.n3/.srl: N3's graph patch operates on quoted formula
# terms (log:collectAllIn/log:conjunction/log:notIncludes), which Eyelang
# has no counterpart for. This reifies the same three triple sets
# (source, delete, insert) as ordinary `fact/3`-shaped relations and
# computes the same patched result -- kept facts (source minus delete)
# plus every inserted fact -- with plain negation and union.
source(alice, type, person).
source(alice, age, 30).
source(alice, status, oldStatus).
source(alice, email, "alice@example.org").
source(bob, type, person).

delete_(alice, age, 30).
delete_(alice, status, oldStatus).
delete_(alice, email, "alice@example.org").

insert_(alice, age, 31).
insert_(alice, status, activeStatus).
insert_(alice, verified, true).

kept(?s, ?p, ?o) if source(?s, ?p, ?o), not delete_(?s, ?p, ?o).
patched(?s, ?p, ?o) if kept(?s, ?p, ?o).
patched(?s, ?p, ?o) if insert_(?s, ?p, ?o).

ask patched(?s, ?p, ?o).
