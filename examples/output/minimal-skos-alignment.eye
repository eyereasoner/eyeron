# Eyelang result format 2
query(1, [call(treated_as(?v0, ?v1))], [binding("x", ?v0), binding("z", ?v1)]).
result(1, complete, 2).
answer(1, [binding("x", vehicleWithPlate), binding("z", car)]).
answer(1, [binding("x", passengerCar), binding("z", car)]).
