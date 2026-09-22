% Prolog result format 3
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 5).
clause(1, to(post, pillar), true).
clause(2, to(pillar, var('What')), to(var('What'), pillar)).
clause(4, result_is(var('What')), to(pillar, var('What'))).
clause(5, test_is(true), result_is(post)).
substitution(1, []).
proof(1, to(post, pillar), rule(1), []).
substitution(2, ['What' = post]).
proof(2, to(pillar, post), rule(2), [uses(1, to(post, pillar))]).
substitution(3, ['What' = post]).
proof(3, result_is(post), rule(4), [uses(2, to(pillar, post))]).
substitution(4, []).
proof(4, test_is(true), rule(5), [uses(3, result_is(post))]).
substitution(5, ['R' = true]).
proof(5, solution([true]), query, [uses(4, test_is(true))]).
