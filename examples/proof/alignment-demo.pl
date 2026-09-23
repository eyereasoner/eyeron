rolls_up_to(car, car).
rolls_up_to(tel_car, car).
rolls_up_to(heavy_vehicle, car).
rolls_up_to(plate_vehicle, car).
rolls_up_to(passenger_car, car).

clause(1, concept(car), true).
clause(6, broad_match(tel_car, car), true).
clause(7, broad_match(heavy_vehicle, car), true).
clause(8, broad_match(plate_vehicle, car), true).
clause(9, broader(passenger_car, plate_vehicle), true).
clause(10, broader(var('A'), var('B')), broad_match(var('A'), var('B'))).
clause(12, broader_transitive(var('A'), var('B')), broader(var('A'), var('B'))).
clause(14,
       broader_transitive(var('A'), var('C')),
       (broader_transitive(var('A'), var('B')), broader_transitive(var('B'), var('C')))).
clause(18, narrower_or_equal(var('Concept'), var('Concept')), concept(var('Concept'))).
clause(19,
       narrower_or_equal(var('Concept'), var('Broader')),
       broader_transitive(var('Concept'), var('Broader'))).
clause(20, rolls_up_to(var('X'), car), narrower_or_equal(var('X'), car)).

step(rolls_up_to(car, car), rule(20), ['X' = car], [narrower_or_equal(car, car)]).
step(narrower_or_equal(car, car), rule(18), ['Concept' = car], [concept(car)]).
step(concept(car), fact(1), [], []).
step(rolls_up_to(tel_car, car), rule(20), ['X' = tel_car], [narrower_or_equal(tel_car, car)]).
step(narrower_or_equal(tel_car, car),
     rule(19),
     ['Concept' = tel_car, 'Broader' = car],
     [broader_transitive(tel_car, car)]).
step(broader_transitive(tel_car, car),
     rule(12),
     ['A' = tel_car, 'B' = car],
     [broader(tel_car, car)]).
step(broader(tel_car, car), rule(10), ['A' = tel_car, 'B' = car], [broad_match(tel_car, car)]).
step(broad_match(tel_car, car), fact(6), [], []).
step(rolls_up_to(heavy_vehicle, car),
     rule(20),
     ['X' = heavy_vehicle],
     [narrower_or_equal(heavy_vehicle, car)]).
step(narrower_or_equal(heavy_vehicle, car),
     rule(19),
     ['Concept' = heavy_vehicle, 'Broader' = car],
     [broader_transitive(heavy_vehicle, car)]).
step(broader_transitive(heavy_vehicle, car),
     rule(12),
     ['A' = heavy_vehicle, 'B' = car],
     [broader(heavy_vehicle, car)]).
step(broader(heavy_vehicle, car),
     rule(10),
     ['A' = heavy_vehicle, 'B' = car],
     [broad_match(heavy_vehicle, car)]).
step(broad_match(heavy_vehicle, car), fact(7), [], []).
step(rolls_up_to(plate_vehicle, car),
     rule(20),
     ['X' = plate_vehicle],
     [narrower_or_equal(plate_vehicle, car)]).
step(narrower_or_equal(plate_vehicle, car),
     rule(19),
     ['Concept' = plate_vehicle, 'Broader' = car],
     [broader_transitive(plate_vehicle, car)]).
step(broader_transitive(plate_vehicle, car),
     rule(12),
     ['A' = plate_vehicle, 'B' = car],
     [broader(plate_vehicle, car)]).
step(broader(plate_vehicle, car),
     rule(10),
     ['A' = plate_vehicle, 'B' = car],
     [broad_match(plate_vehicle, car)]).
step(broad_match(plate_vehicle, car), fact(8), [], []).
step(rolls_up_to(passenger_car, car),
     rule(20),
     ['X' = passenger_car],
     [narrower_or_equal(passenger_car, car)]).
step(narrower_or_equal(passenger_car, car),
     rule(19),
     ['Concept' = passenger_car, 'Broader' = car],
     [broader_transitive(passenger_car, car)]).
step(broader_transitive(passenger_car, car),
     rule(14),
     ['A' = passenger_car, 'C' = car, 'B' = plate_vehicle],
     [broader_transitive(passenger_car, plate_vehicle), broader_transitive(plate_vehicle, car)]).
step(broader_transitive(passenger_car, plate_vehicle),
     rule(12),
     ['A' = passenger_car, 'B' = plate_vehicle],
     [broader(passenger_car, plate_vehicle)]).
step(broader(passenger_car, plate_vehicle), fact(9), [], []).
