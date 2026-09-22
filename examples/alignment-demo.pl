% Prolog example: alignment-demo.
concept(car).
concept(tel_car).
concept(heavy_vehicle).
concept(plate_vehicle).
concept(passenger_car).
broad_match(tel_car, car).
broad_match(heavy_vehicle, car).
broad_match(plate_vehicle, car).
broader(passenger_car, plate_vehicle).
broader(A, B) :-
    broad_match(A, B).
narrower(B, A) :-
    broader(A, B).
broader_transitive(A, B) :-
    broader(A, B).
narrower_transitive(A, B) :-
    narrower(A, B).
broader_transitive(A, C) :-
    broader_transitive(A, B),
    broader_transitive(B, C).
narrower_transitive(A, C) :-
    narrower_transitive(A, B),
    narrower_transitive(B, C).
narrower_transitive(B, A) :-
    broader_transitive(A, B).
broader_transitive(B, A) :-
    narrower_transitive(A, B).
narrower_or_equal(Concept, Concept) :-
    concept(Concept).
narrower_or_equal(Concept, Broader) :-
    broader_transitive(Concept, Broader).
rolls_up_to(X, car) :-
    narrower_or_equal(X, car).
?- rolls_up_to(Concept, car).
