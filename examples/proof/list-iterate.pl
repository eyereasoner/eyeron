test_iterate([huey, dewey, louie], 0, huey).
test_iterate([huey, dewey, louie], 1, dewey).
test_iterate([huey, dewey, louie], 2, louie).
test_is(true).

clause(1, param(letv, [huey, dewey, louie]), true).
clause(2, iterate([var('X')|var('Xs')], 0, var('X')), true).
clause(3,
       iterate([var('X')|var('Xs')], var('I'), var('Y')),
       (iterate(var('Xs'), var('Prev'), var('Y')), var('I') is var('Prev') + 1)).
clause(4,
       test_iterate(var('X'), var('I'), var('Y')),
       (param(letv, var('X')), iterate(var('X'), var('I'), var('Y')))).
clause(5, test_is(true), test_iterate(var('X'), 1, dewey)).

step(test_iterate([huey, dewey, louie], 0, huey),
     rule(4),
     ['X' = [huey, dewey, louie], 'I' = 0, 'Y' = huey],
     [param(letv, [huey, dewey, louie]), iterate([huey, dewey, louie], 0, huey)]).
step(param(letv, [huey, dewey, louie]), fact(1), [], []).
step(iterate([huey, dewey, louie], 0, huey), fact(2), ['X' = huey, 'Xs' = [dewey, louie]], []).
step(test_iterate([huey, dewey, louie], 1, dewey),
     rule(4),
     ['X' = [huey, dewey, louie], 'I' = 1, 'Y' = dewey],
     [param(letv, [huey, dewey, louie]), iterate([huey, dewey, louie], 1, dewey)]).
step(iterate([huey, dewey, louie], 1, dewey),
     rule(3),
     ['X' = huey, 'Xs' = [dewey, louie], 'I' = 1, 'Y' = dewey, 'Prev' = 0],
     [iterate([dewey, louie], 0, dewey), 1 is 0 + 1]).
step(iterate([dewey, louie], 0, dewey), fact(2), ['X' = dewey, 'Xs' = [louie]], []).
step(1 is 0 + 1, builtin, [], []).
step(test_iterate([huey, dewey, louie], 2, louie),
     rule(4),
     ['X' = [huey, dewey, louie], 'I' = 2, 'Y' = louie],
     [param(letv, [huey, dewey, louie]), iterate([huey, dewey, louie], 2, louie)]).
step(iterate([huey, dewey, louie], 2, louie),
     rule(3),
     ['X' = huey, 'Xs' = [dewey, louie], 'I' = 2, 'Y' = louie, 'Prev' = 1],
     [iterate([dewey, louie], 1, louie), 2 is 1 + 1]).
step(iterate([dewey, louie], 1, louie),
     rule(3),
     ['X' = dewey, 'Xs' = [louie], 'I' = 1, 'Y' = louie, 'Prev' = 0],
     [iterate([louie], 0, louie), 1 is 0 + 1]).
step(iterate([louie], 0, louie), fact(2), ['X' = louie, 'Xs' = []], []).
step(2 is 1 + 1, builtin, [], []).
step(test_is(true),
     rule(5),
     ['X' = [huey, dewey, louie]],
     [test_iterate([huey, dewey, louie], 1, dewey)]).
