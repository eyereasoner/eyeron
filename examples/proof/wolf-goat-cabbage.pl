% Prolog result format 3
query(1, solution(_0), ['Moves' = _0]).
result(1, complete, 2).
answer(1, ['Moves' = [goat, nothing, wolf, goat, cabbage, nothing, goat]]).
why(1, ['Moves' = [goat, nothing, wolf, goat, cabbage, nothing, goat]], 129).
answer(1, ['Moves' = [goat, nothing, cabbage, goat, wolf, nothing, goat]]).
why(1, ['Moves' = [goat, nothing, cabbage, goat, wolf, nothing, goat]], 130).
clause(1, member(var('X'), [var('X')|anonymous(1)]), true).
clause(2, member(var('X'), [anonymous(1)|var('Rest')]), member(var('X'), var('Rest'))).
clause(3, change(e, w), true).
clause(4, change(w, e), true).
clause(5, move([var('X'), var('X'), var('Goat'), var('Cabbage')], wolf, [var('Y'), var('Y'), var('Goat'), var('Cabbage')]), change(var('X'), var('Y'))).
clause(6, move([var('X'), var('Wolf'), var('X'), var('Cabbage')], goat, [var('Y'), var('Wolf'), var('Y'), var('Cabbage')]), change(var('X'), var('Y'))).
clause(7, move([var('X'), var('Wolf'), var('Goat'), var('X')], cabbage, [var('Y'), var('Wolf'), var('Goat'), var('Y')]), change(var('X'), var('Y'))).
clause(8, move([var('X'), var('Wolf'), var('Goat'), var('Cabbage')], nothing, [var('Y'), var('Wolf'), var('Goat'), var('Cabbage')]), change(var('X'), var('Y'))).
clause(9, one_equal(var('X'), var('X'), anonymous(1)), true).
clause(10, one_equal(var('X'), anonymous(1), var('X')), true).
clause(11, safe([var('Person'), var('Wolf'), var('Goat'), var('Cabbage')]), (one_equal(var('Person'), var('Goat'), var('Wolf')), one_equal(var('Person'), var('Goat'), var('Cabbage')))).
clause(12, solve(var('Goal'), var('Goal'), anonymous(1), []), true).
clause(13, solve(var('State'), var('Goal'), var('Visited'), [var('Move')|var('Rest')]), (move(var('State'), var('Move'), var('Next')), safe(var('Next')), \+member(var('Next'), var('Visited')), solve(var('Next'), var('Goal'), [var('Next')|var('Visited')], var('Rest')))).
clause(14, solution(var('Moves')), (solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], var('Moves')), length(var('Moves'), 7))).
substitution(1, []).
proof(1, change(w, e), rule(4), []).
substitution(2, ['X' = w, 'Goat' = w, 'Cabbage' = w, 'Y' = e]).
proof(2, move([w, w, w, w], wolf, [e, e, w, w]), rule(5), [uses(1, change(w, e))]).
substitution(3, ['X' = w, 'Wolf' = w, 'Cabbage' = w, 'Y' = e]).
proof(3, move([w, w, w, w], goat, [e, w, e, w]), rule(6), [uses(1, change(w, e))]).
substitution(4, ['X' = w, 'Wolf' = w, 'Goat' = w, 'Y' = e]).
proof(4, move([w, w, w, w], cabbage, [e, w, w, e]), rule(7), [uses(1, change(w, e))]).
substitution(5, ['X' = w, 'Wolf' = w, 'Goat' = w, 'Cabbage' = w, 'Y' = e]).
proof(5, move([w, w, w, w], nothing, [e, w, w, w]), rule(8), [uses(1, change(w, e))]).
substitution(6, ['X' = e]).
proof(6, one_equal(e, w, e), rule(10), []).
substitution(7, ['X' = e]).
proof(7, one_equal(e, e, w), rule(9), []).
substitution(8, ['Person' = e, 'Wolf' = w, 'Goat' = e, 'Cabbage' = w]).
proof(8, safe([e, w, e, w]), rule(11), [uses(7, one_equal(e, e, w)), uses(7, one_equal(e, e, w))]).
substitution(9, []).
proof(9, change(e, w), rule(3), []).
substitution(10, ['X' = e, 'Wolf' = w, 'Cabbage' = w, 'Y' = w]).
proof(10, move([e, w, e, w], goat, [w, w, w, w]), rule(6), [uses(9, change(e, w))]).
substitution(11, ['X' = e, 'Wolf' = w, 'Goat' = e, 'Cabbage' = w, 'Y' = w]).
proof(11, move([e, w, e, w], nothing, [w, w, e, w]), rule(8), [uses(9, change(e, w))]).
substitution(12, ['X' = w]).
proof(12, one_equal(w, w, w), rule(9), []).
substitution(13, ['X' = w]).
proof(13, one_equal(w, e, w), rule(10), []).
substitution(14, ['Person' = w, 'Wolf' = w, 'Goat' = w, 'Cabbage' = w]).
proof(14, safe([w, w, w, w]), rule(11), [uses(12, one_equal(w, w, w)), uses(12, one_equal(w, w, w))]).
substitution(15, ['Person' = w, 'Wolf' = w, 'Goat' = e, 'Cabbage' = w]).
proof(15, safe([w, w, e, w]), rule(11), [uses(13, one_equal(w, e, w)), uses(13, one_equal(w, e, w))]).
substitution(16, ['X' = [w, w, w, w]]).
proof(16, member([w, w, w, w], [[w, w, w, w]]), rule(1), []).
substitution(17, ['X' = [w, w, w, w], 'Rest' = [[w, w, w, w]]]).
proof(17, member([w, w, w, w], [[e, w, e, w], [w, w, w, w]]), rule(2), [uses(16, member([w, w, w, w], [[w, w, w, w]]))]).
substitution(18, []).
proof(18, solution([]), query, [uses(17, member([w, w, w, w], [[e, w, e, w], [w, w, w, w]]))]).
substitution(19, ['X' = w, 'Goat' = e, 'Cabbage' = w, 'Y' = e]).
proof(19, move([w, w, e, w], wolf, [e, e, e, w]), rule(5), [uses(1, change(w, e))]).
substitution(20, ['X' = w, 'Wolf' = w, 'Goat' = e, 'Y' = e]).
proof(20, move([w, w, e, w], cabbage, [e, w, e, e]), rule(7), [uses(1, change(w, e))]).
substitution(21, ['X' = w, 'Wolf' = w, 'Goat' = e, 'Cabbage' = w, 'Y' = e]).
proof(21, move([w, w, e, w], nothing, [e, w, e, w]), rule(8), [uses(1, change(w, e))]).
substitution(22, ['X' = [e, w, e, w]]).
proof(22, member([e, w, e, w], [[e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(23, ['X' = [e, w, e, w], 'Rest' = [[e, w, e, w], [w, w, w, w]]]).
proof(23, member([e, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(22, member([e, w, e, w], [[e, w, e, w], [w, w, w, w]]))]).
substitution(24, []).
proof(24, solution([]), query, [uses(23, member([e, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(25, ['X' = e]).
proof(25, one_equal(e, e, e), rule(9), []).
substitution(26, ['Person' = e, 'Wolf' = e, 'Goat' = e, 'Cabbage' = w]).
proof(26, safe([e, e, e, w]), rule(11), [uses(25, one_equal(e, e, e)), uses(7, one_equal(e, e, w))]).
substitution(27, ['Person' = e, 'Wolf' = w, 'Goat' = e, 'Cabbage' = e]).
proof(27, safe([e, w, e, e]), rule(11), [uses(7, one_equal(e, e, w)), uses(25, one_equal(e, e, e))]).
substitution(28, ['X' = e, 'Goat' = e, 'Cabbage' = w, 'Y' = w]).
proof(28, move([e, e, e, w], wolf, [w, w, e, w]), rule(5), [uses(9, change(e, w))]).
substitution(29, ['X' = e, 'Wolf' = e, 'Cabbage' = w, 'Y' = w]).
proof(29, move([e, e, e, w], goat, [w, e, w, w]), rule(6), [uses(9, change(e, w))]).
substitution(30, ['X' = e, 'Wolf' = e, 'Goat' = e, 'Cabbage' = w, 'Y' = w]).
proof(30, move([e, e, e, w], nothing, [w, e, e, w]), rule(8), [uses(9, change(e, w))]).
substitution(31, ['X' = e, 'Wolf' = w, 'Cabbage' = e, 'Y' = w]).
proof(31, move([e, w, e, e], goat, [w, w, w, e]), rule(6), [uses(9, change(e, w))]).
substitution(32, ['X' = e, 'Wolf' = w, 'Goat' = e, 'Y' = w]).
proof(32, move([e, w, e, e], cabbage, [w, w, e, w]), rule(7), [uses(9, change(e, w))]).
substitution(33, ['X' = e, 'Wolf' = w, 'Goat' = e, 'Cabbage' = e, 'Y' = w]).
proof(33, move([e, w, e, e], nothing, [w, w, e, e]), rule(8), [uses(9, change(e, w))]).
substitution(34, ['X' = [w, w, e, w]]).
proof(34, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(35, ['X' = [w, w, e, w], 'Rest' = [[w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(35, member([w, w, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(34, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(36, []).
proof(36, solution([]), query, [uses(35, member([w, w, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(37, ['X' = [w, w, e, w]]).
proof(37, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(38, ['X' = [w, w, e, w], 'Rest' = [[w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(38, member([w, w, e, w], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(37, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(39, []).
proof(39, solution([]), query, [uses(38, member([w, w, e, w], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(40, ['X' = w]).
proof(40, one_equal(w, w, e), rule(9), []).
substitution(41, ['Person' = w, 'Wolf' = e, 'Goat' = w, 'Cabbage' = w]).
proof(41, safe([w, e, w, w]), rule(11), [uses(40, one_equal(w, w, e)), uses(12, one_equal(w, w, w))]).
substitution(42, ['Person' = w, 'Wolf' = w, 'Goat' = w, 'Cabbage' = e]).
proof(42, safe([w, w, w, e]), rule(11), [uses(12, one_equal(w, w, w)), uses(40, one_equal(w, w, e))]).
substitution(43, ['X' = w, 'Wolf' = e, 'Cabbage' = w, 'Y' = e]).
proof(43, move([w, e, w, w], goat, [e, e, e, w]), rule(6), [uses(1, change(w, e))]).
substitution(44, ['X' = w, 'Wolf' = e, 'Goat' = w, 'Y' = e]).
proof(44, move([w, e, w, w], cabbage, [e, e, w, e]), rule(7), [uses(1, change(w, e))]).
substitution(45, ['X' = w, 'Wolf' = e, 'Goat' = w, 'Cabbage' = w, 'Y' = e]).
proof(45, move([w, e, w, w], nothing, [e, e, w, w]), rule(8), [uses(1, change(w, e))]).
substitution(46, ['X' = w, 'Goat' = w, 'Cabbage' = e, 'Y' = e]).
proof(46, move([w, w, w, e], wolf, [e, e, w, e]), rule(5), [uses(1, change(w, e))]).
substitution(47, ['X' = w, 'Wolf' = w, 'Cabbage' = e, 'Y' = e]).
proof(47, move([w, w, w, e], goat, [e, w, e, e]), rule(6), [uses(1, change(w, e))]).
substitution(48, ['X' = w, 'Wolf' = w, 'Goat' = w, 'Cabbage' = e, 'Y' = e]).
proof(48, move([w, w, w, e], nothing, [e, w, w, e]), rule(8), [uses(1, change(w, e))]).
substitution(49, ['X' = [e, e, e, w]]).
proof(49, member([e, e, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(50, ['X' = [e, e, e, w], 'Rest' = [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(50, member([e, e, e, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(49, member([e, e, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(51, []).
proof(51, solution([]), query, [uses(50, member([e, e, e, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(52, ['X' = [e, w, e, e]]).
proof(52, member([e, w, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(53, ['X' = [e, w, e, e], 'Rest' = [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(53, member([e, w, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(52, member([e, w, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(54, []).
proof(54, solution([]), query, [uses(53, member([e, w, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(55, ['Person' = e, 'Wolf' = e, 'Goat' = w, 'Cabbage' = e]).
proof(55, safe([e, e, w, e]), rule(11), [uses(6, one_equal(e, w, e)), uses(6, one_equal(e, w, e))]).
substitution(56, ['X' = e, 'Goat' = w, 'Cabbage' = e, 'Y' = w]).
proof(56, move([e, e, w, e], wolf, [w, w, w, e]), rule(5), [uses(9, change(e, w))]).
substitution(57, ['X' = e, 'Wolf' = e, 'Goat' = w, 'Y' = w]).
proof(57, move([e, e, w, e], cabbage, [w, e, w, w]), rule(7), [uses(9, change(e, w))]).
substitution(58, ['X' = e, 'Wolf' = e, 'Goat' = w, 'Cabbage' = e, 'Y' = w]).
proof(58, move([e, e, w, e], nothing, [w, e, w, e]), rule(8), [uses(9, change(e, w))]).
substitution(59, ['X' = [w, e, w, w]]).
proof(59, member([w, e, w, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(60, ['X' = [w, e, w, w], 'Rest' = [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(60, member([w, e, w, w], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(59, member([w, e, w, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(61, []).
proof(61, solution([]), query, [uses(60, member([w, e, w, w], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(62, ['X' = [w, w, w, e]]).
proof(62, member([w, w, w, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(63, ['X' = [w, w, w, e], 'Rest' = [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(63, member([w, w, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(62, member([w, w, w, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(64, []).
proof(64, solution([]), query, [uses(63, member([w, w, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(65, ['X' = [e, e, w, e]]).
proof(65, member([e, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(66, ['X' = [e, e, w, e], 'Rest' = [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(66, member([e, e, w, e], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(65, member([e, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(67, []).
proof(67, solution([]), query, [uses(66, member([e, e, w, e], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(68, ['Person' = w, 'Wolf' = e, 'Goat' = w, 'Cabbage' = e]).
proof(68, safe([w, e, w, e]), rule(11), [uses(40, one_equal(w, w, e)), uses(40, one_equal(w, w, e))]).
substitution(69, ['X' = [e, e, w, e]]).
proof(69, member([e, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(70, ['X' = [e, e, w, e], 'Rest' = [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(70, member([e, e, w, e], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(69, member([e, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(71, []).
proof(71, solution([]), query, [uses(70, member([e, e, w, e], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(72, ['X' = [w, w, w, e]]).
proof(72, member([w, w, w, e], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(73, ['X' = [w, w, w, e], 'Rest' = [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(73, member([w, w, w, e], [[e, w, e, e], [w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(72, member([w, w, w, e], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(74, []).
proof(74, solution([]), query, [uses(73, member([w, w, w, e], [[e, w, e, e], [w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(75, ['X' = [w, w, e, w]]).
proof(75, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(76, ['X' = [w, w, e, w], 'Rest' = [[w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(76, member([w, w, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(75, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(77, ['X' = [w, w, e, w], 'Rest' = [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(77, member([w, w, e, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(76, member([w, w, e, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(78, ['X' = [w, w, e, w], 'Rest' = [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(78, member([w, w, e, w], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(77, member([w, w, e, w], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(79, ['X' = [w, w, e, w], 'Rest' = [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(79, member([w, w, e, w], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(78, member([w, w, e, w], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(80, ['X' = [w, w, e, w], 'Rest' = [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(80, member([w, w, e, w], [[e, w, e, e], [w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(79, member([w, w, e, w], [[w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(81, []).
proof(81, solution([]), query, [uses(80, member([w, w, e, w], [[e, w, e, e], [w, w, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(82, ['X' = [w, w, e, w]]).
proof(82, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(83, ['X' = [w, w, e, w], 'Rest' = [[w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(83, member([w, w, e, w], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(82, member([w, w, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(84, ['X' = [w, w, e, w], 'Rest' = [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(84, member([w, w, e, w], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(83, member([w, w, e, w], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(85, ['X' = [w, w, e, w], 'Rest' = [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(85, member([w, w, e, w], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(84, member([w, w, e, w], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(86, ['X' = [w, w, e, w], 'Rest' = [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(86, member([w, w, e, w], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(85, member([w, w, e, w], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(87, ['X' = [w, w, e, w], 'Rest' = [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(87, member([w, w, e, w], [[e, e, e, w], [w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(86, member([w, w, e, w], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(88, []).
proof(88, solution([]), query, [uses(87, member([w, w, e, w], [[e, e, e, w], [w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(89, ['X' = [w, e, w, w]]).
proof(89, member([w, e, w, w], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(90, ['X' = [w, e, w, w], 'Rest' = [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(90, member([w, e, w, w], [[e, e, e, w], [w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(89, member([w, e, w, w], [[w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(91, []).
proof(91, solution([]), query, [uses(90, member([w, e, w, w], [[e, e, e, w], [w, e, w, w], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(92, ['X' = w, 'Wolf' = e, 'Cabbage' = e, 'Y' = e]).
proof(92, move([w, e, w, e], goat, [e, e, e, e]), rule(6), [uses(1, change(w, e))]).
substitution(93, ['X' = w, 'Wolf' = e, 'Goat' = w, 'Cabbage' = e, 'Y' = e]).
proof(93, move([w, e, w, e], nothing, [e, e, w, e]), rule(8), [uses(1, change(w, e))]).
substitution(94, ['X' = [e, e, w, e]]).
proof(94, member([e, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(95, ['X' = [e, e, w, e], 'Rest' = [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(95, member([e, e, w, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(94, member([e, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(96, []).
proof(96, solution([]), query, [uses(95, member([e, e, w, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(97, ['X' = [e, e, w, e]]).
proof(97, member([e, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(98, ['X' = [e, e, w, e], 'Rest' = [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(98, member([e, e, w, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(97, member([e, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(99, []).
proof(99, solution([]), query, [uses(98, member([e, e, w, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(100, ['Person' = e, 'Wolf' = e, 'Goat' = e, 'Cabbage' = e]).
proof(100, safe([e, e, e, e]), rule(11), [uses(25, one_equal(e, e, e)), uses(25, one_equal(e, e, e))]).
substitution(101, ['Goal' = [e, e, e, e]]).
proof(101, solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []), rule(12), []).
substitution(102, ['Goal' = [e, e, e, e]]).
proof(102, solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []), rule(12), []).
substitution(103, ['State' = [w, e, w, e], 'Goal' = [e, e, e, e], 'Visited' = [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = goat, 'Rest' = [], 'Next' = [e, e, e, e]]).
proof(103, solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]), rule(13), [uses(92, move([w, e, w, e], goat, [e, e, e, e])), uses(100, safe([e, e, e, e])), absent(member([e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(101, solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []))]).
substitution(104, ['X' = e, 'Goat' = e, 'Cabbage' = e, 'Y' = w]).
proof(104, move([e, e, e, e], wolf, [w, w, e, e]), rule(5), [uses(9, change(e, w))]).
substitution(105, ['X' = e, 'Wolf' = e, 'Cabbage' = e, 'Y' = w]).
proof(105, move([e, e, e, e], goat, [w, e, w, e]), rule(6), [uses(9, change(e, w))]).
substitution(106, ['X' = e, 'Wolf' = e, 'Goat' = e, 'Y' = w]).
proof(106, move([e, e, e, e], cabbage, [w, e, e, w]), rule(7), [uses(9, change(e, w))]).
substitution(107, ['X' = e, 'Wolf' = e, 'Goat' = e, 'Cabbage' = e, 'Y' = w]).
proof(107, move([e, e, e, e], nothing, [w, e, e, e]), rule(8), [uses(9, change(e, w))]).
substitution(108, ['State' = [w, e, w, e], 'Goal' = [e, e, e, e], 'Visited' = [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = goat, 'Rest' = [], 'Next' = [e, e, e, e]]).
proof(108, solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]), rule(13), [uses(92, move([w, e, w, e], goat, [e, e, e, e])), uses(100, safe([e, e, e, e])), absent(member([e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(102, solve([e, e, e, e], [e, e, e, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], []))]).
substitution(109, ['State' = [e, e, w, e], 'Goal' = [e, e, e, e], 'Visited' = [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = nothing, 'Rest' = [goat], 'Next' = [w, e, w, e]]).
proof(109, solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]), rule(13), [uses(58, move([e, e, w, e], nothing, [w, e, w, e])), uses(68, safe([w, e, w, e])), absent(member([w, e, w, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(103, solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]))]).
substitution(110, ['X' = [w, e, w, e]]).
proof(110, member([w, e, w, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(111, ['X' = [w, e, w, e], 'Rest' = [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(111, member([w, e, w, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(110, member([w, e, w, e], [[w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(112, []).
proof(112, solution([]), query, [uses(111, member([w, e, w, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(113, ['X' = [w, e, w, e]]).
proof(113, member([w, e, w, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(1), []).
substitution(114, ['X' = [w, e, w, e], 'Rest' = [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]]).
proof(114, member([w, e, w, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), rule(2), [uses(113, member([w, e, w, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(115, []).
proof(115, solution([]), query, [uses(114, member([w, e, w, e], [[e, e, e, e], [w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]))]).
substitution(116, ['State' = [e, e, w, e], 'Goal' = [e, e, e, e], 'Visited' = [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = nothing, 'Rest' = [goat], 'Next' = [w, e, w, e]]).
proof(116, solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]), rule(13), [uses(58, move([e, e, w, e], nothing, [w, e, w, e])), uses(68, safe([w, e, w, e])), absent(member([w, e, w, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(108, solve([w, e, w, e], [e, e, e, e], [[w, e, w, e], [e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat]))]).
substitution(117, ['State' = [w, e, w, w], 'Goal' = [e, e, e, e], 'Visited' = [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = cabbage, 'Rest' = [nothing, goat], 'Next' = [e, e, w, e]]).
proof(117, solve([w, e, w, w], [e, e, e, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, nothing, goat]), rule(13), [uses(44, move([w, e, w, w], cabbage, [e, e, w, e])), uses(55, safe([e, e, w, e])), absent(member([e, e, w, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(109, solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]))]).
substitution(118, ['State' = [w, w, w, e], 'Goal' = [e, e, e, e], 'Visited' = [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = wolf, 'Rest' = [nothing, goat], 'Next' = [e, e, w, e]]).
proof(118, solve([w, w, w, e], [e, e, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, nothing, goat]), rule(13), [uses(46, move([w, w, w, e], wolf, [e, e, w, e])), uses(55, safe([e, e, w, e])), absent(member([e, e, w, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(116, solve([e, e, w, e], [e, e, e, e], [[e, e, w, e], [w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [nothing, goat]))]).
substitution(119, ['State' = [e, e, e, w], 'Goal' = [e, e, e, e], 'Visited' = [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = goat, 'Rest' = [cabbage, nothing, goat], 'Next' = [w, e, w, w]]).
proof(119, solve([e, e, e, w], [e, e, e, e], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, cabbage, nothing, goat]), rule(13), [uses(29, move([e, e, e, w], goat, [w, e, w, w])), uses(41, safe([w, e, w, w])), absent(member([w, e, w, w], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(117, solve([w, e, w, w], [e, e, e, e], [[w, e, w, w], [e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, nothing, goat]))]).
substitution(120, ['State' = [e, w, e, e], 'Goal' = [e, e, e, e], 'Visited' = [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = goat, 'Rest' = [wolf, nothing, goat], 'Next' = [w, w, w, e]]).
proof(120, solve([e, w, e, e], [e, e, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, wolf, nothing, goat]), rule(13), [uses(31, move([e, w, e, e], goat, [w, w, w, e])), uses(42, safe([w, w, w, e])), absent(member([w, w, w, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(118, solve([w, w, w, e], [e, e, e, e], [[w, w, w, e], [e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, nothing, goat]))]).
substitution(121, ['State' = [w, w, e, w], 'Goal' = [e, e, e, e], 'Visited' = [[w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = wolf, 'Rest' = [goat, cabbage, nothing, goat], 'Next' = [e, e, e, w]]).
proof(121, solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, goat, cabbage, nothing, goat]), rule(13), [uses(19, move([w, w, e, w], wolf, [e, e, e, w])), uses(26, safe([e, e, e, w])), absent(member([e, e, e, w], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(119, solve([e, e, e, w], [e, e, e, e], [[e, e, e, w], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, cabbage, nothing, goat]))]).
substitution(122, ['State' = [w, w, e, w], 'Goal' = [e, e, e, e], 'Visited' = [[w, w, e, w], [e, w, e, w], [w, w, w, w]], 'Move' = cabbage, 'Rest' = [goat, wolf, nothing, goat], 'Next' = [e, w, e, e]]).
proof(122, solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, goat, wolf, nothing, goat]), rule(13), [uses(20, move([w, w, e, w], cabbage, [e, w, e, e])), uses(27, safe([e, w, e, e])), absent(member([e, w, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]]), complete), uses(120, solve([e, w, e, e], [e, e, e, e], [[e, w, e, e], [w, w, e, w], [e, w, e, w], [w, w, w, w]], [goat, wolf, nothing, goat]))]).
substitution(123, ['State' = [e, w, e, w], 'Goal' = [e, e, e, e], 'Visited' = [[e, w, e, w], [w, w, w, w]], 'Move' = nothing, 'Rest' = [wolf, goat, cabbage, nothing, goat], 'Next' = [w, w, e, w]]).
proof(123, solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, wolf, goat, cabbage, nothing, goat]), rule(13), [uses(11, move([e, w, e, w], nothing, [w, w, e, w])), uses(15, safe([w, w, e, w])), absent(member([w, w, e, w], [[e, w, e, w], [w, w, w, w]]), complete), uses(121, solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [wolf, goat, cabbage, nothing, goat]))]).
substitution(124, ['State' = [e, w, e, w], 'Goal' = [e, e, e, e], 'Visited' = [[e, w, e, w], [w, w, w, w]], 'Move' = nothing, 'Rest' = [cabbage, goat, wolf, nothing, goat], 'Next' = [w, w, e, w]]).
proof(124, solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, cabbage, goat, wolf, nothing, goat]), rule(13), [uses(11, move([e, w, e, w], nothing, [w, w, e, w])), uses(15, safe([w, w, e, w])), absent(member([w, w, e, w], [[e, w, e, w], [w, w, w, w]]), complete), uses(122, solve([w, w, e, w], [e, e, e, e], [[w, w, e, w], [e, w, e, w], [w, w, w, w]], [cabbage, goat, wolf, nothing, goat]))]).
substitution(125, ['State' = [w, w, w, w], 'Goal' = [e, e, e, e], 'Visited' = [[w, w, w, w]], 'Move' = goat, 'Rest' = [nothing, wolf, goat, cabbage, nothing, goat], 'Next' = [e, w, e, w]]).
proof(125, solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, wolf, goat, cabbage, nothing, goat]), rule(13), [uses(3, move([w, w, w, w], goat, [e, w, e, w])), uses(8, safe([e, w, e, w])), absent(member([e, w, e, w], [[w, w, w, w]]), complete), uses(123, solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, wolf, goat, cabbage, nothing, goat]))]).
substitution(126, ['State' = [w, w, w, w], 'Goal' = [e, e, e, e], 'Visited' = [[w, w, w, w]], 'Move' = goat, 'Rest' = [nothing, cabbage, goat, wolf, nothing, goat], 'Next' = [e, w, e, w]]).
proof(126, solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, cabbage, goat, wolf, nothing, goat]), rule(13), [uses(3, move([w, w, w, w], goat, [e, w, e, w])), uses(8, safe([e, w, e, w])), absent(member([e, w, e, w], [[w, w, w, w]]), complete), uses(124, solve([e, w, e, w], [e, e, e, e], [[e, w, e, w], [w, w, w, w]], [nothing, cabbage, goat, wolf, nothing, goat]))]).
substitution(127, ['Moves' = [goat, nothing, wolf, goat, cabbage, nothing, goat]]).
proof(127, solution([goat, nothing, wolf, goat, cabbage, nothing, goat]), rule(14), [uses(125, solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, wolf, goat, cabbage, nothing, goat])), builtin(length([goat, nothing, wolf, goat, cabbage, nothing, goat], 7))]).
substitution(128, ['Moves' = [goat, nothing, cabbage, goat, wolf, nothing, goat]]).
proof(128, solution([goat, nothing, cabbage, goat, wolf, nothing, goat]), rule(14), [uses(126, solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], [goat, nothing, cabbage, goat, wolf, nothing, goat])), builtin(length([goat, nothing, cabbage, goat, wolf, nothing, goat], 7))]).
substitution(129, ['Moves' = [goat, nothing, wolf, goat, cabbage, nothing, goat]]).
proof(129, solution([[goat, nothing, wolf, goat, cabbage, nothing, goat]]), query, [uses(127, solution([goat, nothing, wolf, goat, cabbage, nothing, goat]))]).
substitution(130, ['Moves' = [goat, nothing, cabbage, goat, wolf, nothing, goat]]).
proof(130, solution([[goat, nothing, cabbage, goat, wolf, nothing, goat]]), query, [uses(128, solution([goat, nothing, cabbage, goat, wolf, nothing, goat]))]).
