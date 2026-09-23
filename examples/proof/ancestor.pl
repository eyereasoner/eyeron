ancestor(alice, bob).
ancestor(alice, carol).
ancestor(alice, dana).

clause(1, parent(alice, bob), true).
clause(2, parent(bob, carol), true).
clause(3, parent(carol, dana), true).
clause(4, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(5,
       ancestor(var('X'), var('Z')),
       (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).

step(ancestor(alice, bob), rule(4), ['X' = alice, 'Y' = bob], [parent(alice, bob)]).
step(parent(alice, bob), fact(1), [], []).
step(ancestor(alice, carol),
     rule(5),
     ['X' = alice, 'Z' = carol, 'Y' = bob],
     [parent(alice, bob), ancestor(bob, carol)]).
step(ancestor(bob, carol), rule(4), ['X' = bob, 'Y' = carol], [parent(bob, carol)]).
step(parent(bob, carol), fact(2), [], []).
step(ancestor(alice, dana),
     rule(5),
     ['X' = alice, 'Z' = dana, 'Y' = bob],
     [parent(alice, bob), ancestor(bob, dana)]).
step(ancestor(bob, dana),
     rule(5),
     ['X' = bob, 'Z' = dana, 'Y' = carol],
     [parent(bob, carol), ancestor(carol, dana)]).
step(ancestor(carol, dana), rule(4), ['X' = carol, 'Y' = dana], [parent(carol, dana)]).
step(parent(carol, dana), fact(3), [], []).
