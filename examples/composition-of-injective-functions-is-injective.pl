% Prolog example: composition-of-injective-functions-is-injective.
% Companion to composition-of-injective-functions-is-injective.n3/.srl:
% proves that composing two injective functions yields an injective
% function, over a small concrete example (f: a->p, b->q; g: p->r, q->r;
% h = g . f), as ordinary relations.
in_x(a).
in_x(b).
in_y(p).
in_y(q).
in_z(r).

same_term(X, X) :-
    in_x(X).
same_term(Y, Y) :-
    in_y(Y).
same_term(Z, Z) :-
    in_z(Z).
same_term(B_, A_) :-
    same_term(A_, B_).

same_term(U, V) :-
    app(F, X, U),
    app(F, X, V).

same_term(X, Y) :-
    injective(F),
    app(F, X, U),
    app(F, Y, V),
    same_term(U, V).

app(H, X, Z) :-
    composite_of(H, G, F),
    app(F, X, Y),
    app(G, Y, Z).

same_input_under_equal_composite_output(H, X, Y) :-
    composite_of(H, G, F),
    injective(F),
    injective(G),
    app(F, X, Fx),
    app(F, Y, Fy),
    app(G, Fx, U),
    app(G, Fy, V),
    same_term(U, V),
    same_term(X, Y).

injective(f).
injective(g).
composite_of(h, g, f).
app(f, a, p).
app(f, b, q).
app(g, p, r).
app(g, q, r).

result_query(H, X, Y) :-
    same_input_under_equal_composite_output(H, X, Y),
    X \== Y.
?- result_query(H, X, Y).
