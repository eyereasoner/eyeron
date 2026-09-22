% Prolog example: stratified-negation.
person(alice).
person(bob).
person(carol).
directly_blocked(alice).
flagged(carol).
blocked(X) :-
    directly_blocked(X).
blocked(X) :-
    flagged(X).
eligible(X) :-
    person(X),
    \+ blocked(X).
?- eligible(Person).
