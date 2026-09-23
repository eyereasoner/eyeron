eligible(bob).

clause(2, person(bob), true).
clause(8, eligible(var('X')), (person(var('X')), \+blocked(var('X')))).

step(eligible(bob), rule(8), ['X' = bob], [person(bob), \+blocked(bob)]).
step(person(bob), fact(2), [], []).
step(\+blocked(bob), absent, [], []).
