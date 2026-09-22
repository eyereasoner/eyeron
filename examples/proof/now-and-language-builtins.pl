% Prolog result format 4
query(1, same_language(msg), []).
result(1, complete, 1).
answer(1, []).
why(1, [], [same_language(msg)]).
query(2, event_year(clock, _0), ['Year' = _0]).
result(2, complete, 1).
answer(2, ['Year' = 2026]).
why(2, ['Year' = 2026], [event_year(clock, 2026)]).

clause(1, text(msg, literal("bonjour", fr)), true).
clause(2, same_language(var('Message')), text(var('Message'), literal(var('Value'), fr))).
clause(3, event(clock, datetime(2026, 5, 15, 10, 20, 30)), true).
clause(4,
       event_year(var('Event'), var('Year')),
       event(var('Event'), datetime(var('Year'), var('Month'), var('Day'), var('Hour'), var('Minute'), var('Second')))).

step(same_language(msg),
     rule(2),
     ['Message' = msg, 'Value' = "bonjour"],
     [text(msg, literal("bonjour", fr))]).
step(text(msg, literal("bonjour", fr)), fact(1), [], []).
step(event_year(clock, 2026),
     rule(4),
     ['Event' = clock,
      'Year' = 2026,
      'Month' = 5,
      'Day' = 15,
      'Hour' = 10,
      'Minute' = 20,
      'Second' = 30],
     [event(clock, datetime(2026, 5, 15, 10, 20, 30))]).
step(event(clock, datetime(2026, 5, 15, 10, 20, 30)), fact(3), [], []).
