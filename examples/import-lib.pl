% Prolog example: import-lib.
parent(iris, jules).
parent(jules, kai).
ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Z) :-
    parent(X, Y),
    ancestor(Y, Z).
?- ancestor(iris, Descendant).
