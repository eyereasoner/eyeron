% Prolog result format 4
query(1, has_parent(_0, _1), ['X' = _0, 'Y' = _1]).
result(1, complete, 1).
answer(1, ['X' = bob, 'Y' = alice]).
why(1, ['X' = bob, 'Y' = alice], [has_parent(bob, alice)]).
query(2, child_of(_0, _1), ['X' = _0, 'Y' = _1]).
result(2, complete, 1).
answer(2, ['X' = bob, 'Y' = alice]).
why(2, ['X' = bob, 'Y' = alice], [child_of(bob, alice)]).

clause(1, parent_of(alice, bob), true).
clause(2, child_of(var('X'), var('Y')), parent_of(var('Y'), var('X'))).
clause(3, has_parent(var('X'), var('Y')), child_of(var('X'), var('Y'))).

step(has_parent(bob, alice), rule(3), ['X' = bob, 'Y' = alice], [child_of(bob, alice)]).
step(child_of(bob, alice), rule(2), ['X' = bob, 'Y' = alice], [parent_of(alice, bob)]).
step(parent_of(alice, bob), fact(1), [], []).
