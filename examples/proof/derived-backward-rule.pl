has_parent(bob, alice).
child_of(bob, alice).

clause(1, parent_of(alice, bob), true).
clause(2, child_of(var('X'), var('Y')), parent_of(var('Y'), var('X'))).
clause(3, has_parent(var('X'), var('Y')), child_of(var('X'), var('Y'))).

step(has_parent(bob, alice), rule(3), ['X' = bob, 'Y' = alice], [child_of(bob, alice)]).
step(child_of(bob, alice), rule(2), ['X' = bob, 'Y' = alice], [parent_of(alice, bob)]).
step(parent_of(alice, bob), fact(1), [], []).
