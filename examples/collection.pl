% Prolog example: collection.
value(root, [1, node(q), [2]]).
first(X) :-
    value(root, [X, Middle, Last]).
blank_property(X) :-
    value(root, [First, node(X), Last]).
nested_first(X) :-
    value(root, [First, Middle, [X]]).
?- first(X).
?- blank_property(X).
?- nested_first(X).
