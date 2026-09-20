# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 4).
clause(1, cat(minka), []).
clause(2, dog(charly), []).
clause(3, test_is(true), [call(cat(var("x"))), call(dog(var("y")))]).
substitution(1, []).
proof(1, cat(minka), rule(1), []).
substitution(2, []).
proof(2, dog(charly), rule(2), []).
substitution(3, [binding("x", minka), binding("y", charly)]).
proof(3, test_is(true), rule(3), [uses(1, cat(minka)), uses(2, dog(charly))]).
substitution(4, [binding("r", true)]).
proof(4, solution([true]), query, [uses(3, test_is(true))]).
