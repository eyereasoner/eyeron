# Eyelang example: spec-2-5-assignment.
distance_miles(route1, 10). distance_miles(route2, 5).
distance_km(?route, ?km) if distance_miles(?route, ?miles), let ?km = ?miles * 1.60934.
ask distance_km(?route, ?kilometers).
