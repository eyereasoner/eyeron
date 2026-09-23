test.

clause(1, animal(koko), true).
clause(2, cat(generated_cat), animal(koko)).
clause(3, british_short_hair(generated_bsh), animal(koko)).
clause(4, test, (cat(var('X')), british_short_hair(var('Y')), var('X') \== var('Y'))).

step(test,
     rule(4),
     ['X' = generated_cat, 'Y' = generated_bsh],
     [cat(generated_cat), british_short_hair(generated_bsh), generated_cat \== generated_bsh]).
step(cat(generated_cat), rule(2), [], [animal(koko)]).
step(animal(koko), fact(1), [], []).
step(british_short_hair(generated_bsh), rule(3), [], [animal(koko)]).
step(generated_cat \== generated_bsh, builtin, [], []).
