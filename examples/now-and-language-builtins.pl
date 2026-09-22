% Prolog example: now-and-language-builtins.
text(msg, literal("bonjour", fr)).
same_language(Message) :-
    text(Message, literal(Value, fr)).
event(clock, datetime(2026, 5, 15, 10, 20, 30)).
event_year(Event, Year) :-
    event(Event, datetime(Year, Month, Day, Hour, Minute, Second)).
?- same_language(msg).
?- event_year(clock, Year).
