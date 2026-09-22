% Prolog result format 3
query(1, result(_0), ['V' = _0]).
result(1, complete, 1).
answer(1, ['V' = 12]).
why(1, ['V' = 12], 17).
clause(1, n_(n2, 2), true).
clause(2, n_(n3, 3), true).
clause(3, n_(n10, 10), true).
clause(4, n_(n4, 4), true).
clause(5, expr(eMul, mul, n2, n3), true).
clause(6, expr(eSub, sub, n10, n4), true).
clause(7, expr(eAdd, add, eMul, eSub), true).
clause(8, root_expr(eAdd), true).
clause(9, value(var('N'), var('V')), n_(var('N'), var('V'))).
clause(10, value(var('E'), var('V')), (expr(var('E'), add, var('L'), var('R')), value(var('L'), var('Lv')), value(var('R'), var('Rv')), var('V') is var('Lv') + var('Rv'))).
clause(11, value(var('E'), var('V')), (expr(var('E'), sub, var('L'), var('R')), value(var('L'), var('Lv')), value(var('R'), var('Rv')), var('V') is var('Lv') - var('Rv'))).
clause(12, value(var('E'), var('V')), (expr(var('E'), mul, var('L'), var('R')), value(var('L'), var('Lv')), value(var('R'), var('Rv')), var('V') is var('Lv') * var('Rv'))).
clause(13, result(var('V')), (root_expr(var('E')), value(var('E'), var('V')))).
substitution(1, []).
proof(1, root_expr(eAdd), rule(8), []).
substitution(2, []).
proof(2, expr(eAdd, add, eMul, eSub), rule(7), []).
substitution(3, []).
proof(3, expr(eMul, mul, n2, n3), rule(5), []).
substitution(4, []).
proof(4, n_(n2, 2), rule(1), []).
substitution(5, ['N' = n2, 'V' = 2]).
proof(5, value(n2, 2), rule(9), [uses(4, n_(n2, 2))]).
substitution(6, []).
proof(6, n_(n3, 3), rule(2), []).
substitution(7, ['N' = n3, 'V' = 3]).
proof(7, value(n3, 3), rule(9), [uses(6, n_(n3, 3))]).
substitution(8, ['E' = eMul, 'V' = 6, 'L' = n2, 'R' = n3, 'Lv' = 2, 'Rv' = 3]).
proof(8, value(eMul, 6), rule(12), [uses(3, expr(eMul, mul, n2, n3)), uses(5, value(n2, 2)), uses(7, value(n3, 3)), builtin(6 is 2 * 3)]).
substitution(9, []).
proof(9, expr(eSub, sub, n10, n4), rule(6), []).
substitution(10, []).
proof(10, n_(n10, 10), rule(3), []).
substitution(11, ['N' = n10, 'V' = 10]).
proof(11, value(n10, 10), rule(9), [uses(10, n_(n10, 10))]).
substitution(12, []).
proof(12, n_(n4, 4), rule(4), []).
substitution(13, ['N' = n4, 'V' = 4]).
proof(13, value(n4, 4), rule(9), [uses(12, n_(n4, 4))]).
substitution(14, ['E' = eSub, 'V' = 6, 'L' = n10, 'R' = n4, 'Lv' = 10, 'Rv' = 4]).
proof(14, value(eSub, 6), rule(11), [uses(9, expr(eSub, sub, n10, n4)), uses(11, value(n10, 10)), uses(13, value(n4, 4)), builtin(6 is 10 - 4)]).
substitution(15, ['E' = eAdd, 'V' = 12, 'L' = eMul, 'R' = eSub, 'Lv' = 6, 'Rv' = 6]).
proof(15, value(eAdd, 12), rule(10), [uses(2, expr(eAdd, add, eMul, eSub)), uses(8, value(eMul, 6)), uses(14, value(eSub, 6)), builtin(12 is 6 + 6)]).
substitution(16, ['V' = 12, 'E' = eAdd]).
proof(16, result(12), rule(13), [uses(1, root_expr(eAdd)), uses(15, value(eAdd, 12))]).
substitution(17, ['V' = 12]).
proof(17, solution([12]), query, [uses(16, result(12))]).
