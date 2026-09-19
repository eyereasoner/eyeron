# Eyelang example: negation-orphan.
# Companion to negation-orphan.srl: stratified negation as failure.
person(alice). person(bob).
child_of(alice, carol).
has_a_parent(?x) if child_of(?x, ?_).
orphan(?x) if person(?x), not has_a_parent(?x).
ask orphan(?x).
