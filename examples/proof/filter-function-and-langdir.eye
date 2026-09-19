# Eyelang result format 2
query(1, [call(negative(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", n1)]).
why(1, [binding("x", n1)], 4).
query(2, [call(language_direction(msg, ?v0))], [binding("direction", ?v0)]).
result(2, complete, 1).
answer(2, [binding("direction", ltr)]).
why(2, [binding("direction", ltr)], 7).
clause(1, value(n1, -3.5), []).
clause(2, value(n2, 7), []).
clause(3, directed_text(msg, literal("bonjour", fr, ltr)), []).
clause(4, negative(var("x")), [call(value(var("x"), var("v"))), compare("<", var("v"), 0)]).
clause(5, language_direction(var("message"), var("direction")), [call(directed_text(var("message"), literal(var("text"), var("lang"), var("direction"))))]).
substitution(1, []).
proof(1, value(n1, -3.5), rule(1), []).
substitution(2, []).
proof(2, value(n2, 7), rule(2), []).
substitution(3, [binding("x", n1), binding("v", -3.5)]).
proof(3, negative(n1), rule(4), [uses(1, value(n1, -3.5)), compared("<", -3.5, 0)]).
substitution(4, [binding("x", n1)]).
proof(4, solution([n1]), query, [uses(3, negative(n1))]).
substitution(5, []).
proof(5, directed_text(msg, literal("bonjour", fr, ltr)), rule(3), []).
substitution(6, [binding("message", msg), binding("direction", ltr), binding("text", "bonjour"), binding("lang", fr)]).
proof(6, language_direction(msg, ltr), rule(5), [uses(5, directed_text(msg, literal("bonjour", fr, ltr)))]).
substitution(7, [binding("direction", ltr)]).
proof(7, solution([ltr]), query, [uses(6, language_direction(msg, ltr))]).
