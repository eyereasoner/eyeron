% Prolog result format 3
query(1, test, []).
result(1, complete, 1).
answer(1, []).
why(1, [], 5).
clause(1, animal(koko), true).
clause(2, cat(generated_cat), animal(koko)).
clause(3, british_short_hair(generated_bsh), animal(koko)).
clause(4, test, (cat(var('X')), british_short_hair(var('Y')), var('X') \== var('Y'))).
substitution(1, []).
proof(1, animal(koko), rule(1), []).
substitution(2, []).
proof(2, cat(generated_cat), rule(2), [uses(1, animal(koko))]).
substitution(3, []).
proof(3, british_short_hair(generated_bsh), rule(3), [uses(1, animal(koko))]).
substitution(4, ['X' = generated_cat, 'Y' = generated_bsh]).
proof(4, test, rule(4), [uses(2, cat(generated_cat)), uses(3, british_short_hair(generated_bsh)), builtin(generated_cat \== generated_bsh)]).
substitution(5, []).
proof(5, solution([]), query, [uses(4, test)]).
