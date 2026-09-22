% Prolog result format 4
query(1, result(_0), ['V' = _0]).
result(1, complete, 1).
answer(1, ['V' = 12]).
why(1, ['V' = 12], [result(12)]).

clause(1, n_(n2, 2), true).
clause(2, n_(n3, 3), true).
clause(3, n_(n10, 10), true).
clause(4, n_(n4, 4), true).
clause(5, expr(eMul, mul, n2, n3), true).
clause(6, expr(eSub, sub, n10, n4), true).
clause(7, expr(eAdd, add, eMul, eSub), true).
clause(8, root_expr(eAdd), true).
clause(9, value(var('N'), var('V')), n_(var('N'), var('V'))).
clause(10,
       value(var('E'), var('V')),
       (expr(var('E'), add, var('L'), var('R')),
        value(var('L'), var('Lv')),
        value(var('R'), var('Rv')),
        var('V') is var('Lv') + var('Rv'))).
clause(11,
       value(var('E'), var('V')),
       (expr(var('E'), sub, var('L'), var('R')),
        value(var('L'), var('Lv')),
        value(var('R'), var('Rv')),
        var('V') is var('Lv') - var('Rv'))).
clause(12,
       value(var('E'), var('V')),
       (expr(var('E'), mul, var('L'), var('R')),
        value(var('L'), var('Lv')),
        value(var('R'), var('Rv')),
        var('V') is var('Lv') * var('Rv'))).
clause(13, result(var('V')), (root_expr(var('E')), value(var('E'), var('V')))).

step(result(12), rule(13), ['V' = 12, 'E' = eAdd], [root_expr(eAdd), value(eAdd, 12)]).
step(root_expr(eAdd), fact(8), [], []).
step(value(eAdd, 12),
     rule(10),
     ['E' = eAdd, 'V' = 12, 'L' = eMul, 'R' = eSub, 'Lv' = 6, 'Rv' = 6],
     [expr(eAdd, add, eMul, eSub), value(eMul, 6), value(eSub, 6), 12 is 6 + 6]).
step(expr(eAdd, add, eMul, eSub), fact(7), [], []).
step(value(eMul, 6),
     rule(12),
     ['E' = eMul, 'V' = 6, 'L' = n2, 'R' = n3, 'Lv' = 2, 'Rv' = 3],
     [expr(eMul, mul, n2, n3), value(n2, 2), value(n3, 3), 6 is 2 * 3]).
step(expr(eMul, mul, n2, n3), fact(5), [], []).
step(value(n2, 2), rule(9), ['N' = n2, 'V' = 2], [n_(n2, 2)]).
step(n_(n2, 2), fact(1), [], []).
step(value(n3, 3), rule(9), ['N' = n3, 'V' = 3], [n_(n3, 3)]).
step(n_(n3, 3), fact(2), [], []).
step(6 is 2 * 3, builtin, [], []).
step(value(eSub, 6),
     rule(11),
     ['E' = eSub, 'V' = 6, 'L' = n10, 'R' = n4, 'Lv' = 10, 'Rv' = 4],
     [expr(eSub, sub, n10, n4), value(n10, 10), value(n4, 4), 6 is 10 - 4]).
step(expr(eSub, sub, n10, n4), fact(6), [], []).
step(value(n10, 10), rule(9), ['N' = n10, 'V' = 10], [n_(n10, 10)]).
step(n_(n10, 10), fact(3), [], []).
step(value(n4, 4), rule(9), ['N' = n4, 'V' = 4], [n_(n4, 4)]).
step(n_(n4, 4), fact(4), [], []).
step(6 is 10 - 4, builtin, [], []).
step(12 is 6 + 6, builtin, [], []).
