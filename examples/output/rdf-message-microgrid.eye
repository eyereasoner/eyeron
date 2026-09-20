# Eyelang result format 2
query(1, [call(critical_watts(?v0))], [binding("critical", ?v0)]).
result(1, complete, 1).
answer(1, [binding("critical", 620)]).
query(2, [call(available_total(?v0))], [binding("available", ?v0)]).
result(2, complete, 1).
answer(2, [binding("available", 800)]).
query(3, [call(deferrable_watts(?v0))], [binding("deferrable", ?v0)]).
result(3, complete, 1).
answer(3, [binding("deferrable", 600)]).
query(4, [call(protected_budget(?v0))], [binding("protected", ?v0)]).
result(4, complete, 1).
answer(4, [binding("protected", 1400)]).
query(5, [call(resilience_action(?v0))], [binding("action", ?v0)]).
result(5, complete, 1).
answer(5, [binding("action", protect_clinic)]).
