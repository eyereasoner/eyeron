% Prolog result format 4
query(1, mortal(socrates), []).
result(1, complete, 1).
answer(1, []).
why(1, [], [mortal(socrates)]).

clause(1, man(socrates), true).
clause(2, mortal(var('X')), man(var('X'))).

step(mortal(socrates), rule(2), ['X' = socrates], [man(socrates)]).
step(man(socrates), fact(1), [], []).
