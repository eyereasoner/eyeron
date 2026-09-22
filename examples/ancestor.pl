% Family relations: facts and recursive definitions use the same rule model.
parent(alice, bob).
parent(bob, carol).
parent(carol, dana).
ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Z) :-
    parent(X, Y),
    ancestor(Y, Z).
?- ancestor(alice, Who).
