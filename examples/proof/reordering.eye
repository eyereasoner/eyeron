# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 4).
clause(1, has(alice, [book, 1]), []).
clause(2, has(bob, [table, 1]), []).
clause(3, test_is(true), [call(has(var("w1"), [var("o1"), var("n1")])), call(has(var("w2"), [var("o2"), var("n2")])), compare("!=", var("o1"), var("o2"))]).
substitution(1, []).
proof(1, has(alice, [book, 1]), rule(1), []).
substitution(2, []).
proof(2, has(bob, [table, 1]), rule(2), []).
substitution(3, [binding("w1", alice), binding("o1", book), binding("n1", 1), binding("w2", bob), binding("o2", table), binding("n2", 1)]).
proof(3, test_is(true), rule(3), [uses(1, has(alice, [book, 1])), uses(2, has(bob, [table, 1])), compared("!=", book, table)]).
substitution(4, [binding("r", true)]).
proof(4, solution([true]), query, [uses(3, test_is(true))]).
