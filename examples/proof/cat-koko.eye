# Eyelang result format 2
query(1, [call(test())], []).
result(1, complete, 1).
answer(1, []).
why(1, [], 5).
clause(1, animal(koko), []).
clause(2, cat(generated_cat), [call(animal(koko))]).
clause(3, british_short_hair(generated_bsh), [call(animal(koko))]).
clause(4, test(), [call(cat(var("x"))), call(british_short_hair(var("y"))), compare("!=", var("x"), var("y"))]).
substitution(1, []).
proof(1, animal(koko), rule(1), []).
substitution(2, []).
proof(2, cat(generated_cat), rule(2), [uses(1, animal(koko))]).
substitution(3, []).
proof(3, british_short_hair(generated_bsh), rule(3), [uses(1, animal(koko))]).
substitution(4, [binding("x", generated_cat), binding("y", generated_bsh)]).
proof(4, test(), rule(4), [uses(2, cat(generated_cat)), uses(3, british_short_hair(generated_bsh)), compared("!=", generated_cat, generated_bsh)]).
substitution(5, []).
proof(5, solution([]), query, [uses(4, test())]).
