# Eyelang example: stratified-negation.
person(alice). person(bob). person(carol). directly_blocked(alice). flagged(carol).
blocked(?x) if directly_blocked(?x). blocked(?x) if flagged(?x).
eligible(?x) if person(?x), not blocked(?x).
ask eligible(?person).
