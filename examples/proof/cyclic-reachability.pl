% Prolog result format 4
query(1, path(a, _0), ['Where' = _0]).
result(1, complete, 3).
answer(1, ['Where' = b]).
why(1, ['Where' = b], [path(a, b)]).
answer(1, ['Where' = c]).
why(1, ['Where' = c], [path(a, c)]).
answer(1, ['Where' = a]).
why(1, ['Where' = a], [path(a, a)]).

clause(1, edge(a, b), true).
clause(2, edge(b, c), true).
clause(3, edge(c, a), true).
clause(4, path(var('X'), var('Y')), edge(var('X'), var('Y'))).
clause(5, path(var('X'), var('Z')), (path(var('X'), var('Y')), edge(var('Y'), var('Z')))).

step(path(a, b), rule(4), ['X' = a, 'Y' = b], [edge(a, b)]).
step(edge(a, b), fact(1), [], []).
step(path(a, c), rule(5), ['X' = a, 'Z' = c, 'Y' = b], [path(a, b), edge(b, c)]).
step(edge(b, c), fact(2), [], []).
step(path(a, a), rule(5), ['X' = a, 'Z' = a, 'Y' = c], [path(a, c), edge(c, a)]).
step(edge(c, a), fact(3), [], []).
