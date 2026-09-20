# Eyelang example: quoted-head-unquote.
# Companion to quoted-head-unquote.n3/.srl: the N3 source stores a rule
# as a quoted formula and activates it by using a term (rather than a
# literal `{...}` block) as a rule's right-hand side -- a reflective
# capability with no Eyelang counterpart (Eyelang rules are not
# first-class data the way an N3 formula is; compare rule-matching.eye's
# own note on this). This reifies the outcome the activated rule would
# produce directly: a cat is an animal.
cat(c).
animal(?x) if cat(?x).
test_is(true) if animal(c).
ask test_is(?r).
