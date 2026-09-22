% Prolog result format 4
query(1, route(_0, _1), ['M' = _0, 'Sink' = _1]).
result(1, complete, 5).
answer(1, ['M' = 3, 'Sink' = heartbeat_sink]).
answer(1, ['M' = 1, 'Sink' = archive_sink]).
answer(1, ['M' = 2, 'Sink' = archive_sink]).
answer(1, ['M' = 4, 'Sink' = alert_sink]).
answer(1, ['M' = 5, 'Sink' = alert_sink]).
