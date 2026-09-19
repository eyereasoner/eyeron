# Derive a shortest path over the weighted graph used by the source example.
# This reference formulation enumerates simple paths and selects the minimum;
# it has Dijkstra's result, though not its priority-queue complexity.
edge(a, b, 4). edge(a, c, 2). edge(b, c, 1). edge(b, d, 5). edge(c, d, 8).
edge(c, e, 10). edge(d, e, 2). edge(d, f, 6). edge(e, f, 3).
connected(?right, ?left, ?weight) if edge(?left, ?right, ?weight).
connected(?left, ?right, ?weight) if edge(?left, ?right, ?weight).

member(?x, [?x | ?_]).
member(?x, [?_ | ?rest]) if member(?x, ?rest).
route(?goal, ?goal, ?_, [?goal], 0).
route(?from, ?goal, ?visited, [?from | ?path], ?cost) if
    connected(?from, ?next, ?step),
    not member(?next, ?visited),
    route(?next, ?goal, [?next | ?visited], ?path, ?remaining),
    let ?cost = ?step + ?remaining.

best(?from, ?to, ?path, ?cost) if
    collect ?costs = ?candidate where { route(?from, ?to, [?from], ?_, ?candidate) },
    let ?cost = min(?costs),
    route(?from, ?to, [?from], ?path, ?cost).

ask best(a, f, ?path, ?cost).
