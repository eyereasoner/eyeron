# Eyelang result format 2
query(1, [call(phase_pi(?v0, ?v1))], [binding("re", ?v0), binding("im", ?v1)]).
result(1, complete, 1).
answer(1, [binding("re", -1), binding("im", 0)]).
query(2, [call(lhs(?v0, ?v1))], [binding("re", ?v0), binding("im", ?v1)]).
result(2, complete, 1).
answer(2, [binding("re", 0), binding("im", 0)]).
query(3, [call(holds(?v0))], [binding("ok", ?v0)]).
result(3, complete, 1).
answer(3, [binding("ok", true)]).
query(4, [call(mod_sq(?v0))], [binding("m", ?v0)]).
result(4, complete, 1).
answer(4, [binding("m", 1)]).
query(5, [call(mod_sq_is_one(?v0))], [binding("ok", ?v0)]).
result(5, complete, 1).
answer(5, [binding("ok", true)]).
