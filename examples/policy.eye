# The producer of blocked appears after its consumer deliberately.
person(alice).
person(bob).
person(carol).
blocked(alice).
flagged(carol).
eligible(?person) if person(?person), not blocked(?person).
blocked(?person) if flagged(?person).
ask eligible(?person).
