% Prolog example: import-main.
parent(alice, bob).
parent(bob, carol).
ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Z) :-
    parent(X, Y),
    ancestor(Y, Z).
?- ancestor(alice, Who).
