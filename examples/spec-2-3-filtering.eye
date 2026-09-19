# Eyelang example: spec-2-3-filtering.
population(town1, 1000). population(town2, 2000).
large_town(?town) if population(?town, ?population), ?population > 1500.
ask large_town(?town).
