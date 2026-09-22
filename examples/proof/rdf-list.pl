% Prolog result format 3
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 3).
clause(1, val(x, [1, 2]), true).
clause(2, test_is(true), (val(x, [var('H')|var('T')]), var('H') = 1, var('T') = [2])).
substitution(1, []).
proof(1, val(x, [1, 2]), rule(1), []).
substitution(2, ['H' = 1, 'T' = [2]]).
proof(2, test_is(true), rule(2), [uses(1, val(x, [1, 2])), builtin(1 = 1), builtin([2] = [2])]).
substitution(3, ['R' = true]).
proof(3, solution([true]), query, [uses(2, test_is(true))]).
