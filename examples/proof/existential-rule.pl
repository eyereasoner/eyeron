is_(socrates, witness(socrates)).
is_(plato, witness(plato)).

clause(1, human(socrates), true).
clause(2, human(plato), true).
clause(3, is_(var('S'), witness(var('S'))), human(var('S'))).

step(is_(socrates, witness(socrates)), rule(3), ['S' = socrates], [human(socrates)]).
step(human(socrates), fact(1), [], []).
step(is_(plato, witness(plato)), rule(3), ['S' = plato], [human(plato)]).
step(human(plato), fact(2), [], []).
