% Prolog result format 3
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 4).
clause(1, cat(c), true).
clause(2, animal(var('X')), cat(var('X'))).
clause(3, test_is(true), animal(c)).
substitution(1, []).
proof(1, cat(c), rule(1), []).
substitution(2, ['X' = c]).
proof(2, animal(c), rule(2), [uses(1, cat(c))]).
substitution(3, []).
proof(3, test_is(true), rule(3), [uses(2, animal(c))]).
substitution(4, ['R' = true]).
proof(4, solution([true]), query, [uses(3, test_is(true))]).
