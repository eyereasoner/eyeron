# Eyelang result format 2
query(1, [call(type([], app(lam(x, var(x)), int_lit(42)), ?v0))], [binding("type", ?v0)]).
result(1, complete, 1).
answer(1, [binding("type", int)]).
query(2, [call(type([], lam(x, var(x)), ?v0))], [binding("type", ?v0)]).
result(2, complete, 1).
answer(2, [binding("type", fun(?v0, ?v0))]).
