% Prolog result format 3
query(1, treated_as(_0, _1), ['X' = _0, 'Z' = _1]).
result(1, complete, 2).
answer(1, ['X' = vehicleWithPlate, 'Z' = car]).
why(1, ['X' = vehicleWithPlate, 'Z' = car], 4).
answer(1, ['X' = passengerCar, 'Z' = car]).
why(1, ['X' = passengerCar, 'Z' = car], 8).
clause(1, broad_match(vehicleWithPlate, car), true).
clause(2, broader(passengerCar, vehicleWithPlate), true).
clause(3, treated_as(var('A'), var('B')), broad_match(var('A'), var('B'))).
clause(4, treated_as(var('X'), var('Z')), (broader(var('X'), var('Y')), treated_as(var('Y'), var('Z')))).
substitution(1, []).
proof(1, broad_match(vehicleWithPlate, car), rule(1), []).
substitution(2, []).
proof(2, broader(passengerCar, vehicleWithPlate), rule(2), []).
substitution(3, ['A' = vehicleWithPlate, 'B' = car]).
proof(3, treated_as(vehicleWithPlate, car), rule(3), [uses(1, broad_match(vehicleWithPlate, car))]).
substitution(4, ['X' = vehicleWithPlate, 'Z' = car]).
proof(4, solution([vehicleWithPlate, car]), query, [uses(3, treated_as(vehicleWithPlate, car))]).
substitution(5, []).
proof(5, broad_match(vehicleWithPlate, car), rule(1), []).
substitution(6, ['A' = vehicleWithPlate, 'B' = car]).
proof(6, treated_as(vehicleWithPlate, car), rule(3), [uses(5, broad_match(vehicleWithPlate, car))]).
substitution(7, ['X' = passengerCar, 'Z' = car, 'Y' = vehicleWithPlate]).
proof(7, treated_as(passengerCar, car), rule(4), [uses(2, broader(passengerCar, vehicleWithPlate)), uses(6, treated_as(vehicleWithPlate, car))]).
substitution(8, ['X' = passengerCar, 'Z' = car]).
proof(8, solution([passengerCar, car]), query, [uses(7, treated_as(passengerCar, car))]).
