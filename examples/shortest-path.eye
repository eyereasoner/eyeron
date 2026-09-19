# Enumerate simple directed paths, then select the minimum cost.
# This preserves the problem, not Dijkstra's algorithm or its complexity.
edge(a, b, 2).
edge(a, c, 5).
edge(b, c, 1).
edge(b, d, 7).
edge(c, d, 2).
edge(c, a, 1).
member(?x, [?x | ?_]).
member(?x, [?_ | ?rest]) if member(?x, ?rest).
route(?goal, ?goal, ?_, [?goal], 0).
route(?from, ?goal, ?visited, [?from | ?path], ?cost) if
    edge(?from, ?next, ?step),
    not member(?next, ?visited),
    route(?next, ?goal, [?next | ?visited], ?path, ?remaining),
    let ?cost = ?step + ?remaining.
best(?from, ?to, ?path, ?cost) if
    collect ?costs = ?candidate where { route(?from, ?to, [?from], ?_, ?candidate) },
    let ?cost = min(?costs),
    route(?from, ?to, [?from], ?path, ?cost).
ask best(a, d, ?path, ?cost).
