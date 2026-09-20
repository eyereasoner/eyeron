# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 3).
clause(1, val(x, [1, 2]), []).
clause(2, test_is(true), [call(val(x, [var("h") | var("t")])), compare("=", var("h"), 1), compare("=", var("t"), [2])]).
substitution(1, []).
proof(1, val(x, [1, 2]), rule(1), []).
substitution(2, [binding("h", 1), binding("t", [2])]).
proof(2, test_is(true), rule(2), [uses(1, val(x, [1, 2])), compared("=", 1, 1), compared("=", [2], [2])]).
substitution(3, [binding("r", true)]).
proof(3, solution([true]), query, [uses(2, test_is(true))]).
