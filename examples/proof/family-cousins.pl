% Prolog result format 3
query(1, cousin(_0, _1), ['Person' = _0, 'Cousin' = _1]).
result(1, complete, 12).
answer(1, ['Person' = dave, 'Cousin' = frank]).
why(1, ['Person' = dave, 'Cousin' = frank], 66).
answer(1, ['Person' = dave, 'Cousin' = grace]).
why(1, ['Person' = dave, 'Cousin' = grace], 67).
answer(1, ['Person' = eve, 'Cousin' = frank]).
why(1, ['Person' = eve, 'Cousin' = frank], 68).
answer(1, ['Person' = eve, 'Cousin' = grace]).
why(1, ['Person' = eve, 'Cousin' = grace], 69).
answer(1, ['Person' = frank, 'Cousin' = dave]).
why(1, ['Person' = frank, 'Cousin' = dave], 70).
answer(1, ['Person' = frank, 'Cousin' = eve]).
why(1, ['Person' = frank, 'Cousin' = eve], 71).
answer(1, ['Person' = grace, 'Cousin' = dave]).
why(1, ['Person' = grace, 'Cousin' = dave], 72).
answer(1, ['Person' = grace, 'Cousin' = eve]).
why(1, ['Person' = grace, 'Cousin' = eve], 73).
answer(1, ['Person' = heidi, 'Cousin' = judy]).
why(1, ['Person' = heidi, 'Cousin' = judy], 74).
answer(1, ['Person' = ivan, 'Cousin' = judy]).
why(1, ['Person' = ivan, 'Cousin' = judy], 75).
answer(1, ['Person' = judy, 'Cousin' = heidi]).
why(1, ['Person' = judy, 'Cousin' = heidi], 76).
answer(1, ['Person' = judy, 'Cousin' = ivan]).
why(1, ['Person' = judy, 'Cousin' = ivan], 77).
clause(1, parent(adam, bob), true).
clause(2, parent(adam, carol), true).
clause(3, parent(bob, dave), true).
clause(4, parent(bob, eve), true).
clause(5, parent(carol, frank), true).
clause(6, parent(carol, grace), true).
clause(7, parent(dave, heidi), true).
clause(8, parent(eve, ivan), true).
clause(9, parent(frank, judy), true).
clause(10, branch(dave, b), true).
clause(11, branch(eve, b), true).
clause(12, branch(frank, c), true).
clause(13, branch(grace, c), true).
clause(14, different(b, c), true).
clause(15, different(c, b), true).
clause(16, generation(adam, 0), true).
clause(17, generation(var('Child'), var('Next')), (parent(var('Parent'), var('Child')), generation(var('Parent'), var('Current')), var('Next') is var('Current') + 1)).
clause(18, branch(var('Child'), var('Branch')), (parent(var('Parent'), var('Child')), branch(var('Parent'), var('Branch')))).
clause(19, cousin(var('X'), var('Y')), (generation(var('X'), var('G')), generation(var('Y'), var('G')), branch(var('X'), var('Bx')), branch(var('Y'), var('By')), different(var('Bx'), var('By')))).
substitution(1, []).
proof(1, generation(adam, 0), rule(16), []).
substitution(2, []).
proof(2, parent(adam, bob), rule(1), []).
substitution(3, []).
proof(3, parent(adam, carol), rule(2), []).
substitution(4, []).
proof(4, parent(bob, dave), rule(3), []).
substitution(5, []).
proof(5, parent(bob, eve), rule(4), []).
substitution(6, []).
proof(6, parent(carol, frank), rule(5), []).
substitution(7, []).
proof(7, parent(carol, grace), rule(6), []).
substitution(8, []).
proof(8, parent(dave, heidi), rule(7), []).
substitution(9, []).
proof(9, parent(eve, ivan), rule(8), []).
substitution(10, []).
proof(10, parent(frank, judy), rule(9), []).
substitution(11, []).
proof(11, generation(adam, 0), rule(16), []).
substitution(12, []).
proof(12, generation(adam, 0), rule(16), []).
substitution(13, ['Child' = bob, 'Next' = 1, 'Parent' = adam, 'Current' = 0]).
proof(13, generation(bob, 1), rule(17), [uses(2, parent(adam, bob)), uses(12, generation(adam, 0)), builtin(1 is 0 + 1)]).
substitution(14, ['Child' = carol, 'Next' = 1, 'Parent' = adam, 'Current' = 0]).
proof(14, generation(carol, 1), rule(17), [uses(3, parent(adam, carol)), uses(12, generation(adam, 0)), builtin(1 is 0 + 1)]).
substitution(15, []).
proof(15, parent(adam, bob), rule(1), []).
substitution(16, []).
proof(16, parent(adam, carol), rule(2), []).
substitution(17, []).
proof(17, parent(bob, dave), rule(3), []).
substitution(18, []).
proof(18, parent(bob, eve), rule(4), []).
substitution(19, []).
proof(19, parent(carol, frank), rule(5), []).
substitution(20, ['Child' = bob, 'Next' = 1, 'Parent' = adam, 'Current' = 0]).
proof(20, generation(bob, 1), rule(17), [uses(15, parent(adam, bob)), uses(12, generation(adam, 0)), builtin(1 is 0 + 1)]).
substitution(21, ['Child' = carol, 'Next' = 1, 'Parent' = adam, 'Current' = 0]).
proof(21, generation(carol, 1), rule(17), [uses(16, parent(adam, carol)), uses(12, generation(adam, 0)), builtin(1 is 0 + 1)]).
substitution(22, ['Child' = dave, 'Next' = 2, 'Parent' = bob, 'Current' = 1]).
proof(22, generation(dave, 2), rule(17), [uses(17, parent(bob, dave)), uses(20, generation(bob, 1)), builtin(2 is 1 + 1)]).
substitution(23, ['Child' = eve, 'Next' = 2, 'Parent' = bob, 'Current' = 1]).
proof(23, generation(eve, 2), rule(17), [uses(18, parent(bob, eve)), uses(20, generation(bob, 1)), builtin(2 is 1 + 1)]).
substitution(24, ['Child' = frank, 'Next' = 2, 'Parent' = carol, 'Current' = 1]).
proof(24, generation(frank, 2), rule(17), [uses(19, parent(carol, frank)), uses(21, generation(carol, 1)), builtin(2 is 1 + 1)]).
substitution(25, ['Child' = bob, 'Next' = 1, 'Parent' = adam, 'Current' = 0]).
proof(25, generation(bob, 1), rule(17), [uses(2, parent(adam, bob)), uses(12, generation(adam, 0)), builtin(1 is 0 + 1)]).
substitution(26, ['Child' = carol, 'Next' = 1, 'Parent' = adam, 'Current' = 0]).
proof(26, generation(carol, 1), rule(17), [uses(3, parent(adam, carol)), uses(12, generation(adam, 0)), builtin(1 is 0 + 1)]).
substitution(27, ['Child' = dave, 'Next' = 2, 'Parent' = bob, 'Current' = 1]).
proof(27, generation(dave, 2), rule(17), [uses(4, parent(bob, dave)), uses(20, generation(bob, 1)), builtin(2 is 1 + 1)]).
substitution(28, ['Child' = eve, 'Next' = 2, 'Parent' = bob, 'Current' = 1]).
proof(28, generation(eve, 2), rule(17), [uses(5, parent(bob, eve)), uses(20, generation(bob, 1)), builtin(2 is 1 + 1)]).
substitution(29, ['Child' = frank, 'Next' = 2, 'Parent' = carol, 'Current' = 1]).
proof(29, generation(frank, 2), rule(17), [uses(6, parent(carol, frank)), uses(21, generation(carol, 1)), builtin(2 is 1 + 1)]).
substitution(30, ['Child' = grace, 'Next' = 2, 'Parent' = carol, 'Current' = 1]).
proof(30, generation(grace, 2), rule(17), [uses(7, parent(carol, grace)), uses(21, generation(carol, 1)), builtin(2 is 1 + 1)]).
substitution(31, ['Child' = heidi, 'Next' = 3, 'Parent' = dave, 'Current' = 2]).
proof(31, generation(heidi, 3), rule(17), [uses(8, parent(dave, heidi)), uses(22, generation(dave, 2)), builtin(3 is 2 + 1)]).
substitution(32, ['Child' = ivan, 'Next' = 3, 'Parent' = eve, 'Current' = 2]).
proof(32, generation(ivan, 3), rule(17), [uses(9, parent(eve, ivan)), uses(23, generation(eve, 2)), builtin(3 is 2 + 1)]).
substitution(33, ['Child' = judy, 'Next' = 3, 'Parent' = frank, 'Current' = 2]).
proof(33, generation(judy, 3), rule(17), [uses(10, parent(frank, judy)), uses(24, generation(frank, 2)), builtin(3 is 2 + 1)]).
substitution(34, ['Child' = dave, 'Next' = 2, 'Parent' = bob, 'Current' = 1]).
proof(34, generation(dave, 2), rule(17), [uses(4, parent(bob, dave)), uses(20, generation(bob, 1)), builtin(2 is 1 + 1)]).
substitution(35, ['Child' = eve, 'Next' = 2, 'Parent' = bob, 'Current' = 1]).
proof(35, generation(eve, 2), rule(17), [uses(5, parent(bob, eve)), uses(20, generation(bob, 1)), builtin(2 is 1 + 1)]).
substitution(36, ['Child' = frank, 'Next' = 2, 'Parent' = carol, 'Current' = 1]).
proof(36, generation(frank, 2), rule(17), [uses(6, parent(carol, frank)), uses(21, generation(carol, 1)), builtin(2 is 1 + 1)]).
substitution(37, ['Child' = grace, 'Next' = 2, 'Parent' = carol, 'Current' = 1]).
proof(37, generation(grace, 2), rule(17), [uses(7, parent(carol, grace)), uses(21, generation(carol, 1)), builtin(2 is 1 + 1)]).
substitution(38, ['Child' = heidi, 'Next' = 3, 'Parent' = dave, 'Current' = 2]).
proof(38, generation(heidi, 3), rule(17), [uses(8, parent(dave, heidi)), uses(22, generation(dave, 2)), builtin(3 is 2 + 1)]).
substitution(39, ['Child' = ivan, 'Next' = 3, 'Parent' = eve, 'Current' = 2]).
proof(39, generation(ivan, 3), rule(17), [uses(9, parent(eve, ivan)), uses(23, generation(eve, 2)), builtin(3 is 2 + 1)]).
substitution(40, ['Child' = judy, 'Next' = 3, 'Parent' = frank, 'Current' = 2]).
proof(40, generation(judy, 3), rule(17), [uses(10, parent(frank, judy)), uses(24, generation(frank, 2)), builtin(3 is 2 + 1)]).
substitution(41, []).
proof(41, branch(dave, b), rule(10), []).
substitution(42, []).
proof(42, branch(eve, b), rule(11), []).
substitution(43, []).
proof(43, branch(frank, c), rule(12), []).
substitution(44, []).
proof(44, branch(grace, c), rule(13), []).
substitution(45, []).
proof(45, parent(carol, grace), rule(6), []).
substitution(46, []).
proof(46, parent(dave, heidi), rule(7), []).
substitution(47, []).
proof(47, parent(eve, ivan), rule(8), []).
substitution(48, []).
proof(48, parent(frank, judy), rule(9), []).
substitution(49, []).
proof(49, different(b, c), rule(14), []).
substitution(50, []).
proof(50, different(c, b), rule(15), []).
substitution(51, ['Child' = heidi, 'Branch' = b, 'Parent' = dave]).
proof(51, branch(heidi, b), rule(18), [uses(46, parent(dave, heidi)), uses(41, branch(dave, b))]).
substitution(52, ['Child' = ivan, 'Branch' = b, 'Parent' = eve]).
proof(52, branch(ivan, b), rule(18), [uses(47, parent(eve, ivan)), uses(42, branch(eve, b))]).
substitution(53, ['Child' = judy, 'Branch' = c, 'Parent' = frank]).
proof(53, branch(judy, c), rule(18), [uses(48, parent(frank, judy)), uses(43, branch(frank, c))]).
substitution(54, ['X' = dave, 'Y' = frank, 'G' = 2, 'Bx' = b, 'By' = c]).
proof(54, cousin(dave, frank), rule(19), [uses(27, generation(dave, 2)), uses(36, generation(frank, 2)), uses(41, branch(dave, b)), uses(43, branch(frank, c)), uses(49, different(b, c))]).
substitution(55, ['X' = dave, 'Y' = grace, 'G' = 2, 'Bx' = b, 'By' = c]).
proof(55, cousin(dave, grace), rule(19), [uses(27, generation(dave, 2)), uses(37, generation(grace, 2)), uses(41, branch(dave, b)), uses(44, branch(grace, c)), uses(49, different(b, c))]).
substitution(56, ['X' = eve, 'Y' = frank, 'G' = 2, 'Bx' = b, 'By' = c]).
proof(56, cousin(eve, frank), rule(19), [uses(28, generation(eve, 2)), uses(36, generation(frank, 2)), uses(42, branch(eve, b)), uses(43, branch(frank, c)), uses(49, different(b, c))]).
substitution(57, ['X' = eve, 'Y' = grace, 'G' = 2, 'Bx' = b, 'By' = c]).
proof(57, cousin(eve, grace), rule(19), [uses(28, generation(eve, 2)), uses(37, generation(grace, 2)), uses(42, branch(eve, b)), uses(44, branch(grace, c)), uses(49, different(b, c))]).
substitution(58, ['X' = frank, 'Y' = dave, 'G' = 2, 'Bx' = c, 'By' = b]).
proof(58, cousin(frank, dave), rule(19), [uses(29, generation(frank, 2)), uses(34, generation(dave, 2)), uses(43, branch(frank, c)), uses(41, branch(dave, b)), uses(50, different(c, b))]).
substitution(59, ['X' = frank, 'Y' = eve, 'G' = 2, 'Bx' = c, 'By' = b]).
proof(59, cousin(frank, eve), rule(19), [uses(29, generation(frank, 2)), uses(35, generation(eve, 2)), uses(43, branch(frank, c)), uses(42, branch(eve, b)), uses(50, different(c, b))]).
substitution(60, ['X' = grace, 'Y' = dave, 'G' = 2, 'Bx' = c, 'By' = b]).
proof(60, cousin(grace, dave), rule(19), [uses(30, generation(grace, 2)), uses(34, generation(dave, 2)), uses(44, branch(grace, c)), uses(41, branch(dave, b)), uses(50, different(c, b))]).
substitution(61, ['X' = grace, 'Y' = eve, 'G' = 2, 'Bx' = c, 'By' = b]).
proof(61, cousin(grace, eve), rule(19), [uses(30, generation(grace, 2)), uses(35, generation(eve, 2)), uses(44, branch(grace, c)), uses(42, branch(eve, b)), uses(50, different(c, b))]).
substitution(62, ['X' = heidi, 'Y' = judy, 'G' = 3, 'Bx' = b, 'By' = c]).
proof(62, cousin(heidi, judy), rule(19), [uses(31, generation(heidi, 3)), uses(40, generation(judy, 3)), uses(51, branch(heidi, b)), uses(53, branch(judy, c)), uses(49, different(b, c))]).
substitution(63, ['X' = ivan, 'Y' = judy, 'G' = 3, 'Bx' = b, 'By' = c]).
proof(63, cousin(ivan, judy), rule(19), [uses(32, generation(ivan, 3)), uses(40, generation(judy, 3)), uses(52, branch(ivan, b)), uses(53, branch(judy, c)), uses(49, different(b, c))]).
substitution(64, ['X' = judy, 'Y' = heidi, 'G' = 3, 'Bx' = c, 'By' = b]).
proof(64, cousin(judy, heidi), rule(19), [uses(33, generation(judy, 3)), uses(38, generation(heidi, 3)), uses(53, branch(judy, c)), uses(51, branch(heidi, b)), uses(50, different(c, b))]).
substitution(65, ['X' = judy, 'Y' = ivan, 'G' = 3, 'Bx' = c, 'By' = b]).
proof(65, cousin(judy, ivan), rule(19), [uses(33, generation(judy, 3)), uses(39, generation(ivan, 3)), uses(53, branch(judy, c)), uses(52, branch(ivan, b)), uses(50, different(c, b))]).
substitution(66, ['Person' = dave, 'Cousin' = frank]).
proof(66, solution([dave, frank]), query, [uses(54, cousin(dave, frank))]).
substitution(67, ['Person' = dave, 'Cousin' = grace]).
proof(67, solution([dave, grace]), query, [uses(55, cousin(dave, grace))]).
substitution(68, ['Person' = eve, 'Cousin' = frank]).
proof(68, solution([eve, frank]), query, [uses(56, cousin(eve, frank))]).
substitution(69, ['Person' = eve, 'Cousin' = grace]).
proof(69, solution([eve, grace]), query, [uses(57, cousin(eve, grace))]).
substitution(70, ['Person' = frank, 'Cousin' = dave]).
proof(70, solution([frank, dave]), query, [uses(58, cousin(frank, dave))]).
substitution(71, ['Person' = frank, 'Cousin' = eve]).
proof(71, solution([frank, eve]), query, [uses(59, cousin(frank, eve))]).
substitution(72, ['Person' = grace, 'Cousin' = dave]).
proof(72, solution([grace, dave]), query, [uses(60, cousin(grace, dave))]).
substitution(73, ['Person' = grace, 'Cousin' = eve]).
proof(73, solution([grace, eve]), query, [uses(61, cousin(grace, eve))]).
substitution(74, ['Person' = heidi, 'Cousin' = judy]).
proof(74, solution([heidi, judy]), query, [uses(62, cousin(heidi, judy))]).
substitution(75, ['Person' = ivan, 'Cousin' = judy]).
proof(75, solution([ivan, judy]), query, [uses(63, cousin(ivan, judy))]).
substitution(76, ['Person' = judy, 'Cousin' = heidi]).
proof(76, solution([judy, heidi]), query, [uses(64, cousin(judy, heidi))]).
substitution(77, ['Person' = judy, 'Cousin' = ivan]).
proof(77, solution([judy, ivan]), query, [uses(65, cousin(judy, ivan))]).
