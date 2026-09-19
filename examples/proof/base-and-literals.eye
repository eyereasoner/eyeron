# Eyelang result format 2
query(1, [call(adult(?v0))], [binding("person", ?v0)]).
result(1, complete, 1).
answer(1, [binding("person", alice)]).
why(1, [binding("person", alice)], 3).
clause(1, person(alice, literal("Alice Smith", en), typed(22, integer)), []).
clause(3, adult(var("person")), [call(person(var("person"), literal(var("name"), en), typed(var("age"), integer))), compare(">=", var("age"), 18)]).
substitution(1, []).
proof(1, person(alice, literal("Alice Smith", en), typed(22, integer)), rule(1), []).
substitution(2, [binding("person", alice), binding("name", "Alice Smith"), binding("age", 22)]).
proof(2, adult(alice), rule(3), [uses(1, person(alice, literal("Alice Smith", en), typed(22, integer))), compared(">=", 22, 18)]).
substitution(3, [binding("person", alice)]).
proof(3, solution([alice]), query, [uses(2, adult(alice))]).
