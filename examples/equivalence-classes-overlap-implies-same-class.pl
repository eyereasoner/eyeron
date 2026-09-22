% Prolog example: equivalence-classes-overlap-implies-same-class.
% Companion to equivalence-classes-overlap-implies-same-class.n3/.srl:
% proves that two equivalence classes sharing a member are the same
% class, over a reflexive/symmetric/transitive :sim relation, as
% ordinary relations.
in_x(a).
in_x(b).
in_x(c).

sim(X, X) :-
    in_x(X).
sim(Y, X) :-
    sim(X, Y).
sim(X, Z) :-
    sim(X, Y),
    sim(Y, Z).

in_class_of(U, X) :-
    sim(U, X).
same_class(X, Y) :-
    sim(X, Y).
same_class(Y, X) :-
    same_class(X, Y).

shared_member_shows_same_class(X, Y, Z) :-
    in_class_of(Z, X),
    in_class_of(Z, Y),
    same_class(X, Y).

sim(b, a).
sim(b, c).

result_query(X, Y, Z) :-
    shared_member_shows_same_class(X, Y, Z),
    X \== Y.
?- result_query(X, Y, Z).
