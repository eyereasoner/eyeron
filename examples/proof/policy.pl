eligible(bob).

clause(2, person(bob), true).
clause(6, eligible(var('Person')), (person(var('Person')), \+blocked(var('Person')))).

step(eligible(bob), rule(6), ['Person' = bob], [person(bob), \+blocked(bob)]).
step(person(bob), fact(2), [], []).
step(\+blocked(bob), absent, [], []).
