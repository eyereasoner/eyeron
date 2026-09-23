test_is(true).

clause(1, to(post, pillar), true).
clause(2, to(pillar, var('What')), to(var('What'), pillar)).
clause(4, result_is(var('What')), to(pillar, var('What'))).
clause(5, test_is(true), result_is(post)).

step(test_is(true), rule(5), [], [result_is(post)]).
step(result_is(post), rule(4), ['What' = post], [to(pillar, post)]).
step(to(pillar, post), rule(2), ['What' = post], [to(post, pillar)]).
step(to(post, pillar), fact(1), [], []).
