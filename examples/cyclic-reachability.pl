% Left recursion and a graph cycle. No visited list or table directive needed.
edge(a, b).
edge(b, c).
edge(c, a).
path(X, Y) :-
    edge(X, Y).
path(X, Z) :-
    path(X, Y),
    edge(Y, Z).
?- path(a, Where).
