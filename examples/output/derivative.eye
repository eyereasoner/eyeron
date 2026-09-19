# Eyelang result format 2
query(1, [call(d(mul(var(x), var(x)), x, ?v0))], [binding("derivative", ?v0)]).
result(1, complete, 1).
answer(1, [binding("derivative", add(mul(const(1), var(x)), mul(var(x), const(1))))]).
