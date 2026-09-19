# Eyelang example: unstratified-negation.
person(alice). in(?x) if person(?x), not out(?x). out(?x) if person(?x), not in(?x). ask in(alice).
