# Eyelang result format 2
query(1, [call(distance_km(?v0, ?v1))], [binding("route", ?v0), binding("kilometers", ?v1)]).
result(1, complete, 2).
answer(1, [binding("route", route1), binding("kilometers", 16.0934)]).
why(1, [binding("route", route1), binding("kilometers", 16.0934)], 5).
answer(1, [binding("route", route2), binding("kilometers", 8.0467)]).
why(1, [binding("route", route2), binding("kilometers", 8.0467)], 6).
clause(1, distance_miles(route1, 10), []).
clause(2, distance_miles(route2, 5), []).
clause(3, distance_km(var("route"), var("km")), [call(distance_miles(var("route"), var("miles"))), calculate(var("km"), binary("*", value(var("miles")), value(1.60934)))]).
substitution(1, []).
proof(1, distance_miles(route1, 10), rule(1), []).
substitution(2, []).
proof(2, distance_miles(route2, 5), rule(2), []).
substitution(3, [binding("route", route1), binding("km", 16.0934), binding("miles", 10)]).
proof(3, distance_km(route1, 16.0934), rule(3), [uses(1, distance_miles(route1, 10)), calculated(16.0934, binary("*", value(10), value(1.60934)))]).
substitution(4, [binding("route", route2), binding("km", 8.0467), binding("miles", 5)]).
proof(4, distance_km(route2, 8.0467), rule(3), [uses(2, distance_miles(route2, 5)), calculated(8.0467, binary("*", value(5), value(1.60934)))]).
substitution(5, [binding("route", route1), binding("kilometers", 16.0934)]).
proof(5, solution([route1, 16.0934]), query, [uses(3, distance_km(route1, 16.0934))]).
substitution(6, [binding("route", route2), binding("kilometers", 8.0467)]).
proof(6, solution([route2, 8.0467]), query, [uses(4, distance_km(route2, 8.0467))]).
