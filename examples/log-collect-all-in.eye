# Eyelang example: log-collect-all-in.
# Companion to log-collect-all-in.n3/.srl: the same three collection
# shapes (plain, each item wrapped in its own list, and filtered) via
# Eyelang's `collect`. Eyelang has no string ordering operator (only
# numeric comparisons), so the filter uses `!=` "Louie" instead of N3's
# `string:lessThan "Louie"` -- equivalent for this data, since every
# other value already sorts before "Louie". `collect` also always
# canonically sorts its result (alphabetical here), unlike N3's
# collectAllIn, which preserves original derivation order.
param("Huey"). param("Dewey"). param("Louie").

result1(?all) if collect ?all = ?p where { param(?p) }.
result2(?nested) if collect ?nested = [?p] where { param(?p) }.
result3(?filtered) if collect ?filtered = ?p where { param(?p), ?p != "Louie" }.

ask result1(?all).
ask result2(?nested).
ask result3(?filtered).
