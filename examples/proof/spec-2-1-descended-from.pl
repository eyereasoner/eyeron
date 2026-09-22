% Prolog result format 4
query(1, descended(_0, _1), ['Person' = _0, 'Ancestor' = _1]).
result(1, complete, 3).
answer(1, ['Person' = x, 'Ancestor' = a]).
why(1, ['Person' = x, 'Ancestor' = a], [descended(x, a)]).
answer(1, ['Person' = x, 'Ancestor' = b]).
why(1, ['Person' = x, 'Ancestor' = b], [descended(x, b)]).
answer(1, ['Person' = a, 'Ancestor' = c]).
why(1, ['Person' = a, 'Ancestor' = c], [descended(a, c)]).

clause(1, father(a, x), true).
clause(2, mother(b, x), true).
clause(3, mother(c, a), true).
clause(4, child(var('X'), var('Y')), father(var('Y'), var('X'))).
clause(5, child(var('X'), var('Y')), mother(var('Y'), var('X'))).
clause(6, descended(var('X'), var('Y')), child(var('X'), var('Y'))).

step(descended(x, a), rule(6), ['X' = x, 'Y' = a], [child(x, a)]).
step(child(x, a), rule(4), ['X' = x, 'Y' = a], [father(a, x)]).
step(father(a, x), fact(1), [], []).
step(descended(x, b), rule(6), ['X' = x, 'Y' = b], [child(x, b)]).
step(child(x, b), rule(5), ['X' = x, 'Y' = b], [mother(b, x)]).
step(mother(b, x), fact(2), [], []).
step(descended(a, c), rule(6), ['X' = a, 'Y' = c], [child(a, c)]).
step(child(a, c), rule(5), ['X' = a, 'Y' = c], [mother(c, a)]).
step(mother(c, a), fact(3), [], []).
