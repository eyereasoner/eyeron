% Prolog result format 4
query(1, result_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], [result_is(true)]).

clause(1, composite_task(c), true).
clause(9, all_completed(var('C')), (composite_task(var('C')), \+incomplete(var('C')))).
clause(10, result_is(true), all_completed(c)).

step(result_is(true), rule(10), [], [all_completed(c)]).
step(all_completed(c), rule(9), ['C' = c], [composite_task(c), \+incomplete(c)]).
step(composite_task(c), fact(1), [], []).
step(\+incomplete(c), absent, [], []).
