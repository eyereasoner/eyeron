# Eyelang example: derived-rule.
# Companion to derived-rule.n3/.srl: N3's source generates a rule from
# a rule's own conclusion (a rule whose body contains another rule --
# something Eyelang has no counterpart for, see log-not-includes.eye's
# own note on generated rules); this reifies the outcome it produces
# directly: the generated rule only fires once both a cat and a dog
# exist, deriving :test :is true.
cat(minka). dog(charly).
test_is(true) if cat(?x), dog(?y).
ask test_is(?r).
