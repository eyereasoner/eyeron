% Prolog result format 3
query(1, is_(_0, _1), ['S' = _0, 'W' = _1]).
result(1, complete, 2).
answer(1, ['S' = socrates, 'W' = witness(socrates)]).
why(1, ['S' = socrates, 'W' = witness(socrates)], 5).
answer(1, ['S' = plato, 'W' = witness(plato)]).
why(1, ['S' = plato, 'W' = witness(plato)], 6).
clause(1, human(socrates), true).
clause(2, human(plato), true).
clause(3, is_(var('S'), witness(var('S'))), human(var('S'))).
substitution(1, []).
proof(1, human(socrates), rule(1), []).
substitution(2, []).
proof(2, human(plato), rule(2), []).
substitution(3, ['S' = socrates]).
proof(3, is_(socrates, witness(socrates)), rule(3), [uses(1, human(socrates))]).
substitution(4, ['S' = plato]).
proof(4, is_(plato, witness(plato)), rule(3), [uses(2, human(plato))]).
substitution(5, ['S' = socrates, 'W' = witness(socrates)]).
proof(5, solution([socrates, witness(socrates)]), query, [uses(3, is_(socrates, witness(socrates)))]).
substitution(6, ['S' = plato, 'W' = witness(plato)]).
proof(6, solution([plato, witness(plato)]), query, [uses(4, is_(plato, witness(plato)))]).
