% Prolog example: greatest-lower-bound-uniqueness.
% Companion to greatest-lower-bound-uniqueness.n3/.srl: proves that a
% greatest lower bound in a partial order is unique, over two
% differently-named candidates (:g1, :g2) for the same pair, as ordinary
% relations.
in_p(a).
in_p(b).
in_p(g1).
in_p(g2).
glb_of(g1, a, b).
glb_of(g2, a, b).

leq(X, X) :-
    in_p(X).
leq(X, Z) :-
    leq(X, Y),
    leq(Y, Z).
same_term(X, Y) :-
    leq(X, Y),
    leq(Y, X).
same_term(Y, X) :-
    same_term(X, Y).

lower_bound_of(M, A, B) :-
    glb_of(M, A, B).
leq(M, A) :-
    glb_of(M, A, B).
leq(M, B) :-
    glb_of(M, A, B).

leq(L, M) :-
    glb_of(M, A, B),
    lower_bound_of(L, A, B).

same_glb(A, B, M, N) :-
    glb_of(M, A, B),
    glb_of(N, A, B),
    same_term(M, N).

result_query(A, B, M, N) :-
    same_glb(A, B, M, N),
    M \== N.
?- result_query(A, B, M, N).
