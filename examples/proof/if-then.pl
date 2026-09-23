mortal(socrates).

clause(1, man(socrates), true).
clause(2, mortal(var('X')), man(var('X'))).

step(mortal(socrates), rule(2), ['X' = socrates], [man(socrates)]).
step(man(socrates), fact(1), [], []).
