# Eyelang result format 2
query(1, [call(ancestor(iris, ?v0))], [binding("descendant", ?v0)]).
result(1, complete, 2).
answer(1, [binding("descendant", jules)]).
why(1, [binding("descendant", jules)], 3).
answer(1, [binding("descendant", kai)]).
why(1, [binding("descendant", kai)], 7).
clause(1, parent(iris, jules), []).
clause(2, parent(jules, kai), []).
clause(3, ancestor(var("x"), var("y")), [call(parent(var("x"), var("y")))]).
clause(4, ancestor(var("x"), var("z")), [call(parent(var("x"), var("y"))), call(ancestor(var("y"), var("z")))]).
substitution(1, []).
proof(1, parent(iris, jules), rule(1), []).
substitution(2, [binding("x", iris), binding("y", jules)]).
proof(2, ancestor(iris, jules), rule(3), [uses(1, parent(iris, jules))]).
substitution(3, [binding("descendant", jules)]).
proof(3, solution([jules]), query, [uses(2, ancestor(iris, jules))]).
substitution(4, []).
proof(4, parent(jules, kai), rule(2), []).
substitution(5, [binding("x", jules), binding("y", kai)]).
proof(5, ancestor(jules, kai), rule(3), [uses(4, parent(jules, kai))]).
substitution(6, [binding("x", iris), binding("z", kai), binding("y", jules)]).
proof(6, ancestor(iris, kai), rule(4), [uses(1, parent(iris, jules)), uses(5, ancestor(jules, kai))]).
substitution(7, [binding("descendant", kai)]).
proof(7, solution([kai]), query, [uses(6, ancestor(iris, kai))]).
