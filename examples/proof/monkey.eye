# Eyelang result format 2
query(1, [call(animal(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", bobos_kind)]).
why(1, [binding("x", bobos_kind)], 3).
query(2, [call(test())], []).
result(2, complete, 1).
answer(2, []).
why(2, [], 8).
clause(2, monkey(bobos_kind), []).
clause(3, animal(var("x")), [call(monkey(var("x")))]).
clause(4, test(), [call(monkey(var("x"))), call(animal(var("x")))]).
substitution(1, []).
proof(1, monkey(bobos_kind), rule(2), []).
substitution(2, [binding("x", bobos_kind)]).
proof(2, animal(bobos_kind), rule(3), [uses(1, monkey(bobos_kind))]).
substitution(3, [binding("x", bobos_kind)]).
proof(3, solution([bobos_kind]), query, [uses(2, animal(bobos_kind))]).
substitution(4, []).
proof(4, monkey(bobos_kind), rule(2), []).
substitution(5, []).
proof(5, monkey(bobos_kind), rule(2), []).
substitution(6, [binding("x", bobos_kind)]).
proof(6, animal(bobos_kind), rule(3), [uses(5, monkey(bobos_kind))]).
substitution(7, [binding("x", bobos_kind)]).
proof(7, test(), rule(4), [uses(4, monkey(bobos_kind)), uses(6, animal(bobos_kind))]).
substitution(8, []).
proof(8, solution([]), query, [uses(7, test())]).
