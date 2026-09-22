% Prolog example: spec-2-3-filtering.
population(town1, 1000).
population(town2, 2000).
large_town(Town) :-
    population(Town, Population),
    Population > 1500.
?- large_town(Town).
