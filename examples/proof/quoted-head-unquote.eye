# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 4).
clause(1, cat(c), []).
clause(2, animal(var("x")), [call(cat(var("x")))]).
clause(3, test_is(true), [call(animal(c))]).
substitution(1, []).
proof(1, cat(c), rule(1), []).
substitution(2, [binding("x", c)]).
proof(2, animal(c), rule(2), [uses(1, cat(c))]).
substitution(3, []).
proof(3, test_is(true), rule(3), [uses(2, animal(c))]).
substitution(4, [binding("r", true)]).
proof(4, solution([true]), query, [uses(3, test_is(true))]).
