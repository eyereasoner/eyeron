# Eyelang example: now-and-language-builtins.
text(msg, literal("bonjour", fr)).
same_language(?message) if text(?message, literal(?value, fr)).
event(clock, datetime(2026, 5, 15, 10, 20, 30)).
event_year(?event, ?year) if event(?event, datetime(?year, ?month, ?day, ?hour, ?minute, ?second)).
ask same_language(msg). ask event_year(clock, ?year).
