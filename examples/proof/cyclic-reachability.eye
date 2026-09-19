# Eyelang result format 2
query(1, [call(path(a, ?v0))], [binding("where", ?v0)]).
result(1, complete, 3).
answer(1, [binding("where", b)]).
why(1, [binding("where", b)], 3).
answer(1, [binding("where", c)]).
why(1, [binding("where", c)], 6).
answer(1, [binding("where", a)]).
why(1, [binding("where", a)], 9).
clause(1, edge(a, b), []).
clause(2, edge(b, c), []).
clause(3, edge(c, a), []).
clause(4, path(var("x"), var("y")), [call(edge(var("x"), var("y")))]).
clause(5, path(var("x"), var("z")), [call(path(var("x"), var("y"))), call(edge(var("y"), var("z")))]).
substitution(1, []).
proof(1, edge(a, b), rule(1), []).
substitution(2, [binding("x", a), binding("y", b)]).
proof(2, path(a, b), rule(4), [uses(1, edge(a, b))]).
substitution(3, [binding("where", b)]).
proof(3, solution([b]), query, [uses(2, path(a, b))]).
substitution(4, []).
proof(4, edge(b, c), rule(2), []).
substitution(5, [binding("x", a), binding("z", c), binding("y", b)]).
proof(5, path(a, c), rule(5), [uses(2, path(a, b)), uses(4, edge(b, c))]).
substitution(6, [binding("where", c)]).
proof(6, solution([c]), query, [uses(5, path(a, c))]).
substitution(7, []).
proof(7, edge(c, a), rule(3), []).
substitution(8, [binding("x", a), binding("z", a), binding("y", c)]).
proof(8, path(a, a), rule(5), [uses(5, path(a, c)), uses(7, edge(c, a))]).
substitution(9, [binding("where", a)]).
proof(9, solution([a]), query, [uses(8, path(a, a))]).
