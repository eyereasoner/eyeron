# Eyelang example: derived-backward-rule.
# Companion to derived-backward-rule.n3/.srl: the N3 source generates a
# *backward* rule from an :invOf metadata fact (again, a rule generated
# as a rule's own conclusion, with no Eyelang counterpart). This reifies
# the resulting inverse relationship directly as an ordinary rule.
parent_of(alice, bob).
child_of(?x, ?y) if parent_of(?y, ?x).
has_parent(?x, ?y) if child_of(?x, ?y).
ask has_parent(?x, ?y).
ask child_of(?x, ?y).
