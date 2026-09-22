% Prolog result format 4
query(1, distance_km(_0, _1), ['Route' = _0, 'Kilometers' = _1]).
result(1, complete, 2).
answer(1, ['Route' = route1, 'Kilometers' = 16.0934]).
why(1, ['Route' = route1, 'Kilometers' = 16.0934], [distance_km(route1, 16.0934)]).
answer(1, ['Route' = route2, 'Kilometers' = 8.0467]).
why(1, ['Route' = route2, 'Kilometers' = 8.0467], [distance_km(route2, 8.0467)]).

clause(1, distance_miles(route1, 10), true).
clause(2, distance_miles(route2, 5), true).
clause(3,
       distance_km(var('Route'), var('Km')),
       (distance_miles(var('Route'), var('Miles')), var('Km') is var('Miles') * 1.60934)).

step(distance_km(route1, 16.0934),
     rule(3),
     ['Route' = route1, 'Km' = 16.0934, 'Miles' = 10],
     [distance_miles(route1, 10), 16.0934 is 10 * 1.60934]).
step(distance_miles(route1, 10), fact(1), [], []).
step(16.0934 is 10 * 1.60934, builtin, [], []).
step(distance_km(route2, 8.0467),
     rule(3),
     ['Route' = route2, 'Km' = 8.0467, 'Miles' = 5],
     [distance_miles(route2, 5), 8.0467 is 5 * 1.60934]).
step(distance_miles(route2, 5), fact(2), [], []).
step(8.0467 is 5 * 1.60934, builtin, [], []).
