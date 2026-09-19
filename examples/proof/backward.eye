# Eyelang result format 2
query(1, [call(indeed_more_interesting(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(1, complete, 1).
answer(1, [binding("x", five), binding("y", three)]).
why(1, [binding("x", five), binding("y", three)], 5).
clause(1, value(five, 5), []).
clause(2, value(three, 3), []).
clause(3, more_interesting(var("x"), var("y")), [call(value(var("x"), var("left"))), call(value(var("y"), var("right"))), compare(">", var("left"), var("right"))]).
clause(4, indeed_more_interesting(var("x"), var("y")), [call(more_interesting(var("x"), var("y")))]).
substitution(1, []).
proof(1, value(five, 5), rule(1), []).
substitution(2, []).
proof(2, value(three, 3), rule(2), []).
substitution(3, [binding("x", five), binding("y", three), binding("left", 5), binding("right", 3)]).
proof(3, more_interesting(five, three), rule(3), [uses(1, value(five, 5)), uses(2, value(three, 3)), compared(">", 5, 3)]).
substitution(4, [binding("x", five), binding("y", three)]).
proof(4, indeed_more_interesting(five, three), rule(4), [uses(3, more_interesting(five, three))]).
substitution(5, [binding("x", five), binding("y", three)]).
proof(5, solution([five, three]), query, [uses(4, indeed_more_interesting(five, three))]).
