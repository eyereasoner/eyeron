# Eyelang result format 2
query(1, [call(same_language(msg))], []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
query(2, [call(event_year(clock, ?v0))], [binding("year", ?v0)]).
result(2, complete, 1).
answer(2, [binding("year", 2026)]).
why(2, [binding("year", 2026)], 6).
clause(1, text(msg, literal("bonjour", fr)), []).
clause(2, same_language(var("message")), [call(text(var("message"), literal(var("value"), fr)))]).
clause(3, event(clock, datetime(2026, 5, 15, 10, 20, 30)), []).
clause(4, event_year(var("event"), var("year")), [call(event(var("event"), datetime(var("year"), var("month"), var("day"), var("hour"), var("minute"), var("second"))))]).
substitution(1, []).
proof(1, text(msg, literal("bonjour", fr)), rule(1), []).
substitution(2, [binding("message", msg), binding("value", "bonjour")]).
proof(2, same_language(msg), rule(2), [uses(1, text(msg, literal("bonjour", fr)))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, same_language(msg))]).
substitution(4, []).
proof(4, event(clock, datetime(2026, 5, 15, 10, 20, 30)), rule(3), []).
substitution(5, [binding("event", clock), binding("year", 2026), binding("month", 5), binding("day", 15), binding("hour", 10), binding("minute", 20), binding("second", 30)]).
proof(5, event_year(clock, 2026), rule(4), [uses(4, event(clock, datetime(2026, 5, 15, 10, 20, 30)))]).
substitution(6, [binding("year", 2026)]).
proof(6, solution([2026]), query, [uses(5, event_year(clock, 2026))]).
