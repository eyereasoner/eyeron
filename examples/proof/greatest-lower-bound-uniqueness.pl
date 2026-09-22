% Prolog result format 3
query(1, result_query(_0, _1, _2, _3), ['A' = _0, 'B' = _1, 'M' = _2, 'N' = _3]).
result(1, complete, 2).
answer(1, ['A' = a, 'B' = b, 'M' = g1, 'N' = g2]).
why(1, ['A' = a, 'B' = b, 'M' = g1, 'N' = g2], 39).
answer(1, ['A' = a, 'B' = b, 'M' = g2, 'N' = g1]).
why(1, ['A' = a, 'B' = b, 'M' = g2, 'N' = g1], 40).
clause(1, in_p(a), true).
clause(2, in_p(b), true).
clause(3, in_p(g1), true).
clause(4, in_p(g2), true).
clause(5, glb_of(g1, a, b), true).
clause(6, glb_of(g2, a, b), true).
clause(7, leq(var('X'), var('X')), in_p(var('X'))).
clause(8, leq(var('X'), var('Z')), (leq(var('X'), var('Y')), leq(var('Y'), var('Z')))).
clause(9, same_term(var('X'), var('Y')), (leq(var('X'), var('Y')), leq(var('Y'), var('X')))).
clause(11, lower_bound_of(var('M'), var('A'), var('B')), glb_of(var('M'), var('A'), var('B'))).
clause(12, leq(var('M'), var('A')), glb_of(var('M'), var('A'), var('B'))).
clause(13, leq(var('M'), var('B')), glb_of(var('M'), var('A'), var('B'))).
clause(14, leq(var('L'), var('M')), (glb_of(var('M'), var('A'), var('B')), lower_bound_of(var('L'), var('A'), var('B')))).
clause(15, same_glb(var('A'), var('B'), var('M'), var('N')), (glb_of(var('M'), var('A'), var('B')), glb_of(var('N'), var('A'), var('B')), same_term(var('M'), var('N')))).
clause(16, result_query(var('A'), var('B'), var('M'), var('N')), (same_glb(var('A'), var('B'), var('M'), var('N')), var('M') \== var('N'))).
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
substitution(6, ['X' = g1]).
proof(6, leq(g1, g1), rule(7), [uses(5, in_p(g1))]).
substitution(7, []).
proof(7, glb_of(g1, a, b), rule(5), []).
substitution(8, []).
proof(8, glb_of(g2, a, b), rule(6), []).
substitution(9, ['M' = g2, 'A' = a, 'B' = b]).
proof(9, leq(g2, a), rule(12), [uses(8, glb_of(g2, a, b))]).
substitution(10, ['M' = g2, 'B' = b, 'A' = a]).
proof(10, leq(g2, b), rule(13), [uses(8, glb_of(g2, a, b))]).
substitution(11, []).
proof(11, in_p(g2), rule(4), []).
substitution(12, ['X' = g1]).
proof(12, leq(g1, g1), rule(7), [uses(5, in_p(g1))]).
substitution(13, ['M' = g1, 'A' = a, 'B' = b]).
proof(13, leq(g1, a), rule(12), [uses(7, glb_of(g1, a, b))]).
substitution(14, ['M' = g1, 'B' = b, 'A' = a]).
proof(14, leq(g1, b), rule(13), [uses(7, glb_of(g1, a, b))]).
substitution(15, ['X' = g2]).
proof(15, leq(g2, g2), rule(7), [uses(11, in_p(g2))]).
substitution(16, ['X' = g2]).
proof(16, leq(g2, g2), rule(7), [uses(11, in_p(g2))]).
substitution(17, ['X' = g1, 'Y' = g1]).
proof(17, same_term(g1, g1), rule(9), [uses(12, leq(g1, g1)), uses(12, leq(g1, g1))]).
substitution(18, []).
proof(18, glb_of(g1, a, b), rule(5), []).
substitution(19, ['X' = g2, 'Y' = g2]).
proof(19, same_term(g2, g2), rule(9), [uses(15, leq(g2, g2)), uses(15, leq(g2, g2))]).
substitution(20, []).
proof(20, glb_of(g2, a, b), rule(6), []).
substitution(21, ['A' = a, 'B' = b, 'M' = g1, 'N' = g1]).
proof(21, same_glb(a, b, g1, g1), rule(15), [uses(1, glb_of(g1, a, b)), uses(3, glb_of(g1, a, b)), uses(17, same_term(g1, g1))]).
substitution(22, ['A' = a, 'B' = b, 'M' = g2, 'N' = g2]).
proof(22, same_glb(a, b, g2, g2), rule(15), [uses(2, glb_of(g2, a, b)), uses(4, glb_of(g2, a, b)), uses(19, same_term(g2, g2))]).
substitution(23, ['M' = g1, 'A' = a, 'B' = b]).
proof(23, lower_bound_of(g1, a, b), rule(11), [uses(18, glb_of(g1, a, b))]).
substitution(24, []).
proof(24, in_p(a), rule(1), []).
substitution(25, []).
proof(25, in_p(b), rule(2), []).
substitution(26, ['M' = g2, 'A' = a, 'B' = b]).
proof(26, lower_bound_of(g2, a, b), rule(11), [uses(20, glb_of(g2, a, b))]).
substitution(27, ['L' = g1, 'M' = g2, 'A' = a, 'B' = b]).
proof(27, leq(g1, g2), rule(14), [uses(2, glb_of(g2, a, b)), uses(23, lower_bound_of(g1, a, b))]).
substitution(28, ['X' = g1, 'Z' = g2, 'Y' = g2]).
proof(28, leq(g1, g2), rule(8), [uses(27, leq(g1, g2)), uses(15, leq(g2, g2))]).
substitution(29, ['X' = a]).
proof(29, leq(a, a), rule(7), [uses(24, in_p(a))]).
substitution(30, ['X' = b]).
proof(30, leq(b, b), rule(7), [uses(25, in_p(b))]).
substitution(31, ['L' = g2, 'M' = g1, 'A' = a, 'B' = b]).
proof(31, leq(g2, g1), rule(14), [uses(1, glb_of(g1, a, b)), uses(26, lower_bound_of(g2, a, b))]).
substitution(32, ['X' = g2, 'Z' = g1, 'Y' = g1]).
proof(32, leq(g2, g1), rule(8), [uses(31, leq(g2, g1)), uses(12, leq(g1, g1))]).
substitution(33, ['X' = g1, 'Y' = g2]).
proof(33, same_term(g1, g2), rule(9), [uses(28, leq(g1, g2)), uses(32, leq(g2, g1))]).
substitution(34, ['X' = g2, 'Y' = g1]).
proof(34, same_term(g2, g1), rule(9), [uses(32, leq(g2, g1)), uses(28, leq(g1, g2))]).
substitution(35, ['A' = a, 'B' = b, 'M' = g1, 'N' = g2]).
proof(35, same_glb(a, b, g1, g2), rule(15), [uses(1, glb_of(g1, a, b)), uses(4, glb_of(g2, a, b)), uses(33, same_term(g1, g2))]).
substitution(36, ['A' = a, 'B' = b, 'M' = g2, 'N' = g1]).
proof(36, same_glb(a, b, g2, g1), rule(15), [uses(2, glb_of(g2, a, b)), uses(3, glb_of(g1, a, b)), uses(34, same_term(g2, g1))]).
substitution(37, ['A' = a, 'B' = b, 'M' = g1, 'N' = g2]).
proof(37, result_query(a, b, g1, g2), rule(16), [uses(35, same_glb(a, b, g1, g2)), builtin(g1 \== g2)]).
substitution(38, ['A' = a, 'B' = b, 'M' = g2, 'N' = g1]).
proof(38, result_query(a, b, g2, g1), rule(16), [uses(36, same_glb(a, b, g2, g1)), builtin(g2 \== g1)]).
substitution(39, ['A' = a, 'B' = b, 'M' = g1, 'N' = g2]).
proof(39, solution([a, b, g1, g2]), query, [uses(37, result_query(a, b, g1, g2))]).
substitution(40, ['A' = a, 'B' = b, 'M' = g2, 'N' = g1]).
proof(40, solution([a, b, g2, g1]), query, [uses(38, result_query(a, b, g2, g1))]).
