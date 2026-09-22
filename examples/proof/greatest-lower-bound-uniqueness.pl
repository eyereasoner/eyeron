% Prolog result format 4
query(1, result_query(_0, _1, _2, _3), ['A' = _0, 'B' = _1, 'M' = _2, 'N' = _3]).
result(1, complete, 2).
answer(1, ['A' = a, 'B' = b, 'M' = g1, 'N' = g2]).
why(1, ['A' = a, 'B' = b, 'M' = g1, 'N' = g2], [result_query(a, b, g1, g2)]).
answer(1, ['A' = a, 'B' = b, 'M' = g2, 'N' = g1]).
why(1, ['A' = a, 'B' = b, 'M' = g2, 'N' = g1], [result_query(a, b, g2, g1)]).

clause(3, in_p(g1), true).
clause(4, in_p(g2), true).
clause(5, glb_of(g1, a, b), true).
clause(6, glb_of(g2, a, b), true).
clause(7, leq(var('X'), var('X')), in_p(var('X'))).
clause(8, leq(var('X'), var('Z')), (leq(var('X'), var('Y')), leq(var('Y'), var('Z')))).
clause(9, same_term(var('X'), var('Y')), (leq(var('X'), var('Y')), leq(var('Y'), var('X')))).
clause(15,
       same_glb(var('A'), var('B'), var('M'), var('N')),
       (glb_of(var('M'), var('A'), var('B')),
        glb_of(var('N'), var('A'), var('B')),
        same_term(var('M'), var('N')))).
clause(16,
       result_query(var('A'), var('B'), var('M'), var('N')),
       (same_glb(var('A'), var('B'), var('M'), var('N')), var('M') \== var('N'))).

step(result_query(a, b, g1, g2),
     rule(16),
     ['A' = a, 'B' = b, 'M' = g1, 'N' = g2],
     [same_glb(a, b, g1, g2), g1 \== g2]).
step(same_glb(a, b, g1, g2),
     rule(15),
     ['A' = a, 'B' = b, 'M' = g1, 'N' = g2],
     [glb_of(g1, a, b), glb_of(g2, a, b), same_term(g1, g2)]).
step(glb_of(g1, a, b), fact(5), [], []).
step(glb_of(g2, a, b), fact(6), [], []).
step(same_term(g1, g2), rule(9), ['X' = g1, 'Y' = g2], [leq(g1, g2), leq(g2, g1)]).
step(leq(g1, g2), rule(8), ['X' = g1, 'Z' = g2, 'Y' = g2], [leq(g1, g2), leq(g2, g2)]).
step(leq(g2, g2), rule(7), ['X' = g2], [in_p(g2)]).
step(in_p(g2), fact(4), [], []).
step(leq(g2, g1), rule(8), ['X' = g2, 'Z' = g1, 'Y' = g1], [leq(g2, g1), leq(g1, g1)]).
step(leq(g1, g1), rule(7), ['X' = g1], [in_p(g1)]).
step(in_p(g1), fact(3), [], []).
step(g1 \== g2, builtin, [], []).
step(result_query(a, b, g2, g1),
     rule(16),
     ['A' = a, 'B' = b, 'M' = g2, 'N' = g1],
     [same_glb(a, b, g2, g1), g2 \== g1]).
step(same_glb(a, b, g2, g1),
     rule(15),
     ['A' = a, 'B' = b, 'M' = g2, 'N' = g1],
     [glb_of(g2, a, b), glb_of(g1, a, b), same_term(g2, g1)]).
step(same_term(g2, g1), rule(9), ['X' = g2, 'Y' = g1], [leq(g2, g1), leq(g1, g2)]).
step(g2 \== g1, builtin, [], []).
