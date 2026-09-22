% Prolog result format 4
query(1, ancestor(alice, _0), ['Who' = _0]).
result(1, complete, 2).
answer(1, ['Who' = bob]).
why(1, ['Who' = bob], [ancestor(alice, bob)]).
answer(1, ['Who' = carol]).
why(1, ['Who' = carol], [ancestor(alice, carol)]).

clause(1, parent(alice, bob), true).
clause(2, parent(bob, carol), true).
clause(3, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(4,
       ancestor(var('X'), var('Z')),
       (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).

step(ancestor(alice, bob), rule(3), ['X' = alice, 'Y' = bob], [parent(alice, bob)]).
step(parent(alice, bob), fact(1), [], []).
step(ancestor(alice, carol),
     rule(4),
     ['X' = alice, 'Z' = carol, 'Y' = bob],
     [parent(alice, bob), ancestor(bob, carol)]).
step(ancestor(bob, carol), rule(3), ['X' = bob, 'Y' = carol], [parent(bob, carol)]).
step(parent(bob, carol), fact(2), [], []).
