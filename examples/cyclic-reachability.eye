# Left recursion and a graph cycle. No visited list or table directive needed.
edge(a, b).
edge(b, c).
edge(c, a).
path(?x, ?y) if edge(?x, ?y).
path(?x, ?z) if path(?x, ?y), edge(?y, ?z).
ask path(a, ?where).
