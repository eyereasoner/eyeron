grandparent_of(alice, carol).
has_parent(bob, alice).
has_parent(carol, bob).

clause(1, parent_of(alice, bob), true).
clause(2, parent_of(bob, carol), true).
clause(3,
       grandparent_of(var('X'), var('Z')),
       (parent_of(var('X'), var('Y')), parent_of(var('Y'), var('Z')))).
clause(4, has_parent(var('Child'), var('Parent')), parent_of(var('Parent'), var('Child'))).

step(grandparent_of(alice, carol),
     rule(3),
     ['X' = alice, 'Z' = carol, 'Y' = bob],
     [parent_of(alice, bob), parent_of(bob, carol)]).
step(parent_of(alice, bob), fact(1), [], []).
step(parent_of(bob, carol), fact(2), [], []).
step(has_parent(bob, alice),
     rule(4),
     ['Child' = bob, 'Parent' = alice],
     [parent_of(alice, bob)]).
step(has_parent(carol, bob),
     rule(4),
     ['Child' = carol, 'Parent' = bob],
     [parent_of(bob, carol)]).
