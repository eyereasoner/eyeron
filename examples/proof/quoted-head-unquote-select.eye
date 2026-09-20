# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 5).
clause(1, activates(cat, ruleCat), []).
clause(3, class_of(c, cat), []).
clause(4, animal(var("x")), [call(class_of(var("x"), cat)), call(activates(cat, ruleCat))]).
clause(6, test_is(true), [call(animal(c))]).
substitution(1, []).
proof(1, class_of(c, cat), rule(3), []).
substitution(2, []).
proof(2, activates(cat, ruleCat), rule(1), []).
substitution(3, [binding("x", c)]).
proof(3, animal(c), rule(4), [uses(1, class_of(c, cat)), uses(2, activates(cat, ruleCat))]).
substitution(4, []).
proof(4, test_is(true), rule(6), [uses(3, animal(c))]).
substitution(5, [binding("r", true)]).
proof(5, solution([true]), query, [uses(4, test_is(true))]).
