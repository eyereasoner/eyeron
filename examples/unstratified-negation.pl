% Prolog example: unstratified-negation.
person(alice).
in(X) :-
    person(X),
    \+ out(X).
out(X) :-
    person(X),
    \+ in(X).
?- in(alice).
