# Eyelang result format 2
query(1, [call(child(?v0, ?v1))], [binding("child", ?v0), binding("parent", ?v1)]).
result(1, complete, 3).
answer(1, [binding("child", x), binding("parent", a)]).
why(1, [binding("child", x), binding("parent", a)], 7).
answer(1, [binding("child", x), binding("parent", b)]).
why(1, [binding("child", x), binding("parent", b)], 8).
answer(1, [binding("child", a), binding("parent", c)]).
why(1, [binding("child", a), binding("parent", c)], 9).
clause(1, father(a, x), []).
clause(2, mother(b, x), []).
clause(3, mother(c, a), []).
clause(4, child(var("x"), var("y")), [call(father(var("y"), var("x")))]).
clause(5, child(var("x"), var("y")), [call(mother(var("y"), var("x")))]).
substitution(1, []).
proof(1, father(a, x), rule(1), []).
substitution(2, []).
proof(2, mother(b, x), rule(2), []).
substitution(3, []).
proof(3, mother(c, a), rule(3), []).
substitution(4, [binding("x", x), binding("y", a)]).
proof(4, child(x, a), rule(4), [uses(1, father(a, x))]).
substitution(5, [binding("x", x), binding("y", b)]).
proof(5, child(x, b), rule(5), [uses(2, mother(b, x))]).
substitution(6, [binding("x", a), binding("y", c)]).
proof(6, child(a, c), rule(5), [uses(3, mother(c, a))]).
substitution(7, [binding("child", x), binding("parent", a)]).
proof(7, solution([x, a]), query, [uses(4, child(x, a))]).
substitution(8, [binding("child", x), binding("parent", b)]).
proof(8, solution([x, b]), query, [uses(5, child(x, b))]).
substitution(9, [binding("child", a), binding("parent", c)]).
proof(9, solution([a, c]), query, [uses(6, child(a, c))]).
