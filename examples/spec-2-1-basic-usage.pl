% Prolog example: spec-2-1-basic-usage.
father(a, x).
mother(b, x).
mother(c, a).
child(X, Y) :-
    father(Y, X).
child(X, Y) :-
    mother(Y, X).
?- child(Child, Parent).
