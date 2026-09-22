% Prolog result format 3
query(1, distance_km(_0, _1), ['Route' = _0, 'Kilometers' = _1]).
result(1, complete, 2).
answer(1, ['Route' = route1, 'Kilometers' = 16.0934]).
why(1, ['Route' = route1, 'Kilometers' = 16.0934], 5).
answer(1, ['Route' = route2, 'Kilometers' = 8.0467]).
why(1, ['Route' = route2, 'Kilometers' = 8.0467], 6).
clause(1, distance_miles(route1, 10), true).
clause(2, distance_miles(route2, 5), true).
clause(3, distance_km(var('Route'), var('Km')), (distance_miles(var('Route'), var('Miles')), var('Km') is var('Miles') * 1.60934)).
substitution(1, []).
proof(1, distance_miles(route1, 10), rule(1), []).
substitution(2, []).
proof(2, distance_miles(route2, 5), rule(2), []).
substitution(3, ['Route' = route1, 'Km' = 16.0934, 'Miles' = 10]).
proof(3, distance_km(route1, 16.0934), rule(3), [uses(1, distance_miles(route1, 10)), builtin(16.0934 is 10 * 1.60934)]).
substitution(4, ['Route' = route2, 'Km' = 8.0467, 'Miles' = 5]).
proof(4, distance_km(route2, 8.0467), rule(3), [uses(2, distance_miles(route2, 5)), builtin(8.0467 is 5 * 1.60934)]).
substitution(5, ['Route' = route1, 'Kilometers' = 16.0934]).
proof(5, solution([route1, 16.0934]), query, [uses(3, distance_km(route1, 16.0934))]).
substitution(6, ['Route' = route2, 'Kilometers' = 8.0467]).
proof(6, solution([route2, 8.0467]), query, [uses(4, distance_km(route2, 8.0467))]).
