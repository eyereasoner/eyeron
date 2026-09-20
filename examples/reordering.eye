# Eyelang example: reordering.
# Companion to reordering.n3/.srl: the N3 source specifically exercises
# premise reordering (its inequality check is written *before* the
# variables it compares are bound, relying on N3's selectivity-based
# reordering to defer it). Eyelang does the opposite by design -- goals
# run strictly left to right, and `!=` requires its inputs already bound,
# reporting a mode error rather than reordering -- so this writes the
# two `has` calls first and the inequality check last.
has(alice, [book, 1]).
has(bob, [table, 1]).

test_is(true) if
    has(?w1, [?o1, ?n1]), has(?w2, [?o2, ?n2]), ?o1 != ?o2.

ask test_is(?r).
