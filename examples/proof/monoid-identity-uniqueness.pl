unique_identity(e2).

clause(1, in_g(e), true).
clause(2, candidate_identity(e2), true).
clause(3, in_g(e2), true).
clause(4, mul(var('A'), e, var('A')), in_g(var('A'))).
clause(5, mul(var('E2_'), var('A'), var('A')), (candidate_identity(var('E2_')), in_g(var('A')))).
clause(6,
       unique_identity(var('E2_')),
       (candidate_identity(var('E2_')),
        in_g(var('E2_')),
        in_g(e),
        mul(var('E2_'), e, var('E2_')),
        mul(var('E2_'), e, e))).

step(unique_identity(e2),
     rule(6),
     ['E2_' = e2],
     [candidate_identity(e2), in_g(e2), in_g(e), mul(e2, e, e2), mul(e2, e, e)]).
step(candidate_identity(e2), fact(2), [], []).
step(in_g(e2), fact(3), [], []).
step(in_g(e), fact(1), [], []).
step(mul(e2, e, e2), rule(4), ['A' = e2], [in_g(e2)]).
step(mul(e2, e, e), rule(5), ['E2_' = e2, 'A' = e], [candidate_identity(e2), in_g(e)]).
