# Eyelang result format 2
query(1, [call(first(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", 1)]).
why(1, [binding("x", 1)], 3).
query(2, [call(blank_property(?v0))], [binding("x", ?v0)]).
result(2, complete, 1).
answer(2, [binding("x", q)]).
why(2, [binding("x", q)], 6).
query(3, [call(nested_first(?v0))], [binding("x", ?v0)]).
result(3, complete, 1).
answer(3, [binding("x", 2)]).
why(3, [binding("x", 2)], 9).
clause(1, value(root, [1, node(q), [2]]), []).
clause(2, first(var("x")), [call(value(root, [var("x"), var("middle"), var("last")]))]).
clause(3, blank_property(var("x")), [call(value(root, [var("first"), node(var("x")), var("last")]))]).
clause(4, nested_first(var("x")), [call(value(root, [var("first"), var("middle"), [var("x")]]))]).
substitution(1, []).
proof(1, value(root, [1, node(q), [2]]), rule(1), []).
substitution(2, [binding("x", 1), binding("middle", node(q)), binding("last", [2])]).
proof(2, first(1), rule(2), [uses(1, value(root, [1, node(q), [2]]))]).
substitution(3, [binding("x", 1)]).
proof(3, solution([1]), query, [uses(2, first(1))]).
substitution(4, []).
proof(4, value(root, [1, node(q), [2]]), rule(1), []).
substitution(5, [binding("x", q), binding("first", 1), binding("last", [2])]).
proof(5, blank_property(q), rule(3), [uses(4, value(root, [1, node(q), [2]]))]).
substitution(6, [binding("x", q)]).
proof(6, solution([q]), query, [uses(5, blank_property(q))]).
substitution(7, []).
proof(7, value(root, [1, node(q), [2]]), rule(1), []).
substitution(8, [binding("x", 2), binding("first", 1), binding("middle", node(q))]).
proof(8, nested_first(2), rule(4), [uses(7, value(root, [1, node(q), [2]]))]).
substitution(9, [binding("x", 2)]).
proof(9, solution([2]), query, [uses(8, nested_first(2))]).
