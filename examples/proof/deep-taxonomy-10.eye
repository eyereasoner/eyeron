# Eyelang result format 2
query(1, [call(direct_subclass(n(4), n(5)))], []).
result(1, complete, 1).
answer(1, []).
why(1, [], 2).
query(2, [call(direct_subclass(n(4), i(5)))], []).
result(2, complete, 1).
answer(2, []).
why(2, [], 4).
query(3, [call(direct_subclass(n(4), j(5)))], []).
result(3, complete, 1).
answer(3, []).
why(3, [], 6).
query(4, [call(subsumed(n(0), n(10)))], []).
result(4, complete, 1).
answer(4, []).
why(4, [], 8).
query(5, [call(classified_as(ind, i(5)))], []).
result(5, complete, 1).
answer(5, []).
why(5, [], 12).
query(6, [call(classified_as(ind, j(10)))], []).
result(6, complete, 1).
answer(6, []).
why(6, [], 16).
query(7, [call(classified_as(ind, a2))], []).
result(7, complete, 1).
answer(7, []).
why(7, [], 20).
query(8, [absent(subsumed(i(5), n(10)))], []).
result(8, complete, 1).
answer(8, []).
why(8, [], 21).
query(9, [absent(subsumed(i(5), j(5)))], []).
result(9, complete, 1).
answer(9, []).
why(9, [], 22).
query(10, [absent(classified_as(ind, i(11)))], []).
result(10, complete, 1).
answer(10, []).
why(10, [], 24).
query(11, [absent(direct_subclass(n(-1), n(0)))], []).
result(11, complete, 1).
answer(11, []).
why(11, [], 25).
query(12, [absent(subsumed(a2, n(10)))], []).
result(12, complete, 1).
answer(12, []).
why(12, [], 26).
clause(1, direct_subclass(n(var("level")), n(var("next"))), [compare(">=", var("level"), 0), compare("<", var("level"), 10), calculate(var("next"), binary("+", value(var("level")), value(1)))]).
clause(2, direct_subclass(n(var("level")), i(var("next"))), [compare(">=", var("level"), 0), compare("<", var("level"), 10), calculate(var("next"), binary("+", value(var("level")), value(1)))]).
clause(3, direct_subclass(n(var("level")), j(var("next"))), [compare(">=", var("level"), 0), compare("<", var("level"), 10), calculate(var("next"), binary("+", value(var("level")), value(1)))]).
clause(6, subsumed(n(var("lower")), n(var("upper"))), [compare(">=", var("lower"), 0), compare("<", var("lower"), var("upper")), compare("<=", var("upper"), 10)]).
clause(7, subsumed(n(var("lower")), i(var("branch"))), [compare(">=", var("lower"), 0), compare("<", var("lower"), var("branch")), compare("<=", var("branch"), 10)]).
clause(8, subsumed(n(var("lower")), j(var("branch"))), [compare(">=", var("lower"), 0), compare("<", var("lower"), var("branch")), compare("<=", var("branch"), 10)]).
clause(9, subsumed(n(var("lower")), a2), [compare(">=", var("lower"), 0), compare("<=", var("lower"), 10)]).
clause(10, asserted_type(ind, n(0)), []).
clause(11, classified_as(var("individual"), var("class")), [call(asserted_type(var("individual"), var("base"))), call(subsumed(var("base"), var("class")))]).
substitution(1, [binding("level", 4), binding("next", 5)]).
proof(1, direct_subclass(n(4), n(5)), rule(1), [compared(">=", 4, 0), compared("<", 4, 10), calculated(5, binary("+", value(4), value(1)))]).
substitution(2, []).
proof(2, solution([]), query, [uses(1, direct_subclass(n(4), n(5)))]).
substitution(3, [binding("level", 4), binding("next", 5)]).
proof(3, direct_subclass(n(4), i(5)), rule(2), [compared(">=", 4, 0), compared("<", 4, 10), calculated(5, binary("+", value(4), value(1)))]).
substitution(4, []).
proof(4, solution([]), query, [uses(3, direct_subclass(n(4), i(5)))]).
substitution(5, [binding("level", 4), binding("next", 5)]).
proof(5, direct_subclass(n(4), j(5)), rule(3), [compared(">=", 4, 0), compared("<", 4, 10), calculated(5, binary("+", value(4), value(1)))]).
substitution(6, []).
proof(6, solution([]), query, [uses(5, direct_subclass(n(4), j(5)))]).
substitution(7, [binding("lower", 0), binding("upper", 10)]).
proof(7, subsumed(n(0), n(10)), rule(6), [compared(">=", 0, 0), compared("<", 0, 10), compared("<=", 10, 10)]).
substitution(8, []).
proof(8, solution([]), query, [uses(7, subsumed(n(0), n(10)))]).
substitution(9, []).
proof(9, asserted_type(ind, n(0)), rule(10), []).
substitution(10, [binding("lower", 0), binding("branch", 5)]).
proof(10, subsumed(n(0), i(5)), rule(7), [compared(">=", 0, 0), compared("<", 0, 5), compared("<=", 5, 10)]).
substitution(11, [binding("individual", ind), binding("class", i(5)), binding("base", n(0))]).
proof(11, classified_as(ind, i(5)), rule(11), [uses(9, asserted_type(ind, n(0))), uses(10, subsumed(n(0), i(5)))]).
substitution(12, []).
proof(12, solution([]), query, [uses(11, classified_as(ind, i(5)))]).
substitution(13, []).
proof(13, asserted_type(ind, n(0)), rule(10), []).
substitution(14, [binding("lower", 0), binding("branch", 10)]).
proof(14, subsumed(n(0), j(10)), rule(8), [compared(">=", 0, 0), compared("<", 0, 10), compared("<=", 10, 10)]).
substitution(15, [binding("individual", ind), binding("class", j(10)), binding("base", n(0))]).
proof(15, classified_as(ind, j(10)), rule(11), [uses(13, asserted_type(ind, n(0))), uses(14, subsumed(n(0), j(10)))]).
substitution(16, []).
proof(16, solution([]), query, [uses(15, classified_as(ind, j(10)))]).
substitution(17, []).
proof(17, asserted_type(ind, n(0)), rule(10), []).
substitution(18, [binding("lower", 0)]).
proof(18, subsumed(n(0), a2), rule(9), [compared(">=", 0, 0), compared("<=", 0, 10)]).
substitution(19, [binding("individual", ind), binding("class", a2), binding("base", n(0))]).
proof(19, classified_as(ind, a2), rule(11), [uses(17, asserted_type(ind, n(0))), uses(18, subsumed(n(0), a2))]).
substitution(20, []).
proof(20, solution([]), query, [uses(19, classified_as(ind, a2))]).
substitution(21, []).
proof(21, solution([]), query, [absent(subsumed(i(5), n(10)), complete)]).
substitution(22, []).
proof(22, solution([]), query, [absent(subsumed(i(5), j(5)), complete)]).
substitution(23, []).
proof(23, asserted_type(ind, n(0)), rule(10), []).
substitution(24, []).
proof(24, solution([]), query, [absent(classified_as(ind, i(11)), complete)]).
substitution(25, []).
proof(25, solution([]), query, [absent(direct_subclass(n(-1), n(0)), complete)]).
substitution(26, []).
proof(26, solution([]), query, [absent(subsumed(a2, n(10)), complete)]).
