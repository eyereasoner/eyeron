# Eyelang result format 2
query(1, [call(first(?v0))], [binding("value", ?v0)]).
result(1, complete, 1).
answer(1, [binding("value", 1)]).
why(1, [binding("value", 1)], 3).
query(2, [call(second_property(?v0))], [binding("value", ?v0)]).
result(2, complete, 1).
answer(2, [binding("value", q)]).
why(2, [binding("value", q)], 6).
query(3, [call(third_first(?v0))], [binding("value", ?v0)]).
result(3, complete, 1).
answer(3, [binding("value", 2)]).
why(3, [binding("value", 2)], 9).
clause(1, nested(root, [1, node(q), [2]]), []).
clause(2, first(var("first")), [call(nested(root, [var("first"), var("second"), var("third")]))]).
clause(3, second_property(var("value")), [call(nested(root, [var("first"), node(var("value")), var("third")]))]).
clause(4, third_first(var("value")), [call(nested(root, [var("first"), var("second"), [var("value")]]))]).
substitution(1, []).
proof(1, nested(root, [1, node(q), [2]]), rule(1), []).
substitution(2, [binding("first", 1), binding("second", node(q)), binding("third", [2])]).
proof(2, first(1), rule(2), [uses(1, nested(root, [1, node(q), [2]]))]).
substitution(3, [binding("value", 1)]).
proof(3, solution([1]), query, [uses(2, first(1))]).
substitution(4, []).
proof(4, nested(root, [1, node(q), [2]]), rule(1), []).
substitution(5, [binding("value", q), binding("first", 1), binding("third", [2])]).
proof(5, second_property(q), rule(3), [uses(4, nested(root, [1, node(q), [2]]))]).
substitution(6, [binding("value", q)]).
proof(6, solution([q]), query, [uses(5, second_property(q))]).
substitution(7, []).
proof(7, nested(root, [1, node(q), [2]]), rule(1), []).
substitution(8, [binding("value", 2), binding("first", 1), binding("second", node(q))]).
proof(8, third_first(2), rule(4), [uses(7, nested(root, [1, node(q), [2]]))]).
substitution(9, [binding("value", 2)]).
proof(9, solution([2]), query, [uses(8, third_first(2))]).
