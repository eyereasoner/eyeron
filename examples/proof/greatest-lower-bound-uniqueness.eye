# Eyelang result format 2
query(1, [call(result_query(?v0, ?v1, ?v2, ?v3))], [binding("a", ?v0), binding("b", ?v1), binding("m", ?v2), binding("n", ?v3)]).
result(1, complete, 2).
answer(1, [binding("a", a), binding("b", b), binding("m", g1), binding("n", g2)]).
why(1, [binding("a", a), binding("b", b), binding("m", g1), binding("n", g2)], 39).
answer(1, [binding("a", a), binding("b", b), binding("m", g2), binding("n", g1)]).
why(1, [binding("a", a), binding("b", b), binding("m", g2), binding("n", g1)], 40).
clause(1, in_p(a), []).
clause(2, in_p(b), []).
clause(3, in_p(g1), []).
clause(4, in_p(g2), []).
clause(5, glb_of(g1, a, b), []).
clause(6, glb_of(g2, a, b), []).
clause(7, leq(var("x"), var("x")), [call(in_p(var("x")))]).
clause(8, leq(var("x"), var("z")), [call(leq(var("x"), var("y"))), call(leq(var("y"), var("z")))]).
clause(9, same_term(var("x"), var("y")), [call(leq(var("x"), var("y"))), call(leq(var("y"), var("x")))]).
clause(11, lower_bound_of(var("m"), var("a"), var("b")), [call(glb_of(var("m"), var("a"), var("b")))]).
clause(12, leq(var("m"), var("a")), [call(glb_of(var("m"), var("a"), var("b")))]).
clause(13, leq(var("m"), var("b")), [call(glb_of(var("m"), var("a"), var("b")))]).
clause(14, leq(var("l"), var("m")), [call(glb_of(var("m"), var("a"), var("b"))), call(lower_bound_of(var("l"), var("a"), var("b")))]).
clause(15, same_glb(var("a"), var("b"), var("m"), var("n")), [call(glb_of(var("m"), var("a"), var("b"))), call(glb_of(var("n"), var("a"), var("b"))), call(same_term(var("m"), var("n")))]).
clause(16, result_query(var("a"), var("b"), var("m"), var("n")), [call(same_glb(var("a"), var("b"), var("m"), var("n"))), compare("!=", var("m"), var("n"))]).
substitution(1, []).
proof(1, glb_of(g1, a, b), rule(5), []).
substitution(2, []).
proof(2, glb_of(g2, a, b), rule(6), []).
substitution(3, []).
proof(3, glb_of(g1, a, b), rule(5), []).
substitution(4, []).
proof(4, glb_of(g2, a, b), rule(6), []).
substitution(5, []).
proof(5, in_p(g1), rule(3), []).
substitution(6, [binding("x", g1)]).
proof(6, leq(g1, g1), rule(7), [uses(5, in_p(g1))]).
substitution(7, []).
proof(7, glb_of(g1, a, b), rule(5), []).
substitution(8, []).
proof(8, glb_of(g2, a, b), rule(6), []).
substitution(9, [binding("m", g2), binding("a", a), binding("b", b)]).
proof(9, leq(g2, a), rule(12), [uses(8, glb_of(g2, a, b))]).
substitution(10, [binding("m", g2), binding("b", b), binding("a", a)]).
proof(10, leq(g2, b), rule(13), [uses(8, glb_of(g2, a, b))]).
substitution(11, []).
proof(11, in_p(g2), rule(4), []).
substitution(12, [binding("x", g1)]).
proof(12, leq(g1, g1), rule(7), [uses(5, in_p(g1))]).
substitution(13, [binding("m", g1), binding("a", a), binding("b", b)]).
proof(13, leq(g1, a), rule(12), [uses(7, glb_of(g1, a, b))]).
substitution(14, [binding("m", g1), binding("b", b), binding("a", a)]).
proof(14, leq(g1, b), rule(13), [uses(7, glb_of(g1, a, b))]).
substitution(15, [binding("x", g2)]).
proof(15, leq(g2, g2), rule(7), [uses(11, in_p(g2))]).
substitution(16, [binding("x", g2)]).
proof(16, leq(g2, g2), rule(7), [uses(11, in_p(g2))]).
substitution(17, [binding("x", g1), binding("y", g1)]).
proof(17, same_term(g1, g1), rule(9), [uses(12, leq(g1, g1)), uses(12, leq(g1, g1))]).
substitution(18, []).
proof(18, glb_of(g1, a, b), rule(5), []).
substitution(19, [binding("x", g2), binding("y", g2)]).
proof(19, same_term(g2, g2), rule(9), [uses(15, leq(g2, g2)), uses(15, leq(g2, g2))]).
substitution(20, []).
proof(20, glb_of(g2, a, b), rule(6), []).
substitution(21, [binding("a", a), binding("b", b), binding("m", g1), binding("n", g1)]).
proof(21, same_glb(a, b, g1, g1), rule(15), [uses(1, glb_of(g1, a, b)), uses(3, glb_of(g1, a, b)), uses(17, same_term(g1, g1))]).
substitution(22, [binding("a", a), binding("b", b), binding("m", g2), binding("n", g2)]).
proof(22, same_glb(a, b, g2, g2), rule(15), [uses(2, glb_of(g2, a, b)), uses(4, glb_of(g2, a, b)), uses(19, same_term(g2, g2))]).
substitution(23, [binding("m", g1), binding("a", a), binding("b", b)]).
proof(23, lower_bound_of(g1, a, b), rule(11), [uses(18, glb_of(g1, a, b))]).
substitution(24, []).
proof(24, in_p(a), rule(1), []).
substitution(25, []).
proof(25, in_p(b), rule(2), []).
substitution(26, [binding("m", g2), binding("a", a), binding("b", b)]).
proof(26, lower_bound_of(g2, a, b), rule(11), [uses(20, glb_of(g2, a, b))]).
substitution(27, [binding("l", g1), binding("m", g2), binding("a", a), binding("b", b)]).
proof(27, leq(g1, g2), rule(14), [uses(2, glb_of(g2, a, b)), uses(23, lower_bound_of(g1, a, b))]).
substitution(28, [binding("x", g1), binding("z", g2), binding("y", g2)]).
proof(28, leq(g1, g2), rule(8), [uses(27, leq(g1, g2)), uses(15, leq(g2, g2))]).
substitution(29, [binding("x", a)]).
proof(29, leq(a, a), rule(7), [uses(24, in_p(a))]).
substitution(30, [binding("x", b)]).
proof(30, leq(b, b), rule(7), [uses(25, in_p(b))]).
substitution(31, [binding("l", g2), binding("m", g1), binding("a", a), binding("b", b)]).
proof(31, leq(g2, g1), rule(14), [uses(1, glb_of(g1, a, b)), uses(26, lower_bound_of(g2, a, b))]).
substitution(32, [binding("x", g2), binding("z", g1), binding("y", g1)]).
proof(32, leq(g2, g1), rule(8), [uses(31, leq(g2, g1)), uses(12, leq(g1, g1))]).
substitution(33, [binding("x", g1), binding("y", g2)]).
proof(33, same_term(g1, g2), rule(9), [uses(28, leq(g1, g2)), uses(32, leq(g2, g1))]).
substitution(34, [binding("x", g2), binding("y", g1)]).
proof(34, same_term(g2, g1), rule(9), [uses(32, leq(g2, g1)), uses(28, leq(g1, g2))]).
substitution(35, [binding("a", a), binding("b", b), binding("m", g1), binding("n", g2)]).
proof(35, same_glb(a, b, g1, g2), rule(15), [uses(1, glb_of(g1, a, b)), uses(4, glb_of(g2, a, b)), uses(33, same_term(g1, g2))]).
substitution(36, [binding("a", a), binding("b", b), binding("m", g2), binding("n", g1)]).
proof(36, same_glb(a, b, g2, g1), rule(15), [uses(2, glb_of(g2, a, b)), uses(3, glb_of(g1, a, b)), uses(34, same_term(g2, g1))]).
substitution(37, [binding("a", a), binding("b", b), binding("m", g1), binding("n", g2)]).
proof(37, result_query(a, b, g1, g2), rule(16), [uses(35, same_glb(a, b, g1, g2)), compared("!=", g1, g2)]).
substitution(38, [binding("a", a), binding("b", b), binding("m", g2), binding("n", g1)]).
proof(38, result_query(a, b, g2, g1), rule(16), [uses(36, same_glb(a, b, g2, g1)), compared("!=", g2, g1)]).
substitution(39, [binding("a", a), binding("b", b), binding("m", g1), binding("n", g2)]).
proof(39, solution([a, b, g1, g2]), query, [uses(37, result_query(a, b, g1, g2))]).
substitution(40, [binding("a", a), binding("b", b), binding("m", g2), binding("n", g1)]).
proof(40, solution([a, b, g2, g1]), query, [uses(38, result_query(a, b, g2, g1))]).
