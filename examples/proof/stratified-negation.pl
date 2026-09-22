% Prolog result format 4
query(1, eligible(_0), ['Person' = _0]).
result(1, complete, 1).
answer(1, ['Person' = bob]).
why(1, ['Person' = bob], [eligible(bob)]).

clause(2, person(bob), true).
clause(8, eligible(var('X')), (person(var('X')), \+blocked(var('X')))).

step(eligible(bob), rule(8), ['X' = bob], [person(bob), \+blocked(bob)]).
step(person(bob), fact(2), [], []).
step(\+blocked(bob), absent, [], []).
