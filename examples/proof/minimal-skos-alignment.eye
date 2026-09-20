# Eyelang result format 2
query(1, [call(treated_as(?v0, ?v1))], [binding("x", ?v0), binding("z", ?v1)]).
result(1, complete, 2).
answer(1, [binding("x", vehicleWithPlate), binding("z", car)]).
why(1, [binding("x", vehicleWithPlate), binding("z", car)], 4).
answer(1, [binding("x", passengerCar), binding("z", car)]).
why(1, [binding("x", passengerCar), binding("z", car)], 8).
clause(1, broad_match(vehicleWithPlate, car), []).
clause(2, broader(passengerCar, vehicleWithPlate), []).
clause(3, treated_as(var("a"), var("b")), [call(broad_match(var("a"), var("b")))]).
clause(4, treated_as(var("x"), var("z")), [call(broader(var("x"), var("y"))), call(treated_as(var("y"), var("z")))]).
substitution(1, []).
proof(1, broad_match(vehicleWithPlate, car), rule(1), []).
substitution(2, []).
proof(2, broader(passengerCar, vehicleWithPlate), rule(2), []).
substitution(3, [binding("a", vehicleWithPlate), binding("b", car)]).
proof(3, treated_as(vehicleWithPlate, car), rule(3), [uses(1, broad_match(vehicleWithPlate, car))]).
substitution(4, [binding("x", vehicleWithPlate), binding("z", car)]).
proof(4, solution([vehicleWithPlate, car]), query, [uses(3, treated_as(vehicleWithPlate, car))]).
substitution(5, []).
proof(5, broad_match(vehicleWithPlate, car), rule(1), []).
substitution(6, [binding("a", vehicleWithPlate), binding("b", car)]).
proof(6, treated_as(vehicleWithPlate, car), rule(3), [uses(5, broad_match(vehicleWithPlate, car))]).
substitution(7, [binding("x", passengerCar), binding("z", car), binding("y", vehicleWithPlate)]).
proof(7, treated_as(passengerCar, car), rule(4), [uses(2, broader(passengerCar, vehicleWithPlate)), uses(6, treated_as(vehicleWithPlate, car))]).
substitution(8, [binding("x", passengerCar), binding("z", car)]).
proof(8, solution([passengerCar, car]), query, [uses(7, treated_as(passengerCar, car))]).
