% Prolog result format 3
query(1, best(a, f, _0, _1), ['Path' = _0, 'Cost' = _1]).
result(1, complete, 1).
answer(1, ['Path' = [a, c, b, d, e, f], 'Cost' = 13]).
why(1, ['Path' = [a, c, b, d, e, f], 'Cost' = 13], 646).
clause(1, edge(a, b, 4), true).
clause(2, edge(a, c, 2), true).
clause(3, edge(b, c, 1), true).
clause(4, edge(b, d, 5), true).
clause(5, edge(c, d, 8), true).
clause(6, edge(c, e, 10), true).
clause(7, edge(d, e, 2), true).
clause(8, edge(d, f, 6), true).
clause(9, edge(e, f, 3), true).
clause(10, connected(var('Right'), var('Left'), var('Weight')), edge(var('Left'), var('Right'), var('Weight'))).
clause(11, connected(var('Left'), var('Right'), var('Weight')), edge(var('Left'), var('Right'), var('Weight'))).
clause(12, member(var('X'), [var('X')|anonymous(1)]), true).
clause(13, member(var('X'), [anonymous(1)|var('Rest')]), member(var('X'), var('Rest'))).
clause(14, route(var('Goal'), var('Goal'), anonymous(1), [var('Goal')], 0), true).
clause(15, route(var('From'), var('Goal'), var('Visited'), [var('From')|var('Path')], var('Cost')), (connected(var('From'), var('Next'), var('Step')), \+member(var('Next'), var('Visited')), route(var('Next'), var('Goal'), [var('Next')|var('Visited')], var('Path'), var('Remaining')), var('Cost') is var('Step') + var('Remaining'))).
clause(16, best(var('From'), var('To'), var('Path'), var('Cost')), (findall(var('Candidate'), route(var('From'), var('To'), [var('From')], anonymous(1), var('Candidate')), var('Bag1')), sort(var('Bag1'), var('Costs')), min_list(var('Costs'), var('Cost')), route(var('From'), var('To'), [var('From')], var('Path'), var('Cost')))).
substitution(1, []).
proof(1, edge(a, b, 4), rule(1), []).
substitution(2, []).
proof(2, edge(a, c, 2), rule(2), []).
substitution(3, ['Left' = a, 'Right' = b, 'Weight' = 4]).
proof(3, connected(a, b, 4), rule(11), [uses(1, edge(a, b, 4))]).
substitution(4, ['Left' = a, 'Right' = c, 'Weight' = 2]).
proof(4, connected(a, c, 2), rule(11), [uses(2, edge(a, c, 2))]).
substitution(5, []).
proof(5, edge(a, b, 4), rule(1), []).
substitution(6, []).
proof(6, edge(b, c, 1), rule(3), []).
substitution(7, []).
proof(7, edge(b, d, 5), rule(4), []).
substitution(8, []).
proof(8, edge(a, c, 2), rule(2), []).
substitution(9, []).
proof(9, edge(b, c, 1), rule(3), []).
substitution(10, []).
proof(10, edge(c, d, 8), rule(5), []).
substitution(11, []).
proof(11, edge(c, e, 10), rule(6), []).
substitution(12, ['Right' = b, 'Left' = a, 'Weight' = 4]).
proof(12, connected(b, a, 4), rule(10), [uses(5, edge(a, b, 4))]).
substitution(13, ['Left' = b, 'Right' = c, 'Weight' = 1]).
proof(13, connected(b, c, 1), rule(11), [uses(6, edge(b, c, 1))]).
substitution(14, ['Left' = b, 'Right' = d, 'Weight' = 5]).
proof(14, connected(b, d, 5), rule(11), [uses(7, edge(b, d, 5))]).
substitution(15, ['Right' = c, 'Left' = a, 'Weight' = 2]).
proof(15, connected(c, a, 2), rule(10), [uses(8, edge(a, c, 2))]).
substitution(16, ['Right' = c, 'Left' = b, 'Weight' = 1]).
proof(16, connected(c, b, 1), rule(10), [uses(9, edge(b, c, 1))]).
substitution(17, ['Left' = c, 'Right' = d, 'Weight' = 8]).
proof(17, connected(c, d, 8), rule(11), [uses(10, edge(c, d, 8))]).
substitution(18, ['Left' = c, 'Right' = e, 'Weight' = 10]).
proof(18, connected(c, e, 10), rule(11), [uses(11, edge(c, e, 10))]).
substitution(19, ['X' = a]).
proof(19, member(a, [a]), rule(12), []).
substitution(20, ['X' = a, 'Rest' = [a]]).
proof(20, member(a, [b, a]), rule(13), [uses(19, member(a, [a]))]).
substitution(21, []).
proof(21, solution([]), query, [uses(20, member(a, [b, a]))]).
substitution(22, ['X' = a]).
proof(22, member(a, [a]), rule(12), []).
substitution(23, ['X' = a, 'Rest' = [a]]).
proof(23, member(a, [c, a]), rule(13), [uses(22, member(a, [a]))]).
substitution(24, []).
proof(24, solution([]), query, [uses(23, member(a, [c, a]))]).
substitution(25, ['X' = a]).
proof(25, member(a, [a]), rule(12), []).
substitution(26, ['X' = a, 'Rest' = [a]]).
proof(26, member(a, [b, a]), rule(13), [uses(25, member(a, [a]))]).
substitution(27, ['X' = a, 'Rest' = [b, a]]).
proof(27, member(a, [c, b, a]), rule(13), [uses(26, member(a, [b, a]))]).
substitution(28, []).
proof(28, solution([]), query, [uses(27, member(a, [c, b, a]))]).
substitution(29, ['X' = b]).
proof(29, member(b, [b, a]), rule(12), []).
substitution(30, ['X' = b, 'Rest' = [b, a]]).
proof(30, member(b, [c, b, a]), rule(13), [uses(29, member(b, [b, a]))]).
substitution(31, []).
proof(31, solution([]), query, [uses(30, member(b, [c, b, a]))]).
substitution(32, ['X' = a]).
proof(32, member(a, [a]), rule(12), []).
substitution(33, ['X' = a, 'Rest' = [a]]).
proof(33, member(a, [c, a]), rule(13), [uses(32, member(a, [a]))]).
substitution(34, ['X' = a, 'Rest' = [c, a]]).
proof(34, member(a, [b, c, a]), rule(13), [uses(33, member(a, [c, a]))]).
substitution(35, []).
proof(35, solution([]), query, [uses(34, member(a, [b, c, a]))]).
substitution(36, ['X' = c]).
proof(36, member(c, [c, a]), rule(12), []).
substitution(37, ['X' = c, 'Rest' = [c, a]]).
proof(37, member(c, [b, c, a]), rule(13), [uses(36, member(c, [c, a]))]).
substitution(38, []).
proof(38, solution([]), query, [uses(37, member(c, [b, c, a]))]).
substitution(39, []).
proof(39, edge(b, d, 5), rule(4), []).
substitution(40, []).
proof(40, edge(c, d, 8), rule(5), []).
substitution(41, []).
proof(41, edge(d, e, 2), rule(7), []).
substitution(42, []).
proof(42, edge(d, f, 6), rule(8), []).
substitution(43, []).
proof(43, edge(c, e, 10), rule(6), []).
substitution(44, []).
proof(44, edge(d, e, 2), rule(7), []).
substitution(45, []).
proof(45, edge(e, f, 3), rule(9), []).
substitution(46, ['Right' = d, 'Left' = b, 'Weight' = 5]).
proof(46, connected(d, b, 5), rule(10), [uses(39, edge(b, d, 5))]).
substitution(47, ['Right' = d, 'Left' = c, 'Weight' = 8]).
proof(47, connected(d, c, 8), rule(10), [uses(40, edge(c, d, 8))]).
substitution(48, ['Left' = d, 'Right' = e, 'Weight' = 2]).
proof(48, connected(d, e, 2), rule(11), [uses(41, edge(d, e, 2))]).
substitution(49, ['Left' = d, 'Right' = f, 'Weight' = 6]).
proof(49, connected(d, f, 6), rule(11), [uses(42, edge(d, f, 6))]).
substitution(50, ['Right' = e, 'Left' = c, 'Weight' = 10]).
proof(50, connected(e, c, 10), rule(10), [uses(43, edge(c, e, 10))]).
substitution(51, ['Right' = e, 'Left' = d, 'Weight' = 2]).
proof(51, connected(e, d, 2), rule(10), [uses(44, edge(d, e, 2))]).
substitution(52, ['Left' = e, 'Right' = f, 'Weight' = 3]).
proof(52, connected(e, f, 3), rule(11), [uses(45, edge(e, f, 3))]).
substitution(53, ['X' = b]).
proof(53, member(b, [b, a]), rule(12), []).
substitution(54, ['X' = b, 'Rest' = [b, a]]).
proof(54, member(b, [d, b, a]), rule(13), [uses(53, member(b, [b, a]))]).
substitution(55, []).
proof(55, solution([]), query, [uses(54, member(b, [d, b, a]))]).
substitution(56, ['X' = c]).
proof(56, member(c, [c, a]), rule(12), []).
substitution(57, ['X' = c, 'Rest' = [c, a]]).
proof(57, member(c, [d, c, a]), rule(13), [uses(56, member(c, [c, a]))]).
substitution(58, []).
proof(58, solution([]), query, [uses(57, member(c, [d, c, a]))]).
substitution(59, ['X' = b]).
proof(59, member(b, [b, a]), rule(12), []).
substitution(60, ['X' = b, 'Rest' = [b, a]]).
proof(60, member(b, [c, b, a]), rule(13), [uses(59, member(b, [b, a]))]).
substitution(61, ['X' = b, 'Rest' = [c, b, a]]).
proof(61, member(b, [d, c, b, a]), rule(13), [uses(60, member(b, [c, b, a]))]).
substitution(62, []).
proof(62, solution([]), query, [uses(61, member(b, [d, c, b, a]))]).
substitution(63, ['X' = c]).
proof(63, member(c, [c, b, a]), rule(12), []).
substitution(64, ['X' = c, 'Rest' = [c, b, a]]).
proof(64, member(c, [d, c, b, a]), rule(13), [uses(63, member(c, [c, b, a]))]).
substitution(65, []).
proof(65, solution([]), query, [uses(64, member(c, [d, c, b, a]))]).
substitution(66, ['X' = b]).
proof(66, member(b, [b, c, a]), rule(12), []).
substitution(67, ['X' = b, 'Rest' = [b, c, a]]).
proof(67, member(b, [d, b, c, a]), rule(13), [uses(66, member(b, [b, c, a]))]).
substitution(68, []).
proof(68, solution([]), query, [uses(67, member(b, [d, b, c, a]))]).
substitution(69, ['X' = c]).
proof(69, member(c, [c, a]), rule(12), []).
substitution(70, ['X' = c, 'Rest' = [c, a]]).
proof(70, member(c, [b, c, a]), rule(13), [uses(69, member(c, [c, a]))]).
substitution(71, ['X' = c, 'Rest' = [b, c, a]]).
proof(71, member(c, [d, b, c, a]), rule(13), [uses(70, member(c, [b, c, a]))]).
substitution(72, []).
proof(72, solution([]), query, [uses(71, member(c, [d, b, c, a]))]).
substitution(73, ['X' = c]).
proof(73, member(c, [c, a]), rule(12), []).
substitution(74, ['X' = c, 'Rest' = [c, a]]).
proof(74, member(c, [e, c, a]), rule(13), [uses(73, member(c, [c, a]))]).
substitution(75, []).
proof(75, solution([]), query, [uses(74, member(c, [e, c, a]))]).
substitution(76, ['X' = c]).
proof(76, member(c, [c, b, a]), rule(12), []).
substitution(77, ['X' = c, 'Rest' = [c, b, a]]).
proof(77, member(c, [e, c, b, a]), rule(13), [uses(76, member(c, [c, b, a]))]).
substitution(78, []).
proof(78, solution([]), query, [uses(77, member(c, [e, c, b, a]))]).
substitution(79, ['X' = a]).
proof(79, member(a, [a]), rule(12), []).
substitution(80, ['X' = a, 'Rest' = [a]]).
proof(80, member(a, [b, a]), rule(13), [uses(79, member(a, [a]))]).
substitution(81, ['X' = a, 'Rest' = [b, a]]).
proof(81, member(a, [d, b, a]), rule(13), [uses(80, member(a, [b, a]))]).
substitution(82, ['X' = a, 'Rest' = [d, b, a]]).
proof(82, member(a, [c, d, b, a]), rule(13), [uses(81, member(a, [d, b, a]))]).
substitution(83, []).
proof(83, solution([]), query, [uses(82, member(a, [c, d, b, a]))]).
substitution(84, ['X' = b]).
proof(84, member(b, [b, a]), rule(12), []).
substitution(85, ['X' = b, 'Rest' = [b, a]]).
proof(85, member(b, [d, b, a]), rule(13), [uses(84, member(b, [b, a]))]).
substitution(86, ['X' = b, 'Rest' = [d, b, a]]).
proof(86, member(b, [c, d, b, a]), rule(13), [uses(85, member(b, [d, b, a]))]).
substitution(87, []).
proof(87, solution([]), query, [uses(86, member(b, [c, d, b, a]))]).
substitution(88, ['X' = d]).
proof(88, member(d, [d, b, a]), rule(12), []).
substitution(89, ['X' = d, 'Rest' = [d, b, a]]).
proof(89, member(d, [c, d, b, a]), rule(13), [uses(88, member(d, [d, b, a]))]).
substitution(90, []).
proof(90, solution([]), query, [uses(89, member(d, [c, d, b, a]))]).
substitution(91, ['X' = d]).
proof(91, member(d, [d, b, a]), rule(12), []).
substitution(92, ['X' = d, 'Rest' = [d, b, a]]).
proof(92, member(d, [e, d, b, a]), rule(13), [uses(91, member(d, [d, b, a]))]).
substitution(93, []).
proof(93, solution([]), query, [uses(92, member(d, [e, d, b, a]))]).
substitution(94, ['Goal' = f]).
proof(94, route(f, f, [f, d, b, a], [f], 0), rule(14), []).
substitution(95, ['X' = a]).
proof(95, member(a, [a]), rule(12), []).
substitution(96, ['X' = a, 'Rest' = [a]]).
proof(96, member(a, [c, a]), rule(13), [uses(95, member(a, [a]))]).
substitution(97, ['X' = a, 'Rest' = [c, a]]).
proof(97, member(a, [d, c, a]), rule(13), [uses(96, member(a, [c, a]))]).
substitution(98, ['X' = a, 'Rest' = [d, c, a]]).
proof(98, member(a, [b, d, c, a]), rule(13), [uses(97, member(a, [d, c, a]))]).
substitution(99, []).
proof(99, solution([]), query, [uses(98, member(a, [b, d, c, a]))]).
substitution(100, ['X' = c]).
proof(100, member(c, [c, a]), rule(12), []).
substitution(101, ['X' = c, 'Rest' = [c, a]]).
proof(101, member(c, [d, c, a]), rule(13), [uses(100, member(c, [c, a]))]).
substitution(102, ['X' = c, 'Rest' = [d, c, a]]).
proof(102, member(c, [b, d, c, a]), rule(13), [uses(101, member(c, [d, c, a]))]).
substitution(103, []).
proof(103, solution([]), query, [uses(102, member(c, [b, d, c, a]))]).
substitution(104, ['X' = d]).
proof(104, member(d, [d, c, a]), rule(12), []).
substitution(105, ['X' = d, 'Rest' = [d, c, a]]).
proof(105, member(d, [b, d, c, a]), rule(13), [uses(104, member(d, [d, c, a]))]).
substitution(106, []).
proof(106, solution([]), query, [uses(105, member(d, [b, d, c, a]))]).
substitution(107, ['X' = c]).
proof(107, member(c, [c, a]), rule(12), []).
substitution(108, ['X' = c, 'Rest' = [c, a]]).
proof(108, member(c, [d, c, a]), rule(13), [uses(107, member(c, [c, a]))]).
substitution(109, ['X' = c, 'Rest' = [d, c, a]]).
proof(109, member(c, [e, d, c, a]), rule(13), [uses(108, member(c, [d, c, a]))]).
substitution(110, []).
proof(110, solution([]), query, [uses(109, member(c, [e, d, c, a]))]).
substitution(111, ['X' = d]).
proof(111, member(d, [d, c, a]), rule(12), []).
substitution(112, ['X' = d, 'Rest' = [d, c, a]]).
proof(112, member(d, [e, d, c, a]), rule(13), [uses(111, member(d, [d, c, a]))]).
substitution(113, []).
proof(113, solution([]), query, [uses(112, member(d, [e, d, c, a]))]).
substitution(114, ['Goal' = f]).
proof(114, route(f, f, [f, d, c, a], [f], 0), rule(14), []).
substitution(115, ['X' = c]).
proof(115, member(c, [c, b, a]), rule(12), []).
substitution(116, ['X' = c, 'Rest' = [c, b, a]]).
proof(116, member(c, [d, c, b, a]), rule(13), [uses(115, member(c, [c, b, a]))]).
substitution(117, ['X' = c, 'Rest' = [d, c, b, a]]).
proof(117, member(c, [e, d, c, b, a]), rule(13), [uses(116, member(c, [d, c, b, a]))]).
substitution(118, []).
proof(118, solution([]), query, [uses(117, member(c, [e, d, c, b, a]))]).
substitution(119, ['X' = d]).
proof(119, member(d, [d, c, b, a]), rule(12), []).
substitution(120, ['X' = d, 'Rest' = [d, c, b, a]]).
proof(120, member(d, [e, d, c, b, a]), rule(13), [uses(119, member(d, [d, c, b, a]))]).
substitution(121, []).
proof(121, solution([]), query, [uses(120, member(d, [e, d, c, b, a]))]).
substitution(122, ['Goal' = f]).
proof(122, route(f, f, [f, d, c, b, a], [f], 0), rule(14), []).
substitution(123, ['X' = c]).
proof(123, member(c, [c, a]), rule(12), []).
substitution(124, ['X' = c, 'Rest' = [c, a]]).
proof(124, member(c, [b, c, a]), rule(13), [uses(123, member(c, [c, a]))]).
substitution(125, ['X' = c, 'Rest' = [b, c, a]]).
proof(125, member(c, [d, b, c, a]), rule(13), [uses(124, member(c, [b, c, a]))]).
substitution(126, ['X' = c, 'Rest' = [d, b, c, a]]).
proof(126, member(c, [e, d, b, c, a]), rule(13), [uses(125, member(c, [d, b, c, a]))]).
substitution(127, []).
proof(127, solution([]), query, [uses(126, member(c, [e, d, b, c, a]))]).
substitution(128, ['X' = d]).
proof(128, member(d, [d, b, c, a]), rule(12), []).
substitution(129, ['X' = d, 'Rest' = [d, b, c, a]]).
proof(129, member(d, [e, d, b, c, a]), rule(13), [uses(128, member(d, [d, b, c, a]))]).
substitution(130, []).
proof(130, solution([]), query, [uses(129, member(d, [e, d, b, c, a]))]).
substitution(131, ['Goal' = f]).
proof(131, route(f, f, [f, d, b, c, a], [f], 0), rule(14), []).
substitution(132, ['X' = c]).
proof(132, member(c, [c, a]), rule(12), []).
substitution(133, ['X' = c, 'Rest' = [c, a]]).
proof(133, member(c, [e, c, a]), rule(13), [uses(132, member(c, [c, a]))]).
substitution(134, ['X' = c, 'Rest' = [e, c, a]]).
proof(134, member(c, [d, e, c, a]), rule(13), [uses(133, member(c, [e, c, a]))]).
substitution(135, []).
proof(135, solution([]), query, [uses(134, member(c, [d, e, c, a]))]).
substitution(136, ['X' = e]).
proof(136, member(e, [e, c, a]), rule(12), []).
substitution(137, ['X' = e, 'Rest' = [e, c, a]]).
proof(137, member(e, [d, e, c, a]), rule(13), [uses(136, member(e, [e, c, a]))]).
substitution(138, []).
proof(138, solution([]), query, [uses(137, member(e, [d, e, c, a]))]).
substitution(139, ['Goal' = f]).
proof(139, route(f, f, [f, e, c, a], [f], 0), rule(14), []).
substitution(140, ['X' = b]).
proof(140, member(b, [b, a]), rule(12), []).
substitution(141, ['X' = b, 'Rest' = [b, a]]).
proof(141, member(b, [c, b, a]), rule(13), [uses(140, member(b, [b, a]))]).
substitution(142, ['X' = b, 'Rest' = [c, b, a]]).
proof(142, member(b, [e, c, b, a]), rule(13), [uses(141, member(b, [c, b, a]))]).
substitution(143, ['X' = b, 'Rest' = [e, c, b, a]]).
proof(143, member(b, [d, e, c, b, a]), rule(13), [uses(142, member(b, [e, c, b, a]))]).
substitution(144, []).
proof(144, solution([]), query, [uses(143, member(b, [d, e, c, b, a]))]).
substitution(145, ['X' = c]).
proof(145, member(c, [c, b, a]), rule(12), []).
substitution(146, ['X' = c, 'Rest' = [c, b, a]]).
proof(146, member(c, [e, c, b, a]), rule(13), [uses(145, member(c, [c, b, a]))]).
substitution(147, ['X' = c, 'Rest' = [e, c, b, a]]).
proof(147, member(c, [d, e, c, b, a]), rule(13), [uses(146, member(c, [e, c, b, a]))]).
substitution(148, []).
proof(148, solution([]), query, [uses(147, member(c, [d, e, c, b, a]))]).
substitution(149, ['X' = e]).
proof(149, member(e, [e, c, b, a]), rule(12), []).
substitution(150, ['X' = e, 'Rest' = [e, c, b, a]]).
proof(150, member(e, [d, e, c, b, a]), rule(13), [uses(149, member(e, [e, c, b, a]))]).
substitution(151, []).
proof(151, solution([]), query, [uses(150, member(e, [d, e, c, b, a]))]).
substitution(152, ['Goal' = f]).
proof(152, route(f, f, [f, e, c, b, a], [f], 0), rule(14), []).
substitution(153, ['X' = c]).
proof(153, member(c, [c, d, b, a]), rule(12), []).
substitution(154, ['X' = c, 'Rest' = [c, d, b, a]]).
proof(154, member(c, [e, c, d, b, a]), rule(13), [uses(153, member(c, [c, d, b, a]))]).
substitution(155, []).
proof(155, solution([]), query, [uses(154, member(c, [e, c, d, b, a]))]).
substitution(156, ['X' = d]).
proof(156, member(d, [d, b, a]), rule(12), []).
substitution(157, ['X' = d, 'Rest' = [d, b, a]]).
proof(157, member(d, [c, d, b, a]), rule(13), [uses(156, member(d, [d, b, a]))]).
substitution(158, ['X' = d, 'Rest' = [c, d, b, a]]).
proof(158, member(d, [e, c, d, b, a]), rule(13), [uses(157, member(d, [c, d, b, a]))]).
substitution(159, []).
proof(159, solution([]), query, [uses(158, member(d, [e, c, d, b, a]))]).
substitution(160, ['X' = a]).
proof(160, member(a, [a]), rule(12), []).
substitution(161, ['X' = a, 'Rest' = [a]]).
proof(161, member(a, [b, a]), rule(13), [uses(160, member(a, [a]))]).
substitution(162, ['X' = a, 'Rest' = [b, a]]).
proof(162, member(a, [d, b, a]), rule(13), [uses(161, member(a, [b, a]))]).
substitution(163, ['X' = a, 'Rest' = [d, b, a]]).
proof(163, member(a, [e, d, b, a]), rule(13), [uses(162, member(a, [d, b, a]))]).
substitution(164, ['X' = a, 'Rest' = [e, d, b, a]]).
proof(164, member(a, [c, e, d, b, a]), rule(13), [uses(163, member(a, [e, d, b, a]))]).
substitution(165, []).
proof(165, solution([]), query, [uses(164, member(a, [c, e, d, b, a]))]).
substitution(166, ['X' = b]).
proof(166, member(b, [b, a]), rule(12), []).
substitution(167, ['X' = b, 'Rest' = [b, a]]).
proof(167, member(b, [d, b, a]), rule(13), [uses(166, member(b, [b, a]))]).
substitution(168, ['X' = b, 'Rest' = [d, b, a]]).
proof(168, member(b, [e, d, b, a]), rule(13), [uses(167, member(b, [d, b, a]))]).
substitution(169, ['X' = b, 'Rest' = [e, d, b, a]]).
proof(169, member(b, [c, e, d, b, a]), rule(13), [uses(168, member(b, [e, d, b, a]))]).
substitution(170, []).
proof(170, solution([]), query, [uses(169, member(b, [c, e, d, b, a]))]).
substitution(171, ['X' = d]).
proof(171, member(d, [d, b, a]), rule(12), []).
substitution(172, ['X' = d, 'Rest' = [d, b, a]]).
proof(172, member(d, [e, d, b, a]), rule(13), [uses(171, member(d, [d, b, a]))]).
substitution(173, ['X' = d, 'Rest' = [e, d, b, a]]).
proof(173, member(d, [c, e, d, b, a]), rule(13), [uses(172, member(d, [e, d, b, a]))]).
substitution(174, []).
proof(174, solution([]), query, [uses(173, member(d, [c, e, d, b, a]))]).
substitution(175, ['X' = e]).
proof(175, member(e, [e, d, b, a]), rule(12), []).
substitution(176, ['X' = e, 'Rest' = [e, d, b, a]]).
proof(176, member(e, [c, e, d, b, a]), rule(13), [uses(175, member(e, [e, d, b, a]))]).
substitution(177, []).
proof(177, solution([]), query, [uses(176, member(e, [c, e, d, b, a]))]).
substitution(178, ['Goal' = f]).
proof(178, route(f, f, [f, e, d, b, a], [f], 0), rule(14), []).
substitution(179, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(179, route(d, f, [d, b, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, b, a]), complete), uses(94, route(f, f, [f, d, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(180, ['Goal' = f]).
proof(180, route(f, f, [f, e, d, c, a], [f], 0), rule(14), []).
substitution(181, ['From' = d, 'Goal' = f, 'Visited' = [d, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(181, route(d, f, [d, c, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, c, a]), complete), uses(114, route(f, f, [f, d, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(182, ['Goal' = f]).
proof(182, route(f, f, [f, e, d, c, b, a], [f], 0), rule(14), []).
substitution(183, ['From' = d, 'Goal' = f, 'Visited' = [d, c, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(183, route(d, f, [d, c, b, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, c, b, a]), complete), uses(122, route(f, f, [f, d, c, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(184, ['Goal' = f]).
proof(184, route(f, f, [f, e, d, b, c, a], [f], 0), rule(14), []).
substitution(185, ['From' = d, 'Goal' = f, 'Visited' = [d, b, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(185, route(d, f, [d, b, c, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, b, c, a]), complete), uses(131, route(f, f, [f, d, b, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(186, ['X' = a]).
proof(186, member(a, [a]), rule(12), []).
substitution(187, ['X' = a, 'Rest' = [a]]).
proof(187, member(a, [c, a]), rule(13), [uses(186, member(a, [a]))]).
substitution(188, ['X' = a, 'Rest' = [c, a]]).
proof(188, member(a, [e, c, a]), rule(13), [uses(187, member(a, [c, a]))]).
substitution(189, ['X' = a, 'Rest' = [e, c, a]]).
proof(189, member(a, [d, e, c, a]), rule(13), [uses(188, member(a, [e, c, a]))]).
substitution(190, ['X' = a, 'Rest' = [d, e, c, a]]).
proof(190, member(a, [b, d, e, c, a]), rule(13), [uses(189, member(a, [d, e, c, a]))]).
substitution(191, []).
proof(191, solution([]), query, [uses(190, member(a, [b, d, e, c, a]))]).
substitution(192, ['X' = c]).
proof(192, member(c, [c, a]), rule(12), []).
substitution(193, ['X' = c, 'Rest' = [c, a]]).
proof(193, member(c, [e, c, a]), rule(13), [uses(192, member(c, [c, a]))]).
substitution(194, ['X' = c, 'Rest' = [e, c, a]]).
proof(194, member(c, [d, e, c, a]), rule(13), [uses(193, member(c, [e, c, a]))]).
substitution(195, ['X' = c, 'Rest' = [d, e, c, a]]).
proof(195, member(c, [b, d, e, c, a]), rule(13), [uses(194, member(c, [d, e, c, a]))]).
substitution(196, []).
proof(196, solution([]), query, [uses(195, member(c, [b, d, e, c, a]))]).
substitution(197, ['X' = d]).
proof(197, member(d, [d, e, c, a]), rule(12), []).
substitution(198, ['X' = d, 'Rest' = [d, e, c, a]]).
proof(198, member(d, [b, d, e, c, a]), rule(13), [uses(197, member(d, [d, e, c, a]))]).
substitution(199, []).
proof(199, solution([]), query, [uses(198, member(d, [b, d, e, c, a]))]).
substitution(200, ['Goal' = f]).
proof(200, route(f, f, [f, d, e, c, a], [f], 0), rule(14), []).
substitution(201, ['From' = e, 'Goal' = f, 'Visited' = [e, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(201, route(e, f, [e, c, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, c, a]), complete), uses(139, route(f, f, [f, e, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(202, ['Goal' = f]).
proof(202, route(f, f, [f, d, e, c, b, a], [f], 0), rule(14), []).
substitution(203, ['From' = e, 'Goal' = f, 'Visited' = [e, c, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(203, route(e, f, [e, c, b, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, c, b, a]), complete), uses(152, route(f, f, [f, e, c, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(204, ['Goal' = f]).
proof(204, route(f, f, [f, e, c, d, b, a], [f], 0), rule(14), []).
substitution(205, ['From' = e, 'Goal' = f, 'Visited' = [e, d, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(205, route(e, f, [e, d, b, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, d, b, a]), complete), uses(178, route(f, f, [f, e, d, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(206, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, f], 'Cost' = 11, 'Next' = d, 'Step' = 5, 'Remaining' = 6]).
proof(206, route(b, f, [b, a], [b, d, f], 11), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(179, route(d, f, [d, b, a], [d, f], 6)), builtin(11 is 5 + 6)]).
substitution(207, []).
proof(207, edge(d, f, 6), rule(8), []).
substitution(208, []).
proof(208, edge(e, f, 3), rule(9), []).
substitution(209, ['From' = e, 'Goal' = f, 'Visited' = [e, d, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(209, route(e, f, [e, d, c, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, d, c, a]), complete), uses(180, route(f, f, [f, e, d, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(210, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [d, f], 'Cost' = 14, 'Next' = d, 'Step' = 8, 'Remaining' = 6]).
proof(210, route(c, f, [c, a], [c, d, f], 14), rule(15), [uses(17, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(181, route(d, f, [d, c, a], [d, f], 6)), builtin(14 is 8 + 6)]).
substitution(211, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(211, route(c, f, [c, a], [c, e, f], 13), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(201, route(e, f, [e, c, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(212, ['From' = e, 'Goal' = f, 'Visited' = [e, d, c, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(212, route(e, f, [e, d, c, b, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, d, c, b, a]), complete), uses(182, route(f, f, [f, e, d, c, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(213, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [d, f], 'Cost' = 14, 'Next' = d, 'Step' = 8, 'Remaining' = 6]).
proof(213, route(c, f, [c, b, a], [c, d, f], 14), rule(15), [uses(17, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(183, route(d, f, [d, c, b, a], [d, f], 6)), builtin(14 is 8 + 6)]).
substitution(214, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(214, route(c, f, [c, b, a], [c, e, f], 13), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(203, route(e, f, [e, c, b, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(215, ['From' = e, 'Goal' = f, 'Visited' = [e, d, b, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(215, route(e, f, [e, d, b, c, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, d, b, c, a]), complete), uses(184, route(f, f, [f, e, d, b, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(216, ['From' = b, 'Goal' = f, 'Visited' = [b, c, a], 'Path' = [d, f], 'Cost' = 11, 'Next' = d, 'Step' = 5, 'Remaining' = 6]).
proof(216, route(b, f, [b, c, a], [b, d, f], 11), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(185, route(d, f, [d, b, c, a], [d, f], 6)), builtin(11 is 5 + 6)]).
substitution(217, ['From' = d, 'Goal' = f, 'Visited' = [d, e, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(217, route(d, f, [d, e, c, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, e, c, a]), complete), uses(200, route(f, f, [f, d, e, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(218, ['From' = d, 'Goal' = f, 'Visited' = [d, e, c, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(218, route(d, f, [d, e, c, b, a], [d, f], 6), rule(15), [uses(49, connected(d, f, 6)), absent(member(f, [d, e, c, b, a]), complete), uses(202, route(f, f, [f, d, e, c, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(219, ['From' = e, 'Goal' = f, 'Visited' = [e, c, d, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(219, route(e, f, [e, c, d, b, a], [e, f], 3), rule(15), [uses(52, connected(e, f, 3)), absent(member(f, [e, c, d, b, a]), complete), uses(204, route(f, f, [f, e, c, d, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(220, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(220, route(d, f, [d, b, a], [d, e, f], 5), rule(15), [uses(48, connected(d, e, 2)), absent(member(e, [d, b, a]), complete), uses(205, route(e, f, [e, d, b, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(221, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, d, f], 'Cost' = 15, 'Next' = b, 'Step' = 4, 'Remaining' = 11]).
proof(221, route(a, f, [a], [a, b, d, f], 15), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(206, route(b, f, [b, a], [b, d, f], 11)), builtin(15 is 4 + 11)]).
substitution(222, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, d, f], 'Cost' = 16, 'Next' = c, 'Step' = 2, 'Remaining' = 14]).
proof(222, route(a, f, [a], [a, c, d, f], 16), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(210, route(c, f, [c, a], [c, d, f], 14)), builtin(16 is 2 + 14)]).
substitution(223, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, e, f], 'Cost' = 15, 'Next' = c, 'Step' = 2, 'Remaining' = 13]).
proof(223, route(a, f, [a], [a, c, e, f], 15), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(211, route(c, f, [c, a], [c, e, f], 13)), builtin(15 is 2 + 13)]).
substitution(224, ['Right' = f, 'Left' = d, 'Weight' = 6]).
proof(224, connected(f, d, 6), rule(10), [uses(207, edge(d, f, 6))]).
substitution(225, ['Right' = f, 'Left' = e, 'Weight' = 3]).
proof(225, connected(f, e, 3), rule(10), [uses(208, edge(e, f, 3))]).
substitution(226, ['From' = d, 'Goal' = f, 'Visited' = [d, c, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(226, route(d, f, [d, c, a], [d, e, f], 5), rule(15), [uses(48, connected(d, e, 2)), absent(member(e, [d, c, a]), complete), uses(209, route(e, f, [e, d, c, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(227, ['From' = d, 'Goal' = f, 'Visited' = [d, c, b, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(227, route(d, f, [d, c, b, a], [d, e, f], 5), rule(15), [uses(48, connected(d, e, 2)), absent(member(e, [d, c, b, a]), complete), uses(212, route(e, f, [e, d, c, b, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(228, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, d, f], 'Cost' = 15, 'Next' = c, 'Step' = 1, 'Remaining' = 14]).
proof(228, route(b, f, [b, a], [b, c, d, f], 15), rule(15), [uses(13, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(213, route(c, f, [c, b, a], [c, d, f], 14)), builtin(15 is 1 + 14)]).
substitution(229, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, e, f], 'Cost' = 14, 'Next' = c, 'Step' = 1, 'Remaining' = 13]).
proof(229, route(b, f, [b, a], [b, c, e, f], 14), rule(15), [uses(13, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(214, route(c, f, [c, b, a], [c, e, f], 13)), builtin(14 is 1 + 13)]).
substitution(230, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, e, f], 'Cost' = 10, 'Next' = d, 'Step' = 5, 'Remaining' = 5]).
proof(230, route(b, f, [b, a], [b, d, e, f], 10), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(220, route(d, f, [d, b, a], [d, e, f], 5)), builtin(10 is 5 + 5)]).
substitution(231, ['From' = d, 'Goal' = f, 'Visited' = [d, b, c, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(231, route(d, f, [d, b, c, a], [d, e, f], 5), rule(15), [uses(48, connected(d, e, 2)), absent(member(e, [d, b, c, a]), complete), uses(215, route(e, f, [e, d, b, c, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(232, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [b, d, f], 'Cost' = 12, 'Next' = b, 'Step' = 1, 'Remaining' = 11]).
proof(232, route(c, f, [c, a], [c, b, d, f], 12), rule(15), [uses(16, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(216, route(b, f, [b, c, a], [b, d, f], 11)), builtin(12 is 1 + 11)]).
substitution(233, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [d, e, f], 'Cost' = 13, 'Next' = d, 'Step' = 8, 'Remaining' = 5]).
proof(233, route(c, f, [c, a], [c, d, e, f], 13), rule(15), [uses(17, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(226, route(d, f, [d, c, a], [d, e, f], 5)), builtin(13 is 8 + 5)]).
substitution(234, ['From' = e, 'Goal' = f, 'Visited' = [e, c, a], 'Path' = [d, f], 'Cost' = 8, 'Next' = d, 'Step' = 2, 'Remaining' = 6]).
proof(234, route(e, f, [e, c, a], [e, d, f], 8), rule(15), [uses(51, connected(e, d, 2)), absent(member(d, [e, c, a]), complete), uses(217, route(d, f, [d, e, c, a], [d, f], 6)), builtin(8 is 2 + 6)]).
substitution(235, ['From' = e, 'Goal' = f, 'Visited' = [e, c, b, a], 'Path' = [d, f], 'Cost' = 8, 'Next' = d, 'Step' = 2, 'Remaining' = 6]).
proof(235, route(e, f, [e, c, b, a], [e, d, f], 8), rule(15), [uses(51, connected(e, d, 2)), absent(member(d, [e, c, b, a]), complete), uses(218, route(d, f, [d, e, c, b, a], [d, f], 6)), builtin(8 is 2 + 6)]).
substitution(236, ['From' = c, 'Goal' = f, 'Visited' = [c, d, b, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(236, route(c, f, [c, d, b, a], [c, e, f], 13), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, d, b, a]), complete), uses(219, route(e, f, [e, c, d, b, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(237, ['Candidate' = 15]).
proof(237, solution([15]), query, [uses(221, route(a, f, [a], [a, b, d, f], 15))]).
substitution(238, ['Candidate' = 16]).
proof(238, solution([16]), query, [uses(222, route(a, f, [a], [a, c, d, f], 16))]).
substitution(239, ['X' = d]).
proof(239, member(d, [d, b, a]), rule(12), []).
substitution(240, ['X' = d, 'Rest' = [d, b, a]]).
proof(240, member(d, [f, d, b, a]), rule(13), [uses(239, member(d, [d, b, a]))]).
substitution(241, []).
proof(241, solution([]), query, [uses(240, member(d, [f, d, b, a]))]).
substitution(242, ['X' = d]).
proof(242, member(d, [d, c, a]), rule(12), []).
substitution(243, ['X' = d, 'Rest' = [d, c, a]]).
proof(243, member(d, [f, d, c, a]), rule(13), [uses(242, member(d, [d, c, a]))]).
substitution(244, []).
proof(244, solution([]), query, [uses(243, member(d, [f, d, c, a]))]).
substitution(245, ['X' = d]).
proof(245, member(d, [d, c, b, a]), rule(12), []).
substitution(246, ['X' = d, 'Rest' = [d, c, b, a]]).
proof(246, member(d, [f, d, c, b, a]), rule(13), [uses(245, member(d, [d, c, b, a]))]).
substitution(247, []).
proof(247, solution([]), query, [uses(246, member(d, [f, d, c, b, a]))]).
substitution(248, ['X' = d]).
proof(248, member(d, [d, b, c, a]), rule(12), []).
substitution(249, ['X' = d, 'Rest' = [d, b, c, a]]).
proof(249, member(d, [f, d, b, c, a]), rule(13), [uses(248, member(d, [d, b, c, a]))]).
substitution(250, []).
proof(250, solution([]), query, [uses(249, member(d, [f, d, b, c, a]))]).
substitution(251, ['X' = e]).
proof(251, member(e, [e, c, a]), rule(12), []).
substitution(252, ['X' = e, 'Rest' = [e, c, a]]).
proof(252, member(e, [f, e, c, a]), rule(13), [uses(251, member(e, [e, c, a]))]).
substitution(253, []).
proof(253, solution([]), query, [uses(252, member(e, [f, e, c, a]))]).
substitution(254, ['X' = e]).
proof(254, member(e, [e, c, b, a]), rule(12), []).
substitution(255, ['X' = e, 'Rest' = [e, c, b, a]]).
proof(255, member(e, [f, e, c, b, a]), rule(13), [uses(254, member(e, [e, c, b, a]))]).
substitution(256, []).
proof(256, solution([]), query, [uses(255, member(e, [f, e, c, b, a]))]).
substitution(257, ['X' = d]).
proof(257, member(d, [d, b, a]), rule(12), []).
substitution(258, ['X' = d, 'Rest' = [d, b, a]]).
proof(258, member(d, [e, d, b, a]), rule(13), [uses(257, member(d, [d, b, a]))]).
substitution(259, ['X' = d, 'Rest' = [e, d, b, a]]).
proof(259, member(d, [f, e, d, b, a]), rule(13), [uses(258, member(d, [e, d, b, a]))]).
substitution(260, []).
proof(260, solution([]), query, [uses(259, member(d, [f, e, d, b, a]))]).
substitution(261, ['X' = e]).
proof(261, member(e, [e, d, b, a]), rule(12), []).
substitution(262, ['X' = e, 'Rest' = [e, d, b, a]]).
proof(262, member(e, [f, e, d, b, a]), rule(13), [uses(261, member(e, [e, d, b, a]))]).
substitution(263, []).
proof(263, solution([]), query, [uses(262, member(e, [f, e, d, b, a]))]).
substitution(264, ['X' = d]).
proof(264, member(d, [d, c, a]), rule(12), []).
substitution(265, ['X' = d, 'Rest' = [d, c, a]]).
proof(265, member(d, [e, d, c, a]), rule(13), [uses(264, member(d, [d, c, a]))]).
substitution(266, ['X' = d, 'Rest' = [e, d, c, a]]).
proof(266, member(d, [f, e, d, c, a]), rule(13), [uses(265, member(d, [e, d, c, a]))]).
substitution(267, []).
proof(267, solution([]), query, [uses(266, member(d, [f, e, d, c, a]))]).
substitution(268, ['X' = e]).
proof(268, member(e, [e, d, c, a]), rule(12), []).
substitution(269, ['X' = e, 'Rest' = [e, d, c, a]]).
proof(269, member(e, [f, e, d, c, a]), rule(13), [uses(268, member(e, [e, d, c, a]))]).
substitution(270, []).
proof(270, solution([]), query, [uses(269, member(e, [f, e, d, c, a]))]).
substitution(271, ['X' = d]).
proof(271, member(d, [d, c, b, a]), rule(12), []).
substitution(272, ['X' = d, 'Rest' = [d, c, b, a]]).
proof(272, member(d, [e, d, c, b, a]), rule(13), [uses(271, member(d, [d, c, b, a]))]).
substitution(273, ['X' = d, 'Rest' = [e, d, c, b, a]]).
proof(273, member(d, [f, e, d, c, b, a]), rule(13), [uses(272, member(d, [e, d, c, b, a]))]).
substitution(274, []).
proof(274, solution([]), query, [uses(273, member(d, [f, e, d, c, b, a]))]).
substitution(275, ['X' = e]).
proof(275, member(e, [e, d, c, b, a]), rule(12), []).
substitution(276, ['X' = e, 'Rest' = [e, d, c, b, a]]).
proof(276, member(e, [f, e, d, c, b, a]), rule(13), [uses(275, member(e, [e, d, c, b, a]))]).
substitution(277, []).
proof(277, solution([]), query, [uses(276, member(e, [f, e, d, c, b, a]))]).
substitution(278, ['X' = d]).
proof(278, member(d, [d, b, c, a]), rule(12), []).
substitution(279, ['X' = d, 'Rest' = [d, b, c, a]]).
proof(279, member(d, [e, d, b, c, a]), rule(13), [uses(278, member(d, [d, b, c, a]))]).
substitution(280, ['X' = d, 'Rest' = [e, d, b, c, a]]).
proof(280, member(d, [f, e, d, b, c, a]), rule(13), [uses(279, member(d, [e, d, b, c, a]))]).
substitution(281, []).
proof(281, solution([]), query, [uses(280, member(d, [f, e, d, b, c, a]))]).
substitution(282, ['X' = e]).
proof(282, member(e, [e, d, b, c, a]), rule(12), []).
substitution(283, ['X' = e, 'Rest' = [e, d, b, c, a]]).
proof(283, member(e, [f, e, d, b, c, a]), rule(13), [uses(282, member(e, [e, d, b, c, a]))]).
substitution(284, []).
proof(284, solution([]), query, [uses(283, member(e, [f, e, d, b, c, a]))]).
substitution(285, ['X' = d]).
proof(285, member(d, [d, e, c, a]), rule(12), []).
substitution(286, ['X' = d, 'Rest' = [d, e, c, a]]).
proof(286, member(d, [f, d, e, c, a]), rule(13), [uses(285, member(d, [d, e, c, a]))]).
substitution(287, []).
proof(287, solution([]), query, [uses(286, member(d, [f, d, e, c, a]))]).
substitution(288, ['X' = e]).
proof(288, member(e, [e, c, a]), rule(12), []).
substitution(289, ['X' = e, 'Rest' = [e, c, a]]).
proof(289, member(e, [d, e, c, a]), rule(13), [uses(288, member(e, [e, c, a]))]).
substitution(290, ['X' = e, 'Rest' = [d, e, c, a]]).
proof(290, member(e, [f, d, e, c, a]), rule(13), [uses(289, member(e, [d, e, c, a]))]).
substitution(291, []).
proof(291, solution([]), query, [uses(290, member(e, [f, d, e, c, a]))]).
substitution(292, ['X' = d]).
proof(292, member(d, [d, e, c, b, a]), rule(12), []).
substitution(293, ['X' = d, 'Rest' = [d, e, c, b, a]]).
proof(293, member(d, [f, d, e, c, b, a]), rule(13), [uses(292, member(d, [d, e, c, b, a]))]).
substitution(294, []).
proof(294, solution([]), query, [uses(293, member(d, [f, d, e, c, b, a]))]).
substitution(295, ['X' = e]).
proof(295, member(e, [e, c, b, a]), rule(12), []).
substitution(296, ['X' = e, 'Rest' = [e, c, b, a]]).
proof(296, member(e, [d, e, c, b, a]), rule(13), [uses(295, member(e, [e, c, b, a]))]).
substitution(297, ['X' = e, 'Rest' = [d, e, c, b, a]]).
proof(297, member(e, [f, d, e, c, b, a]), rule(13), [uses(296, member(e, [d, e, c, b, a]))]).
substitution(298, []).
proof(298, solution([]), query, [uses(297, member(e, [f, d, e, c, b, a]))]).
substitution(299, ['X' = d]).
proof(299, member(d, [d, b, a]), rule(12), []).
substitution(300, ['X' = d, 'Rest' = [d, b, a]]).
proof(300, member(d, [c, d, b, a]), rule(13), [uses(299, member(d, [d, b, a]))]).
substitution(301, ['X' = d, 'Rest' = [c, d, b, a]]).
proof(301, member(d, [e, c, d, b, a]), rule(13), [uses(300, member(d, [c, d, b, a]))]).
substitution(302, ['X' = d, 'Rest' = [e, c, d, b, a]]).
proof(302, member(d, [f, e, c, d, b, a]), rule(13), [uses(301, member(d, [e, c, d, b, a]))]).
substitution(303, []).
proof(303, solution([]), query, [uses(302, member(d, [f, e, c, d, b, a]))]).
substitution(304, ['X' = e]).
proof(304, member(e, [e, c, d, b, a]), rule(12), []).
substitution(305, ['X' = e, 'Rest' = [e, c, d, b, a]]).
proof(305, member(e, [f, e, c, d, b, a]), rule(13), [uses(304, member(e, [e, c, d, b, a]))]).
substitution(306, []).
proof(306, solution([]), query, [uses(305, member(e, [f, e, c, d, b, a]))]).
substitution(307, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [d, e, f], 'Cost' = 13, 'Next' = d, 'Step' = 8, 'Remaining' = 5]).
proof(307, route(c, f, [c, b, a], [c, d, e, f], 13), rule(15), [uses(17, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(227, route(d, f, [d, c, b, a], [d, e, f], 5)), builtin(13 is 8 + 5)]).
substitution(308, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [e, d, f], 'Cost' = 18, 'Next' = e, 'Step' = 10, 'Remaining' = 8]).
proof(308, route(c, f, [c, b, a], [c, e, d, f], 18), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(235, route(e, f, [e, c, b, a], [e, d, f], 8)), builtin(18 is 10 + 8)]).
substitution(309, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, c, d, f], 'Cost' = 19, 'Next' = b, 'Step' = 4, 'Remaining' = 15]).
proof(309, route(a, f, [a], [a, b, c, d, f], 19), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(228, route(b, f, [b, a], [b, c, d, f], 15)), builtin(19 is 4 + 15)]).
substitution(310, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, c, e, f], 'Cost' = 18, 'Next' = b, 'Step' = 4, 'Remaining' = 14]).
proof(310, route(a, f, [a], [a, b, c, e, f], 18), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(229, route(b, f, [b, a], [b, c, e, f], 14)), builtin(18 is 4 + 14)]).
substitution(311, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, d, e, f], 'Cost' = 14, 'Next' = b, 'Step' = 4, 'Remaining' = 10]).
proof(311, route(a, f, [a], [a, b, d, e, f], 14), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(230, route(b, f, [b, a], [b, d, e, f], 10)), builtin(14 is 4 + 10)]).
substitution(312, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, b, d, f], 'Cost' = 14, 'Next' = c, 'Step' = 2, 'Remaining' = 12]).
proof(312, route(a, f, [a], [a, c, b, d, f], 14), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(232, route(c, f, [c, a], [c, b, d, f], 12)), builtin(14 is 2 + 12)]).
substitution(313, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, d, e, f], 'Cost' = 15, 'Next' = c, 'Step' = 2, 'Remaining' = 13]).
proof(313, route(a, f, [a], [a, c, d, e, f], 15), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(233, route(c, f, [c, a], [c, d, e, f], 13)), builtin(15 is 2 + 13)]).
substitution(314, ['From' = b, 'Goal' = f, 'Visited' = [b, c, a], 'Path' = [d, e, f], 'Cost' = 10, 'Next' = d, 'Step' = 5, 'Remaining' = 5]).
proof(314, route(b, f, [b, c, a], [b, d, e, f], 10), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(231, route(d, f, [d, b, c, a], [d, e, f], 5)), builtin(10 is 5 + 5)]).
substitution(315, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [b, d, e, f], 'Cost' = 11, 'Next' = b, 'Step' = 1, 'Remaining' = 10]).
proof(315, route(c, f, [c, a], [c, b, d, e, f], 11), rule(15), [uses(16, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(314, route(b, f, [b, c, a], [b, d, e, f], 10)), builtin(11 is 1 + 10)]).
substitution(316, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [e, d, f], 'Cost' = 18, 'Next' = e, 'Step' = 10, 'Remaining' = 8]).
proof(316, route(c, f, [c, a], [c, e, d, f], 18), rule(15), [uses(18, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(234, route(e, f, [e, c, a], [e, d, f], 8)), builtin(18 is 10 + 8)]).
substitution(317, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [c, e, f], 'Cost' = 21, 'Next' = c, 'Step' = 8, 'Remaining' = 13]).
proof(317, route(d, f, [d, b, a], [d, c, e, f], 21), rule(15), [uses(47, connected(d, c, 8)), absent(member(c, [d, b, a]), complete), uses(236, route(c, f, [c, d, b, a], [c, e, f], 13)), builtin(21 is 8 + 13)]).
substitution(318, ['X' = d]).
proof(318, member(d, [d, b, a]), rule(12), []).
substitution(319, ['X' = d, 'Rest' = [d, b, a]]).
proof(319, member(d, [f, d, b, a]), rule(13), [uses(318, member(d, [d, b, a]))]).
substitution(320, ['X' = d, 'Rest' = [f, d, b, a]]).
proof(320, member(d, [e, f, d, b, a]), rule(13), [uses(319, member(d, [f, d, b, a]))]).
substitution(321, []).
proof(321, solution([]), query, [uses(320, member(d, [e, f, d, b, a]))]).
substitution(322, ['X' = f]).
proof(322, member(f, [f, d, b, a]), rule(12), []).
substitution(323, ['X' = f, 'Rest' = [f, d, b, a]]).
proof(323, member(f, [e, f, d, b, a]), rule(13), [uses(322, member(f, [f, d, b, a]))]).
substitution(324, []).
proof(324, solution([]), query, [uses(323, member(f, [e, f, d, b, a]))]).
substitution(325, ['X' = c]).
proof(325, member(c, [c, a]), rule(12), []).
substitution(326, ['X' = c, 'Rest' = [c, a]]).
proof(326, member(c, [d, c, a]), rule(13), [uses(325, member(c, [c, a]))]).
substitution(327, ['X' = c, 'Rest' = [d, c, a]]).
proof(327, member(c, [f, d, c, a]), rule(13), [uses(326, member(c, [d, c, a]))]).
substitution(328, ['X' = c, 'Rest' = [f, d, c, a]]).
proof(328, member(c, [e, f, d, c, a]), rule(13), [uses(327, member(c, [f, d, c, a]))]).
substitution(329, []).
proof(329, solution([]), query, [uses(328, member(c, [e, f, d, c, a]))]).
substitution(330, ['X' = d]).
proof(330, member(d, [d, c, a]), rule(12), []).
substitution(331, ['X' = d, 'Rest' = [d, c, a]]).
proof(331, member(d, [f, d, c, a]), rule(13), [uses(330, member(d, [d, c, a]))]).
substitution(332, ['X' = d, 'Rest' = [f, d, c, a]]).
proof(332, member(d, [e, f, d, c, a]), rule(13), [uses(331, member(d, [f, d, c, a]))]).
substitution(333, []).
proof(333, solution([]), query, [uses(332, member(d, [e, f, d, c, a]))]).
substitution(334, ['X' = f]).
proof(334, member(f, [f, d, c, a]), rule(12), []).
substitution(335, ['X' = f, 'Rest' = [f, d, c, a]]).
proof(335, member(f, [e, f, d, c, a]), rule(13), [uses(334, member(f, [f, d, c, a]))]).
substitution(336, []).
proof(336, solution([]), query, [uses(335, member(f, [e, f, d, c, a]))]).
substitution(337, ['X' = c]).
proof(337, member(c, [c, b, a]), rule(12), []).
substitution(338, ['X' = c, 'Rest' = [c, b, a]]).
proof(338, member(c, [d, c, b, a]), rule(13), [uses(337, member(c, [c, b, a]))]).
substitution(339, ['X' = c, 'Rest' = [d, c, b, a]]).
proof(339, member(c, [f, d, c, b, a]), rule(13), [uses(338, member(c, [d, c, b, a]))]).
substitution(340, ['X' = c, 'Rest' = [f, d, c, b, a]]).
proof(340, member(c, [e, f, d, c, b, a]), rule(13), [uses(339, member(c, [f, d, c, b, a]))]).
substitution(341, []).
proof(341, solution([]), query, [uses(340, member(c, [e, f, d, c, b, a]))]).
substitution(342, ['X' = d]).
proof(342, member(d, [d, c, b, a]), rule(12), []).
substitution(343, ['X' = d, 'Rest' = [d, c, b, a]]).
proof(343, member(d, [f, d, c, b, a]), rule(13), [uses(342, member(d, [d, c, b, a]))]).
substitution(344, ['X' = d, 'Rest' = [f, d, c, b, a]]).
proof(344, member(d, [e, f, d, c, b, a]), rule(13), [uses(343, member(d, [f, d, c, b, a]))]).
substitution(345, []).
proof(345, solution([]), query, [uses(344, member(d, [e, f, d, c, b, a]))]).
substitution(346, ['X' = f]).
proof(346, member(f, [f, d, c, b, a]), rule(12), []).
substitution(347, ['X' = f, 'Rest' = [f, d, c, b, a]]).
proof(347, member(f, [e, f, d, c, b, a]), rule(13), [uses(346, member(f, [f, d, c, b, a]))]).
substitution(348, []).
proof(348, solution([]), query, [uses(347, member(f, [e, f, d, c, b, a]))]).
substitution(349, ['X' = c]).
proof(349, member(c, [c, a]), rule(12), []).
substitution(350, ['X' = c, 'Rest' = [c, a]]).
proof(350, member(c, [b, c, a]), rule(13), [uses(349, member(c, [c, a]))]).
substitution(351, ['X' = c, 'Rest' = [b, c, a]]).
proof(351, member(c, [d, b, c, a]), rule(13), [uses(350, member(c, [b, c, a]))]).
substitution(352, ['X' = c, 'Rest' = [d, b, c, a]]).
proof(352, member(c, [f, d, b, c, a]), rule(13), [uses(351, member(c, [d, b, c, a]))]).
substitution(353, ['X' = c, 'Rest' = [f, d, b, c, a]]).
proof(353, member(c, [e, f, d, b, c, a]), rule(13), [uses(352, member(c, [f, d, b, c, a]))]).
substitution(354, []).
proof(354, solution([]), query, [uses(353, member(c, [e, f, d, b, c, a]))]).
substitution(355, ['X' = d]).
proof(355, member(d, [d, b, c, a]), rule(12), []).
substitution(356, ['X' = d, 'Rest' = [d, b, c, a]]).
proof(356, member(d, [f, d, b, c, a]), rule(13), [uses(355, member(d, [d, b, c, a]))]).
substitution(357, ['X' = d, 'Rest' = [f, d, b, c, a]]).
proof(357, member(d, [e, f, d, b, c, a]), rule(13), [uses(356, member(d, [f, d, b, c, a]))]).
substitution(358, []).
proof(358, solution([]), query, [uses(357, member(d, [e, f, d, b, c, a]))]).
substitution(359, ['X' = f]).
proof(359, member(f, [f, d, b, c, a]), rule(12), []).
substitution(360, ['X' = f, 'Rest' = [f, d, b, c, a]]).
proof(360, member(f, [e, f, d, b, c, a]), rule(13), [uses(359, member(f, [f, d, b, c, a]))]).
substitution(361, []).
proof(361, solution([]), query, [uses(360, member(f, [e, f, d, b, c, a]))]).
substitution(362, ['X' = c]).
proof(362, member(c, [c, a]), rule(12), []).
substitution(363, ['X' = c, 'Rest' = [c, a]]).
proof(363, member(c, [e, c, a]), rule(13), [uses(362, member(c, [c, a]))]).
substitution(364, ['X' = c, 'Rest' = [e, c, a]]).
proof(364, member(c, [f, e, c, a]), rule(13), [uses(363, member(c, [e, c, a]))]).
substitution(365, ['X' = c, 'Rest' = [f, e, c, a]]).
proof(365, member(c, [d, f, e, c, a]), rule(13), [uses(364, member(c, [f, e, c, a]))]).
substitution(366, []).
proof(366, solution([]), query, [uses(365, member(c, [d, f, e, c, a]))]).
substitution(367, ['X' = e]).
proof(367, member(e, [e, c, a]), rule(12), []).
substitution(368, ['X' = e, 'Rest' = [e, c, a]]).
proof(368, member(e, [f, e, c, a]), rule(13), [uses(367, member(e, [e, c, a]))]).
substitution(369, ['X' = e, 'Rest' = [f, e, c, a]]).
proof(369, member(e, [d, f, e, c, a]), rule(13), [uses(368, member(e, [f, e, c, a]))]).
substitution(370, []).
proof(370, solution([]), query, [uses(369, member(e, [d, f, e, c, a]))]).
substitution(371, ['X' = f]).
proof(371, member(f, [f, e, c, a]), rule(12), []).
substitution(372, ['X' = f, 'Rest' = [f, e, c, a]]).
proof(372, member(f, [d, f, e, c, a]), rule(13), [uses(371, member(f, [f, e, c, a]))]).
substitution(373, []).
proof(373, solution([]), query, [uses(372, member(f, [d, f, e, c, a]))]).
substitution(374, ['X' = b]).
proof(374, member(b, [b, a]), rule(12), []).
substitution(375, ['X' = b, 'Rest' = [b, a]]).
proof(375, member(b, [c, b, a]), rule(13), [uses(374, member(b, [b, a]))]).
substitution(376, ['X' = b, 'Rest' = [c, b, a]]).
proof(376, member(b, [e, c, b, a]), rule(13), [uses(375, member(b, [c, b, a]))]).
substitution(377, ['X' = b, 'Rest' = [e, c, b, a]]).
proof(377, member(b, [f, e, c, b, a]), rule(13), [uses(376, member(b, [e, c, b, a]))]).
substitution(378, ['X' = b, 'Rest' = [f, e, c, b, a]]).
proof(378, member(b, [d, f, e, c, b, a]), rule(13), [uses(377, member(b, [f, e, c, b, a]))]).
substitution(379, []).
proof(379, solution([]), query, [uses(378, member(b, [d, f, e, c, b, a]))]).
substitution(380, ['X' = c]).
proof(380, member(c, [c, b, a]), rule(12), []).
substitution(381, ['X' = c, 'Rest' = [c, b, a]]).
proof(381, member(c, [e, c, b, a]), rule(13), [uses(380, member(c, [c, b, a]))]).
substitution(382, ['X' = c, 'Rest' = [e, c, b, a]]).
proof(382, member(c, [f, e, c, b, a]), rule(13), [uses(381, member(c, [e, c, b, a]))]).
substitution(383, ['X' = c, 'Rest' = [f, e, c, b, a]]).
proof(383, member(c, [d, f, e, c, b, a]), rule(13), [uses(382, member(c, [f, e, c, b, a]))]).
substitution(384, []).
proof(384, solution([]), query, [uses(383, member(c, [d, f, e, c, b, a]))]).
substitution(385, ['X' = e]).
proof(385, member(e, [e, c, b, a]), rule(12), []).
substitution(386, ['X' = e, 'Rest' = [e, c, b, a]]).
proof(386, member(e, [f, e, c, b, a]), rule(13), [uses(385, member(e, [e, c, b, a]))]).
substitution(387, ['X' = e, 'Rest' = [f, e, c, b, a]]).
proof(387, member(e, [d, f, e, c, b, a]), rule(13), [uses(386, member(e, [f, e, c, b, a]))]).
substitution(388, []).
proof(388, solution([]), query, [uses(387, member(e, [d, f, e, c, b, a]))]).
substitution(389, ['X' = f]).
proof(389, member(f, [f, e, c, b, a]), rule(12), []).
substitution(390, ['X' = f, 'Rest' = [f, e, c, b, a]]).
proof(390, member(f, [d, f, e, c, b, a]), rule(13), [uses(389, member(f, [f, e, c, b, a]))]).
substitution(391, []).
proof(391, solution([]), query, [uses(390, member(f, [d, f, e, c, b, a]))]).
substitution(392, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, d, e, f], 'Cost' = 14, 'Next' = c, 'Step' = 1, 'Remaining' = 13]).
proof(392, route(b, f, [b, a], [b, c, d, e, f], 14), rule(15), [uses(13, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(307, route(c, f, [c, b, a], [c, d, e, f], 13)), builtin(14 is 1 + 13)]).
substitution(393, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, e, d, f], 'Cost' = 19, 'Next' = c, 'Step' = 1, 'Remaining' = 18]).
proof(393, route(b, f, [b, a], [b, c, e, d, f], 19), rule(15), [uses(13, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(308, route(c, f, [c, b, a], [c, e, d, f], 18)), builtin(19 is 1 + 18)]).
substitution(394, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, c, e, f], 'Cost' = 26, 'Next' = d, 'Step' = 5, 'Remaining' = 21]).
proof(394, route(b, f, [b, a], [b, d, c, e, f], 26), rule(15), [uses(14, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(317, route(d, f, [d, b, a], [d, c, e, f], 21)), builtin(26 is 5 + 21)]).
substitution(395, ['Candidate' = 19]).
proof(395, solution([19]), query, [uses(309, route(a, f, [a], [a, b, c, d, f], 19))]).
substitution(396, ['Candidate' = 18]).
proof(396, solution([18]), query, [uses(310, route(a, f, [a], [a, b, c, e, f], 18))]).
substitution(397, ['Candidate' = 14]).
proof(397, solution([14]), query, [uses(311, route(a, f, [a], [a, b, d, e, f], 14))]).
substitution(398, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, c, d, e, f], 'Cost' = 18, 'Next' = b, 'Step' = 4, 'Remaining' = 14]).
proof(398, route(a, f, [a], [a, b, c, d, e, f], 18), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(392, route(b, f, [b, a], [b, c, d, e, f], 14)), builtin(18 is 4 + 14)]).
substitution(399, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, c, e, d, f], 'Cost' = 23, 'Next' = b, 'Step' = 4, 'Remaining' = 19]).
proof(399, route(a, f, [a], [a, b, c, e, d, f], 23), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(393, route(b, f, [b, a], [b, c, e, d, f], 19)), builtin(23 is 4 + 19)]).
substitution(400, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, d, c, e, f], 'Cost' = 30, 'Next' = b, 'Step' = 4, 'Remaining' = 26]).
proof(400, route(a, f, [a], [a, b, d, c, e, f], 30), rule(15), [uses(3, connected(a, b, 4)), absent(member(b, [a]), complete), uses(394, route(b, f, [b, a], [b, d, c, e, f], 26)), builtin(30 is 4 + 26)]).
substitution(401, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, b, d, e, f], 'Cost' = 13, 'Next' = c, 'Step' = 2, 'Remaining' = 11]).
proof(401, route(a, f, [a], [a, c, b, d, e, f], 13), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(315, route(c, f, [c, a], [c, b, d, e, f], 11)), builtin(13 is 2 + 11)]).
substitution(402, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, e, d, f], 'Cost' = 20, 'Next' = c, 'Step' = 2, 'Remaining' = 18]).
proof(402, route(a, f, [a], [a, c, e, d, f], 20), rule(15), [uses(4, connected(a, c, 2)), absent(member(c, [a]), complete), uses(316, route(c, f, [c, a], [c, e, d, f], 18)), builtin(20 is 2 + 18)]).
substitution(403, ['X' = a]).
proof(403, member(a, [a]), rule(12), []).
substitution(404, ['X' = a, 'Rest' = [a]]).
proof(404, member(a, [b, a]), rule(13), [uses(403, member(a, [a]))]).
substitution(405, ['X' = a, 'Rest' = [b, a]]).
proof(405, member(a, [d, b, a]), rule(13), [uses(404, member(a, [b, a]))]).
substitution(406, ['X' = a, 'Rest' = [d, b, a]]).
proof(406, member(a, [f, d, b, a]), rule(13), [uses(405, member(a, [d, b, a]))]).
substitution(407, ['X' = a, 'Rest' = [f, d, b, a]]).
proof(407, member(a, [e, f, d, b, a]), rule(13), [uses(406, member(a, [f, d, b, a]))]).
substitution(408, ['X' = a, 'Rest' = [e, f, d, b, a]]).
proof(408, member(a, [c, e, f, d, b, a]), rule(13), [uses(407, member(a, [e, f, d, b, a]))]).
substitution(409, []).
proof(409, solution([]), query, [uses(408, member(a, [c, e, f, d, b, a]))]).
substitution(410, ['X' = b]).
proof(410, member(b, [b, a]), rule(12), []).
substitution(411, ['X' = b, 'Rest' = [b, a]]).
proof(411, member(b, [d, b, a]), rule(13), [uses(410, member(b, [b, a]))]).
substitution(412, ['X' = b, 'Rest' = [d, b, a]]).
proof(412, member(b, [f, d, b, a]), rule(13), [uses(411, member(b, [d, b, a]))]).
substitution(413, ['X' = b, 'Rest' = [f, d, b, a]]).
proof(413, member(b, [e, f, d, b, a]), rule(13), [uses(412, member(b, [f, d, b, a]))]).
substitution(414, ['X' = b, 'Rest' = [e, f, d, b, a]]).
proof(414, member(b, [c, e, f, d, b, a]), rule(13), [uses(413, member(b, [e, f, d, b, a]))]).
substitution(415, []).
proof(415, solution([]), query, [uses(414, member(b, [c, e, f, d, b, a]))]).
substitution(416, ['X' = d]).
proof(416, member(d, [d, b, a]), rule(12), []).
substitution(417, ['X' = d, 'Rest' = [d, b, a]]).
proof(417, member(d, [f, d, b, a]), rule(13), [uses(416, member(d, [d, b, a]))]).
substitution(418, ['X' = d, 'Rest' = [f, d, b, a]]).
proof(418, member(d, [e, f, d, b, a]), rule(13), [uses(417, member(d, [f, d, b, a]))]).
substitution(419, ['X' = d, 'Rest' = [e, f, d, b, a]]).
proof(419, member(d, [c, e, f, d, b, a]), rule(13), [uses(418, member(d, [e, f, d, b, a]))]).
substitution(420, []).
proof(420, solution([]), query, [uses(419, member(d, [c, e, f, d, b, a]))]).
substitution(421, ['X' = e]).
proof(421, member(e, [e, f, d, b, a]), rule(12), []).
substitution(422, ['X' = e, 'Rest' = [e, f, d, b, a]]).
proof(422, member(e, [c, e, f, d, b, a]), rule(13), [uses(421, member(e, [e, f, d, b, a]))]).
substitution(423, []).
proof(423, solution([]), query, [uses(422, member(e, [c, e, f, d, b, a]))]).
substitution(424, ['X' = a]).
proof(424, member(a, [a]), rule(12), []).
substitution(425, ['X' = a, 'Rest' = [a]]).
proof(425, member(a, [c, a]), rule(13), [uses(424, member(a, [a]))]).
substitution(426, ['X' = a, 'Rest' = [c, a]]).
proof(426, member(a, [e, c, a]), rule(13), [uses(425, member(a, [c, a]))]).
substitution(427, ['X' = a, 'Rest' = [e, c, a]]).
proof(427, member(a, [f, e, c, a]), rule(13), [uses(426, member(a, [e, c, a]))]).
substitution(428, ['X' = a, 'Rest' = [f, e, c, a]]).
proof(428, member(a, [d, f, e, c, a]), rule(13), [uses(427, member(a, [f, e, c, a]))]).
substitution(429, ['X' = a, 'Rest' = [d, f, e, c, a]]).
proof(429, member(a, [b, d, f, e, c, a]), rule(13), [uses(428, member(a, [d, f, e, c, a]))]).
substitution(430, []).
proof(430, solution([]), query, [uses(429, member(a, [b, d, f, e, c, a]))]).
substitution(431, ['X' = c]).
proof(431, member(c, [c, a]), rule(12), []).
substitution(432, ['X' = c, 'Rest' = [c, a]]).
proof(432, member(c, [e, c, a]), rule(13), [uses(431, member(c, [c, a]))]).
substitution(433, ['X' = c, 'Rest' = [e, c, a]]).
proof(433, member(c, [f, e, c, a]), rule(13), [uses(432, member(c, [e, c, a]))]).
substitution(434, ['X' = c, 'Rest' = [f, e, c, a]]).
proof(434, member(c, [d, f, e, c, a]), rule(13), [uses(433, member(c, [f, e, c, a]))]).
substitution(435, ['X' = c, 'Rest' = [d, f, e, c, a]]).
proof(435, member(c, [b, d, f, e, c, a]), rule(13), [uses(434, member(c, [d, f, e, c, a]))]).
substitution(436, []).
proof(436, solution([]), query, [uses(435, member(c, [b, d, f, e, c, a]))]).
substitution(437, ['X' = d]).
proof(437, member(d, [d, f, e, c, a]), rule(12), []).
substitution(438, ['X' = d, 'Rest' = [d, f, e, c, a]]).
proof(438, member(d, [b, d, f, e, c, a]), rule(13), [uses(437, member(d, [d, f, e, c, a]))]).
substitution(439, []).
proof(439, solution([]), query, [uses(438, member(d, [b, d, f, e, c, a]))]).
substitution(440, ['Candidate' = 23]).
proof(440, solution([23]), query, [uses(399, route(a, f, [a], [a, b, c, e, d, f], 23))]).
substitution(441, ['Candidate' = 30]).
proof(441, solution([30]), query, [uses(400, route(a, f, [a], [a, b, d, c, e, f], 30))]).
substitution(442, ['Candidate' = 13]).
proof(442, solution([13]), query, [uses(401, route(a, f, [a], [a, c, b, d, e, f], 13))]).
substitution(443, ['Candidate' = 20]).
proof(443, solution([20]), query, [uses(402, route(a, f, [a], [a, c, e, d, f], 20))]).
substitution(444, []).
proof(444, edge(a, b, 4), rule(1), []).
substitution(445, []).
proof(445, edge(a, c, 2), rule(2), []).
substitution(446, ['Left' = a, 'Right' = b, 'Weight' = 4]).
proof(446, connected(a, b, 4), rule(11), [uses(444, edge(a, b, 4))]).
substitution(447, ['Left' = a, 'Right' = c, 'Weight' = 2]).
proof(447, connected(a, c, 2), rule(11), [uses(445, edge(a, c, 2))]).
substitution(448, []).
proof(448, edge(a, b, 4), rule(1), []).
substitution(449, []).
proof(449, edge(b, c, 1), rule(3), []).
substitution(450, []).
proof(450, edge(b, d, 5), rule(4), []).
substitution(451, []).
proof(451, edge(a, c, 2), rule(2), []).
substitution(452, []).
proof(452, edge(b, c, 1), rule(3), []).
substitution(453, []).
proof(453, edge(c, d, 8), rule(5), []).
substitution(454, []).
proof(454, edge(c, e, 10), rule(6), []).
substitution(455, ['Right' = b, 'Left' = a, 'Weight' = 4]).
proof(455, connected(b, a, 4), rule(10), [uses(448, edge(a, b, 4))]).
substitution(456, ['Left' = b, 'Right' = c, 'Weight' = 1]).
proof(456, connected(b, c, 1), rule(11), [uses(449, edge(b, c, 1))]).
substitution(457, ['Left' = b, 'Right' = d, 'Weight' = 5]).
proof(457, connected(b, d, 5), rule(11), [uses(450, edge(b, d, 5))]).
substitution(458, ['Right' = c, 'Left' = a, 'Weight' = 2]).
proof(458, connected(c, a, 2), rule(10), [uses(451, edge(a, c, 2))]).
substitution(459, ['Right' = c, 'Left' = b, 'Weight' = 1]).
proof(459, connected(c, b, 1), rule(10), [uses(452, edge(b, c, 1))]).
substitution(460, ['Left' = c, 'Right' = d, 'Weight' = 8]).
proof(460, connected(c, d, 8), rule(11), [uses(453, edge(c, d, 8))]).
substitution(461, ['Left' = c, 'Right' = e, 'Weight' = 10]).
proof(461, connected(c, e, 10), rule(11), [uses(454, edge(c, e, 10))]).
substitution(462, []).
proof(462, edge(b, d, 5), rule(4), []).
substitution(463, []).
proof(463, edge(c, d, 8), rule(5), []).
substitution(464, []).
proof(464, edge(d, e, 2), rule(7), []).
substitution(465, []).
proof(465, edge(d, f, 6), rule(8), []).
substitution(466, []).
proof(466, edge(c, e, 10), rule(6), []).
substitution(467, []).
proof(467, edge(d, e, 2), rule(7), []).
substitution(468, []).
proof(468, edge(e, f, 3), rule(9), []).
substitution(469, ['Right' = d, 'Left' = b, 'Weight' = 5]).
proof(469, connected(d, b, 5), rule(10), [uses(462, edge(b, d, 5))]).
substitution(470, ['Right' = d, 'Left' = c, 'Weight' = 8]).
proof(470, connected(d, c, 8), rule(10), [uses(463, edge(c, d, 8))]).
substitution(471, ['Left' = d, 'Right' = e, 'Weight' = 2]).
proof(471, connected(d, e, 2), rule(11), [uses(464, edge(d, e, 2))]).
substitution(472, ['Left' = d, 'Right' = f, 'Weight' = 6]).
proof(472, connected(d, f, 6), rule(11), [uses(465, edge(d, f, 6))]).
substitution(473, ['Right' = e, 'Left' = c, 'Weight' = 10]).
proof(473, connected(e, c, 10), rule(10), [uses(466, edge(c, e, 10))]).
substitution(474, ['Right' = e, 'Left' = d, 'Weight' = 2]).
proof(474, connected(e, d, 2), rule(10), [uses(467, edge(d, e, 2))]).
substitution(475, ['Left' = e, 'Right' = f, 'Weight' = 3]).
proof(475, connected(e, f, 3), rule(11), [uses(468, edge(e, f, 3))]).
substitution(476, ['Goal' = f]).
proof(476, route(f, f, [f, d, b, a], [f], 0), rule(14), []).
substitution(477, ['Goal' = f]).
proof(477, route(f, f, [f, d, c, a], [f], 0), rule(14), []).
substitution(478, ['Goal' = f]).
proof(478, route(f, f, [f, d, c, b, a], [f], 0), rule(14), []).
substitution(479, ['Goal' = f]).
proof(479, route(f, f, [f, d, b, c, a], [f], 0), rule(14), []).
substitution(480, ['Goal' = f]).
proof(480, route(f, f, [f, e, c, a], [f], 0), rule(14), []).
substitution(481, ['Goal' = f]).
proof(481, route(f, f, [f, e, c, b, a], [f], 0), rule(14), []).
substitution(482, ['Goal' = f]).
proof(482, route(f, f, [f, e, d, b, a], [f], 0), rule(14), []).
substitution(483, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(483, route(d, f, [d, b, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, b, a]), complete), uses(476, route(f, f, [f, d, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(484, ['Goal' = f]).
proof(484, route(f, f, [f, e, d, c, a], [f], 0), rule(14), []).
substitution(485, ['From' = d, 'Goal' = f, 'Visited' = [d, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(485, route(d, f, [d, c, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, c, a]), complete), uses(477, route(f, f, [f, d, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(486, ['Goal' = f]).
proof(486, route(f, f, [f, e, d, c, b, a], [f], 0), rule(14), []).
substitution(487, ['From' = d, 'Goal' = f, 'Visited' = [d, c, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(487, route(d, f, [d, c, b, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, c, b, a]), complete), uses(478, route(f, f, [f, d, c, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(488, ['Goal' = f]).
proof(488, route(f, f, [f, e, d, b, c, a], [f], 0), rule(14), []).
substitution(489, ['From' = d, 'Goal' = f, 'Visited' = [d, b, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(489, route(d, f, [d, b, c, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, b, c, a]), complete), uses(479, route(f, f, [f, d, b, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(490, ['Goal' = f]).
proof(490, route(f, f, [f, d, e, c, a], [f], 0), rule(14), []).
substitution(491, ['From' = e, 'Goal' = f, 'Visited' = [e, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(491, route(e, f, [e, c, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, c, a]), complete), uses(480, route(f, f, [f, e, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(492, ['Goal' = f]).
proof(492, route(f, f, [f, d, e, c, b, a], [f], 0), rule(14), []).
substitution(493, ['From' = e, 'Goal' = f, 'Visited' = [e, c, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(493, route(e, f, [e, c, b, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, c, b, a]), complete), uses(481, route(f, f, [f, e, c, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(494, ['Goal' = f]).
proof(494, route(f, f, [f, e, c, d, b, a], [f], 0), rule(14), []).
substitution(495, ['From' = e, 'Goal' = f, 'Visited' = [e, d, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(495, route(e, f, [e, d, b, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, d, b, a]), complete), uses(482, route(f, f, [f, e, d, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(496, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, f], 'Cost' = 11, 'Next' = d, 'Step' = 5, 'Remaining' = 6]).
proof(496, route(b, f, [b, a], [b, d, f], 11), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(483, route(d, f, [d, b, a], [d, f], 6)), builtin(11 is 5 + 6)]).
substitution(497, []).
proof(497, edge(d, f, 6), rule(8), []).
substitution(498, []).
proof(498, edge(e, f, 3), rule(9), []).
substitution(499, ['From' = e, 'Goal' = f, 'Visited' = [e, d, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(499, route(e, f, [e, d, c, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, d, c, a]), complete), uses(484, route(f, f, [f, e, d, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(500, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [d, f], 'Cost' = 14, 'Next' = d, 'Step' = 8, 'Remaining' = 6]).
proof(500, route(c, f, [c, a], [c, d, f], 14), rule(15), [uses(460, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(485, route(d, f, [d, c, a], [d, f], 6)), builtin(14 is 8 + 6)]).
substitution(501, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(501, route(c, f, [c, a], [c, e, f], 13), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(491, route(e, f, [e, c, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(502, ['From' = e, 'Goal' = f, 'Visited' = [e, d, c, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(502, route(e, f, [e, d, c, b, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, d, c, b, a]), complete), uses(486, route(f, f, [f, e, d, c, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(503, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [d, f], 'Cost' = 14, 'Next' = d, 'Step' = 8, 'Remaining' = 6]).
proof(503, route(c, f, [c, b, a], [c, d, f], 14), rule(15), [uses(460, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(487, route(d, f, [d, c, b, a], [d, f], 6)), builtin(14 is 8 + 6)]).
substitution(504, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(504, route(c, f, [c, b, a], [c, e, f], 13), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(493, route(e, f, [e, c, b, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(505, ['From' = e, 'Goal' = f, 'Visited' = [e, d, b, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(505, route(e, f, [e, d, b, c, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, d, b, c, a]), complete), uses(488, route(f, f, [f, e, d, b, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(506, ['From' = b, 'Goal' = f, 'Visited' = [b, c, a], 'Path' = [d, f], 'Cost' = 11, 'Next' = d, 'Step' = 5, 'Remaining' = 6]).
proof(506, route(b, f, [b, c, a], [b, d, f], 11), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(489, route(d, f, [d, b, c, a], [d, f], 6)), builtin(11 is 5 + 6)]).
substitution(507, ['From' = d, 'Goal' = f, 'Visited' = [d, e, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(507, route(d, f, [d, e, c, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, e, c, a]), complete), uses(490, route(f, f, [f, d, e, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(508, ['From' = d, 'Goal' = f, 'Visited' = [d, e, c, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(508, route(d, f, [d, e, c, b, a], [d, f], 6), rule(15), [uses(472, connected(d, f, 6)), absent(member(f, [d, e, c, b, a]), complete), uses(492, route(f, f, [f, d, e, c, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(509, ['From' = e, 'Goal' = f, 'Visited' = [e, c, d, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(509, route(e, f, [e, c, d, b, a], [e, f], 3), rule(15), [uses(475, connected(e, f, 3)), absent(member(f, [e, c, d, b, a]), complete), uses(494, route(f, f, [f, e, c, d, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(510, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(510, route(d, f, [d, b, a], [d, e, f], 5), rule(15), [uses(471, connected(d, e, 2)), absent(member(e, [d, b, a]), complete), uses(495, route(e, f, [e, d, b, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(511, ['Right' = f, 'Left' = d, 'Weight' = 6]).
proof(511, connected(f, d, 6), rule(10), [uses(497, edge(d, f, 6))]).
substitution(512, ['Right' = f, 'Left' = e, 'Weight' = 3]).
proof(512, connected(f, e, 3), rule(10), [uses(498, edge(e, f, 3))]).
substitution(513, ['From' = d, 'Goal' = f, 'Visited' = [d, c, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(513, route(d, f, [d, c, a], [d, e, f], 5), rule(15), [uses(471, connected(d, e, 2)), absent(member(e, [d, c, a]), complete), uses(499, route(e, f, [e, d, c, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(514, ['From' = d, 'Goal' = f, 'Visited' = [d, c, b, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(514, route(d, f, [d, c, b, a], [d, e, f], 5), rule(15), [uses(471, connected(d, e, 2)), absent(member(e, [d, c, b, a]), complete), uses(502, route(e, f, [e, d, c, b, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(515, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, d, f], 'Cost' = 15, 'Next' = c, 'Step' = 1, 'Remaining' = 14]).
proof(515, route(b, f, [b, a], [b, c, d, f], 15), rule(15), [uses(456, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(503, route(c, f, [c, b, a], [c, d, f], 14)), builtin(15 is 1 + 14)]).
substitution(516, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, e, f], 'Cost' = 14, 'Next' = c, 'Step' = 1, 'Remaining' = 13]).
proof(516, route(b, f, [b, a], [b, c, e, f], 14), rule(15), [uses(456, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(504, route(c, f, [c, b, a], [c, e, f], 13)), builtin(14 is 1 + 13)]).
substitution(517, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, e, f], 'Cost' = 10, 'Next' = d, 'Step' = 5, 'Remaining' = 5]).
proof(517, route(b, f, [b, a], [b, d, e, f], 10), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(510, route(d, f, [d, b, a], [d, e, f], 5)), builtin(10 is 5 + 5)]).
substitution(518, ['From' = d, 'Goal' = f, 'Visited' = [d, b, c, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(518, route(d, f, [d, b, c, a], [d, e, f], 5), rule(15), [uses(471, connected(d, e, 2)), absent(member(e, [d, b, c, a]), complete), uses(505, route(e, f, [e, d, b, c, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(519, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [b, d, f], 'Cost' = 12, 'Next' = b, 'Step' = 1, 'Remaining' = 11]).
proof(519, route(c, f, [c, a], [c, b, d, f], 12), rule(15), [uses(459, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(506, route(b, f, [b, c, a], [b, d, f], 11)), builtin(12 is 1 + 11)]).
substitution(520, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [d, e, f], 'Cost' = 13, 'Next' = d, 'Step' = 8, 'Remaining' = 5]).
proof(520, route(c, f, [c, a], [c, d, e, f], 13), rule(15), [uses(460, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(513, route(d, f, [d, c, a], [d, e, f], 5)), builtin(13 is 8 + 5)]).
substitution(521, ['From' = e, 'Goal' = f, 'Visited' = [e, c, a], 'Path' = [d, f], 'Cost' = 8, 'Next' = d, 'Step' = 2, 'Remaining' = 6]).
proof(521, route(e, f, [e, c, a], [e, d, f], 8), rule(15), [uses(474, connected(e, d, 2)), absent(member(d, [e, c, a]), complete), uses(507, route(d, f, [d, e, c, a], [d, f], 6)), builtin(8 is 2 + 6)]).
substitution(522, ['From' = e, 'Goal' = f, 'Visited' = [e, c, b, a], 'Path' = [d, f], 'Cost' = 8, 'Next' = d, 'Step' = 2, 'Remaining' = 6]).
proof(522, route(e, f, [e, c, b, a], [e, d, f], 8), rule(15), [uses(474, connected(e, d, 2)), absent(member(d, [e, c, b, a]), complete), uses(508, route(d, f, [d, e, c, b, a], [d, f], 6)), builtin(8 is 2 + 6)]).
substitution(523, ['From' = c, 'Goal' = f, 'Visited' = [c, d, b, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(523, route(c, f, [c, d, b, a], [c, e, f], 13), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, d, b, a]), complete), uses(509, route(e, f, [e, c, d, b, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(524, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [d, e, f], 'Cost' = 13, 'Next' = d, 'Step' = 8, 'Remaining' = 5]).
proof(524, route(c, f, [c, b, a], [c, d, e, f], 13), rule(15), [uses(460, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(514, route(d, f, [d, c, b, a], [d, e, f], 5)), builtin(13 is 8 + 5)]).
substitution(525, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [e, d, f], 'Cost' = 18, 'Next' = e, 'Step' = 10, 'Remaining' = 8]).
proof(525, route(c, f, [c, b, a], [c, e, d, f], 18), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(522, route(e, f, [e, c, b, a], [e, d, f], 8)), builtin(18 is 10 + 8)]).
substitution(526, ['From' = b, 'Goal' = f, 'Visited' = [b, c, a], 'Path' = [d, e, f], 'Cost' = 10, 'Next' = d, 'Step' = 5, 'Remaining' = 5]).
proof(526, route(b, f, [b, c, a], [b, d, e, f], 10), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(518, route(d, f, [d, b, c, a], [d, e, f], 5)), builtin(10 is 5 + 5)]).
substitution(527, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [b, d, e, f], 'Cost' = 11, 'Next' = b, 'Step' = 1, 'Remaining' = 10]).
proof(527, route(c, f, [c, a], [c, b, d, e, f], 11), rule(15), [uses(459, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(526, route(b, f, [b, c, a], [b, d, e, f], 10)), builtin(11 is 1 + 10)]).
substitution(528, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [e, d, f], 'Cost' = 18, 'Next' = e, 'Step' = 10, 'Remaining' = 8]).
proof(528, route(c, f, [c, a], [c, e, d, f], 18), rule(15), [uses(461, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(521, route(e, f, [e, c, a], [e, d, f], 8)), builtin(18 is 10 + 8)]).
substitution(529, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [c, e, f], 'Cost' = 21, 'Next' = c, 'Step' = 8, 'Remaining' = 13]).
proof(529, route(d, f, [d, b, a], [d, c, e, f], 21), rule(15), [uses(470, connected(d, c, 8)), absent(member(c, [d, b, a]), complete), uses(523, route(c, f, [c, d, b, a], [c, e, f], 13)), builtin(21 is 8 + 13)]).
substitution(530, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, d, e, f], 'Cost' = 14, 'Next' = c, 'Step' = 1, 'Remaining' = 13]).
proof(530, route(b, f, [b, a], [b, c, d, e, f], 14), rule(15), [uses(456, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(524, route(c, f, [c, b, a], [c, d, e, f], 13)), builtin(14 is 1 + 13)]).
substitution(531, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, e, d, f], 'Cost' = 19, 'Next' = c, 'Step' = 1, 'Remaining' = 18]).
proof(531, route(b, f, [b, a], [b, c, e, d, f], 19), rule(15), [uses(456, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(525, route(c, f, [c, b, a], [c, e, d, f], 18)), builtin(19 is 1 + 18)]).
substitution(532, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, c, e, f], 'Cost' = 26, 'Next' = d, 'Step' = 5, 'Remaining' = 21]).
proof(532, route(b, f, [b, a], [b, d, c, e, f], 26), rule(15), [uses(457, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(529, route(d, f, [d, b, a], [d, c, e, f], 21)), builtin(26 is 5 + 21)]).
substitution(533, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, b, d, e, f], 'Cost' = 13, 'Next' = c, 'Step' = 2, 'Remaining' = 11]).
proof(533, route(a, f, [a], [a, c, b, d, e, f], 13), rule(15), [uses(447, connected(a, c, 2)), absent(member(c, [a]), complete), uses(527, route(c, f, [c, a], [c, b, d, e, f], 11)), builtin(13 is 2 + 11)]).
substitution(534, []).
proof(534, edge(a, b, 4), rule(1), []).
substitution(535, []).
proof(535, edge(a, c, 2), rule(2), []).
substitution(536, ['Left' = a, 'Right' = b, 'Weight' = 4]).
proof(536, connected(a, b, 4), rule(11), [uses(534, edge(a, b, 4))]).
substitution(537, ['Left' = a, 'Right' = c, 'Weight' = 2]).
proof(537, connected(a, c, 2), rule(11), [uses(535, edge(a, c, 2))]).
substitution(538, []).
proof(538, edge(a, b, 4), rule(1), []).
substitution(539, []).
proof(539, edge(b, c, 1), rule(3), []).
substitution(540, []).
proof(540, edge(b, d, 5), rule(4), []).
substitution(541, []).
proof(541, edge(a, c, 2), rule(2), []).
substitution(542, []).
proof(542, edge(b, c, 1), rule(3), []).
substitution(543, []).
proof(543, edge(c, d, 8), rule(5), []).
substitution(544, []).
proof(544, edge(c, e, 10), rule(6), []).
substitution(545, ['Right' = b, 'Left' = a, 'Weight' = 4]).
proof(545, connected(b, a, 4), rule(10), [uses(538, edge(a, b, 4))]).
substitution(546, ['Left' = b, 'Right' = c, 'Weight' = 1]).
proof(546, connected(b, c, 1), rule(11), [uses(539, edge(b, c, 1))]).
substitution(547, ['Left' = b, 'Right' = d, 'Weight' = 5]).
proof(547, connected(b, d, 5), rule(11), [uses(540, edge(b, d, 5))]).
substitution(548, ['Right' = c, 'Left' = a, 'Weight' = 2]).
proof(548, connected(c, a, 2), rule(10), [uses(541, edge(a, c, 2))]).
substitution(549, ['Right' = c, 'Left' = b, 'Weight' = 1]).
proof(549, connected(c, b, 1), rule(10), [uses(542, edge(b, c, 1))]).
substitution(550, ['Left' = c, 'Right' = d, 'Weight' = 8]).
proof(550, connected(c, d, 8), rule(11), [uses(543, edge(c, d, 8))]).
substitution(551, ['Left' = c, 'Right' = e, 'Weight' = 10]).
proof(551, connected(c, e, 10), rule(11), [uses(544, edge(c, e, 10))]).
substitution(552, []).
proof(552, edge(b, d, 5), rule(4), []).
substitution(553, []).
proof(553, edge(c, d, 8), rule(5), []).
substitution(554, []).
proof(554, edge(d, e, 2), rule(7), []).
substitution(555, []).
proof(555, edge(d, f, 6), rule(8), []).
substitution(556, []).
proof(556, edge(c, e, 10), rule(6), []).
substitution(557, []).
proof(557, edge(d, e, 2), rule(7), []).
substitution(558, []).
proof(558, edge(e, f, 3), rule(9), []).
substitution(559, ['Right' = d, 'Left' = b, 'Weight' = 5]).
proof(559, connected(d, b, 5), rule(10), [uses(552, edge(b, d, 5))]).
substitution(560, ['Right' = d, 'Left' = c, 'Weight' = 8]).
proof(560, connected(d, c, 8), rule(10), [uses(553, edge(c, d, 8))]).
substitution(561, ['Left' = d, 'Right' = e, 'Weight' = 2]).
proof(561, connected(d, e, 2), rule(11), [uses(554, edge(d, e, 2))]).
substitution(562, ['Left' = d, 'Right' = f, 'Weight' = 6]).
proof(562, connected(d, f, 6), rule(11), [uses(555, edge(d, f, 6))]).
substitution(563, ['Right' = e, 'Left' = c, 'Weight' = 10]).
proof(563, connected(e, c, 10), rule(10), [uses(556, edge(c, e, 10))]).
substitution(564, ['Right' = e, 'Left' = d, 'Weight' = 2]).
proof(564, connected(e, d, 2), rule(10), [uses(557, edge(d, e, 2))]).
substitution(565, ['Left' = e, 'Right' = f, 'Weight' = 3]).
proof(565, connected(e, f, 3), rule(11), [uses(558, edge(e, f, 3))]).
substitution(566, ['Goal' = f]).
proof(566, route(f, f, [f, d, b, a], [f], 0), rule(14), []).
substitution(567, ['Goal' = f]).
proof(567, route(f, f, [f, d, c, a], [f], 0), rule(14), []).
substitution(568, ['Goal' = f]).
proof(568, route(f, f, [f, d, c, b, a], [f], 0), rule(14), []).
substitution(569, ['Goal' = f]).
proof(569, route(f, f, [f, d, b, c, a], [f], 0), rule(14), []).
substitution(570, ['Goal' = f]).
proof(570, route(f, f, [f, e, c, a], [f], 0), rule(14), []).
substitution(571, ['Goal' = f]).
proof(571, route(f, f, [f, e, c, b, a], [f], 0), rule(14), []).
substitution(572, ['Goal' = f]).
proof(572, route(f, f, [f, e, d, b, a], [f], 0), rule(14), []).
substitution(573, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(573, route(d, f, [d, b, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, b, a]), complete), uses(566, route(f, f, [f, d, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(574, ['Goal' = f]).
proof(574, route(f, f, [f, e, d, c, a], [f], 0), rule(14), []).
substitution(575, ['From' = d, 'Goal' = f, 'Visited' = [d, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(575, route(d, f, [d, c, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, c, a]), complete), uses(567, route(f, f, [f, d, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(576, ['Goal' = f]).
proof(576, route(f, f, [f, e, d, c, b, a], [f], 0), rule(14), []).
substitution(577, ['From' = d, 'Goal' = f, 'Visited' = [d, c, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(577, route(d, f, [d, c, b, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, c, b, a]), complete), uses(568, route(f, f, [f, d, c, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(578, ['Goal' = f]).
proof(578, route(f, f, [f, e, d, b, c, a], [f], 0), rule(14), []).
substitution(579, ['From' = d, 'Goal' = f, 'Visited' = [d, b, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(579, route(d, f, [d, b, c, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, b, c, a]), complete), uses(569, route(f, f, [f, d, b, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(580, ['Goal' = f]).
proof(580, route(f, f, [f, d, e, c, a], [f], 0), rule(14), []).
substitution(581, ['From' = e, 'Goal' = f, 'Visited' = [e, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(581, route(e, f, [e, c, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, c, a]), complete), uses(570, route(f, f, [f, e, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(582, ['Goal' = f]).
proof(582, route(f, f, [f, d, e, c, b, a], [f], 0), rule(14), []).
substitution(583, ['From' = e, 'Goal' = f, 'Visited' = [e, c, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(583, route(e, f, [e, c, b, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, c, b, a]), complete), uses(571, route(f, f, [f, e, c, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(584, ['Goal' = f]).
proof(584, route(f, f, [f, e, c, d, b, a], [f], 0), rule(14), []).
substitution(585, ['From' = e, 'Goal' = f, 'Visited' = [e, d, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(585, route(e, f, [e, d, b, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, d, b, a]), complete), uses(572, route(f, f, [f, e, d, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(586, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, f], 'Cost' = 11, 'Next' = d, 'Step' = 5, 'Remaining' = 6]).
proof(586, route(b, f, [b, a], [b, d, f], 11), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(573, route(d, f, [d, b, a], [d, f], 6)), builtin(11 is 5 + 6)]).
substitution(587, []).
proof(587, edge(d, f, 6), rule(8), []).
substitution(588, []).
proof(588, edge(e, f, 3), rule(9), []).
substitution(589, ['From' = e, 'Goal' = f, 'Visited' = [e, d, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(589, route(e, f, [e, d, c, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, d, c, a]), complete), uses(574, route(f, f, [f, e, d, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(590, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [d, f], 'Cost' = 14, 'Next' = d, 'Step' = 8, 'Remaining' = 6]).
proof(590, route(c, f, [c, a], [c, d, f], 14), rule(15), [uses(550, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(575, route(d, f, [d, c, a], [d, f], 6)), builtin(14 is 8 + 6)]).
substitution(591, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(591, route(c, f, [c, a], [c, e, f], 13), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(581, route(e, f, [e, c, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(592, ['From' = e, 'Goal' = f, 'Visited' = [e, d, c, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(592, route(e, f, [e, d, c, b, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, d, c, b, a]), complete), uses(576, route(f, f, [f, e, d, c, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(593, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [d, f], 'Cost' = 14, 'Next' = d, 'Step' = 8, 'Remaining' = 6]).
proof(593, route(c, f, [c, b, a], [c, d, f], 14), rule(15), [uses(550, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(577, route(d, f, [d, c, b, a], [d, f], 6)), builtin(14 is 8 + 6)]).
substitution(594, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(594, route(c, f, [c, b, a], [c, e, f], 13), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(583, route(e, f, [e, c, b, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(595, ['From' = e, 'Goal' = f, 'Visited' = [e, d, b, c, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(595, route(e, f, [e, d, b, c, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, d, b, c, a]), complete), uses(578, route(f, f, [f, e, d, b, c, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(596, ['From' = b, 'Goal' = f, 'Visited' = [b, c, a], 'Path' = [d, f], 'Cost' = 11, 'Next' = d, 'Step' = 5, 'Remaining' = 6]).
proof(596, route(b, f, [b, c, a], [b, d, f], 11), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(579, route(d, f, [d, b, c, a], [d, f], 6)), builtin(11 is 5 + 6)]).
substitution(597, ['From' = d, 'Goal' = f, 'Visited' = [d, e, c, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(597, route(d, f, [d, e, c, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, e, c, a]), complete), uses(580, route(f, f, [f, d, e, c, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(598, ['From' = d, 'Goal' = f, 'Visited' = [d, e, c, b, a], 'Path' = [f], 'Cost' = 6, 'Next' = f, 'Step' = 6, 'Remaining' = 0]).
proof(598, route(d, f, [d, e, c, b, a], [d, f], 6), rule(15), [uses(562, connected(d, f, 6)), absent(member(f, [d, e, c, b, a]), complete), uses(582, route(f, f, [f, d, e, c, b, a], [f], 0)), builtin(6 is 6 + 0)]).
substitution(599, ['From' = e, 'Goal' = f, 'Visited' = [e, c, d, b, a], 'Path' = [f], 'Cost' = 3, 'Next' = f, 'Step' = 3, 'Remaining' = 0]).
proof(599, route(e, f, [e, c, d, b, a], [e, f], 3), rule(15), [uses(565, connected(e, f, 3)), absent(member(f, [e, c, d, b, a]), complete), uses(584, route(f, f, [f, e, c, d, b, a], [f], 0)), builtin(3 is 3 + 0)]).
substitution(600, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(600, route(d, f, [d, b, a], [d, e, f], 5), rule(15), [uses(561, connected(d, e, 2)), absent(member(e, [d, b, a]), complete), uses(585, route(e, f, [e, d, b, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(601, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, d, f], 'Cost' = 15, 'Next' = b, 'Step' = 4, 'Remaining' = 11]).
proof(601, route(a, f, [a], [a, b, d, f], 15), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(586, route(b, f, [b, a], [b, d, f], 11)), builtin(15 is 4 + 11)]).
substitution(602, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, d, f], 'Cost' = 16, 'Next' = c, 'Step' = 2, 'Remaining' = 14]).
proof(602, route(a, f, [a], [a, c, d, f], 16), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(590, route(c, f, [c, a], [c, d, f], 14)), builtin(16 is 2 + 14)]).
substitution(603, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, e, f], 'Cost' = 15, 'Next' = c, 'Step' = 2, 'Remaining' = 13]).
proof(603, route(a, f, [a], [a, c, e, f], 15), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(591, route(c, f, [c, a], [c, e, f], 13)), builtin(15 is 2 + 13)]).
substitution(604, ['Right' = f, 'Left' = d, 'Weight' = 6]).
proof(604, connected(f, d, 6), rule(10), [uses(587, edge(d, f, 6))]).
substitution(605, ['Right' = f, 'Left' = e, 'Weight' = 3]).
proof(605, connected(f, e, 3), rule(10), [uses(588, edge(e, f, 3))]).
substitution(606, ['From' = d, 'Goal' = f, 'Visited' = [d, c, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(606, route(d, f, [d, c, a], [d, e, f], 5), rule(15), [uses(561, connected(d, e, 2)), absent(member(e, [d, c, a]), complete), uses(589, route(e, f, [e, d, c, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(607, ['From' = d, 'Goal' = f, 'Visited' = [d, c, b, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(607, route(d, f, [d, c, b, a], [d, e, f], 5), rule(15), [uses(561, connected(d, e, 2)), absent(member(e, [d, c, b, a]), complete), uses(592, route(e, f, [e, d, c, b, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(608, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, d, f], 'Cost' = 15, 'Next' = c, 'Step' = 1, 'Remaining' = 14]).
proof(608, route(b, f, [b, a], [b, c, d, f], 15), rule(15), [uses(546, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(593, route(c, f, [c, b, a], [c, d, f], 14)), builtin(15 is 1 + 14)]).
substitution(609, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, e, f], 'Cost' = 14, 'Next' = c, 'Step' = 1, 'Remaining' = 13]).
proof(609, route(b, f, [b, a], [b, c, e, f], 14), rule(15), [uses(546, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(594, route(c, f, [c, b, a], [c, e, f], 13)), builtin(14 is 1 + 13)]).
substitution(610, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, e, f], 'Cost' = 10, 'Next' = d, 'Step' = 5, 'Remaining' = 5]).
proof(610, route(b, f, [b, a], [b, d, e, f], 10), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(600, route(d, f, [d, b, a], [d, e, f], 5)), builtin(10 is 5 + 5)]).
substitution(611, ['From' = d, 'Goal' = f, 'Visited' = [d, b, c, a], 'Path' = [e, f], 'Cost' = 5, 'Next' = e, 'Step' = 2, 'Remaining' = 3]).
proof(611, route(d, f, [d, b, c, a], [d, e, f], 5), rule(15), [uses(561, connected(d, e, 2)), absent(member(e, [d, b, c, a]), complete), uses(595, route(e, f, [e, d, b, c, a], [e, f], 3)), builtin(5 is 2 + 3)]).
substitution(612, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [b, d, f], 'Cost' = 12, 'Next' = b, 'Step' = 1, 'Remaining' = 11]).
proof(612, route(c, f, [c, a], [c, b, d, f], 12), rule(15), [uses(549, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(596, route(b, f, [b, c, a], [b, d, f], 11)), builtin(12 is 1 + 11)]).
substitution(613, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [d, e, f], 'Cost' = 13, 'Next' = d, 'Step' = 8, 'Remaining' = 5]).
proof(613, route(c, f, [c, a], [c, d, e, f], 13), rule(15), [uses(550, connected(c, d, 8)), absent(member(d, [c, a]), complete), uses(606, route(d, f, [d, c, a], [d, e, f], 5)), builtin(13 is 8 + 5)]).
substitution(614, ['From' = e, 'Goal' = f, 'Visited' = [e, c, a], 'Path' = [d, f], 'Cost' = 8, 'Next' = d, 'Step' = 2, 'Remaining' = 6]).
proof(614, route(e, f, [e, c, a], [e, d, f], 8), rule(15), [uses(564, connected(e, d, 2)), absent(member(d, [e, c, a]), complete), uses(597, route(d, f, [d, e, c, a], [d, f], 6)), builtin(8 is 2 + 6)]).
substitution(615, ['From' = e, 'Goal' = f, 'Visited' = [e, c, b, a], 'Path' = [d, f], 'Cost' = 8, 'Next' = d, 'Step' = 2, 'Remaining' = 6]).
proof(615, route(e, f, [e, c, b, a], [e, d, f], 8), rule(15), [uses(564, connected(e, d, 2)), absent(member(d, [e, c, b, a]), complete), uses(598, route(d, f, [d, e, c, b, a], [d, f], 6)), builtin(8 is 2 + 6)]).
substitution(616, ['From' = c, 'Goal' = f, 'Visited' = [c, d, b, a], 'Path' = [e, f], 'Cost' = 13, 'Next' = e, 'Step' = 10, 'Remaining' = 3]).
proof(616, route(c, f, [c, d, b, a], [c, e, f], 13), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, d, b, a]), complete), uses(599, route(e, f, [e, c, d, b, a], [e, f], 3)), builtin(13 is 10 + 3)]).
substitution(617, ['Candidate' = 15]).
proof(617, solution([15]), query, [uses(601, route(a, f, [a], [a, b, d, f], 15))]).
substitution(618, ['Candidate' = 16]).
proof(618, solution([16]), query, [uses(602, route(a, f, [a], [a, c, d, f], 16))]).
substitution(619, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [d, e, f], 'Cost' = 13, 'Next' = d, 'Step' = 8, 'Remaining' = 5]).
proof(619, route(c, f, [c, b, a], [c, d, e, f], 13), rule(15), [uses(550, connected(c, d, 8)), absent(member(d, [c, b, a]), complete), uses(607, route(d, f, [d, c, b, a], [d, e, f], 5)), builtin(13 is 8 + 5)]).
substitution(620, ['From' = c, 'Goal' = f, 'Visited' = [c, b, a], 'Path' = [e, d, f], 'Cost' = 18, 'Next' = e, 'Step' = 10, 'Remaining' = 8]).
proof(620, route(c, f, [c, b, a], [c, e, d, f], 18), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, b, a]), complete), uses(615, route(e, f, [e, c, b, a], [e, d, f], 8)), builtin(18 is 10 + 8)]).
substitution(621, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, c, d, f], 'Cost' = 19, 'Next' = b, 'Step' = 4, 'Remaining' = 15]).
proof(621, route(a, f, [a], [a, b, c, d, f], 19), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(608, route(b, f, [b, a], [b, c, d, f], 15)), builtin(19 is 4 + 15)]).
substitution(622, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, c, e, f], 'Cost' = 18, 'Next' = b, 'Step' = 4, 'Remaining' = 14]).
proof(622, route(a, f, [a], [a, b, c, e, f], 18), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(609, route(b, f, [b, a], [b, c, e, f], 14)), builtin(18 is 4 + 14)]).
substitution(623, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, d, e, f], 'Cost' = 14, 'Next' = b, 'Step' = 4, 'Remaining' = 10]).
proof(623, route(a, f, [a], [a, b, d, e, f], 14), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(610, route(b, f, [b, a], [b, d, e, f], 10)), builtin(14 is 4 + 10)]).
substitution(624, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, b, d, f], 'Cost' = 14, 'Next' = c, 'Step' = 2, 'Remaining' = 12]).
proof(624, route(a, f, [a], [a, c, b, d, f], 14), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(612, route(c, f, [c, a], [c, b, d, f], 12)), builtin(14 is 2 + 12)]).
substitution(625, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, d, e, f], 'Cost' = 15, 'Next' = c, 'Step' = 2, 'Remaining' = 13]).
proof(625, route(a, f, [a], [a, c, d, e, f], 15), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(613, route(c, f, [c, a], [c, d, e, f], 13)), builtin(15 is 2 + 13)]).
substitution(626, ['From' = b, 'Goal' = f, 'Visited' = [b, c, a], 'Path' = [d, e, f], 'Cost' = 10, 'Next' = d, 'Step' = 5, 'Remaining' = 5]).
proof(626, route(b, f, [b, c, a], [b, d, e, f], 10), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, c, a]), complete), uses(611, route(d, f, [d, b, c, a], [d, e, f], 5)), builtin(10 is 5 + 5)]).
substitution(627, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [b, d, e, f], 'Cost' = 11, 'Next' = b, 'Step' = 1, 'Remaining' = 10]).
proof(627, route(c, f, [c, a], [c, b, d, e, f], 11), rule(15), [uses(549, connected(c, b, 1)), absent(member(b, [c, a]), complete), uses(626, route(b, f, [b, c, a], [b, d, e, f], 10)), builtin(11 is 1 + 10)]).
substitution(628, ['From' = c, 'Goal' = f, 'Visited' = [c, a], 'Path' = [e, d, f], 'Cost' = 18, 'Next' = e, 'Step' = 10, 'Remaining' = 8]).
proof(628, route(c, f, [c, a], [c, e, d, f], 18), rule(15), [uses(551, connected(c, e, 10)), absent(member(e, [c, a]), complete), uses(614, route(e, f, [e, c, a], [e, d, f], 8)), builtin(18 is 10 + 8)]).
substitution(629, ['From' = d, 'Goal' = f, 'Visited' = [d, b, a], 'Path' = [c, e, f], 'Cost' = 21, 'Next' = c, 'Step' = 8, 'Remaining' = 13]).
proof(629, route(d, f, [d, b, a], [d, c, e, f], 21), rule(15), [uses(560, connected(d, c, 8)), absent(member(c, [d, b, a]), complete), uses(616, route(c, f, [c, d, b, a], [c, e, f], 13)), builtin(21 is 8 + 13)]).
substitution(630, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, d, e, f], 'Cost' = 14, 'Next' = c, 'Step' = 1, 'Remaining' = 13]).
proof(630, route(b, f, [b, a], [b, c, d, e, f], 14), rule(15), [uses(546, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(619, route(c, f, [c, b, a], [c, d, e, f], 13)), builtin(14 is 1 + 13)]).
substitution(631, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [c, e, d, f], 'Cost' = 19, 'Next' = c, 'Step' = 1, 'Remaining' = 18]).
proof(631, route(b, f, [b, a], [b, c, e, d, f], 19), rule(15), [uses(546, connected(b, c, 1)), absent(member(c, [b, a]), complete), uses(620, route(c, f, [c, b, a], [c, e, d, f], 18)), builtin(19 is 1 + 18)]).
substitution(632, ['From' = b, 'Goal' = f, 'Visited' = [b, a], 'Path' = [d, c, e, f], 'Cost' = 26, 'Next' = d, 'Step' = 5, 'Remaining' = 21]).
proof(632, route(b, f, [b, a], [b, d, c, e, f], 26), rule(15), [uses(547, connected(b, d, 5)), absent(member(d, [b, a]), complete), uses(629, route(d, f, [d, b, a], [d, c, e, f], 21)), builtin(26 is 5 + 21)]).
substitution(633, ['Candidate' = 19]).
proof(633, solution([19]), query, [uses(621, route(a, f, [a], [a, b, c, d, f], 19))]).
substitution(634, ['Candidate' = 18]).
proof(634, solution([18]), query, [uses(622, route(a, f, [a], [a, b, c, e, f], 18))]).
substitution(635, ['Candidate' = 14]).
proof(635, solution([14]), query, [uses(623, route(a, f, [a], [a, b, d, e, f], 14))]).
substitution(636, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, c, d, e, f], 'Cost' = 18, 'Next' = b, 'Step' = 4, 'Remaining' = 14]).
proof(636, route(a, f, [a], [a, b, c, d, e, f], 18), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(630, route(b, f, [b, a], [b, c, d, e, f], 14)), builtin(18 is 4 + 14)]).
substitution(637, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, c, e, d, f], 'Cost' = 23, 'Next' = b, 'Step' = 4, 'Remaining' = 19]).
proof(637, route(a, f, [a], [a, b, c, e, d, f], 23), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(631, route(b, f, [b, a], [b, c, e, d, f], 19)), builtin(23 is 4 + 19)]).
substitution(638, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [b, d, c, e, f], 'Cost' = 30, 'Next' = b, 'Step' = 4, 'Remaining' = 26]).
proof(638, route(a, f, [a], [a, b, d, c, e, f], 30), rule(15), [uses(536, connected(a, b, 4)), absent(member(b, [a]), complete), uses(632, route(b, f, [b, a], [b, d, c, e, f], 26)), builtin(30 is 4 + 26)]).
substitution(639, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, b, d, e, f], 'Cost' = 13, 'Next' = c, 'Step' = 2, 'Remaining' = 11]).
proof(639, route(a, f, [a], [a, c, b, d, e, f], 13), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(627, route(c, f, [c, a], [c, b, d, e, f], 11)), builtin(13 is 2 + 11)]).
substitution(640, ['From' = a, 'Goal' = f, 'Visited' = [a], 'Path' = [c, e, d, f], 'Cost' = 20, 'Next' = c, 'Step' = 2, 'Remaining' = 18]).
proof(640, route(a, f, [a], [a, c, e, d, f], 20), rule(15), [uses(537, connected(a, c, 2)), absent(member(c, [a]), complete), uses(628, route(c, f, [c, a], [c, e, d, f], 18)), builtin(20 is 2 + 18)]).
substitution(641, ['Candidate' = 23]).
proof(641, solution([23]), query, [uses(637, route(a, f, [a], [a, b, c, e, d, f], 23))]).
substitution(642, ['Candidate' = 30]).
proof(642, solution([30]), query, [uses(638, route(a, f, [a], [a, b, d, c, e, f], 30))]).
substitution(643, ['Candidate' = 13]).
proof(643, solution([13]), query, [uses(639, route(a, f, [a], [a, c, b, d, e, f], 13))]).
substitution(644, ['Candidate' = 20]).
proof(644, solution([20]), query, [uses(640, route(a, f, [a], [a, c, e, d, f], 20))]).
substitution(645, ['From' = a, 'To' = f, 'Path' = [a, c, b, d, e, f], 'Cost' = 13, 'Candidate' = _0, 'Bag1' = [15, 16, 19, 18, 14, 23, 30, 13, 20], 'Costs' = [13, 14, 15, 16, 18, 19, 20, 23, 30]]).
proof(645, best(a, f, [a, c, b, d, e, f], 13), rule(16), [collected([15, 16, 19, 18, 14, 23, 30, 13, 20], _0, route(a, f, [a], _1, _0), [617, 618, 633, 634, 635, 641, 642, 643, 644], complete), builtin(sort([15, 16, 19, 18, 14, 23, 30, 13, 20], [13, 14, 15, 16, 18, 19, 20, 23, 30])), builtin(min_list([13, 14, 15, 16, 18, 19, 20, 23, 30], 13)), uses(533, route(a, f, [a], [a, c, b, d, e, f], 13))]).
substitution(646, ['Path' = [a, c, b, d, e, f], 'Cost' = 13]).
proof(646, solution([[a, c, b, d, e, f], 13]), query, [uses(645, best(a, f, [a, c, b, d, e, f], 13))]).
