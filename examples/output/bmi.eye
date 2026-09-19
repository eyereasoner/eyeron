# Eyelang result format 2
query(1, [call(report(?v0, ?v1, ?v2, ?v3))], [binding("bmi", ?v0), binding("category", ?v1), binding("healthy_min", ?v2), binding("healthy_max", ?v3)]).
result(1, complete, 1).
answer(1, [binding("bmi", 22.72), binding("category", normal), binding("healthy_min", 58.6), binding("healthy_max", 78.9)]).
