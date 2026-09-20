# Eyelang result format 2
query(1, [call(result(?v0))], [binding("v", ?v0)]).
result(1, complete, 1).
answer(1, [binding("v", 12)]).
why(1, [binding("v", 12)], 17).
clause(1, n_(n2, 2), []).
clause(2, n_(n3, 3), []).
clause(3, n_(n10, 10), []).
clause(4, n_(n4, 4), []).
clause(5, expr(eMul, mul, n2, n3), []).
clause(6, expr(eSub, sub, n10, n4), []).
clause(7, expr(eAdd, add, eMul, eSub), []).
clause(8, root_expr(eAdd), []).
clause(9, value(var("n"), var("v")), [call(n_(var("n"), var("v")))]).
clause(10, value(var("e"), var("v")), [call(expr(var("e"), add, var("l"), var("r"))), call(value(var("l"), var("lv"))), call(value(var("r"), var("rv"))), calculate(var("v"), binary("+", value(var("lv")), value(var("rv"))))]).
clause(11, value(var("e"), var("v")), [call(expr(var("e"), sub, var("l"), var("r"))), call(value(var("l"), var("lv"))), call(value(var("r"), var("rv"))), calculate(var("v"), binary("-", value(var("lv")), value(var("rv"))))]).
clause(12, value(var("e"), var("v")), [call(expr(var("e"), mul, var("l"), var("r"))), call(value(var("l"), var("lv"))), call(value(var("r"), var("rv"))), calculate(var("v"), binary("*", value(var("lv")), value(var("rv"))))]).
clause(13, result(var("v")), [call(root_expr(var("e"))), call(value(var("e"), var("v")))]).
substitution(1, []).
proof(1, root_expr(eAdd), rule(8), []).
substitution(2, []).
proof(2, expr(eAdd, add, eMul, eSub), rule(7), []).
substitution(3, []).
proof(3, expr(eMul, mul, n2, n3), rule(5), []).
substitution(4, []).
proof(4, n_(n2, 2), rule(1), []).
substitution(5, [binding("n", n2), binding("v", 2)]).
proof(5, value(n2, 2), rule(9), [uses(4, n_(n2, 2))]).
substitution(6, []).
proof(6, n_(n3, 3), rule(2), []).
substitution(7, [binding("n", n3), binding("v", 3)]).
proof(7, value(n3, 3), rule(9), [uses(6, n_(n3, 3))]).
substitution(8, [binding("e", eMul), binding("v", 6), binding("l", n2), binding("r", n3), binding("lv", 2), binding("rv", 3)]).
proof(8, value(eMul, 6), rule(12), [uses(3, expr(eMul, mul, n2, n3)), uses(5, value(n2, 2)), uses(7, value(n3, 3)), calculated(6, binary("*", value(2), value(3)))]).
substitution(9, []).
proof(9, expr(eSub, sub, n10, n4), rule(6), []).
substitution(10, []).
proof(10, n_(n10, 10), rule(3), []).
substitution(11, [binding("n", n10), binding("v", 10)]).
proof(11, value(n10, 10), rule(9), [uses(10, n_(n10, 10))]).
substitution(12, []).
proof(12, n_(n4, 4), rule(4), []).
substitution(13, [binding("n", n4), binding("v", 4)]).
proof(13, value(n4, 4), rule(9), [uses(12, n_(n4, 4))]).
substitution(14, [binding("e", eSub), binding("v", 6), binding("l", n10), binding("r", n4), binding("lv", 10), binding("rv", 4)]).
proof(14, value(eSub, 6), rule(11), [uses(9, expr(eSub, sub, n10, n4)), uses(11, value(n10, 10)), uses(13, value(n4, 4)), calculated(6, binary("-", value(10), value(4)))]).
substitution(15, [binding("e", eAdd), binding("v", 12), binding("l", eMul), binding("r", eSub), binding("lv", 6), binding("rv", 6)]).
proof(15, value(eAdd, 12), rule(10), [uses(2, expr(eAdd, add, eMul, eSub)), uses(8, value(eMul, 6)), uses(14, value(eSub, 6)), calculated(12, binary("+", value(6), value(6)))]).
substitution(16, [binding("v", 12), binding("e", eAdd)]).
proof(16, result(12), rule(13), [uses(1, root_expr(eAdd)), uses(15, value(eAdd, 12))]).
substitution(17, [binding("v", 12)]).
proof(17, solution([12]), query, [uses(16, result(12))]).
