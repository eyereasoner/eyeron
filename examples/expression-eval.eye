# Eyelang example: expression-eval.
# Companion to expression-eval.n3/.srl: the same tiny expression
# evaluator ((2*3)+(10-4) = 12), using genuine recursive relations
# (Eyelang's tabled evaluator handles this natively, the same way N3's
# backward-chained :value does).
n_(n2, 2). n_(n3, 3). n_(n10, 10). n_(n4, 4).

expr(eMul, mul, n2, n3).
expr(eSub, sub, n10, n4).
expr(eAdd, add, eMul, eSub).

root_expr(eAdd).

value(?n, ?v) if n_(?n, ?v).
value(?e, ?v) if expr(?e, add, ?l, ?r), value(?l, ?lv), value(?r, ?rv), let ?v = ?lv + ?rv.
value(?e, ?v) if expr(?e, sub, ?l, ?r), value(?l, ?lv), value(?r, ?rv), let ?v = ?lv - ?rv.
value(?e, ?v) if expr(?e, mul, ?l, ?r), value(?l, ?lv), value(?r, ?rv), let ?v = ?lv * ?rv.

result(?v) if root_expr(?e), value(?e, ?v).
ask result(?v).
