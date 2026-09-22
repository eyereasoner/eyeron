% Prolog example: cat-koko.
animal(koko).
cat(generated_cat) :-
    animal(koko).
british_short_hair(generated_bsh) :-
    animal(koko).
test :-
    cat(X),
    british_short_hair(Y),
    X \== Y.
?- test.
