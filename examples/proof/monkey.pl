animal(bobos_kind).
test.

clause(2, monkey(bobos_kind), true).
clause(3, animal(var('X')), monkey(var('X'))).
clause(4, test, (monkey(var('X')), animal(var('X')))).

step(animal(bobos_kind), rule(3), ['X' = bobos_kind], [monkey(bobos_kind)]).
step(monkey(bobos_kind), fact(2), [], []).
step(test, rule(4), ['X' = bobos_kind], [monkey(bobos_kind), animal(bobos_kind)]).
