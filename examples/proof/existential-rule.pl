% Prolog result format 4
query(1, is_(_0, _1), ['S' = _0, 'W' = _1]).
result(1, complete, 2).
answer(1, ['S' = socrates, 'W' = witness(socrates)]).
why(1, ['S' = socrates, 'W' = witness(socrates)], [is_(socrates, witness(socrates))]).
answer(1, ['S' = plato, 'W' = witness(plato)]).
why(1, ['S' = plato, 'W' = witness(plato)], [is_(plato, witness(plato))]).

clause(1, human(socrates), true).
clause(2, human(plato), true).
clause(3, is_(var('S'), witness(var('S'))), human(var('S'))).

step(is_(socrates, witness(socrates)), rule(3), ['S' = socrates], [human(socrates)]).
step(human(socrates), fact(1), [], []).
step(is_(plato, witness(plato)), rule(3), ['S' = plato], [human(plato)]).
step(human(plato), fact(2), [], []).
