% Prolog result format 4
query(1, ancestor(_0, _1), ['X' = _0, 'Y' = _1]).
result(1, complete, 4).
answer(1, ['X' = alice, 'Y' = bob]).
why(1, ['X' = alice, 'Y' = bob], [ancestor(alice, bob)]).
answer(1, ['X' = bob, 'Y' = carol]).
why(1, ['X' = bob, 'Y' = carol], [ancestor(bob, carol)]).
answer(1, ['X' = dora, 'Y' = emma]).
why(1, ['X' = dora, 'Y' = emma], [ancestor(dora, emma)]).
answer(1, ['X' = alice, 'Y' = carol]).
why(1, ['X' = alice, 'Y' = carol], [ancestor(alice, carol)]).

clause(1, parent(alice, bob), true).
clause(2, parent(bob, carol), true).
clause(3, parent(dora, emma), true).
clause(4, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(5,
       ancestor(var('X'), var('Z')),
       (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).

step(ancestor(alice, bob), rule(4), ['X' = alice, 'Y' = bob], [parent(alice, bob)]).
step(parent(alice, bob), fact(1), [], []).
step(ancestor(bob, carol), rule(4), ['X' = bob, 'Y' = carol], [parent(bob, carol)]).
step(parent(bob, carol), fact(2), [], []).
step(ancestor(dora, emma), rule(4), ['X' = dora, 'Y' = emma], [parent(dora, emma)]).
step(parent(dora, emma), fact(3), [], []).
step(ancestor(alice, carol),
     rule(5),
     ['X' = alice, 'Z' = carol, 'Y' = bob],
     [parent(alice, bob), ancestor(bob, carol)]).
