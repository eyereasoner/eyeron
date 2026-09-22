% Prolog result format 4
query(1, route(_0, _1), ['M' = _0, 'Sink' = _1]).
result(1, complete, 5).
answer(1, ['M' = 3, 'Sink' = heartbeat_sink]).
why(1, ['M' = 3, 'Sink' = heartbeat_sink], [route(3, heartbeat_sink)]).
answer(1, ['M' = 1, 'Sink' = archive_sink]).
why(1, ['M' = 1, 'Sink' = archive_sink], [route(1, archive_sink)]).
answer(1, ['M' = 2, 'Sink' = archive_sink]).
why(1, ['M' = 2, 'Sink' = archive_sink], [route(2, archive_sink)]).
answer(1, ['M' = 4, 'Sink' = alert_sink]).
why(1, ['M' = 4, 'Sink' = alert_sink], [route(4, alert_sink)]).
answer(1, ['M' = 5, 'Sink' = alert_sink]).
why(1, ['M' = 5, 'Sink' = alert_sink], [route(5, alert_sink)]).

clause(1, threshold(26), true).
clause(2, message(1, result, 21), true).
clause(3, message(2, result, 22), true).
clause(4, message(3, empty), true).
clause(5, message(4, result, 28), true).
clause(6, message(5, result, 29), true).
clause(7,
       route(var('M'), archive_sink),
       (message(var('M'), result, var('R')), threshold(var('T')), var('R') =< var('T'))).
clause(8,
       route(var('M'), alert_sink),
       (message(var('M'), result, var('R')), threshold(var('T')), var('R') > var('T'))).
clause(9, route(var('M'), heartbeat_sink), message(var('M'), empty)).

step(route(3, heartbeat_sink), rule(9), ['M' = 3], [message(3, empty)]).
step(message(3, empty), fact(4), [], []).
step(route(1, archive_sink),
     rule(7),
     ['M' = 1, 'R' = 21, 'T' = 26],
     [message(1, result, 21), threshold(26), 21 =< 26]).
step(message(1, result, 21), fact(2), [], []).
step(threshold(26), fact(1), [], []).
step(21 =< 26, builtin, [], []).
step(route(2, archive_sink),
     rule(7),
     ['M' = 2, 'R' = 22, 'T' = 26],
     [message(2, result, 22), threshold(26), 22 =< 26]).
step(message(2, result, 22), fact(3), [], []).
step(22 =< 26, builtin, [], []).
step(route(4, alert_sink),
     rule(8),
     ['M' = 4, 'R' = 28, 'T' = 26],
     [message(4, result, 28), threshold(26), 28 > 26]).
step(message(4, result, 28), fact(5), [], []).
step(28 > 26, builtin, [], []).
step(route(5, alert_sink),
     rule(8),
     ['M' = 5, 'R' = 29, 'T' = 26],
     [message(5, result, 29), threshold(26), 29 > 26]).
step(message(5, result, 29), fact(6), [], []).
step(29 > 26, builtin, [], []).
