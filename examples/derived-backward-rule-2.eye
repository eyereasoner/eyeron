# Eyelang example: derived-backward-rule-2.
# Companion to derived-backward-rule-2.n3/.srl: the N3 source generates
# two backward rules (each `<= true`, i.e. unconditional facts) from a
# forward rule's own conclusion, again something with no Eyelang
# counterpart. This reifies the same two facts directly, plus the
# ordinary subclass rule that uses them to derive Socrates is Mortal.
type_(socrates, human).
subclass_of(human, mortal).
type_(?s, ?b) if type_(?s, ?a), subclass_of(?a, ?b).
test_is(true) if type_(socrates, mortal).
ask test_is(?r).
ask type_(?s, ?t).
