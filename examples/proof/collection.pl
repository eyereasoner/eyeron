first(1).
blank_property(q).
nested_first(2).

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
