# Eyelang example: negation.
person(alice). person(bob). blocked(bob).
eligible(?x) if person(?x), not blocked(?x).
ask eligible(?person).
