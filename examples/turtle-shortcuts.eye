# Eyelang example: turtle-shortcuts.
knows(alice, bob). knows(alice, carol). score(alice, 8). score(bob, 3).
known_by(?friend, ?person, ?score) if knows(?person, ?friend), score(?person, ?score), ?score >= 5.
ask known_by(?friend, ?person, ?score).
