% Prolog result format 3
query(1, best(a, d, _0, _1), ['Path' = _0, 'Cost' = _1]).
result(1, complete, 1).
answer(1, ['Path' = [a, b, c, d], 'Cost' = 5]).
why(1, ['Path' = [a, b, c, d], 'Cost' = 5], 61).
clause(1, edge(a, b, 2), true).
clause(2, edge(a, c, 5), true).
clause(3, edge(b, c, 1), true).
clause(4, edge(b, d, 7), true).
clause(5, edge(c, d, 2), true).
clause(6, edge(c, a, 1), true).
clause(7, member(var('X'), [var('X')|anonymous(1)]), true).
clause(8, member(var('X'), [anonymous(1)|var('Rest')]), member(var('X'), var('Rest'))).
clause(9, route(var('Goal'), var('Goal'), anonymous(1), [var('Goal')], 0), true).
clause(10, route(var('From'), var('Goal'), var('Visited'), [var('From')|var('Path')], var('Cost')), (edge(var('From'), var('Next'), var('Step')), \+member(var('Next'), var('Visited')), route(var('Next'), var('Goal'), [var('Next')|var('Visited')], var('Path'), var('Remaining')), var('Cost') is var('Step') + var('Remaining'))).
clause(11, best(var('From'), var('To'), var('Path'), var('Cost')), (findall(var('Candidate'), route(var('From'), var('To'), [var('From')], anonymous(1), var('Candidate')), var('Bag1')), sort(var('Bag1'), var('Costs')), min_list(var('Costs'), var('Cost')), route(var('From'), var('To'), [var('From')], var('Path'), var('Cost')))).
substitution(1, []).
proof(1, edge(a, b, 2), rule(1), []).
substitution(2, []).
proof(2, edge(a, c, 5), rule(2), []).
substitution(3, []).
proof(3, edge(b, c, 1), rule(3), []).
substitution(4, []).
proof(4, edge(b, d, 7), rule(4), []).
substitution(5, []).
proof(5, edge(c, d, 2), rule(5), []).
substitution(6, []).
proof(6, edge(c, a, 1), rule(6), []).
substitution(7, ['X' = a]).
proof(7, member(a, [a]), rule(7), []).
substitution(8, ['X' = a, 'Rest' = [a]]).
proof(8, member(a, [c, a]), rule(8), [uses(7, member(a, [a]))]).
substitution(9, []).
proof(9, solution([]), query, [uses(8, member(a, [c, a]))]).
substitution(10, ['X' = a]).
proof(10, member(a, [a]), rule(7), []).
substitution(11, ['X' = a, 'Rest' = [a]]).
proof(11, member(a, [b, a]), rule(8), [uses(10, member(a, [a]))]).
substitution(12, ['X' = a, 'Rest' = [b, a]]).
proof(12, member(a, [c, b, a]), rule(8), [uses(11, member(a, [b, a]))]).
substitution(13, []).
proof(13, solution([]), query, [uses(12, member(a, [c, b, a]))]).
substitution(14, ['Goal' = d]).
proof(14, route(d, d, [d, b, a], [d], 0), rule(9), []).
substitution(15, ['Goal' = d]).
proof(15, route(d, d, [d, c, a], [d], 0), rule(9), []).
substitution(16, ['Goal' = d]).
proof(16, route(d, d, [d, c, b, a], [d], 0), rule(9), []).
substitution(17, ['From' = b, 'Goal' = d, 'Visited' = [b, a], 'Path' = [d], 'Cost' = 7, 'Next' = d, 'Step' = 7, 'Remaining' = 0]).
proof(17, route(b, d, [b, a], [b, d], 7), rule(10), [uses(4, edge(b, d, 7)), absent(member(d, [b, a]), complete), uses(14, route(d, d, [d, b, a], [d], 0)), builtin(7 is 7 + 0)]).
substitution(18, ['From' = c, 'Goal' = d, 'Visited' = [c, a], 'Path' = [d], 'Cost' = 2, 'Next' = d, 'Step' = 2, 'Remaining' = 0]).
proof(18, route(c, d, [c, a], [c, d], 2), rule(10), [uses(5, edge(c, d, 2)), absent(member(d, [c, a]), complete), uses(15, route(d, d, [d, c, a], [d], 0)), builtin(2 is 2 + 0)]).
substitution(19, ['From' = c, 'Goal' = d, 'Visited' = [c, b, a], 'Path' = [d], 'Cost' = 2, 'Next' = d, 'Step' = 2, 'Remaining' = 0]).
proof(19, route(c, d, [c, b, a], [c, d], 2), rule(10), [uses(5, edge(c, d, 2)), absent(member(d, [c, b, a]), complete), uses(16, route(d, d, [d, c, b, a], [d], 0)), builtin(2 is 2 + 0)]).
substitution(20, ['From' = a, 'Goal' = d, 'Visited' = [a], 'Path' = [b, d], 'Cost' = 9, 'Next' = b, 'Step' = 2, 'Remaining' = 7]).
proof(20, route(a, d, [a], [a, b, d], 9), rule(10), [uses(1, edge(a, b, 2)), absent(member(b, [a]), complete), uses(17, route(b, d, [b, a], [b, d], 7)), builtin(9 is 2 + 7)]).
substitution(21, ['From' = a, 'Goal' = d, 'Visited' = [a], 'Path' = [c, d], 'Cost' = 7, 'Next' = c, 'Step' = 5, 'Remaining' = 2]).
proof(21, route(a, d, [a], [a, c, d], 7), rule(10), [uses(2, edge(a, c, 5)), absent(member(c, [a]), complete), uses(18, route(c, d, [c, a], [c, d], 2)), builtin(7 is 5 + 2)]).
substitution(22, ['From' = b, 'Goal' = d, 'Visited' = [b, a], 'Path' = [c, d], 'Cost' = 3, 'Next' = c, 'Step' = 1, 'Remaining' = 2]).
proof(22, route(b, d, [b, a], [b, c, d], 3), rule(10), [uses(3, edge(b, c, 1)), absent(member(c, [b, a]), complete), uses(19, route(c, d, [c, b, a], [c, d], 2)), builtin(3 is 1 + 2)]).
substitution(23, ['Candidate' = 9]).
proof(23, solution([9]), query, [uses(20, route(a, d, [a], [a, b, d], 9))]).
substitution(24, ['Candidate' = 7]).
proof(24, solution([7]), query, [uses(21, route(a, d, [a], [a, c, d], 7))]).
substitution(25, ['From' = a, 'Goal' = d, 'Visited' = [a], 'Path' = [b, c, d], 'Cost' = 5, 'Next' = b, 'Step' = 2, 'Remaining' = 3]).
proof(25, route(a, d, [a], [a, b, c, d], 5), rule(10), [uses(1, edge(a, b, 2)), absent(member(b, [a]), complete), uses(22, route(b, d, [b, a], [b, c, d], 3)), builtin(5 is 2 + 3)]).
substitution(26, ['Candidate' = 5]).
proof(26, solution([5]), query, [uses(25, route(a, d, [a], [a, b, c, d], 5))]).
substitution(27, []).
proof(27, edge(a, b, 2), rule(1), []).
substitution(28, []).
proof(28, edge(a, c, 5), rule(2), []).
substitution(29, []).
proof(29, edge(b, c, 1), rule(3), []).
substitution(30, []).
proof(30, edge(b, d, 7), rule(4), []).
substitution(31, []).
proof(31, edge(c, d, 2), rule(5), []).
substitution(32, []).
proof(32, edge(c, a, 1), rule(6), []).
substitution(33, ['Goal' = d]).
proof(33, route(d, d, [d, b, a], [d], 0), rule(9), []).
substitution(34, ['Goal' = d]).
proof(34, route(d, d, [d, c, a], [d], 0), rule(9), []).
substitution(35, ['Goal' = d]).
proof(35, route(d, d, [d, c, b, a], [d], 0), rule(9), []).
substitution(36, ['From' = b, 'Goal' = d, 'Visited' = [b, a], 'Path' = [d], 'Cost' = 7, 'Next' = d, 'Step' = 7, 'Remaining' = 0]).
proof(36, route(b, d, [b, a], [b, d], 7), rule(10), [uses(30, edge(b, d, 7)), absent(member(d, [b, a]), complete), uses(33, route(d, d, [d, b, a], [d], 0)), builtin(7 is 7 + 0)]).
substitution(37, ['From' = c, 'Goal' = d, 'Visited' = [c, a], 'Path' = [d], 'Cost' = 2, 'Next' = d, 'Step' = 2, 'Remaining' = 0]).
proof(37, route(c, d, [c, a], [c, d], 2), rule(10), [uses(31, edge(c, d, 2)), absent(member(d, [c, a]), complete), uses(34, route(d, d, [d, c, a], [d], 0)), builtin(2 is 2 + 0)]).
substitution(38, ['From' = c, 'Goal' = d, 'Visited' = [c, b, a], 'Path' = [d], 'Cost' = 2, 'Next' = d, 'Step' = 2, 'Remaining' = 0]).
proof(38, route(c, d, [c, b, a], [c, d], 2), rule(10), [uses(31, edge(c, d, 2)), absent(member(d, [c, b, a]), complete), uses(35, route(d, d, [d, c, b, a], [d], 0)), builtin(2 is 2 + 0)]).
substitution(39, ['From' = b, 'Goal' = d, 'Visited' = [b, a], 'Path' = [c, d], 'Cost' = 3, 'Next' = c, 'Step' = 1, 'Remaining' = 2]).
proof(39, route(b, d, [b, a], [b, c, d], 3), rule(10), [uses(29, edge(b, c, 1)), absent(member(c, [b, a]), complete), uses(38, route(c, d, [c, b, a], [c, d], 2)), builtin(3 is 1 + 2)]).
substitution(40, ['From' = a, 'Goal' = d, 'Visited' = [a], 'Path' = [b, c, d], 'Cost' = 5, 'Next' = b, 'Step' = 2, 'Remaining' = 3]).
proof(40, route(a, d, [a], [a, b, c, d], 5), rule(10), [uses(27, edge(a, b, 2)), absent(member(b, [a]), complete), uses(39, route(b, d, [b, a], [b, c, d], 3)), builtin(5 is 2 + 3)]).
substitution(41, []).
proof(41, edge(a, b, 2), rule(1), []).
substitution(42, []).
proof(42, edge(a, c, 5), rule(2), []).
substitution(43, []).
proof(43, edge(b, c, 1), rule(3), []).
substitution(44, []).
proof(44, edge(b, d, 7), rule(4), []).
substitution(45, []).
proof(45, edge(c, d, 2), rule(5), []).
substitution(46, []).
proof(46, edge(c, a, 1), rule(6), []).
substitution(47, ['Goal' = d]).
proof(47, route(d, d, [d, b, a], [d], 0), rule(9), []).
substitution(48, ['Goal' = d]).
proof(48, route(d, d, [d, c, a], [d], 0), rule(9), []).
substitution(49, ['Goal' = d]).
proof(49, route(d, d, [d, c, b, a], [d], 0), rule(9), []).
substitution(50, ['From' = b, 'Goal' = d, 'Visited' = [b, a], 'Path' = [d], 'Cost' = 7, 'Next' = d, 'Step' = 7, 'Remaining' = 0]).
proof(50, route(b, d, [b, a], [b, d], 7), rule(10), [uses(44, edge(b, d, 7)), absent(member(d, [b, a]), complete), uses(47, route(d, d, [d, b, a], [d], 0)), builtin(7 is 7 + 0)]).
substitution(51, ['From' = c, 'Goal' = d, 'Visited' = [c, a], 'Path' = [d], 'Cost' = 2, 'Next' = d, 'Step' = 2, 'Remaining' = 0]).
proof(51, route(c, d, [c, a], [c, d], 2), rule(10), [uses(45, edge(c, d, 2)), absent(member(d, [c, a]), complete), uses(48, route(d, d, [d, c, a], [d], 0)), builtin(2 is 2 + 0)]).
substitution(52, ['From' = c, 'Goal' = d, 'Visited' = [c, b, a], 'Path' = [d], 'Cost' = 2, 'Next' = d, 'Step' = 2, 'Remaining' = 0]).
proof(52, route(c, d, [c, b, a], [c, d], 2), rule(10), [uses(45, edge(c, d, 2)), absent(member(d, [c, b, a]), complete), uses(49, route(d, d, [d, c, b, a], [d], 0)), builtin(2 is 2 + 0)]).
substitution(53, ['From' = a, 'Goal' = d, 'Visited' = [a], 'Path' = [b, d], 'Cost' = 9, 'Next' = b, 'Step' = 2, 'Remaining' = 7]).
proof(53, route(a, d, [a], [a, b, d], 9), rule(10), [uses(41, edge(a, b, 2)), absent(member(b, [a]), complete), uses(50, route(b, d, [b, a], [b, d], 7)), builtin(9 is 2 + 7)]).
substitution(54, ['From' = a, 'Goal' = d, 'Visited' = [a], 'Path' = [c, d], 'Cost' = 7, 'Next' = c, 'Step' = 5, 'Remaining' = 2]).
proof(54, route(a, d, [a], [a, c, d], 7), rule(10), [uses(42, edge(a, c, 5)), absent(member(c, [a]), complete), uses(51, route(c, d, [c, a], [c, d], 2)), builtin(7 is 5 + 2)]).
substitution(55, ['From' = b, 'Goal' = d, 'Visited' = [b, a], 'Path' = [c, d], 'Cost' = 3, 'Next' = c, 'Step' = 1, 'Remaining' = 2]).
proof(55, route(b, d, [b, a], [b, c, d], 3), rule(10), [uses(43, edge(b, c, 1)), absent(member(c, [b, a]), complete), uses(52, route(c, d, [c, b, a], [c, d], 2)), builtin(3 is 1 + 2)]).
substitution(56, ['Candidate' = 9]).
proof(56, solution([9]), query, [uses(53, route(a, d, [a], [a, b, d], 9))]).
substitution(57, ['Candidate' = 7]).
proof(57, solution([7]), query, [uses(54, route(a, d, [a], [a, c, d], 7))]).
substitution(58, ['From' = a, 'Goal' = d, 'Visited' = [a], 'Path' = [b, c, d], 'Cost' = 5, 'Next' = b, 'Step' = 2, 'Remaining' = 3]).
proof(58, route(a, d, [a], [a, b, c, d], 5), rule(10), [uses(41, edge(a, b, 2)), absent(member(b, [a]), complete), uses(55, route(b, d, [b, a], [b, c, d], 3)), builtin(5 is 2 + 3)]).
substitution(59, ['Candidate' = 5]).
proof(59, solution([5]), query, [uses(58, route(a, d, [a], [a, b, c, d], 5))]).
substitution(60, ['From' = a, 'To' = d, 'Path' = [a, b, c, d], 'Cost' = 5, 'Candidate' = _0, 'Bag1' = [9, 7, 5], 'Costs' = [5, 7, 9]]).
proof(60, best(a, d, [a, b, c, d], 5), rule(11), [collected([9, 7, 5], _0, route(a, d, [a], _1, _0), [56, 57, 59], complete), builtin(sort([9, 7, 5], [5, 7, 9])), builtin(min_list([5, 7, 9], 5)), uses(40, route(a, d, [a], [a, b, c, d], 5))]).
substitution(61, ['Path' = [a, b, c, d], 'Cost' = 5]).
proof(61, solution([[a, b, c, d], 5]), query, [uses(60, best(a, d, [a, b, c, d], 5))]).
