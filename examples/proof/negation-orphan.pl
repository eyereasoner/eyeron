orphan(bob).

clause(2, person(bob), true).
clause(5, orphan(var('X')), (person(var('X')), \+has_a_parent(var('X')))).

step(orphan(bob), rule(5), ['X' = bob], [person(bob), \+has_a_parent(bob)]).
step(person(bob), fact(2), [], []).
step(\+has_a_parent(bob), absent, [], []).
