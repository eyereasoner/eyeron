% Prolog example: backward-recursion.
parent(a, b).
parent(b, c).
parent(c, d).
ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Z) :-
    parent(X, Y),
    ancestor(Y, Z).
?- ancestor(a, Who).
