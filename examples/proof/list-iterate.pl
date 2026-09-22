% Prolog result format 3
query(1, test_iterate(_0, _1, _2), ['X' = _0, 'I' = _1, 'Y' = _2]).
result(1, complete, 3).
answer(1, ['X' = [huey, dewey, louie], 'I' = 0, 'Y' = huey]).
why(1, ['X' = [huey, dewey, louie], 'I' = 0, 'Y' = huey], 5).
answer(1, ['X' = [huey, dewey, louie], 'I' = 1, 'Y' = dewey]).
why(1, ['X' = [huey, dewey, louie], 'I' = 1, 'Y' = dewey], 10).
answer(1, ['X' = [huey, dewey, louie], 'I' = 2, 'Y' = louie]).
why(1, ['X' = [huey, dewey, louie], 'I' = 2, 'Y' = louie], 13).
query(2, test_is(_0), ['R' = _0]).
result(2, complete, 1).
answer(2, ['R' = true]).
why(2, ['R' = true], 19).
clause(1, param(letv, [huey, dewey, louie]), true).
clause(2, iterate([var('X')|var('Xs')], 0, var('X')), true).
clause(3, iterate([var('X')|var('Xs')], var('I'), var('Y')), (iterate(var('Xs'), var('Prev'), var('Y')), var('I') is var('Prev') + 1)).
clause(4, test_iterate(var('X'), var('I'), var('Y')), (param(letv, var('X')), iterate(var('X'), var('I'), var('Y')))).
clause(5, test_is(true), test_iterate(var('X'), 1, dewey)).
substitution(1, []).
proof(1, param(letv, [huey, dewey, louie]), rule(1), []).
substitution(2, ['X' = huey, 'Xs' = [dewey, louie]]).
proof(2, iterate([huey, dewey, louie], 0, huey), rule(2), []).
substitution(3, ['X' = [huey, dewey, louie], 'I' = 0, 'Y' = huey]).
proof(3, test_iterate([huey, dewey, louie], 0, huey), rule(4), [uses(1, param(letv, [huey, dewey, louie])), uses(2, iterate([huey, dewey, louie], 0, huey))]).
substitution(4, ['X' = dewey, 'Xs' = [louie]]).
proof(4, iterate([dewey, louie], 0, dewey), rule(2), []).
substitution(5, ['X' = [huey, dewey, louie], 'I' = 0, 'Y' = huey]).
proof(5, solution([[huey, dewey, louie], 0, huey]), query, [uses(3, test_iterate([huey, dewey, louie], 0, huey))]).
substitution(6, ['X' = huey, 'Xs' = [dewey, louie], 'I' = 1, 'Y' = dewey, 'Prev' = 0]).
proof(6, iterate([huey, dewey, louie], 1, dewey), rule(3), [uses(4, iterate([dewey, louie], 0, dewey)), builtin(1 is 0 + 1)]).
substitution(7, ['X' = louie, 'Xs' = []]).
proof(7, iterate([louie], 0, louie), rule(2), []).
substitution(8, ['X' = [huey, dewey, louie], 'I' = 1, 'Y' = dewey]).
proof(8, test_iterate([huey, dewey, louie], 1, dewey), rule(4), [uses(1, param(letv, [huey, dewey, louie])), uses(6, iterate([huey, dewey, louie], 1, dewey))]).
substitution(9, ['X' = dewey, 'Xs' = [louie], 'I' = 1, 'Y' = louie, 'Prev' = 0]).
proof(9, iterate([dewey, louie], 1, louie), rule(3), [uses(7, iterate([louie], 0, louie)), builtin(1 is 0 + 1)]).
substitution(10, ['X' = [huey, dewey, louie], 'I' = 1, 'Y' = dewey]).
proof(10, solution([[huey, dewey, louie], 1, dewey]), query, [uses(8, test_iterate([huey, dewey, louie], 1, dewey))]).
substitution(11, ['X' = huey, 'Xs' = [dewey, louie], 'I' = 2, 'Y' = louie, 'Prev' = 1]).
proof(11, iterate([huey, dewey, louie], 2, louie), rule(3), [uses(9, iterate([dewey, louie], 1, louie)), builtin(2 is 1 + 1)]).
substitution(12, ['X' = [huey, dewey, louie], 'I' = 2, 'Y' = louie]).
proof(12, test_iterate([huey, dewey, louie], 2, louie), rule(4), [uses(1, param(letv, [huey, dewey, louie])), uses(11, iterate([huey, dewey, louie], 2, louie))]).
substitution(13, ['X' = [huey, dewey, louie], 'I' = 2, 'Y' = louie]).
proof(13, solution([[huey, dewey, louie], 2, louie]), query, [uses(12, test_iterate([huey, dewey, louie], 2, louie))]).
substitution(14, []).
proof(14, param(letv, [huey, dewey, louie]), rule(1), []).
substitution(15, ['X' = dewey, 'Xs' = [louie]]).
proof(15, iterate([dewey, louie], 0, dewey), rule(2), []).
substitution(16, ['X' = huey, 'Xs' = [dewey, louie], 'I' = 1, 'Y' = dewey, 'Prev' = 0]).
proof(16, iterate([huey, dewey, louie], 1, dewey), rule(3), [uses(15, iterate([dewey, louie], 0, dewey)), builtin(1 is 0 + 1)]).
substitution(17, ['X' = [huey, dewey, louie], 'I' = 1, 'Y' = dewey]).
proof(17, test_iterate([huey, dewey, louie], 1, dewey), rule(4), [uses(14, param(letv, [huey, dewey, louie])), uses(16, iterate([huey, dewey, louie], 1, dewey))]).
substitution(18, ['X' = [huey, dewey, louie]]).
proof(18, test_is(true), rule(5), [uses(17, test_iterate([huey, dewey, louie], 1, dewey))]).
substitution(19, ['R' = true]).
proof(19, solution([true]), query, [uses(18, test_is(true))]).
