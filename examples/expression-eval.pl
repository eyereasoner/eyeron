% Prolog example: expression-eval.
% Companion to expression-eval.n3/.srl: the same tiny expression
% evaluator ((2*3)+(10-4) = 12), using genuine recursive relations
% (the tabled evaluator handles this natively, the same way N3's
% backward-chained :value does).
n_(n2, 2).
n_(n3, 3).
n_(n10, 10).
n_(n4, 4).

expr(eMul, mul, n2, n3).
expr(eSub, sub, n10, n4).
expr(eAdd, add, eMul, eSub).

root_expr(eAdd).

value(N, V) :-
    n_(N, V).
value(E, V) :-
    expr(E, add, L, R),
    value(L, Lv),
    value(R, Rv),
    V is Lv + Rv.
value(E, V) :-
    expr(E, sub, L, R),
    value(L, Lv),
    value(R, Rv),
    V is Lv - Rv.
value(E, V) :-
    expr(E, mul, L, R),
    value(L, Lv),
    value(R, Rv),
    V is Lv * Rv.

result(V) :-
    root_expr(E),
    value(E, V).
?- result(V).
