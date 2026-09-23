eligible(alice).

clause(1, person(alice), true).
clause(4, eligible(var('X')), (person(var('X')), \+blocked(var('X')))).

step(eligible(alice), rule(4), ['X' = alice], [person(alice), \+blocked(alice)]).
step(person(alice), fact(1), [], []).
step(\+blocked(alice), absent, [], []).
