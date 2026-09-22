% Prolog result format 3
query(1, both_positive(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = x]).
why(1, ['X' = x], 3).
query(2, one_zero(_0), ['X' = _0]).
result(2, complete, 0).
clause(1, values(x, 1, 2), true).
clause(2, both_positive(var('X')), (values(var('X'), var('A'), var('B')), var('A') > 0, var('B') > 0)).
substitution(1, []).
proof(1, values(x, 1, 2), rule(1), []).
substitution(2, ['X' = x, 'A' = 1, 'B' = 2]).
proof(2, both_positive(x), rule(2), [uses(1, values(x, 1, 2)), builtin(1 > 0), builtin(2 > 0)]).
substitution(3, ['X' = x]).
proof(3, solution([x]), query, [uses(2, both_positive(x))]).
