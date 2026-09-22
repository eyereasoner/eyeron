% Prolog example: spec-2-4-negation.
place(x1).
place(x2).
place(x3).
population(x1, 1000).
population(x2, 2000).
unclassified(Place) :-
    place(Place),
    \+ has_population(Place).
has_population(Place) :-
    population(Place, Amount).
?- unclassified(Place).
