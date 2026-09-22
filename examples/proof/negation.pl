% Prolog result format 4
query(1, eligible(_0), ['Person' = _0]).
result(1, complete, 1).
answer(1, ['Person' = alice]).
why(1, ['Person' = alice], [eligible(alice)]).

clause(1, person(alice), true).
clause(4, eligible(var('X')), (person(var('X')), \+blocked(var('X')))).

step(eligible(alice), rule(4), ['X' = alice], [person(alice), \+blocked(alice)]).
step(person(alice), fact(1), [], []).
step(\+blocked(alice), absent, [], []).
