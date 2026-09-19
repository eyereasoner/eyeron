# Eyelang result format 2
query(1, [call(descended(?v0, ?v1))], [binding("person", ?v0), binding("ancestor", ?v1)]).
result(1, complete, 4).
answer(1, [binding("person", x), binding("ancestor", a)]).
answer(1, [binding("person", x), binding("ancestor", b)]).
answer(1, [binding("person", a), binding("ancestor", c)]).
answer(1, [binding("person", x), binding("ancestor", c)]).
