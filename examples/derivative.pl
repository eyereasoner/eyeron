% Symbolic differentiation over constructor terms.
d(const(_), _, const(0)).
d(var(X), X, const(1)).
d(var(Y), X, const(0)) :-
    X \== Y.
d(add(U, V), X, add(Du, Dv)) :-
    d(U, X, Du),
    d(V, X, Dv).

d(mul(U, V), X, add(mul(Du, V), mul(U, Dv))) :-
    d(U, X, Du),
    d(V, X, Dv).

?- d(mul(var(x), var(x)), x, Derivative).
