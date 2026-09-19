# Eyelang result format 2
query(1, [call(year(event1, ?v0))], [binding("year", ?v0)]).
result(1, complete, 1).
answer(1, [binding("year", 2026)]).
query(2, [call(quoted(?v0))], [binding("subject", ?v0)]).
result(2, complete, 1).
answer(2, [binding("subject", subject)]).
