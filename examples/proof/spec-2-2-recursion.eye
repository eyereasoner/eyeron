# Eyelang result format 2
query(1, [call(descended(?v0, ?v1))], [binding("person", ?v0), binding("ancestor", ?v1)]).
result(1, complete, 4).
answer(1, [binding("person", x), binding("ancestor", a)]).
why(1, [binding("person", x), binding("ancestor", a)], 10).
answer(1, [binding("person", x), binding("ancestor", b)]).
why(1, [binding("person", x), binding("ancestor", b)], 11).
answer(1, [binding("person", a), binding("ancestor", c)]).
why(1, [binding("person", a), binding("ancestor", c)], 12).
answer(1, [binding("person", x), binding("ancestor", c)]).
why(1, [binding("person", x), binding("ancestor", c)], 17).
clause(1, father(a, x), []).
clause(2, mother(b, x), []).
clause(3, mother(c, a), []).
clause(4, child(var("x"), var("y")), [call(father(var("y"), var("x")))]).
clause(5, child(var("x"), var("y")), [call(mother(var("y"), var("x")))]).
clause(6, descended(var("x"), var("y")), [call(child(var("x"), var("y")))]).
clause(7, descended(var("x"), var("y")), [call(child(var("x"), var("z"))), call(descended(var("z"), var("y")))]).
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
substitution(7, [binding("x", x), binding("y", a)]).
proof(7, descended(x, a), rule(6), [uses(4, child(x, a))]).
substitution(8, [binding("x", x), binding("y", b)]).
proof(8, descended(x, b), rule(6), [uses(5, child(x, b))]).
substitution(9, [binding("x", a), binding("y", c)]).
proof(9, descended(a, c), rule(6), [uses(6, child(a, c))]).
substitution(10, [binding("person", x), binding("ancestor", a)]).
proof(10, solution([x, a]), query, [uses(7, descended(x, a))]).
substitution(11, [binding("person", x), binding("ancestor", b)]).
proof(11, solution([x, b]), query, [uses(8, descended(x, b))]).
substitution(12, [binding("person", a), binding("ancestor", c)]).
proof(12, solution([a, c]), query, [uses(9, descended(a, c))]).
substitution(13, []).
proof(13, mother(c, a), rule(3), []).
substitution(14, [binding("x", a), binding("y", c)]).
proof(14, child(a, c), rule(5), [uses(13, mother(c, a))]).
substitution(15, [binding("x", a), binding("y", c)]).
proof(15, descended(a, c), rule(6), [uses(14, child(a, c))]).
substitution(16, [binding("x", x), binding("y", c), binding("z", a)]).
proof(16, descended(x, c), rule(7), [uses(4, child(x, a)), uses(15, descended(a, c))]).
substitution(17, [binding("person", x), binding("ancestor", c)]).
proof(17, solution([x, c]), query, [uses(16, descended(x, c))]).
