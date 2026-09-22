% Prolog result format 3
query(1, first(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = 1]).
why(1, ['X' = 1], 3).
query(2, blank_property(_0), ['X' = _0]).
result(2, complete, 1).
answer(2, ['X' = q]).
why(2, ['X' = q], 6).
query(3, nested_first(_0), ['X' = _0]).
result(3, complete, 1).
answer(3, ['X' = 2]).
why(3, ['X' = 2], 9).
clause(1, value(root, [1, node(q), [2]]), true).
clause(2, first(var('X')), value(root, [var('X'), var('Middle'), var('Last')])).
clause(3, blank_property(var('X')), value(root, [var('First'), node(var('X')), var('Last')])).
clause(4, nested_first(var('X')), value(root, [var('First'), var('Middle'), [var('X')]])).
substitution(1, []).
proof(1, value(root, [1, node(q), [2]]), rule(1), []).
substitution(2, ['X' = 1, 'Middle' = node(q), 'Last' = [2]]).
proof(2, first(1), rule(2), [uses(1, value(root, [1, node(q), [2]]))]).
substitution(3, ['X' = 1]).
proof(3, solution([1]), query, [uses(2, first(1))]).
substitution(4, []).
proof(4, value(root, [1, node(q), [2]]), rule(1), []).
substitution(5, ['X' = q, 'First' = 1, 'Last' = [2]]).
proof(5, blank_property(q), rule(3), [uses(4, value(root, [1, node(q), [2]]))]).
substitution(6, ['X' = q]).
proof(6, solution([q]), query, [uses(5, blank_property(q))]).
substitution(7, []).
proof(7, value(root, [1, node(q), [2]]), rule(1), []).
substitution(8, ['X' = 2, 'First' = 1, 'Middle' = node(q)]).
proof(8, nested_first(2), rule(4), [uses(7, value(root, [1, node(q), [2]]))]).
substitution(9, ['X' = 2]).
proof(9, solution([2]), query, [uses(8, nested_first(2))]).
