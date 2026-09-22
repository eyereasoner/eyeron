% Prolog result format 3
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 4).
clause(1, has(alice, [book, 1]), true).
clause(2, has(bob, [table, 1]), true).
clause(3, test_is(true), (has(var('W1'), [var('O1'), var('N1')]), has(var('W2'), [var('O2'), var('N2')]), var('O1') \== var('O2'))).
substitution(1, []).
proof(1, has(alice, [book, 1]), rule(1), []).
substitution(2, []).
proof(2, has(bob, [table, 1]), rule(2), []).
substitution(3, ['W1' = alice, 'O1' = book, 'N1' = 1, 'W2' = bob, 'O2' = table, 'N2' = 1]).
proof(3, test_is(true), rule(3), [uses(1, has(alice, [book, 1])), uses(2, has(bob, [table, 1])), builtin(book \== table)]).
substitution(4, ['R' = true]).
proof(4, solution([true]), query, [uses(3, test_is(true))]).
