child(x, a).
child(x, b).
child(a, c).

clause(1, father(a, x), true).
clause(2, mother(b, x), true).
clause(3, mother(c, a), true).
clause(4, child(var('X'), var('Y')), father(var('Y'), var('X'))).
clause(5, child(var('X'), var('Y')), mother(var('Y'), var('X'))).

step(child(x, a), rule(4), ['X' = x, 'Y' = a], [father(a, x)]).
step(father(a, x), fact(1), [], []).
step(child(x, b), rule(5), ['X' = x, 'Y' = b], [mother(b, x)]).
step(mother(b, x), fact(2), [], []).
step(child(a, c), rule(5), ['X' = a, 'Y' = c], [mother(c, a)]).
step(mother(c, a), fact(3), [], []).
