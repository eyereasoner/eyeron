# Eyelang example: spec-2-4-negation.
place(x1). place(x2). place(x3). population(x1, 1000). population(x2, 2000).
unclassified(?place) if place(?place), not has_population(?place).
has_population(?place) if population(?place, ?amount).
ask unclassified(?place).
