# Eyelang result format 2
query(1, [call(unclassified(?v0))], [binding("place", ?v0)]).
result(1, complete, 1).
answer(1, [binding("place", x3)]).
why(1, [binding("place", x3)], 11).
clause(1, place(x1), []).
clause(2, place(x2), []).
clause(3, place(x3), []).
clause(4, population(x1, 1000), []).
clause(5, population(x2, 2000), []).
clause(6, unclassified(var("place")), [call(place(var("place"))), absent(has_population(var("place")))]).
clause(7, has_population(var("place")), [call(population(var("place"), var("amount")))]).
substitution(1, []).
proof(1, place(x1), rule(1), []).
substitution(2, []).
proof(2, place(x2), rule(2), []).
substitution(3, []).
proof(3, place(x3), rule(3), []).
substitution(4, []).
proof(4, population(x1, 1000), rule(4), []).
substitution(5, [binding("place", x1), binding("amount", 1000)]).
proof(5, has_population(x1), rule(7), [uses(4, population(x1, 1000))]).
substitution(6, []).
proof(6, solution([]), query, [uses(5, has_population(x1))]).
substitution(7, []).
proof(7, population(x2, 2000), rule(5), []).
substitution(8, [binding("place", x2), binding("amount", 2000)]).
proof(8, has_population(x2), rule(7), [uses(7, population(x2, 2000))]).
substitution(9, []).
proof(9, solution([]), query, [uses(8, has_population(x2))]).
substitution(10, [binding("place", x3)]).
proof(10, unclassified(x3), rule(6), [uses(3, place(x3)), absent(has_population(x3), complete)]).
substitution(11, [binding("place", x3)]).
proof(11, solution([x3]), query, [uses(10, unclassified(x3))]).
