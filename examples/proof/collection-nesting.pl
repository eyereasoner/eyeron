% Prolog result format 3
query(1, first(_0), ['Value' = _0]).
result(1, complete, 1).
answer(1, ['Value' = 1]).
why(1, ['Value' = 1], 3).
query(2, second_property(_0), ['Value' = _0]).
result(2, complete, 1).
answer(2, ['Value' = q]).
why(2, ['Value' = q], 6).
query(3, third_first(_0), ['Value' = _0]).
result(3, complete, 1).
answer(3, ['Value' = 2]).
why(3, ['Value' = 2], 9).
clause(1, nested(root, [1, node(q), [2]]), true).
clause(2, first(var('First')), nested(root, [var('First'), var('Second'), var('Third')])).
clause(3, second_property(var('Value')), nested(root, [var('First'), node(var('Value')), var('Third')])).
clause(4, third_first(var('Value')), nested(root, [var('First'), var('Second'), [var('Value')]])).
substitution(1, []).
proof(1, nested(root, [1, node(q), [2]]), rule(1), []).
substitution(2, ['First' = 1, 'Second' = node(q), 'Third' = [2]]).
proof(2, first(1), rule(2), [uses(1, nested(root, [1, node(q), [2]]))]).
substitution(3, ['Value' = 1]).
proof(3, solution([1]), query, [uses(2, first(1))]).
substitution(4, []).
proof(4, nested(root, [1, node(q), [2]]), rule(1), []).
substitution(5, ['Value' = q, 'First' = 1, 'Third' = [2]]).
proof(5, second_property(q), rule(3), [uses(4, nested(root, [1, node(q), [2]]))]).
substitution(6, ['Value' = q]).
proof(6, solution([q]), query, [uses(5, second_property(q))]).
substitution(7, []).
proof(7, nested(root, [1, node(q), [2]]), rule(1), []).
substitution(8, ['Value' = 2, 'First' = 1, 'Second' = node(q)]).
proof(8, third_first(2), rule(4), [uses(7, nested(root, [1, node(q), [2]]))]).
substitution(9, ['Value' = 2]).
proof(9, solution([2]), query, [uses(8, third_first(2))]).
