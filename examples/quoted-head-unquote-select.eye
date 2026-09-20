# Eyelang example: quoted-head-unquote-select.
# Companion to quoted-head-unquote-select.n3/.srl: the N3 source picks
# which of several stored quoted rules to activate via metadata
# (class -> rule -> formula) and then unquotes it -- again a reflective
# capability Eyelang has no counterpart for. This keeps the same
# class-to-rule metadata shape (`activates/2`) but dispatches with an
# ordinary, statically-resolved rule per class instead of unquoting a
# formula chosen at runtime.
activates(cat, ruleCat).
activates(dog, ruleDog).
class_of(c, cat).

animal(?x) if class_of(?x, cat), activates(cat, ruleCat).
pet(?x) if class_of(?x, dog), activates(dog, ruleDog).

test_is(true) if animal(c).
ask test_is(?r).
