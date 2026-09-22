% Prolog example: spec-builtins.
event(event1, datetime(2026, 5, 15, 10, 20, 30)).
year(Event, Year) :-
    event(Event, datetime(Year, Month, Day, Hour, Minute, Second)).
quoted(Subject) :-
    triple_value(triple(Subject, predicate, object)).
triple_value(triple(subject, predicate, object)).
?- year(event1, Year).
?- quoted(Subject).
