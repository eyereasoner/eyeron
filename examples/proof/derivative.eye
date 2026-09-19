# Eyelang result format 2
query(1, [call(d(mul(var(x), var(x)), x, ?v0))], [binding("derivative", ?v0)]).
result(1, complete, 1).
answer(1, [binding("derivative", add(mul(const(1), var(x)), mul(var(x), const(1))))]).
why(1, [binding("derivative", add(mul(const(1), var(x)), mul(var(x), const(1))))], 3).
clause(2, d(var(var("x")), var("x"), const(1)), []).
clause(5, d(mul(var("u"), var("v")), var("x"), add(mul(var("du"), var("v")), mul(var("u"), var("dv")))), [call(d(var("u"), var("x"), var("du"))), call(d(var("v"), var("x"), var("dv")))]).
substitution(1, [binding("x", x)]).
proof(1, d(var(x), x, const(1)), rule(2), []).
substitution(2, [binding("u", var(x)), binding("v", var(x)), binding("x", x), binding("du", const(1)), binding("dv", const(1))]).
proof(2, d(mul(var(x), var(x)), x, add(mul(const(1), var(x)), mul(var(x), const(1)))), rule(5), [uses(1, d(var(x), x, const(1))), uses(1, d(var(x), x, const(1)))]).
substitution(3, [binding("derivative", add(mul(const(1), var(x)), mul(var(x), const(1))))]).
proof(3, solution([add(mul(const(1), var(x)), mul(var(x), const(1)))]), query, [uses(2, d(mul(var(x), var(x)), x, add(mul(const(1), var(x)), mul(var(x), const(1)))))]).
