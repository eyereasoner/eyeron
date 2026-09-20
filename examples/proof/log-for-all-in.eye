# Eyelang result format 2
query(1, [call(result_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 13).
clause(1, composite_task(c), []).
clause(2, sub_task(c, s1), []).
clause(3, sub_task(c, s2), []).
clause(4, sub_task(c, s3), []).
clause(5, state(s1, completed), []).
clause(6, state(s2, completed), []).
clause(7, state(s3, completed), []).
clause(9, all_completed(var("c")), [call(composite_task(var("c"))), absent(incomplete(var("c")))]).
clause(10, result_is(true), [call(all_completed(c))]).
substitution(1, []).
proof(1, composite_task(c), rule(1), []).
substitution(2, []).
proof(2, sub_task(c, s1), rule(2), []).
substitution(3, []).
proof(3, sub_task(c, s2), rule(3), []).
substitution(4, []).
proof(4, sub_task(c, s3), rule(4), []).
substitution(5, []).
proof(5, state(s1, completed), rule(5), []).
substitution(6, []).
proof(6, solution([]), query, [uses(5, state(s1, completed))]).
substitution(7, []).
proof(7, state(s2, completed), rule(6), []).
substitution(8, []).
proof(8, solution([]), query, [uses(7, state(s2, completed))]).
substitution(9, []).
proof(9, state(s3, completed), rule(7), []).
substitution(10, []).
proof(10, solution([]), query, [uses(9, state(s3, completed))]).
substitution(11, [binding("c", c)]).
proof(11, all_completed(c), rule(9), [uses(1, composite_task(c)), absent(incomplete(c), complete)]).
substitution(12, []).
proof(12, result_is(true), rule(10), [uses(11, all_completed(c))]).
substitution(13, [binding("r", true)]).
proof(13, solution([true]), query, [uses(12, result_is(true))]).
