% Prolog result format 4
query(1, orphan(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = bob]).
why(1, ['X' = bob], [orphan(bob)]).

clause(2, person(bob), true).
clause(5, orphan(var('X')), (person(var('X')), \+has_a_parent(var('X')))).

step(orphan(bob), rule(5), ['X' = bob], [person(bob), \+has_a_parent(bob)]).
step(person(bob), fact(2), [], []).
step(\+has_a_parent(bob), absent, [], []).
