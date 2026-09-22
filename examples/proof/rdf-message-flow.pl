% Prolog result format 3
query(1, route(_0, _1), ['M' = _0, 'Sink' = _1]).
result(1, complete, 5).
answer(1, ['M' = 3, 'Sink' = heartbeat_sink]).
why(1, ['M' = 3, 'Sink' = heartbeat_sink], 8).
answer(1, ['M' = 1, 'Sink' = archive_sink]).
why(1, ['M' = 1, 'Sink' = archive_sink], 13).
answer(1, ['M' = 2, 'Sink' = archive_sink]).
why(1, ['M' = 2, 'Sink' = archive_sink], 14).
answer(1, ['M' = 4, 'Sink' = alert_sink]).
why(1, ['M' = 4, 'Sink' = alert_sink], 15).
answer(1, ['M' = 5, 'Sink' = alert_sink]).
why(1, ['M' = 5, 'Sink' = alert_sink], 16).
clause(1, threshold(26), true).
clause(2, message(1, result, 21), true).
clause(3, message(2, result, 22), true).
clause(4, message(3, empty), true).
clause(5, message(4, result, 28), true).
clause(6, message(5, result, 29), true).
clause(7, route(var('M'), archive_sink), (message(var('M'), result, var('R')), threshold(var('T')), var('R') =< var('T'))).
clause(8, route(var('M'), alert_sink), (message(var('M'), result, var('R')), threshold(var('T')), var('R') > var('T'))).
clause(9, route(var('M'), heartbeat_sink), message(var('M'), empty)).
substitution(1, []).
proof(1, message(1, result, 21), rule(2), []).
substitution(2, []).
proof(2, message(2, result, 22), rule(3), []).
substitution(3, []).
proof(3, message(4, result, 28), rule(5), []).
substitution(4, []).
proof(4, message(5, result, 29), rule(6), []).
substitution(5, []).
proof(5, message(3, empty), rule(4), []).
substitution(6, ['M' = 3]).
proof(6, route(3, heartbeat_sink), rule(9), [uses(5, message(3, empty))]).
substitution(7, []).
proof(7, threshold(26), rule(1), []).
substitution(8, ['M' = 3, 'Sink' = heartbeat_sink]).
proof(8, solution([3, heartbeat_sink]), query, [uses(6, route(3, heartbeat_sink))]).
substitution(9, ['M' = 1, 'R' = 21, 'T' = 26]).
proof(9, route(1, archive_sink), rule(7), [uses(1, message(1, result, 21)), uses(7, threshold(26)), builtin(21 =< 26)]).
substitution(10, ['M' = 2, 'R' = 22, 'T' = 26]).
proof(10, route(2, archive_sink), rule(7), [uses(2, message(2, result, 22)), uses(7, threshold(26)), builtin(22 =< 26)]).
substitution(11, ['M' = 4, 'R' = 28, 'T' = 26]).
proof(11, route(4, alert_sink), rule(8), [uses(3, message(4, result, 28)), uses(7, threshold(26)), builtin(28 > 26)]).
substitution(12, ['M' = 5, 'R' = 29, 'T' = 26]).
proof(12, route(5, alert_sink), rule(8), [uses(4, message(5, result, 29)), uses(7, threshold(26)), builtin(29 > 26)]).
substitution(13, ['M' = 1, 'Sink' = archive_sink]).
proof(13, solution([1, archive_sink]), query, [uses(9, route(1, archive_sink))]).
substitution(14, ['M' = 2, 'Sink' = archive_sink]).
proof(14, solution([2, archive_sink]), query, [uses(10, route(2, archive_sink))]).
substitution(15, ['M' = 4, 'Sink' = alert_sink]).
proof(15, solution([4, alert_sink]), query, [uses(11, route(4, alert_sink))]).
substitution(16, ['M' = 5, 'Sink' = alert_sink]).
proof(16, solution([5, alert_sink]), query, [uses(12, route(5, alert_sink))]).
