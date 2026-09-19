# Eyelang result format 2
query(1, [call(cousin(?v0, ?v1))], [binding("person", ?v0), binding("cousin", ?v1)]).
result(1, complete, 12).
answer(1, [binding("person", dave), binding("cousin", frank)]).
why(1, [binding("person", dave), binding("cousin", frank)], 66).
answer(1, [binding("person", dave), binding("cousin", grace)]).
why(1, [binding("person", dave), binding("cousin", grace)], 67).
answer(1, [binding("person", eve), binding("cousin", frank)]).
why(1, [binding("person", eve), binding("cousin", frank)], 68).
answer(1, [binding("person", eve), binding("cousin", grace)]).
why(1, [binding("person", eve), binding("cousin", grace)], 69).
answer(1, [binding("person", frank), binding("cousin", dave)]).
why(1, [binding("person", frank), binding("cousin", dave)], 70).
answer(1, [binding("person", frank), binding("cousin", eve)]).
why(1, [binding("person", frank), binding("cousin", eve)], 71).
answer(1, [binding("person", grace), binding("cousin", dave)]).
why(1, [binding("person", grace), binding("cousin", dave)], 72).
answer(1, [binding("person", grace), binding("cousin", eve)]).
why(1, [binding("person", grace), binding("cousin", eve)], 73).
answer(1, [binding("person", heidi), binding("cousin", judy)]).
why(1, [binding("person", heidi), binding("cousin", judy)], 74).
answer(1, [binding("person", ivan), binding("cousin", judy)]).
why(1, [binding("person", ivan), binding("cousin", judy)], 75).
answer(1, [binding("person", judy), binding("cousin", heidi)]).
why(1, [binding("person", judy), binding("cousin", heidi)], 76).
answer(1, [binding("person", judy), binding("cousin", ivan)]).
why(1, [binding("person", judy), binding("cousin", ivan)], 77).
clause(1, parent(adam, bob), []).
clause(2, parent(adam, carol), []).
clause(3, parent(bob, dave), []).
clause(4, parent(bob, eve), []).
clause(5, parent(carol, frank), []).
clause(6, parent(carol, grace), []).
clause(7, parent(dave, heidi), []).
clause(8, parent(eve, ivan), []).
clause(9, parent(frank, judy), []).
clause(10, branch(dave, b), []).
clause(11, branch(eve, b), []).
clause(12, branch(frank, c), []).
clause(13, branch(grace, c), []).
clause(14, different(b, c), []).
clause(15, different(c, b), []).
clause(16, generation(adam, 0), []).
clause(17, generation(var("child"), var("next")), [call(parent(var("parent"), var("child"))), call(generation(var("parent"), var("current"))), calculate(var("next"), binary("+", value(var("current")), value(1)))]).
clause(18, branch(var("child"), var("branch")), [call(parent(var("parent"), var("child"))), call(branch(var("parent"), var("branch")))]).
clause(19, cousin(var("x"), var("y")), [call(generation(var("x"), var("g"))), call(generation(var("y"), var("g"))), call(branch(var("x"), var("bx"))), call(branch(var("y"), var("by"))), call(different(var("bx"), var("by")))]).
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
substitution(13, [binding("child", bob), binding("next", 1), binding("parent", adam), binding("current", 0)]).
proof(13, generation(bob, 1), rule(17), [uses(2, parent(adam, bob)), uses(12, generation(adam, 0)), calculated(1, binary("+", value(0), value(1)))]).
substitution(14, [binding("child", carol), binding("next", 1), binding("parent", adam), binding("current", 0)]).
proof(14, generation(carol, 1), rule(17), [uses(3, parent(adam, carol)), uses(12, generation(adam, 0)), calculated(1, binary("+", value(0), value(1)))]).
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
substitution(20, [binding("child", bob), binding("next", 1), binding("parent", adam), binding("current", 0)]).
proof(20, generation(bob, 1), rule(17), [uses(15, parent(adam, bob)), uses(12, generation(adam, 0)), calculated(1, binary("+", value(0), value(1)))]).
substitution(21, [binding("child", carol), binding("next", 1), binding("parent", adam), binding("current", 0)]).
proof(21, generation(carol, 1), rule(17), [uses(16, parent(adam, carol)), uses(12, generation(adam, 0)), calculated(1, binary("+", value(0), value(1)))]).
substitution(22, [binding("child", dave), binding("next", 2), binding("parent", bob), binding("current", 1)]).
proof(22, generation(dave, 2), rule(17), [uses(17, parent(bob, dave)), uses(20, generation(bob, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(23, [binding("child", eve), binding("next", 2), binding("parent", bob), binding("current", 1)]).
proof(23, generation(eve, 2), rule(17), [uses(18, parent(bob, eve)), uses(20, generation(bob, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(24, [binding("child", frank), binding("next", 2), binding("parent", carol), binding("current", 1)]).
proof(24, generation(frank, 2), rule(17), [uses(19, parent(carol, frank)), uses(21, generation(carol, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(25, [binding("child", bob), binding("next", 1), binding("parent", adam), binding("current", 0)]).
proof(25, generation(bob, 1), rule(17), [uses(2, parent(adam, bob)), uses(12, generation(adam, 0)), calculated(1, binary("+", value(0), value(1)))]).
substitution(26, [binding("child", carol), binding("next", 1), binding("parent", adam), binding("current", 0)]).
proof(26, generation(carol, 1), rule(17), [uses(3, parent(adam, carol)), uses(12, generation(adam, 0)), calculated(1, binary("+", value(0), value(1)))]).
substitution(27, [binding("child", dave), binding("next", 2), binding("parent", bob), binding("current", 1)]).
proof(27, generation(dave, 2), rule(17), [uses(4, parent(bob, dave)), uses(20, generation(bob, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(28, [binding("child", eve), binding("next", 2), binding("parent", bob), binding("current", 1)]).
proof(28, generation(eve, 2), rule(17), [uses(5, parent(bob, eve)), uses(20, generation(bob, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(29, [binding("child", frank), binding("next", 2), binding("parent", carol), binding("current", 1)]).
proof(29, generation(frank, 2), rule(17), [uses(6, parent(carol, frank)), uses(21, generation(carol, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(30, [binding("child", grace), binding("next", 2), binding("parent", carol), binding("current", 1)]).
proof(30, generation(grace, 2), rule(17), [uses(7, parent(carol, grace)), uses(21, generation(carol, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(31, [binding("child", heidi), binding("next", 3), binding("parent", dave), binding("current", 2)]).
proof(31, generation(heidi, 3), rule(17), [uses(8, parent(dave, heidi)), uses(22, generation(dave, 2)), calculated(3, binary("+", value(2), value(1)))]).
substitution(32, [binding("child", ivan), binding("next", 3), binding("parent", eve), binding("current", 2)]).
proof(32, generation(ivan, 3), rule(17), [uses(9, parent(eve, ivan)), uses(23, generation(eve, 2)), calculated(3, binary("+", value(2), value(1)))]).
substitution(33, [binding("child", judy), binding("next", 3), binding("parent", frank), binding("current", 2)]).
proof(33, generation(judy, 3), rule(17), [uses(10, parent(frank, judy)), uses(24, generation(frank, 2)), calculated(3, binary("+", value(2), value(1)))]).
substitution(34, [binding("child", dave), binding("next", 2), binding("parent", bob), binding("current", 1)]).
proof(34, generation(dave, 2), rule(17), [uses(4, parent(bob, dave)), uses(20, generation(bob, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(35, [binding("child", eve), binding("next", 2), binding("parent", bob), binding("current", 1)]).
proof(35, generation(eve, 2), rule(17), [uses(5, parent(bob, eve)), uses(20, generation(bob, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(36, [binding("child", frank), binding("next", 2), binding("parent", carol), binding("current", 1)]).
proof(36, generation(frank, 2), rule(17), [uses(6, parent(carol, frank)), uses(21, generation(carol, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(37, [binding("child", grace), binding("next", 2), binding("parent", carol), binding("current", 1)]).
proof(37, generation(grace, 2), rule(17), [uses(7, parent(carol, grace)), uses(21, generation(carol, 1)), calculated(2, binary("+", value(1), value(1)))]).
substitution(38, [binding("child", heidi), binding("next", 3), binding("parent", dave), binding("current", 2)]).
proof(38, generation(heidi, 3), rule(17), [uses(8, parent(dave, heidi)), uses(22, generation(dave, 2)), calculated(3, binary("+", value(2), value(1)))]).
substitution(39, [binding("child", ivan), binding("next", 3), binding("parent", eve), binding("current", 2)]).
proof(39, generation(ivan, 3), rule(17), [uses(9, parent(eve, ivan)), uses(23, generation(eve, 2)), calculated(3, binary("+", value(2), value(1)))]).
substitution(40, [binding("child", judy), binding("next", 3), binding("parent", frank), binding("current", 2)]).
proof(40, generation(judy, 3), rule(17), [uses(10, parent(frank, judy)), uses(24, generation(frank, 2)), calculated(3, binary("+", value(2), value(1)))]).
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
substitution(51, [binding("child", heidi), binding("branch", b), binding("parent", dave)]).
proof(51, branch(heidi, b), rule(18), [uses(46, parent(dave, heidi)), uses(41, branch(dave, b))]).
substitution(52, [binding("child", ivan), binding("branch", b), binding("parent", eve)]).
proof(52, branch(ivan, b), rule(18), [uses(47, parent(eve, ivan)), uses(42, branch(eve, b))]).
substitution(53, [binding("child", judy), binding("branch", c), binding("parent", frank)]).
proof(53, branch(judy, c), rule(18), [uses(48, parent(frank, judy)), uses(43, branch(frank, c))]).
substitution(54, [binding("x", dave), binding("y", frank), binding("g", 2), binding("bx", b), binding("by", c)]).
proof(54, cousin(dave, frank), rule(19), [uses(27, generation(dave, 2)), uses(36, generation(frank, 2)), uses(41, branch(dave, b)), uses(43, branch(frank, c)), uses(49, different(b, c))]).
substitution(55, [binding("x", dave), binding("y", grace), binding("g", 2), binding("bx", b), binding("by", c)]).
proof(55, cousin(dave, grace), rule(19), [uses(27, generation(dave, 2)), uses(37, generation(grace, 2)), uses(41, branch(dave, b)), uses(44, branch(grace, c)), uses(49, different(b, c))]).
substitution(56, [binding("x", eve), binding("y", frank), binding("g", 2), binding("bx", b), binding("by", c)]).
proof(56, cousin(eve, frank), rule(19), [uses(28, generation(eve, 2)), uses(36, generation(frank, 2)), uses(42, branch(eve, b)), uses(43, branch(frank, c)), uses(49, different(b, c))]).
substitution(57, [binding("x", eve), binding("y", grace), binding("g", 2), binding("bx", b), binding("by", c)]).
proof(57, cousin(eve, grace), rule(19), [uses(28, generation(eve, 2)), uses(37, generation(grace, 2)), uses(42, branch(eve, b)), uses(44, branch(grace, c)), uses(49, different(b, c))]).
substitution(58, [binding("x", frank), binding("y", dave), binding("g", 2), binding("bx", c), binding("by", b)]).
proof(58, cousin(frank, dave), rule(19), [uses(29, generation(frank, 2)), uses(34, generation(dave, 2)), uses(43, branch(frank, c)), uses(41, branch(dave, b)), uses(50, different(c, b))]).
substitution(59, [binding("x", frank), binding("y", eve), binding("g", 2), binding("bx", c), binding("by", b)]).
proof(59, cousin(frank, eve), rule(19), [uses(29, generation(frank, 2)), uses(35, generation(eve, 2)), uses(43, branch(frank, c)), uses(42, branch(eve, b)), uses(50, different(c, b))]).
substitution(60, [binding("x", grace), binding("y", dave), binding("g", 2), binding("bx", c), binding("by", b)]).
proof(60, cousin(grace, dave), rule(19), [uses(30, generation(grace, 2)), uses(34, generation(dave, 2)), uses(44, branch(grace, c)), uses(41, branch(dave, b)), uses(50, different(c, b))]).
substitution(61, [binding("x", grace), binding("y", eve), binding("g", 2), binding("bx", c), binding("by", b)]).
proof(61, cousin(grace, eve), rule(19), [uses(30, generation(grace, 2)), uses(35, generation(eve, 2)), uses(44, branch(grace, c)), uses(42, branch(eve, b)), uses(50, different(c, b))]).
substitution(62, [binding("x", heidi), binding("y", judy), binding("g", 3), binding("bx", b), binding("by", c)]).
proof(62, cousin(heidi, judy), rule(19), [uses(31, generation(heidi, 3)), uses(40, generation(judy, 3)), uses(51, branch(heidi, b)), uses(53, branch(judy, c)), uses(49, different(b, c))]).
substitution(63, [binding("x", ivan), binding("y", judy), binding("g", 3), binding("bx", b), binding("by", c)]).
proof(63, cousin(ivan, judy), rule(19), [uses(32, generation(ivan, 3)), uses(40, generation(judy, 3)), uses(52, branch(ivan, b)), uses(53, branch(judy, c)), uses(49, different(b, c))]).
substitution(64, [binding("x", judy), binding("y", heidi), binding("g", 3), binding("bx", c), binding("by", b)]).
proof(64, cousin(judy, heidi), rule(19), [uses(33, generation(judy, 3)), uses(38, generation(heidi, 3)), uses(53, branch(judy, c)), uses(51, branch(heidi, b)), uses(50, different(c, b))]).
substitution(65, [binding("x", judy), binding("y", ivan), binding("g", 3), binding("bx", c), binding("by", b)]).
proof(65, cousin(judy, ivan), rule(19), [uses(33, generation(judy, 3)), uses(39, generation(ivan, 3)), uses(53, branch(judy, c)), uses(52, branch(ivan, b)), uses(50, different(c, b))]).
substitution(66, [binding("person", dave), binding("cousin", frank)]).
proof(66, solution([dave, frank]), query, [uses(54, cousin(dave, frank))]).
substitution(67, [binding("person", dave), binding("cousin", grace)]).
proof(67, solution([dave, grace]), query, [uses(55, cousin(dave, grace))]).
substitution(68, [binding("person", eve), binding("cousin", frank)]).
proof(68, solution([eve, frank]), query, [uses(56, cousin(eve, frank))]).
substitution(69, [binding("person", eve), binding("cousin", grace)]).
proof(69, solution([eve, grace]), query, [uses(57, cousin(eve, grace))]).
substitution(70, [binding("person", frank), binding("cousin", dave)]).
proof(70, solution([frank, dave]), query, [uses(58, cousin(frank, dave))]).
substitution(71, [binding("person", frank), binding("cousin", eve)]).
proof(71, solution([frank, eve]), query, [uses(59, cousin(frank, eve))]).
substitution(72, [binding("person", grace), binding("cousin", dave)]).
proof(72, solution([grace, dave]), query, [uses(60, cousin(grace, dave))]).
substitution(73, [binding("person", grace), binding("cousin", eve)]).
proof(73, solution([grace, eve]), query, [uses(61, cousin(grace, eve))]).
substitution(74, [binding("person", heidi), binding("cousin", judy)]).
proof(74, solution([heidi, judy]), query, [uses(62, cousin(heidi, judy))]).
substitution(75, [binding("person", ivan), binding("cousin", judy)]).
proof(75, solution([ivan, judy]), query, [uses(63, cousin(ivan, judy))]).
substitution(76, [binding("person", judy), binding("cousin", heidi)]).
proof(76, solution([judy, heidi]), query, [uses(64, cousin(judy, heidi))]).
substitution(77, [binding("person", judy), binding("cousin", ivan)]).
proof(77, solution([judy, ivan]), query, [uses(65, cousin(judy, ivan))]).
