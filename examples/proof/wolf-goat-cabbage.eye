# Eyelang result format 2
query(1, [call(solution(?v0))], [binding("moves", ?v0)]).
result(1, complete, 2).
answer(1, [binding("moves", [goat, nothing, wolf, goat, cabbage, nothing, goat])]).
why(1, [binding("moves", [goat, nothing, wolf, goat, cabbage, nothing, goat])], 129).
answer(1, [binding("moves", [goat, nothing, cabbage, goat, wolf, nothing, goat])]).
why(1, [binding("moves", [goat, nothing, cabbage, goat, wolf, nothing, goat])], 130).
clause(1, member(var("x"), [var("x") | anonymous(1)]), []).
clause(2, member(var("x"), [anonymous(1) | var("rest")]), [call(member(var("x"), var("rest")))]).
clause(3, change(e, w), []).
clause(4, change(w, e), []).
clause(5, move([var("x"), var("x"), var("goat"), var("cabbage")], wolf, [var("y"), var("y"), var("goat"), var("cabbage")]), [call(change(var("x"), var("y")))]).
clause(6, move([var("x"), var("wolf"), var("x"), var("cabbage")], goat, [var("y"), var("wolf"), var("y"), var("cabbage")]), [call(change(var("x"), var("y")))]).
clause(7, move([var("x"), var("wolf"), var("goat"), var("x")], cabbage, [var("y"), var("wolf"), var("goat"), var("y")]), [call(change(var("x"), var("y")))]).
clause(8, move([var("x"), var("wolf"), var("goat"), var("cabbage")], nothing, [var("y"), var("wolf"), var("goat"), var("cabbage")]), [call(change(var("x"), var("y")))]).
clause(9, one_equal(var("x"), var("x"), anonymous(1)), []).
clause(10, one_equal(var("x"), anonymous(1), var("x")), []).
clause(11, safe([var("person"), var("wolf"), var("goat"), var("cabbage")]), [call(one_equal(var("person"), var("goat"), var("wolf"))), call(one_equal(var("person"), var("goat"), var("cabbage")))]).
clause(12, solve(var("goal"), var("goal"), anonymous(1), []), []).
clause(13, solve(var("state"), var("goal"), var("visited"), [var("move") | var("rest")]), [call(move(var("state"), var("move"), var("next"))), call(safe(var("next"))), absent(member(var("next"), var("visited"))), call(solve(var("next"), var("goal"), [var("next") | var("visited")], var("rest")))]).
clause(14, solution(var("moves")), [call(solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], var("moves"))), call(length(var("moves"), 7))]).
substitution(1, []).
proof(1, change(w, e), rule(4), []).
substitution(2, [binding("x", w), binding("goat", w), binding("cabbage", w), binding("y", e)]).
proof(2, move([w, w, w, w], wolf, [e, e, w, w]), rule(5), [uses(1, change(w, e))]).
substitution(3, [binding("x", w), binding("wolf", w), binding("cabbage", w), binding("y", e)]).
proof(3, move([w, w, w, w], goat, [e, w, e, w]), rule(6), [uses(1, change(w, e))]).
substitution(4, [binding("x", w), binding("wolf", w), binding("goat", w), binding("y", e)]).
proof(4, move([w, w, w, w], cabbage, [e, w, w, e]), rule(7), [uses(1, change(w, e))]).
substitution(5, [binding("x", w), binding("wolf", w), binding("goat", w), binding("cabbage", w), binding("y", e)]).
proof(5, move([w, w, w, w], nothing, [e, w, w, w]), rule(8), [uses(1, change(w, e))]).
substitution(6, [binding("x", e)]).
proof(6, one_equal(e, w, e), rule(10), []).
substitution(7, [binding("x", e)]).
proof(7, one_equal(e, e, w), rule(9), []).
substitution(8, [binding("person", e), binding("wolf", w), binding("goat", e), binding("cabbage", w)]).
proof(8, safe([e, w, e, w]), rule(11), [uses(7, one_equal(e, e, w)), uses(7, one_equal(e, e, w))]).
substitution(9, []).
proof(9, change(e, w), rule(3), []).
substitution(10, [binding("x", e), binding("wolf", w), binding("cabbage", w), binding("y", w)]).
proof(10, move([e, w, e, w], goat, [w, w, w, w]), rule(6), [uses(9, change(e, w))]).
substitution(11, [binding("x", e), binding("wolf", w), binding("goat", e), binding("cabbage", w), binding("y", w)]).
proof(11, move([e, w, e, w], nothing, [w, w, e, w]), rule(8), [uses(9, change(e, w))]).
substitution(12, [binding("x", w)]).
proof(12, one_equal(w, w, w), rule(9), []).
substitution(13, [binding("x", w)]).
proof(13, one_equal(w, e, w), rule(10), []).
substitution(14, [binding("person", w), binding("wolf", w), binding("goat", w), binding("cabbage", w)]).
proof(14, safe([w, w, w, w]), rule(11), [uses(12, one_equal(w, w, w)), uses(12, one_equal(w, w, w))]).
substitution(15, [binding("person", w), binding("wolf", w), binding("goat", e), binding("cabbage", w)]).
proof(15, safe([w, w, e, w]), rule(11), [uses(13, one_equal(w, e, w)), uses(13, one_equal(w, e, w))]).
substitution(16, [binding("x", [w, w, w, w])]).
proof(16, member([w, w, w, w], [[w, w, w, w]]), rule(1), []).
substitution(17, [binding("x", [w, w, w, w]), binding("rest", [[w, w, w, w]])]).
proof(17, member([w, w, w, w], [[e, w, e, w], [w, w, w, w]]), rule(2), [uses(16, member([w, w, w, w], [[w, w, w, w]]))]).
substitution(18, []).
proof(18, solution([]), query, [uses(17, member([w, w, w, w], [[e, w, e, w], [w, w, w, w]]))]).
substitution(19, [binding("x", w), binding("goat", e), binding("cabbage", w), binding("y", e)]).
proof(19, move([w, w, e, w], wolf, [e, e, e, w]), rule(5), [uses(1, change(w, e))]).
substitution(20, [binding("x", w), binding("wolf", w), binding("goat", e), binding("y", e)]).
proof(20, move([w, w, e, w], cabbage, [e, w, e, e]), rule(7), [uses(1, change(w, e))]).
substitution(21, [binding("x", w), binding("wolf", w), binding("goat", e), binding("cabbage", w), binding("y", e)]).
proof(21, move([w, w, e, w], nothing, [e, w, e, w]), rule(8), [uses(1, change(w, e))]).
substitution(22, [binding("x", [e, w, e, w])]).
proof(22, member([e, w, e, w], [[e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(23, [binding("x", [e, w, e, w]), binding("rest", [[e, w, e, w], [w, w, w, w]])]).
proof(23, member([e, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(22, member([e, w, e, w], [[e, w, e, w], [w, w, w, w]]))]).
substitution(24, []).
proof(24, solution([]), query, [uses(23, member([e, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(25, [binding("x", e)]).
proof(25, one_equal(e, e, e), rule(9), []).
substitution(26, [binding("person", e), binding("wolf", e), binding("goat", e), binding("cabbage", w)]).
proof(26, safe([e, e, e, w]), rule(11), [uses(25, one_equal(e, e, e)), uses(7, one_equal(e, e, w))]).
substitution(27, [binding("person", e), binding("wolf", w), binding("goat", e), binding("cabbage", e)]).
proof(27, safe([e, w, e, e]), rule(11), [uses(7, one_equal(e, e, w)), uses(25, one_equal(e, e, e))]).
substitution(28, [binding("x", e), binding("goat", e), binding("cabbage", w), binding("y", w)]).
proof(28, move([e, e, e, w], wolf, [w, w, e, w]), rule(5), [uses(9, change(e, w))]).
substitution(29, [binding("x", e), binding("wolf", e), binding("cabbage", w), binding("y", w)]).
proof(29, move([e, e, e, w], goat, [w, e, w, w]), rule(6), [uses(9, change(e, w))]).
substitution(30, [binding("x", e), binding("wolf", e), binding("goat", e), binding("cabbage", w), binding("y", w)]).
proof(30, move([e, e, e, w], nothing, [w, e, e, w]), rule(8), [uses(9, change(e, w))]).
substitution(31, [binding("x", e), binding("wolf", w), binding("cabbage", e), binding("y", w)]).
proof(31, move([e, w, e, e], goat, [w, w, w, e]), rule(6), [uses(9, change(e, w))]).
substitution(32, [binding("x", e), binding("wolf", w), binding("goat", e), binding("y", w)]).
proof(32, move([e, w, e, e], cabbage, [w, w, e, w]), rule(7), [uses(9, change(e, w))]).
substitution(33, [binding("x", e), binding("wolf", w), binding("goat", e), binding("cabbage", e), binding("y", w)]).
proof(33, move([e, w, e, e], nothing, [w, w, e, e]), rule(8), [uses(9, change(e, w))]).
substitution(34, [binding("x", [w, w, e, w])]).
proof(34, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(35, [binding("x", [w, w, e, w]), binding("rest", [[w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(35, member([w, w, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(34, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(36, []).
proof(36, solution([]), query, [uses(35, member([w, w, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(37, [binding("x", [w, w, e, w])]).
proof(37, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(38, [binding("x", [w, w, e, w]), binding("rest", [[w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(38, member([w, w, e, w], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(37, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(39, []).
proof(39, solution([]), query, [uses(38, member([w, w, e, w], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(40, [binding("x", w)]).
proof(40, one_equal(w, w, e), rule(9), []).
substitution(41, [binding("person", w), binding("wolf", e), binding("goat", w), binding("cabbage", w)]).
proof(41, safe([w, e, w, w]), rule(11), [uses(40, one_equal(w, w, e)), uses(12, one_equal(w, w, w))]).
substitution(42, [binding("person", w), binding("wolf", w), binding("goat", w), binding("cabbage", e)]).
proof(42, safe([w, w, w, e]), rule(11), [uses(12, one_equal(w, w, w)), uses(40, one_equal(w, w, e))]).
substitution(43, [binding("x", w), binding("wolf", e), binding("cabbage", w), binding("y", e)]).
proof(43, move([w, e, w, w], goat, [e, e, e, w]), rule(6), [uses(1, change(w, e))]).
substitution(44, [binding("x", w), binding("wolf", e), binding("goat", w), binding("y", e)]).
proof(44, move([w, e, w, w], cabbage, [e, e, w, e]), rule(7), [uses(1, change(w, e))]).
substitution(45, [binding("x", w), binding("wolf", e), binding("goat", w), binding("cabbage", w), binding("y", e)]).
proof(45, move([w, e, w, w], nothing, [e, e, w, w]), rule(8), [uses(1, change(w, e))]).
substitution(46, [binding("x", w), binding("goat", w), binding("cabbage", e), binding("y", e)]).
proof(46, move([w, w, w, e], wolf, [e, e, w, e]), rule(5), [uses(1, change(w, e))]).
substitution(47, [binding("x", w), binding("wolf", w), binding("cabbage", e), binding("y", e)]).
proof(47, move([w, w, w, e], goat, [e, w, e, e]), rule(6), [uses(1, change(w, e))]).
substitution(48, [binding("x", w), binding("wolf", w), binding("goat", w), binding("cabbage", e), binding("y", e)]).
proof(48, move([w, w, w, e], nothing, [e, w, w, e]), rule(8), [uses(1, change(w, e))]).
substitution(49, [binding("x", [e, e, e, w])]).
proof(49, member([e, e, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(50, [binding("x", [e, e, e, w]), binding("rest", [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(50, member([e, e, e, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(49, member([e, e, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(51, []).
proof(51, solution([]), query, [uses(50, member([e, e, e, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(52, [binding("x", [e, w, e, e])]).
proof(52, member([e, w, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(53, [binding("x", [e, w, e, e]), binding("rest", [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(53, member([e, w, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(52, member([e, w, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(54, []).
proof(54, solution([]), query, [uses(53, member([e, w, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(55, [binding("person", e), binding("wolf", e), binding("goat", w), binding("cabbage", e)]).
proof(55, safe([e, e, w, e]), rule(11), [uses(6, one_equal(e, w, e)), uses(6, one_equal(e, w, e))]).
substitution(56, [binding("x", e), binding("goat", w), binding("cabbage", e), binding("y", w)]).
proof(56, move([e, e, w, e], wolf, [w, w, w, e]), rule(5), [uses(9, change(e, w))]).
substitution(57, [binding("x", e), binding("wolf", e), binding("goat", w), binding("y", w)]).
proof(57, move([e, e, w, e], cabbage, [w, e, w, w]), rule(7), [uses(9, change(e, w))]).
substitution(58, [binding("x", e), binding("wolf", e), binding("goat", w), binding("cabbage", e), binding("y", w)]).
proof(58, move([e, e, w, e], nothing, [w, e, w, e]), rule(8), [uses(9, change(e, w))]).
substitution(59, [binding("x", [w, e, w, w])]).
proof(59, member([w, e, w, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(60, [binding("x", [w, e, w, w]), binding("rest", [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(60, member([w, e, w, w], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(59, member([w, e, w, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(61, []).
proof(61, solution([]), query, [uses(60, member([w, e, w, w], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(62, [binding("x", [w, w, w, e])]).
proof(62, member([w, w, w, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(63, [binding("x", [w, w, w, e]), binding("rest", [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(63, member([w, w, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(62, member([w, w, w, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(64, []).
proof(64, solution([]), query, [uses(63, member([w, w, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(65, [binding("x", [e, e, w, e])]).
proof(65, member([e, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(66, [binding("x", [e, e, w, e]), binding("rest", [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(66, member([e, e, w, e], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(65, member([e, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(67, []).
proof(67, solution([]), query, [uses(66, member([e, e, w, e], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(68, [binding("person", w), binding("wolf", e), binding("goat", w), binding("cabbage", e)]).
proof(68, safe([w, e, w, e]), rule(11), [uses(40, one_equal(w, w, e)), uses(40, one_equal(w, w, e))]).
substitution(69, [binding("x", [e, e, w, e])]).
proof(69, member([e, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(70, [binding("x", [e, e, w, e]), binding("rest", [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(70, member([e, e, w, e], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(69, member([e, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(71, []).
proof(71, solution([]), query, [uses(70, member([e, e, w, e], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(72, [binding("x", [w, w, w, e])]).
proof(72, member([w, w, w, e], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(73, [binding("x", [w, w, w, e]), binding("rest", [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(73, member([w, w, w, e], [[e, w, e, e], [w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(72, member([w, w, w, e], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(74, []).
proof(74, solution([]), query, [uses(73, member([w, w, w, e], [[e, w, e, e], [w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(75, [binding("x", [w, w, e, w])]).
proof(75, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(76, [binding("x", [w, w, e, w]), binding("rest", [[w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(76, member([w, w, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(75, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(77, [binding("x", [w, w, e, w]), binding("rest", [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(77, member([w, w, e, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(76, member([w, w, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(78, [binding("x", [w, w, e, w]), binding("rest", [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(78, member([w, w, e, w], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(77, member([w, w, e, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(79, [binding("x", [w, w, e, w]), binding("rest", [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(79, member([w, w, e, w], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(78, member([w, w, e, w], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(80, [binding("x", [w, w, e, w]), binding("rest", [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(80, member([w, w, e, w], [[e, w, e, e], [w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(79, member([w, w, e, w], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(81, []).
proof(81, solution([]), query, [uses(80, member([w, w, e, w], [[e, w, e, e], [w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(82, [binding("x", [w, w, e, w])]).
proof(82, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(83, [binding("x", [w, w, e, w]), binding("rest", [[w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(83, member([w, w, e, w], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(82, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(84, [binding("x", [w, w, e, w]), binding("rest", [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(84, member([w, w, e, w], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(83, member([w, w, e, w], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(85, [binding("x", [w, w, e, w]), binding("rest", [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(85, member([w, w, e, w], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(84, member([w, w, e, w], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(86, [binding("x", [w, w, e, w]), binding("rest", [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(86, member([w, w, e, w], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(85, member([w, w, e, w], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(87, [binding("x", [w, w, e, w]), binding("rest", [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(87, member([w, w, e, w], [[e, e, e, w], [w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(86, member([w, w, e, w], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(88, []).
proof(88, solution([]), query, [uses(87, member([w, w, e, w], [[e, e, e, w], [w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(89, [binding("x", [w, e, w, w])]).
proof(89, member([w, e, w, w], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(90, [binding("x", [w, e, w, w]), binding("rest", [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(90, member([w, e, w, w], [[e, e, e, w], [w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(89, member([w, e, w, w], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(91, []).
proof(91, solution([]), query, [uses(90, member([w, e, w, w], [[e, e, e, w], [w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(92, [binding("x", w), binding("wolf", e), binding("cabbage", e), binding("y", e)]).
proof(92, move([w, e, w, e], goat, [e, e, e, e]), rule(6), [uses(1, change(w, e))]).
substitution(93, [binding("x", w), binding("wolf", e), binding("goat", w), binding("cabbage", e), binding("y", e)]).
proof(93, move([w, e, w, e], nothing, [e, e, w, e]), rule(8), [uses(1, change(w, e))]).
substitution(94, [binding("x", [e, e, w, e])]).
proof(94, member([e, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(95, [binding("x", [e, e, w, e]), binding("rest", [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(95, member([e, e, w, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(94, member([e, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(96, []).
proof(96, solution([]), query, [uses(95, member([e, e, w, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(97, [binding("x", [e, e, w, e])]).
proof(97, member([e, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(98, [binding("x", [e, e, w, e]), binding("rest", [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(98, member([e, e, w, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(97, member([e, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(99, []).
proof(99, solution([]), query, [uses(98, member([e, e, w, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(100, [binding("person", e), binding("wolf", e), binding("goat", e), binding("cabbage", e)]).
proof(100, safe([e, e, e, e]), rule(11), [uses(25, one_equal(e, e, e)), uses(25, one_equal(e, e, e))]).
substitution(101, [binding("goal", [e, e, e, e])]).
proof(101, solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []), rule(12), []).
substitution(102, [binding("goal", [e, e, e, e])]).
proof(102, solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []), rule(12), []).
substitution(103, [binding("state", [w, e, w, e]), binding("goal", [e, e, e, e]), binding("visited", [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", goat), binding("rest", []), binding("next", [e, e, e, e])]).
proof(103, solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]), rule(13), [uses(92, move([w, e, w, e], goat, [e, e, e, e])), uses(100, safe([e, e, e, e])), absent(member([e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(101, solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []))]).
substitution(104, [binding("x", e), binding("goat", e), binding("cabbage", e), binding("y", w)]).
proof(104, move([e, e, e, e], wolf, [w, w, e, e]), rule(5), [uses(9, change(e, w))]).
substitution(105, [binding("x", e), binding("wolf", e), binding("cabbage", e), binding("y", w)]).
proof(105, move([e, e, e, e], goat, [w, e, w, e]), rule(6), [uses(9, change(e, w))]).
substitution(106, [binding("x", e), binding("wolf", e), binding("goat", e), binding("y", w)]).
proof(106, move([e, e, e, e], cabbage, [w, e, e, w]), rule(7), [uses(9, change(e, w))]).
substitution(107, [binding("x", e), binding("wolf", e), binding("goat", e), binding("cabbage", e), binding("y", w)]).
proof(107, move([e, e, e, e], nothing, [w, e, e, e]), rule(8), [uses(9, change(e, w))]).
substitution(108, [binding("state", [w, e, w, e]), binding("goal", [e, e, e, e]), binding("visited", [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", goat), binding("rest", []), binding("next", [e, e, e, e])]).
proof(108, solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]), rule(13), [uses(92, move([w, e, w, e], goat, [e, e, e, e])), uses(100, safe([e, e, e, e])), absent(member([e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(102, solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []))]).
substitution(109, [binding("state", [e, e, w, e]), binding("goal", [e, e, e, e]), binding("visited", [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", nothing), binding("rest", [goat]), binding("next", [w, e, w, e])]).
proof(109, solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]), rule(13), [uses(58, move([e, e, w, e], nothing, [w, e, w, e])), uses(68, safe([w, e, w, e])), absent(member([w, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(103, solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]))]).
substitution(110, [binding("x", [w, e, w, e])]).
proof(110, member([w, e, w, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(111, [binding("x", [w, e, w, e]), binding("rest", [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(111, member([w, e, w, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(110, member([w, e, w, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(112, []).
proof(112, solution([]), query, [uses(111, member([w, e, w, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(113, [binding("x", [w, e, w, e])]).
proof(113, member([w, e, w, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(114, [binding("x", [w, e, w, e]), binding("rest", [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]])]).
proof(114, member([w, e, w, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(113, member([w, e, w, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(115, []).
proof(115, solution([]), query, [uses(114, member([w, e, w, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(116, [binding("state", [e, e, w, e]), binding("goal", [e, e, e, e]), binding("visited", [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", nothing), binding("rest", [goat]), binding("next", [w, e, w, e])]).
proof(116, solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]), rule(13), [uses(58, move([e, e, w, e], nothing, [w, e, w, e])), uses(68, safe([w, e, w, e])), absent(member([w, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(108, solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]))]).
substitution(117, [binding("state", [w, e, w, w]), binding("goal", [e, e, e, e]), binding("visited", [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", cabbage), binding("rest", [nothing, goat]), binding("next", [e, e, w, e])]).
proof(117, solve([w, e, w, w], [e, e, e, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, nothing, goat]), rule(13), [uses(44, move([w, e, w, w], cabbage, [e, e, w, e])), uses(55, safe([e, e, w, e])), absent(member([e, e, w, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(109, solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]))]).
substitution(118, [binding("state", [w, w, w, e]), binding("goal", [e, e, e, e]), binding("visited", [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", wolf), binding("rest", [nothing, goat]), binding("next", [e, e, w, e])]).
proof(118, solve([w, w, w, e], [e, e, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, nothing, goat]), rule(13), [uses(46, move([w, w, w, e], wolf, [e, e, w, e])), uses(55, safe([e, e, w, e])), absent(member([e, e, w, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(116, solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]))]).
substitution(119, [binding("state", [e, e, e, w]), binding("goal", [e, e, e, e]), binding("visited", [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", goat), binding("rest", [cabbage, nothing, goat]), binding("next", [w, e, w, w])]).
proof(119, solve([e, e, e, w], [e, e, e, e], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, cabbage, nothing, goat]), rule(13), [uses(29, move([e, e, e, w], goat, [w, e, w, w])), uses(41, safe([w, e, w, w])), absent(member([w, e, w, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(117, solve([w, e, w, w], [e, e, e, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, nothing, goat]))]).
substitution(120, [binding("state", [e, w, e, e]), binding("goal", [e, e, e, e]), binding("visited", [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", goat), binding("rest", [wolf, nothing, goat]), binding("next", [w, w, w, e])]).
proof(120, solve([e, w, e, e], [e, e, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, wolf, nothing, goat]), rule(13), [uses(31, move([e, w, e, e], goat, [w, w, w, e])), uses(42, safe([w, w, w, e])), absent(member([w, w, w, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(118, solve([w, w, w, e], [e, e, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, nothing, goat]))]).
substitution(121, [binding("state", [w, w, e, w]), binding("goal", [e, e, e, e]), binding("visited", [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", wolf), binding("rest", [goat, cabbage, nothing, goat]), binding("next", [e, e, e, w])]).
proof(121, solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, goat, cabbage, nothing, goat]), rule(13), [uses(19, move([w, w, e, w], wolf, [e, e, e, w])), uses(26, safe([e, e, e, w])), absent(member([e, e, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(119, solve([e, e, e, w], [e, e, e, e], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, cabbage, nothing, goat]))]).
substitution(122, [binding("state", [w, w, e, w]), binding("goal", [e, e, e, e]), binding("visited", [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), binding("move", cabbage), binding("rest", [goat, wolf, nothing, goat]), binding("next", [e, w, e, e])]).
proof(122, solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, goat, wolf, nothing, goat]), rule(13), [uses(20, move([w, w, e, w], cabbage, [e, w, e, e])), uses(27, safe([e, w, e, e])), absent(member([e, w, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(120, solve([e, w, e, e], [e, e, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, wolf, nothing, goat]))]).
substitution(123, [binding("state", [e, w, e, w]), binding("goal", [e, e, e, e]), binding("visited", [[e, w, e, w], [w, w, w, w]]), binding("move", nothing), binding("rest", [wolf, goat, cabbage, nothing, goat]), binding("next", [w, w, e, w])]).
proof(123, solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, wolf, goat, cabbage, nothing, goat]), rule(13), [uses(11, move([e, w, e, w], nothing, [w, w, e, w])), uses(15, safe([w, w, e, w])), absent(member([w, w, e, w], [[e, w, e, w], [w, w, w, w]]), complete), uses(121, solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, goat, cabbage, nothing, goat]))]).
substitution(124, [binding("state", [e, w, e, w]), binding("goal", [e, e, e, e]), binding("visited", [[e, w, e, w], [w, w, w, w]]), binding("move", nothing), binding("rest", [cabbage, goat, wolf, nothing, goat]), binding("next", [w, w, e, w])]).
proof(124, solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, cabbage, goat, wolf, nothing, goat]), rule(13), [uses(11, move([e, w, e, w], nothing, [w, w, e, w])), uses(15, safe([w, w, e, w])), absent(member([w, w, e, w], [[e, w, e, w], [w, w, w, w]]), complete), uses(122, solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, goat, wolf, nothing, goat]))]).
substitution(125, [binding("state", [w, w, w, w]), binding("goal", [e, e, e, e]), binding("visited", [[w, w, w, w]]), binding("move", goat), binding("rest", [nothing, wolf, goat, cabbage, nothing, goat]), binding("next", [e, w, e, w])]).
proof(125, solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, wolf, goat, cabbage, nothing, goat]), rule(13), [uses(3, move([w, w, w, w], goat, [e, w, e, w])), uses(8, safe([e, w, e, w])), absent(member([e, w, e, w], [[w, w, w, w]]), complete), uses(123, solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, wolf, goat, cabbage, nothing, goat]))]).
substitution(126, [binding("state", [w, w, w, w]), binding("goal", [e, e, e, e]), binding("visited", [[w, w, w, w]]), binding("move", goat), binding("rest", [nothing, cabbage, goat, wolf, nothing, goat]), binding("next", [e, w, e, w])]).
proof(126, solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, cabbage, goat, wolf, nothing, goat]), rule(13), [uses(3, move([w, w, w, w], goat, [e, w, e, w])), uses(8, safe([e, w, e, w])), absent(member([e, w, e, w], [[w, w, w, w]]), complete), uses(124, solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, cabbage, goat, wolf, nothing, goat]))]).
substitution(127, [binding("moves", [goat, nothing, wolf, goat, cabbage, nothing, goat])]).
proof(127, solution([goat, nothing, wolf, goat, cabbage, nothing, goat]), rule(14), [uses(125, solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, wolf, goat, cabbage, nothing, goat])), builtin(length([goat, nothing, wolf, goat, cabbage, nothing, goat], 7))]).
substitution(128, [binding("moves", [goat, nothing, cabbage, goat, wolf, nothing, goat])]).
proof(128, solution([goat, nothing, cabbage, goat, wolf, nothing, goat]), rule(14), [uses(126, solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, cabbage, goat, wolf, nothing, goat])), builtin(length([goat, nothing, cabbage, goat, wolf, nothing, goat], 7))]).
substitution(129, [binding("moves", [goat, nothing, wolf, goat, cabbage, nothing, goat])]).
proof(129, solution([[goat, nothing, wolf, goat, cabbage, nothing, goat]]), query, [uses(127, solution([goat, nothing, wolf, goat, cabbage, nothing, goat]))]).
substitution(130, [binding("moves", [goat, nothing, cabbage, goat, wolf, nothing, goat])]).
proof(130, solution([[goat, nothing, cabbage, goat, wolf, nothing, goat]]), query, [uses(128, solution([goat, nothing, cabbage, goat, wolf, nothing, goat]))]).
