result_query(a, b, g1, g2).
result_query(a, b, g2, g1).

clause(5, glb_of(g1, a, b), true).
clause(6, glb_of(g2, a, b), true).
clause(9, same_term(var('X'), var('Y')), (leq(var('X'), var('Y')), leq(var('Y'), var('X')))).
clause(11, lower_bound_of(var('M'), var('A'), var('B')), glb_of(var('M'), var('A'), var('B'))).
clause(14,
       leq(var('L'), var('M')),
       (glb_of(var('M'), var('A'), var('B')), lower_bound_of(var('L'), var('A'), var('B')))).
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
step(leq(g1, g2),
     rule(14),
     ['L' = g1, 'M' = g2, 'A' = a, 'B' = b],
     [glb_of(g2, a, b), lower_bound_of(g1, a, b)]).
step(lower_bound_of(g1, a, b), rule(11), ['M' = g1, 'A' = a, 'B' = b], [glb_of(g1, a, b)]).
step(leq(g2, g1),
     rule(14),
     ['L' = g2, 'M' = g1, 'A' = a, 'B' = b],
     [glb_of(g1, a, b), lower_bound_of(g2, a, b)]).
step(lower_bound_of(g2, a, b), rule(11), ['M' = g2, 'A' = a, 'B' = b], [glb_of(g2, a, b)]).
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
