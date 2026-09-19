# Eyelang result format 2
query(1, [call(year(event1, ?v0))], [binding("year", ?v0)]).
result(1, complete, 1).
answer(1, [binding("year", 2026)]).
why(1, [binding("year", 2026)], 3).
query(2, [call(quoted(?v0))], [binding("subject", ?v0)]).
result(2, complete, 1).
answer(2, [binding("subject", subject)]).
why(2, [binding("subject", subject)], 6).
clause(1, event(event1, datetime(2026, 5, 15, 10, 20, 30)), []).
clause(2, year(var("event"), var("year")), [call(event(var("event"), datetime(var("year"), var("month"), var("day"), var("hour"), var("minute"), var("second"))))]).
clause(3, quoted(var("subject")), [call(triple_value(triple(var("subject"), predicate, object)))]).
clause(4, triple_value(triple(subject, predicate, object)), []).
substitution(1, []).
proof(1, event(event1, datetime(2026, 5, 15, 10, 20, 30)), rule(1), []).
substitution(2, [binding("event", event1), binding("year", 2026), binding("month", 5), binding("day", 15), binding("hour", 10), binding("minute", 20), binding("second", 30)]).
proof(2, year(event1, 2026), rule(2), [uses(1, event(event1, datetime(2026, 5, 15, 10, 20, 30)))]).
substitution(3, [binding("year", 2026)]).
proof(3, solution([2026]), query, [uses(2, year(event1, 2026))]).
substitution(4, []).
proof(4, triple_value(triple(subject, predicate, object)), rule(4), []).
substitution(5, [binding("subject", subject)]).
proof(5, quoted(subject), rule(3), [uses(4, triple_value(triple(subject, predicate, object)))]).
substitution(6, [binding("subject", subject)]).
proof(6, solution([subject]), query, [uses(5, quoted(subject))]).
