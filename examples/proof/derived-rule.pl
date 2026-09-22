% Prolog result format 3
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 4).
clause(1, cat(minka), true).
clause(2, dog(charly), true).
clause(3, test_is(true), (cat(var('X')), dog(var('Y')))).
substitution(1, []).
proof(1, cat(minka), rule(1), []).
substitution(2, []).
proof(2, dog(charly), rule(2), []).
substitution(3, ['X' = minka, 'Y' = charly]).
proof(3, test_is(true), rule(3), [uses(1, cat(minka)), uses(2, dog(charly))]).
substitution(4, ['R' = true]).
proof(4, solution([true]), query, [uses(3, test_is(true))]).
