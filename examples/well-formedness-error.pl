% Prolog example: well-formedness-error.
score(alice, 10).
bad :-
    Score > 5,
    score(alice, Score).
?- bad.
