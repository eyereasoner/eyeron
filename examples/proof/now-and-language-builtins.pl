% Prolog result format 3
query(1, same_language(msg), []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
query(2, event_year(clock, _0), ['Year' = _0]).
result(2, complete, 1).
answer(2, ['Year' = 2026]).
why(2, ['Year' = 2026], 6).
clause(1, text(msg, literal("bonjour", fr)), true).
clause(2, same_language(var('Message')), text(var('Message'), literal(var('Value'), fr))).
clause(3, event(clock, datetime(2026, 5, 15, 10, 20, 30)), true).
clause(4, event_year(var('Event'), var('Year')), event(var('Event'), datetime(var('Year'), var('Month'), var('Day'), var('Hour'), var('Minute'), var('Second')))).
substitution(1, []).
proof(1, text(msg, literal("bonjour", fr)), rule(1), []).
substitution(2, ['Message' = msg, 'Value' = "bonjour"]).
proof(2, same_language(msg), rule(2), [uses(1, text(msg, literal("bonjour", fr)))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, same_language(msg))]).
substitution(4, []).
proof(4, event(clock, datetime(2026, 5, 15, 10, 20, 30)), rule(3), []).
substitution(5, ['Event' = clock, 'Year' = 2026, 'Month' = 5, 'Day' = 15, 'Hour' = 10, 'Minute' = 20, 'Second' = 30]).
proof(5, event_year(clock, 2026), rule(4), [uses(4, event(clock, datetime(2026, 5, 15, 10, 20, 30)))]).
substitution(6, ['Year' = 2026]).
proof(6, solution([2026]), query, [uses(5, event_year(clock, 2026))]).
