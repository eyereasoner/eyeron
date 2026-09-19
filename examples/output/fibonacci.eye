# Eyelang result format 2
query(1, [call(fib(100, ?v0))], [binding("value", ?v0)]).
result(1, complete, 1).
answer(1, [binding("value", 354224848179261915075)]).
