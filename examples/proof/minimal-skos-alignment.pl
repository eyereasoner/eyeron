% Prolog result format 4
query(1, treated_as(_0, _1), ['X' = _0, 'Z' = _1]).
result(1, complete, 2).
answer(1, ['X' = vehicleWithPlate, 'Z' = car]).
why(1, ['X' = vehicleWithPlate, 'Z' = car], [treated_as(vehicleWithPlate, car)]).
answer(1, ['X' = passengerCar, 'Z' = car]).
why(1, ['X' = passengerCar, 'Z' = car], [treated_as(passengerCar, car)]).

clause(1, broad_match(vehicleWithPlate, car), true).
clause(2, broader(passengerCar, vehicleWithPlate), true).
clause(3, treated_as(var('A'), var('B')), broad_match(var('A'), var('B'))).
clause(4,
       treated_as(var('X'), var('Z')),
       (broader(var('X'), var('Y')), treated_as(var('Y'), var('Z')))).

step(treated_as(vehicleWithPlate, car),
     rule(3),
     ['A' = vehicleWithPlate, 'B' = car],
     [broad_match(vehicleWithPlate, car)]).
step(broad_match(vehicleWithPlate, car), fact(1), [], []).
step(treated_as(passengerCar, car),
     rule(4),
     ['X' = passengerCar, 'Z' = car, 'Y' = vehicleWithPlate],
     [broader(passengerCar, vehicleWithPlate), treated_as(vehicleWithPlate, car)]).
step(broader(passengerCar, vehicleWithPlate), fact(2), [], []).
