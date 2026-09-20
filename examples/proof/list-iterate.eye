# Eyelang result format 2
query(1, [call(test_iterate(?v0, ?v1, ?v2))], [binding("x", ?v0), binding("i", ?v1), binding("y", ?v2)]).
result(1, complete, 3).
answer(1, [binding("x", [huey, dewey, louie]), binding("i", 0), binding("y", huey)]).
why(1, [binding("x", [huey, dewey, louie]), binding("i", 0), binding("y", huey)], 5).
answer(1, [binding("x", [huey, dewey, louie]), binding("i", 1), binding("y", dewey)]).
why(1, [binding("x", [huey, dewey, louie]), binding("i", 1), binding("y", dewey)], 10).
answer(1, [binding("x", [huey, dewey, louie]), binding("i", 2), binding("y", louie)]).
why(1, [binding("x", [huey, dewey, louie]), binding("i", 2), binding("y", louie)], 13).
query(2, [call(test_is(?v0))], [binding("r", ?v0)]).
result(2, complete, 1).
answer(2, [binding("r", true)]).
why(2, [binding("r", true)], 19).
clause(1, param(letv, [huey, dewey, louie]), []).
clause(2, iterate([var("x") | var("xs")], 0, var("x")), []).
clause(3, iterate([var("x") | var("xs")], var("i"), var("y")), [call(iterate(var("xs"), var("prev"), var("y"))), calculate(var("i"), binary("+", value(var("prev")), value(1)))]).
clause(4, test_iterate(var("x"), var("i"), var("y")), [call(param(letv, var("x"))), call(iterate(var("x"), var("i"), var("y")))]).
clause(5, test_is(true), [call(test_iterate(var("x"), 1, dewey))]).
substitution(1, []).
proof(1, param(letv, [huey, dewey, louie]), rule(1), []).
substitution(2, [binding("x", huey), binding("xs", [dewey, louie])]).
proof(2, iterate([huey, dewey, louie], 0, huey), rule(2), []).
substitution(3, [binding("x", [huey, dewey, louie]), binding("i", 0), binding("y", huey)]).
proof(3, test_iterate([huey, dewey, louie], 0, huey), rule(4), [uses(1, param(letv, [huey, dewey, louie])), uses(2, iterate([huey, dewey, louie], 0, huey))]).
substitution(4, [binding("x", dewey), binding("xs", [louie])]).
proof(4, iterate([dewey, louie], 0, dewey), rule(2), []).
substitution(5, [binding("x", [huey, dewey, louie]), binding("i", 0), binding("y", huey)]).
proof(5, solution([[huey, dewey, louie], 0, huey]), query, [uses(3, test_iterate([huey, dewey, louie], 0, huey))]).
substitution(6, [binding("x", huey), binding("xs", [dewey, louie]), binding("i", 1), binding("y", dewey), binding("prev", 0)]).
proof(6, iterate([huey, dewey, louie], 1, dewey), rule(3), [uses(4, iterate([dewey, louie], 0, dewey)), calculated(1, binary("+", value(0), value(1)))]).
substitution(7, [binding("x", louie), binding("xs", [])]).
proof(7, iterate([louie], 0, louie), rule(2), []).
substitution(8, [binding("x", [huey, dewey, louie]), binding("i", 1), binding("y", dewey)]).
proof(8, test_iterate([huey, dewey, louie], 1, dewey), rule(4), [uses(1, param(letv, [huey, dewey, louie])), uses(6, iterate([huey, dewey, louie], 1, dewey))]).
substitution(9, [binding("x", dewey), binding("xs", [louie]), binding("i", 1), binding("y", louie), binding("prev", 0)]).
proof(9, iterate([dewey, louie], 1, louie), rule(3), [uses(7, iterate([louie], 0, louie)), calculated(1, binary("+", value(0), value(1)))]).
substitution(10, [binding("x", [huey, dewey, louie]), binding("i", 1), binding("y", dewey)]).
proof(10, solution([[huey, dewey, louie], 1, dewey]), query, [uses(8, test_iterate([huey, dewey, louie], 1, dewey))]).
substitution(11, [binding("x", huey), binding("xs", [dewey, louie]), binding("i", 2), binding("y", louie), binding("prev", 1)]).
proof(11, iterate([huey, dewey, louie], 2, louie), rule(3), [uses(9, iterate([dewey, louie], 1, louie)), calculated(2, binary("+", value(1), value(1)))]).
substitution(12, [binding("x", [huey, dewey, louie]), binding("i", 2), binding("y", louie)]).
proof(12, test_iterate([huey, dewey, louie], 2, louie), rule(4), [uses(1, param(letv, [huey, dewey, louie])), uses(11, iterate([huey, dewey, louie], 2, louie))]).
substitution(13, [binding("x", [huey, dewey, louie]), binding("i", 2), binding("y", louie)]).
proof(13, solution([[huey, dewey, louie], 2, louie]), query, [uses(12, test_iterate([huey, dewey, louie], 2, louie))]).
substitution(14, []).
proof(14, param(letv, [huey, dewey, louie]), rule(1), []).
substitution(15, [binding("x", dewey), binding("xs", [louie])]).
proof(15, iterate([dewey, louie], 0, dewey), rule(2), []).
substitution(16, [binding("x", huey), binding("xs", [dewey, louie]), binding("i", 1), binding("y", dewey), binding("prev", 0)]).
proof(16, iterate([huey, dewey, louie], 1, dewey), rule(3), [uses(15, iterate([dewey, louie], 0, dewey)), calculated(1, binary("+", value(0), value(1)))]).
substitution(17, [binding("x", [huey, dewey, louie]), binding("i", 1), binding("y", dewey)]).
proof(17, test_iterate([huey, dewey, louie], 1, dewey), rule(4), [uses(14, param(letv, [huey, dewey, louie])), uses(16, iterate([huey, dewey, louie], 1, dewey))]).
substitution(18, [binding("x", [huey, dewey, louie])]).
proof(18, test_is(true), rule(5), [uses(17, test_iterate([huey, dewey, louie], 1, dewey))]).
substitution(19, [binding("r", true)]).
proof(19, solution([true]), query, [uses(18, test_is(true))]).
