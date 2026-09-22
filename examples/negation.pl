% Prolog example: negation.
person(alice).
person(bob).
blocked(bob).
eligible(X) :-
    person(X),
    \+ blocked(X).
?- eligible(Person).
