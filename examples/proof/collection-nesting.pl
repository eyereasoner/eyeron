first(1).
second_property(q).
third_first(2).

clause(1, nested(root, [1, node(q), [2]]), true).
clause(2, first(var('First')), nested(root, [var('First'), var('Second'), var('Third')])).
clause(3,
       second_property(var('Value')),
       nested(root, [var('First'), node(var('Value')), var('Third')])).
clause(4,
       third_first(var('Value')),
       nested(root, [var('First'), var('Second'), [var('Value')]])).

step(first(1),
     rule(2),
     ['First' = 1, 'Second' = node(q), 'Third' = [2]],
     [nested(root, [1, node(q), [2]])]).
step(nested(root, [1, node(q), [2]]), fact(1), [], []).
step(second_property(q),
     rule(3),
     ['Value' = q, 'First' = 1, 'Third' = [2]],
     [nested(root, [1, node(q), [2]])]).
step(third_first(2),
     rule(4),
     ['Value' = 2, 'First' = 1, 'Second' = node(q)],
     [nested(root, [1, node(q), [2]])]).
