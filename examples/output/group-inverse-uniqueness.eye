# Eyelang result format 2
query(1, [call(result_query(?v0, ?v1, ?v2))], [binding("x_", ?v0), binding("y_", ?v1), binding("z_", ?v2)]).
result(1, complete, 2).
answer(1, [binding("x_", x_), binding("y_", i_), binding("z_", j_)]).
answer(1, [binding("x_", x_), binding("y_", j_), binding("z_", i_)]).
