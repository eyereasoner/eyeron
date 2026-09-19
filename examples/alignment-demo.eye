# Eyelang example: alignment-demo.
concept(car). concept(tel_car). concept(heavy_vehicle). concept(plate_vehicle). concept(passenger_car).
broad_match(tel_car, car). broad_match(heavy_vehicle, car). broad_match(plate_vehicle, car).
broader(passenger_car, plate_vehicle).
broader(?a, ?b) if broad_match(?a, ?b).
narrower(?b, ?a) if broader(?a, ?b).
broader_transitive(?a, ?b) if broader(?a, ?b).
narrower_transitive(?a, ?b) if narrower(?a, ?b).
broader_transitive(?a, ?c) if broader_transitive(?a, ?b), broader_transitive(?b, ?c).
narrower_transitive(?a, ?c) if narrower_transitive(?a, ?b), narrower_transitive(?b, ?c).
narrower_transitive(?b, ?a) if broader_transitive(?a, ?b).
broader_transitive(?b, ?a) if narrower_transitive(?a, ?b).
narrower_or_equal(?concept, ?concept) if concept(?concept).
narrower_or_equal(?concept, ?broader) if broader_transitive(?concept, ?broader).
rolls_up_to(?x, car) if narrower_or_equal(?x, car).
ask rolls_up_to(?concept, car).
