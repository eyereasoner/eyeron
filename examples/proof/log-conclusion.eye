# Eyelang result format 2
query(1, [call(says(?v0, ?v1))], [binding("x", ?v0), binding("msg", ?v1)]).
result(1, complete, 1).
answer(1, [binding("x", felix), binding("msg", "Meow")]).
why(1, [binding("x", felix), binding("msg", "Meow")], 3).
clause(1, cat(felix), []).
clause(2, says(var("x"), "Meow"), [call(cat(var("x")))]).
substitution(1, []).
proof(1, cat(felix), rule(1), []).
substitution(2, [binding("x", felix)]).
proof(2, says(felix, "Meow"), rule(2), [uses(1, cat(felix))]).
substitution(3, [binding("x", felix), binding("msg", "Meow")]).
proof(3, solution([felix, "Meow"]), query, [uses(2, says(felix, "Meow"))]).
