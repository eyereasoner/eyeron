% Prolog result format 4
query(1, ancestor(a, _0), ['Who' = _0]).
result(1, complete, 3).
answer(1, ['Who' = b]).
why(1, ['Who' = b], [ancestor(a, b)]).
answer(1, ['Who' = c]).
why(1, ['Who' = c], [ancestor(a, c)]).
answer(1, ['Who' = d]).
why(1, ['Who' = d], [ancestor(a, d)]).

clause(1, parent(a, b), true).
clause(2, parent(b, c), true).
clause(3, parent(c, d), true).
clause(4, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(5,
       ancestor(var('X'), var('Z')),
       (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).

step(ancestor(a, b), rule(4), ['X' = a, 'Y' = b], [parent(a, b)]).
step(parent(a, b), fact(1), [], []).
step(ancestor(a, c), rule(5), ['X' = a, 'Z' = c, 'Y' = b], [parent(a, b), ancestor(b, c)]).
step(ancestor(b, c), rule(4), ['X' = b, 'Y' = c], [parent(b, c)]).
step(parent(b, c), fact(2), [], []).
step(ancestor(a, d), rule(5), ['X' = a, 'Z' = d, 'Y' = b], [parent(a, b), ancestor(b, d)]).
step(ancestor(b, d), rule(5), ['X' = b, 'Z' = d, 'Y' = c], [parent(b, c), ancestor(c, d)]).
step(ancestor(c, d), rule(4), ['X' = c, 'Y' = d], [parent(c, d)]).
step(parent(c, d), fact(3), [], []).
