path(a, b).
path(a, c).
path(a, a).

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
