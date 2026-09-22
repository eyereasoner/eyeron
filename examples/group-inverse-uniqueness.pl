% Prolog example: group-inverse-uniqueness.
% Companion to group-inverse-uniqueness.n3/.srl: proves that a group
% element's inverse is unique, over one element :x with two differently-
% named candidate inverses :i and :j, as ordinary relations.
in_g(x_).
in_g(i_).
in_g(j_).
in_g(e_).
inverse_of(i_, x_).
inverse_of(j_, x_).

mul(A, e_, A) :-
    in_g(A).
mul(e_, A, A) :-
    in_g(A).
mul(X_, Y_, e_) :-
    in_g(X_),
    in_g(Y_),
    inverse_of(Y_, X_).
mul(Y_, X_, e_) :-
    in_g(X_),
    in_g(Y_),
    inverse_of(Y_, X_).

same_term(Left, Right) :-
    mul(A, B, Ab),
    mul(Ab, C, Left),
    mul(B, C, Bc),
    mul(A, Bc, Right).
same_term(B_, A_) :-
    same_term(A_, B_).

same_inverse(X_, Y_, Z_) :-
    inverse_of(Y_, X_),
    inverse_of(Z_, X_),
    same_term(Y_, Z_).

result_query(X_, Y_, Z_) :-
    same_inverse(X_, Y_, Z_),
    Y_ \== Z_.
?- result_query(X_, Y_, Z_).
