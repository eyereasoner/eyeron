% Prolog example: spec-2-1-descended-from.
father(a, x).
mother(b, x).
mother(c, a).
child(X, Y) :-
    father(Y, X).
child(X, Y) :-
    mother(Y, X).
descended(X, Y) :-
    child(X, Y).
?- descended(Person, Ancestor).
