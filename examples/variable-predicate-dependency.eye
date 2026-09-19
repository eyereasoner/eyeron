# Eyelang example: variable-predicate-dependency.
# Eyelang has fixed relation names, so the equivalent negative cycle is explicit.
source(a, blocked). derived(?x) if source(?x, blocked), not blocked(?x). blocked(?x) if derived(?x). ask derived(a).
