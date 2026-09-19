# Eyelang result format 2
query(1, [call(large_town(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", town2)]).
why(1, [binding("x", town2)], 4).
clause(1, population(town1, 1000), []).
clause(2, population(town2, 2000), []).
clause(3, large_town(var("x")), [call(population(var("x"), var("p"))), compare(">", var("p"), 1500)]).
substitution(1, []).
proof(1, population(town1, 1000), rule(1), []).
substitution(2, []).
proof(2, population(town2, 2000), rule(2), []).
substitution(3, [binding("x", town2), binding("p", 2000)]).
proof(3, large_town(town2), rule(3), [uses(2, population(town2, 2000)), compared(">", 2000, 1500)]).
substitution(4, [binding("x", town2)]).
proof(4, solution([town2]), query, [uses(3, large_town(town2))]).
