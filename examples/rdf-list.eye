# Eyelang example: rdf-list.
# Companion to rdf-list.n3/.srl: decomposing a list into its head and
# tail. Eyelang has native list/cons syntax, so this uses structural
# pattern matching directly instead of N3's rdf:first/rdf:rest backward
# rules.
val(x, [1, 2]).
test_is(true) if val(x, [?h | ?t]), ?h = 1, ?t = [2].
ask test_is(?r).
