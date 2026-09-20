# Eyelang example: minimal-skos-alignment.
# Companion to minimal-skos-alignment.n3/.srl: a SKOS broadMatch alignment
# that propagates "treated as" down the broader/narrower hierarchy, as
# ordinary relations.
broad_match(vehicleWithPlate, car).
broader(passengerCar, vehicleWithPlate).

treated_as(?a, ?b) if broad_match(?a, ?b).
treated_as(?x, ?z) if broader(?x, ?y), treated_as(?y, ?z).

ask treated_as(?x, ?z).
