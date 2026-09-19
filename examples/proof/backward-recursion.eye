# Eyelang result format 2
query(1, [call(ancestor(a, ?v0))], [binding("who", ?v0)]).
result(1, complete, 3).
answer(1, [binding("who", b)]).
why(1, [binding("who", b)], 3).
answer(1, [binding("who", c)]).
why(1, [binding("who", c)], 7).
answer(1, [binding("who", d)]).
why(1, [binding("who", d)], 12).
clause(1, parent(a, b), []).
clause(2, parent(b, c), []).
clause(3, parent(c, d), []).
clause(4, ancestor(var("x"), var("y")), [call(parent(var("x"), var("y")))]).
clause(5, ancestor(var("x"), var("z")), [call(parent(var("x"), var("y"))), call(ancestor(var("y"), var("z")))]).
substitution(1, []).
proof(1, parent(a, b), rule(1), []).
substitution(2, [binding("x", a), binding("y", b)]).
proof(2, ancestor(a, b), rule(4), [uses(1, parent(a, b))]).
substitution(3, [binding("who", b)]).
proof(3, solution([b]), query, [uses(2, ancestor(a, b))]).
substitution(4, []).
proof(4, parent(b, c), rule(2), []).
substitution(5, [binding("x", b), binding("y", c)]).
proof(5, ancestor(b, c), rule(4), [uses(4, parent(b, c))]).
substitution(6, [binding("x", a), binding("z", c), binding("y", b)]).
proof(6, ancestor(a, c), rule(5), [uses(1, parent(a, b)), uses(5, ancestor(b, c))]).
substitution(7, [binding("who", c)]).
proof(7, solution([c]), query, [uses(6, ancestor(a, c))]).
substitution(8, []).
proof(8, parent(c, d), rule(3), []).
substitution(9, [binding("x", c), binding("y", d)]).
proof(9, ancestor(c, d), rule(4), [uses(8, parent(c, d))]).
substitution(10, [binding("x", b), binding("z", d), binding("y", c)]).
proof(10, ancestor(b, d), rule(5), [uses(4, parent(b, c)), uses(9, ancestor(c, d))]).
substitution(11, [binding("x", a), binding("z", d), binding("y", b)]).
proof(11, ancestor(a, d), rule(5), [uses(1, parent(a, b)), uses(10, ancestor(b, d))]).
substitution(12, [binding("who", d)]).
proof(12, solution([d]), query, [uses(11, ancestor(a, d))]).
