% Prolog result format 3
query(1, year(event1, _0), ['Year' = _0]).
result(1, complete, 1).
answer(1, ['Year' = 2026]).
why(1, ['Year' = 2026], 3).
query(2, quoted(_0), ['Subject' = _0]).
result(2, complete, 1).
answer(2, ['Subject' = subject]).
why(2, ['Subject' = subject], 6).
clause(1, event(event1, datetime(2026, 5, 15, 10, 20, 30)), true).
clause(2, year(var('Event'), var('Year')), event(var('Event'), datetime(var('Year'), var('Month'), var('Day'), var('Hour'), var('Minute'), var('Second')))).
clause(3, quoted(var('Subject')), triple_value(triple(var('Subject'), predicate, object))).
clause(4, triple_value(triple(subject, predicate, object)), true).
substitution(1, []).
proof(1, event(event1, datetime(2026, 5, 15, 10, 20, 30)), rule(1), []).
substitution(2, ['Event' = event1, 'Year' = 2026, 'Month' = 5, 'Day' = 15, 'Hour' = 10, 'Minute' = 20, 'Second' = 30]).
proof(2, year(event1, 2026), rule(2), [uses(1, event(event1, datetime(2026, 5, 15, 10, 20, 30)))]).
substitution(3, ['Year' = 2026]).
proof(3, solution([2026]), query, [uses(2, year(event1, 2026))]).
substitution(4, []).
proof(4, triple_value(triple(subject, predicate, object)), rule(4), []).
substitution(5, ['Subject' = subject]).
proof(5, quoted(subject), rule(3), [uses(4, triple_value(triple(subject, predicate, object)))]).
substitution(6, ['Subject' = subject]).
proof(6, solution([subject]), query, [uses(5, quoted(subject))]).
