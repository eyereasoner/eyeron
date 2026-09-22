% Prolog result format 3
query(1, summary(_0, _1, _2, _3), ['Absolute' = _0, 'Root' = _1, 'Count' = _2, 'Sorted' = _3]).
result(1, complete, 1).
answer(1, ['Absolute' = 3.7, 'Root' = 3.0, 'Count' = 3, 'Sorted' = [-3.7, 2, 7]]).
why(1, ['Absolute' = 3.7, 'Root' = 3.0, 'Count' = 3, 'Sorted' = [-3.7, 2, 7]], 3).
clause(1, numbers([-3.7, 7, 2]), true).
clause(2, summary(var('Absolute'), var('Root'), var('Count'), var('Sorted')), (numbers(var('Values')), var('Absolute') is abs(- 3.7), var('Root') is sqrt(9), length(var('Values'), var('Count')), sort(var('Values'), var('Sorted')))).
substitution(1, []).
proof(1, numbers([-3.7, 7, 2]), rule(1), []).
substitution(2, ['Absolute' = 3.7, 'Root' = 3.0, 'Count' = 3, 'Sorted' = [-3.7, 2, 7], 'Values' = [-3.7, 7, 2]]).
proof(2, summary(3.7, 3.0, 3, [-3.7, 2, 7]), rule(2), [uses(1, numbers([-3.7, 7, 2])), builtin(3.7 is abs(- 3.7)), builtin(3.0 is sqrt(9)), builtin(length([-3.7, 7, 2], 3)), builtin(sort([-3.7, 7, 2], [-3.7, 2, 7]))]).
substitution(3, ['Absolute' = 3.7, 'Root' = 3.0, 'Count' = 3, 'Sorted' = [-3.7, 2, 7]]).
proof(3, solution([3.7, 3.0, 3, [-3.7, 2, 7]]), query, [uses(2, summary(3.7, 3.0, 3, [-3.7, 2, 7]))]).
