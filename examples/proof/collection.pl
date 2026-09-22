% Prolog result format 4
query(1, first(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = 1]).
why(1, ['X' = 1], [first(1)]).
query(2, blank_property(_0), ['X' = _0]).
result(2, complete, 1).
answer(2, ['X' = q]).
why(2, ['X' = q], [blank_property(q)]).
query(3, nested_first(_0), ['X' = _0]).
result(3, complete, 1).
answer(3, ['X' = 2]).
why(3, ['X' = 2], [nested_first(2)]).

clause(1, value(root, [1, node(q), [2]]), true).
clause(2, first(var('X')), value(root, [var('X'), var('Middle'), var('Last')])).
clause(3, blank_property(var('X')), value(root, [var('First'), node(var('X')), var('Last')])).
clause(4, nested_first(var('X')), value(root, [var('First'), var('Middle'), [var('X')]])).

step(first(1),
     rule(2),
     ['X' = 1, 'Middle' = node(q), 'Last' = [2]],
     [value(root, [1, node(q), [2]])]).
step(value(root, [1, node(q), [2]]), fact(1), [], []).
step(blank_property(q),
     rule(3),
     ['X' = q, 'First' = 1, 'Last' = [2]],
     [value(root, [1, node(q), [2]])]).
step(nested_first(2),
     rule(4),
     ['X' = 2, 'First' = 1, 'Middle' = node(q)],
     [value(root, [1, node(q), [2]])]).
