# Eyelang result format 2
query(1, [call(distance_km(?v0, ?v1))], [binding("route", ?v0), binding("kilometers", ?v1)]).
result(1, complete, 2).
answer(1, [binding("route", route1), binding("kilometers", 16.0934)]).
answer(1, [binding("route", route2), binding("kilometers", 8.0467)]).
