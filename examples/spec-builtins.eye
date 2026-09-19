# Eyelang example: spec-builtins.
event(event1, datetime(2026, 5, 15, 10, 20, 30)).
year(?event, ?year) if event(?event, datetime(?year, ?month, ?day, ?hour, ?minute, ?second)).
quoted(?subject) if triple_value(triple(?subject, predicate, object)).
triple_value(triple(subject, predicate, object)).
ask year(event1, ?year). ask quoted(?subject).
