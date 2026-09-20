# Eyelang result format 2
query(1, [call(route(?v0, ?v1))], [binding("m", ?v0), binding("sink", ?v1)]).
result(1, complete, 5).
answer(1, [binding("m", 3), binding("sink", heartbeat_sink)]).
why(1, [binding("m", 3), binding("sink", heartbeat_sink)], 8).
answer(1, [binding("m", 1), binding("sink", archive_sink)]).
why(1, [binding("m", 1), binding("sink", archive_sink)], 13).
answer(1, [binding("m", 2), binding("sink", archive_sink)]).
why(1, [binding("m", 2), binding("sink", archive_sink)], 14).
answer(1, [binding("m", 4), binding("sink", alert_sink)]).
why(1, [binding("m", 4), binding("sink", alert_sink)], 15).
answer(1, [binding("m", 5), binding("sink", alert_sink)]).
why(1, [binding("m", 5), binding("sink", alert_sink)], 16).
clause(1, threshold(26), []).
clause(2, message(1, result, 21), []).
clause(3, message(2, result, 22), []).
clause(4, message(3, empty), []).
clause(5, message(4, result, 28), []).
clause(6, message(5, result, 29), []).
clause(7, route(var("m"), archive_sink), [call(message(var("m"), result, var("r"))), call(threshold(var("t"))), compare("<=", var("r"), var("t"))]).
clause(8, route(var("m"), alert_sink), [call(message(var("m"), result, var("r"))), call(threshold(var("t"))), compare(">", var("r"), var("t"))]).
clause(9, route(var("m"), heartbeat_sink), [call(message(var("m"), empty))]).
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
substitution(6, [binding("m", 3)]).
proof(6, route(3, heartbeat_sink), rule(9), [uses(5, message(3, empty))]).
substitution(7, []).
proof(7, threshold(26), rule(1), []).
substitution(8, [binding("m", 3), binding("sink", heartbeat_sink)]).
proof(8, solution([3, heartbeat_sink]), query, [uses(6, route(3, heartbeat_sink))]).
substitution(9, [binding("m", 1), binding("r", 21), binding("t", 26)]).
proof(9, route(1, archive_sink), rule(7), [uses(1, message(1, result, 21)), uses(7, threshold(26)), compared("<=", 21, 26)]).
substitution(10, [binding("m", 2), binding("r", 22), binding("t", 26)]).
proof(10, route(2, archive_sink), rule(7), [uses(2, message(2, result, 22)), uses(7, threshold(26)), compared("<=", 22, 26)]).
substitution(11, [binding("m", 4), binding("r", 28), binding("t", 26)]).
proof(11, route(4, alert_sink), rule(8), [uses(3, message(4, result, 28)), uses(7, threshold(26)), compared(">", 28, 26)]).
substitution(12, [binding("m", 5), binding("r", 29), binding("t", 26)]).
proof(12, route(5, alert_sink), rule(8), [uses(4, message(5, result, 29)), uses(7, threshold(26)), compared(">", 29, 26)]).
substitution(13, [binding("m", 1), binding("sink", archive_sink)]).
proof(13, solution([1, archive_sink]), query, [uses(9, route(1, archive_sink))]).
substitution(14, [binding("m", 2), binding("sink", archive_sink)]).
proof(14, solution([2, archive_sink]), query, [uses(10, route(2, archive_sink))]).
substitution(15, [binding("m", 4), binding("sink", alert_sink)]).
proof(15, solution([4, alert_sink]), query, [uses(11, route(4, alert_sink))]).
substitution(16, [binding("m", 5), binding("sink", alert_sink)]).
proof(16, solution([5, alert_sink]), query, [uses(12, route(5, alert_sink))]).
