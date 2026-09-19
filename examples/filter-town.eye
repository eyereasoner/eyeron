# Eyelang example: filter-town.
# Companion to filter-town.srl (adapted from eyeleng's spec-2-3-filtering).
population(town1, 1000). population(town2, 2000).
large_town(?x) if population(?x, ?p), ?p > 1500.
ask large_town(?x).
