% Prolog example: spec-2-5-assignment.
distance_miles(route1, 10).
distance_miles(route2, 5).
distance_km(Route, Km) :-
    distance_miles(Route, Miles),
    Km is Miles * 1.60934.
?- distance_km(Route, Kilometers).
