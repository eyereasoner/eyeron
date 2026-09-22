% Prolog example: assignment.
score(alice, 7).
score(bob, 3).
grade(Person, pass(Score)) :-
    score(Person, Score),
    Score >= 5.
?- grade(Person, Grade).
