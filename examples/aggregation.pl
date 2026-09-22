reading(sensor_a, 10).
reading(sensor_b, 15).
reading(sensor_c, 10).

% Collect tagged readings to retain equal values from different sensors.
report(Count, Total) :-
    findall(reading(Sensor, Value), reading(Sensor, Value), Bag1),
    sort(Bag1, Readings),
    length(Readings, Count),
    total(Readings, Total).

total([], 0).

total([reading(_, Value)|Rest], Total) :-
    total(Rest, Tail),
    Total is Value + Tail.

?- report(Count, Total).
