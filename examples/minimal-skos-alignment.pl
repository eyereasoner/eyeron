% Prolog example: minimal-skos-alignment.
% Companion to minimal-skos-alignment.n3/.srl: a SKOS broadMatch alignment
% that propagates "treated as" down the broader/narrower hierarchy, as
% ordinary relations.
broad_match(vehicleWithPlate, car).
broader(passengerCar, vehicleWithPlate).

treated_as(A, B) :-
    broad_match(A, B).
treated_as(X, Z) :-
    broader(X, Y),
    treated_as(Y, Z).

?- treated_as(X, Z).
