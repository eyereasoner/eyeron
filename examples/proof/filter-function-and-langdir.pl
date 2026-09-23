negative(n1).
language_direction(msg, ltr).

clause(1, value(n1, -3.5), true).
clause(3, directed_text(msg, literal("bonjour", fr, ltr)), true).
clause(4, negative(var('X')), (value(var('X'), var('V')), var('V') < 0)).
clause(5,
       language_direction(var('Message'), var('Direction')),
       directed_text(var('Message'), literal(var('Text'), var('Lang'), var('Direction')))).

step(negative(n1), rule(4), ['X' = n1, 'V' = -3.5], [value(n1, -3.5), -3.5 < 0]).
step(value(n1, -3.5), fact(1), [], []).
step(-3.5 < 0, builtin, [], []).
step(language_direction(msg, ltr),
     rule(5),
     ['Message' = msg, 'Direction' = ltr, 'Text' = "bonjour", 'Lang' = fr],
     [directed_text(msg, literal("bonjour", fr, ltr))]).
step(directed_text(msg, literal("bonjour", fr, ltr)), fact(3), [], []).
