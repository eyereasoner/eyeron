year(event1, 2026).
quoted(subject).

clause(1, event(event1, datetime(2026, 5, 15, 10, 20, 30)), true).
clause(2,
       year(var('Event'), var('Year')),
       event(var('Event'), datetime(var('Year'), var('Month'), var('Day'), var('Hour'), var('Minute'), var('Second')))).
clause(3, quoted(var('Subject')), triple_value(triple(var('Subject'), predicate, object))).
clause(4, triple_value(triple(subject, predicate, object)), true).

step(year(event1, 2026),
     rule(2),
     ['Event' = event1,
      'Year' = 2026,
      'Month' = 5,
      'Day' = 15,
      'Hour' = 10,
      'Minute' = 20,
      'Second' = 30],
     [event(event1, datetime(2026, 5, 15, 10, 20, 30))]).
step(event(event1, datetime(2026, 5, 15, 10, 20, 30)), fact(1), [], []).
step(quoted(subject),
     rule(3),
     ['Subject' = subject],
     [triple_value(triple(subject, predicate, object))]).
step(triple_value(triple(subject, predicate, object)), fact(4), [], []).
