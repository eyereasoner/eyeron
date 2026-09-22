% Prolog example: query.
parent(alice, bob).
parent(bob, carol).
parent(dora, emma).
ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Z) :-
    parent(X, Y),
    ancestor(Y, Z).
?- ancestor(X, Y).
