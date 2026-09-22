% Prolog example: family.
father(a, x).
mother(b, x).
mother(c, a).
child(X, Y) :-
    father(Y, X).
child(X, Y) :-
    mother(Y, X).
descended(X, Y) :-
    child(X, Y).
descended(X, Y) :-
    child(X, Z),
    descended(Z, Y).
?- descended(Person, Ancestor).
