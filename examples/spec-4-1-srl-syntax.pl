% Prolog example: spec-4-1-srl-syntax.
values(x, 1, 2).
both_positive(X) :-
    values(X, A, B),
    A > 0,
    B > 0.
one_zero(X) :-
    values(X, 0, B).
one_zero(X) :-
    values(X, A, 0).
?- both_positive(X).
?- one_zero(X).
