# Eyelang result format 2
query(1, [call(route(?v0, ?v1))], [binding("m", ?v0), binding("sink", ?v1)]).
result(1, complete, 5).
answer(1, [binding("m", 3), binding("sink", heartbeat_sink)]).
answer(1, [binding("m", 1), binding("sink", archive_sink)]).
answer(1, [binding("m", 2), binding("sink", archive_sink)]).
answer(1, [binding("m", 4), binding("sink", alert_sink)]).
answer(1, [binding("m", 5), binding("sink", alert_sink)]).
