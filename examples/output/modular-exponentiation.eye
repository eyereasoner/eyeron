# Eyelang result format 2
query(1, [call(small_check(?v0, ?v1))], [binding("naive", ?v0), binding("fast", ?v1)]).
result(1, complete, 1).
answer(1, [binding("naive", 38), binding("fast", 38)]).
query(2, [call(large_case(?v0, ?v1))], [binding("case", ?v0), binding("value", ?v1)]).
result(2, complete, 3).
answer(2, [binding("case", last_12_digits), binding("value", 940335579136)]).
answer(2, [binding("case", seven_power_billion), binding("value", 312556845)]).
answer(2, [binding("case", three_power_two_power_25), binding("value", 849572438)]).
