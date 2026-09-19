# Eyelang example: filter-function-and-langdir.
value(n1, -3.5). value(n2, 7). directed_text(msg, literal("bonjour", fr, ltr)).
negative(?x) if value(?x, ?v), ?v < 0.
language_direction(?message, ?direction) if directed_text(?message, literal(?text, ?lang, ?direction)).
ask negative(?x). ask language_direction(msg, ?direction).
