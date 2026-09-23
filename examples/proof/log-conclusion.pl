says(felix, "Meow").

clause(1, cat(felix), true).
clause(2, says(var('X'), "Meow"), cat(var('X'))).

step(says(felix, "Meow"), rule(2), ['X' = felix], [cat(felix)]).
step(cat(felix), fact(1), [], []).
