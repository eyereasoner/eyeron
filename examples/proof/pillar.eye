# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 5).
clause(1, to(post, pillar), []).
clause(2, to(pillar, var("what")), [call(to(var("what"), pillar))]).
clause(4, result_is(var("what")), [call(to(pillar, var("what")))]).
clause(5, test_is(true), [call(result_is(post))]).
substitution(1, []).
proof(1, to(post, pillar), rule(1), []).
substitution(2, [binding("what", post)]).
proof(2, to(pillar, post), rule(2), [uses(1, to(post, pillar))]).
substitution(3, [binding("what", post)]).
proof(3, result_is(post), rule(4), [uses(2, to(pillar, post))]).
substitution(4, []).
proof(4, test_is(true), rule(5), [uses(3, result_is(post))]).
substitution(5, [binding("r", true)]).
proof(5, solution([true]), query, [uses(4, test_is(true))]).
