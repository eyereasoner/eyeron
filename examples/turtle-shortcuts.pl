% Prolog example: turtle-shortcuts.
knows(alice, bob).
knows(alice, carol).
score(alice, 8).
score(bob, 3).
known_by(Friend, Person, Score) :-
    knows(Person, Friend),
    score(Person, Score),
    Score >= 5.
?- known_by(Friend, Person, Score).
