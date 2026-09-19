# Eyelang result format 2
query(1, [call(must_have(?v0, ?v1))], [binding("person", ?v0), binding("license", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", alice), binding("license", dogLicense)]).
why(1, [binding("person", alice), binding("license", dogLicense)], 69).
query(2, [call(dog_count(?v0, ?v1))], [binding("person", ?v0), binding("count", ?v1)]).
result(2, complete, 2).
answer(2, [binding("person", alice), binding("count", 5)]).
why(2, [binding("person", alice), binding("count", 5)], 137).
answer(2, [binding("person", bob), binding("count", 2)]).
why(2, [binding("person", bob), binding("count", 2)], 138).
clause(1, has_dog(alice, dog1), []).
clause(2, has_dog(alice, dog2), []).
clause(3, has_dog(alice, dog3), []).
clause(4, has_dog(alice, dog4), []).
clause(5, has_dog(alice, dog5), []).
clause(6, has_dog(bob, dog6), []).
clause(7, has_dog(bob, dog7), []).
clause(8, dog_count(var("person"), var("count")), [call(has_dog(var("person"), anonymous(1))), collect(var("dogs"), var("dog"), [call(has_dog(var("person"), var("dog")))]), calculate(var("count"), function("count", [value(var("dogs"))]))]).
clause(9, must_have(var("person"), dogLicense), [call(dog_count(var("person"), var("count"))), compare(">", var("count"), 4)]).
substitution(1, []).
proof(1, has_dog(alice, dog1), rule(1), []).
substitution(2, []).
proof(2, has_dog(alice, dog2), rule(2), []).
substitution(3, []).
proof(3, has_dog(alice, dog3), rule(3), []).
substitution(4, []).
proof(4, has_dog(alice, dog4), rule(4), []).
substitution(5, []).
proof(5, has_dog(alice, dog5), rule(5), []).
substitution(6, []).
proof(6, has_dog(bob, dog6), rule(6), []).
substitution(7, []).
proof(7, has_dog(bob, dog7), rule(7), []).
substitution(8, []).
proof(8, has_dog(alice, dog1), rule(1), []).
substitution(9, []).
proof(9, has_dog(alice, dog2), rule(2), []).
substitution(10, []).
proof(10, has_dog(alice, dog3), rule(3), []).
substitution(11, []).
proof(11, has_dog(alice, dog4), rule(4), []).
substitution(12, []).
proof(12, has_dog(alice, dog5), rule(5), []).
substitution(13, [binding("dog", dog1)]).
proof(13, solution([dog1]), query, [uses(8, has_dog(alice, dog1))]).
substitution(14, [binding("dog", dog2)]).
proof(14, solution([dog2]), query, [uses(9, has_dog(alice, dog2))]).
substitution(15, [binding("dog", dog3)]).
proof(15, solution([dog3]), query, [uses(10, has_dog(alice, dog3))]).
substitution(16, [binding("dog", dog4)]).
proof(16, solution([dog4]), query, [uses(11, has_dog(alice, dog4))]).
substitution(17, [binding("dog", dog5)]).
proof(17, solution([dog5]), query, [uses(12, has_dog(alice, dog5))]).
substitution(18, [binding("person", alice), binding("count", 5), binding("dogs", [dog1, dog2, dog3, dog4, dog5]), binding("dog", ?v0)]).
proof(18, dog_count(alice, 5), rule(8), [uses(1, has_dog(alice, dog1)), collected([dog1, dog2, dog3, dog4, dog5], ?v0, [call(has_dog(alice, ?v0))], [13, 14, 15, 16, 17], complete), calculated(5, function("count", [value([dog1, dog2, dog3, dog4, dog5])]))]).
substitution(19, []).
proof(19, has_dog(alice, dog1), rule(1), []).
substitution(20, []).
proof(20, has_dog(alice, dog2), rule(2), []).
substitution(21, []).
proof(21, has_dog(alice, dog3), rule(3), []).
substitution(22, []).
proof(22, has_dog(alice, dog4), rule(4), []).
substitution(23, []).
proof(23, has_dog(alice, dog5), rule(5), []).
substitution(24, [binding("dog", dog1)]).
proof(24, solution([dog1]), query, [uses(19, has_dog(alice, dog1))]).
substitution(25, [binding("dog", dog2)]).
proof(25, solution([dog2]), query, [uses(20, has_dog(alice, dog2))]).
substitution(26, [binding("dog", dog3)]).
proof(26, solution([dog3]), query, [uses(21, has_dog(alice, dog3))]).
substitution(27, [binding("dog", dog4)]).
proof(27, solution([dog4]), query, [uses(22, has_dog(alice, dog4))]).
substitution(28, [binding("dog", dog5)]).
proof(28, solution([dog5]), query, [uses(23, has_dog(alice, dog5))]).
substitution(29, []).
proof(29, has_dog(alice, dog1), rule(1), []).
substitution(30, []).
proof(30, has_dog(alice, dog2), rule(2), []).
substitution(31, []).
proof(31, has_dog(alice, dog3), rule(3), []).
substitution(32, []).
proof(32, has_dog(alice, dog4), rule(4), []).
substitution(33, []).
proof(33, has_dog(alice, dog5), rule(5), []).
substitution(34, [binding("dog", dog1)]).
proof(34, solution([dog1]), query, [uses(29, has_dog(alice, dog1))]).
substitution(35, [binding("dog", dog2)]).
proof(35, solution([dog2]), query, [uses(30, has_dog(alice, dog2))]).
substitution(36, [binding("dog", dog3)]).
proof(36, solution([dog3]), query, [uses(31, has_dog(alice, dog3))]).
substitution(37, [binding("dog", dog4)]).
proof(37, solution([dog4]), query, [uses(32, has_dog(alice, dog4))]).
substitution(38, [binding("dog", dog5)]).
proof(38, solution([dog5]), query, [uses(33, has_dog(alice, dog5))]).
substitution(39, []).
proof(39, has_dog(alice, dog1), rule(1), []).
substitution(40, []).
proof(40, has_dog(alice, dog2), rule(2), []).
substitution(41, []).
proof(41, has_dog(alice, dog3), rule(3), []).
substitution(42, []).
proof(42, has_dog(alice, dog4), rule(4), []).
substitution(43, []).
proof(43, has_dog(alice, dog5), rule(5), []).
substitution(44, [binding("dog", dog1)]).
proof(44, solution([dog1]), query, [uses(39, has_dog(alice, dog1))]).
substitution(45, [binding("dog", dog2)]).
proof(45, solution([dog2]), query, [uses(40, has_dog(alice, dog2))]).
substitution(46, [binding("dog", dog3)]).
proof(46, solution([dog3]), query, [uses(41, has_dog(alice, dog3))]).
substitution(47, [binding("dog", dog4)]).
proof(47, solution([dog4]), query, [uses(42, has_dog(alice, dog4))]).
substitution(48, [binding("dog", dog5)]).
proof(48, solution([dog5]), query, [uses(43, has_dog(alice, dog5))]).
substitution(49, []).
proof(49, has_dog(alice, dog1), rule(1), []).
substitution(50, []).
proof(50, has_dog(alice, dog2), rule(2), []).
substitution(51, []).
proof(51, has_dog(alice, dog3), rule(3), []).
substitution(52, []).
proof(52, has_dog(alice, dog4), rule(4), []).
substitution(53, []).
proof(53, has_dog(alice, dog5), rule(5), []).
substitution(54, [binding("dog", dog1)]).
proof(54, solution([dog1]), query, [uses(49, has_dog(alice, dog1))]).
substitution(55, [binding("dog", dog2)]).
proof(55, solution([dog2]), query, [uses(50, has_dog(alice, dog2))]).
substitution(56, [binding("dog", dog3)]).
proof(56, solution([dog3]), query, [uses(51, has_dog(alice, dog3))]).
substitution(57, [binding("dog", dog4)]).
proof(57, solution([dog4]), query, [uses(52, has_dog(alice, dog4))]).
substitution(58, [binding("dog", dog5)]).
proof(58, solution([dog5]), query, [uses(53, has_dog(alice, dog5))]).
substitution(59, []).
proof(59, has_dog(bob, dog6), rule(6), []).
substitution(60, []).
proof(60, has_dog(bob, dog7), rule(7), []).
substitution(61, [binding("dog", dog6)]).
proof(61, solution([dog6]), query, [uses(59, has_dog(bob, dog6))]).
substitution(62, [binding("dog", dog7)]).
proof(62, solution([dog7]), query, [uses(60, has_dog(bob, dog7))]).
substitution(63, [binding("person", bob), binding("count", 2), binding("dogs", [dog6, dog7]), binding("dog", ?v0)]).
proof(63, dog_count(bob, 2), rule(8), [uses(6, has_dog(bob, dog6)), collected([dog6, dog7], ?v0, [call(has_dog(bob, ?v0))], [61, 62], complete), calculated(2, function("count", [value([dog6, dog7])]))]).
substitution(64, []).
proof(64, has_dog(bob, dog6), rule(6), []).
substitution(65, []).
proof(65, has_dog(bob, dog7), rule(7), []).
substitution(66, [binding("dog", dog6)]).
proof(66, solution([dog6]), query, [uses(64, has_dog(bob, dog6))]).
substitution(67, [binding("dog", dog7)]).
proof(67, solution([dog7]), query, [uses(65, has_dog(bob, dog7))]).
substitution(68, [binding("person", alice), binding("count", 5)]).
proof(68, must_have(alice, dogLicense), rule(9), [uses(18, dog_count(alice, 5)), compared(">", 5, 4)]).
substitution(69, [binding("person", alice), binding("license", dogLicense)]).
proof(69, solution([alice, dogLicense]), query, [uses(68, must_have(alice, dogLicense))]).
substitution(70, []).
proof(70, has_dog(alice, dog1), rule(1), []).
substitution(71, []).
proof(71, has_dog(alice, dog2), rule(2), []).
substitution(72, []).
proof(72, has_dog(alice, dog3), rule(3), []).
substitution(73, []).
proof(73, has_dog(alice, dog4), rule(4), []).
substitution(74, []).
proof(74, has_dog(alice, dog5), rule(5), []).
substitution(75, []).
proof(75, has_dog(bob, dog6), rule(6), []).
substitution(76, []).
proof(76, has_dog(bob, dog7), rule(7), []).
substitution(77, []).
proof(77, has_dog(alice, dog1), rule(1), []).
substitution(78, []).
proof(78, has_dog(alice, dog2), rule(2), []).
substitution(79, []).
proof(79, has_dog(alice, dog3), rule(3), []).
substitution(80, []).
proof(80, has_dog(alice, dog4), rule(4), []).
substitution(81, []).
proof(81, has_dog(alice, dog5), rule(5), []).
substitution(82, [binding("dog", dog1)]).
proof(82, solution([dog1]), query, [uses(77, has_dog(alice, dog1))]).
substitution(83, [binding("dog", dog2)]).
proof(83, solution([dog2]), query, [uses(78, has_dog(alice, dog2))]).
substitution(84, [binding("dog", dog3)]).
proof(84, solution([dog3]), query, [uses(79, has_dog(alice, dog3))]).
substitution(85, [binding("dog", dog4)]).
proof(85, solution([dog4]), query, [uses(80, has_dog(alice, dog4))]).
substitution(86, [binding("dog", dog5)]).
proof(86, solution([dog5]), query, [uses(81, has_dog(alice, dog5))]).
substitution(87, [binding("person", alice), binding("count", 5), binding("dogs", [dog1, dog2, dog3, dog4, dog5]), binding("dog", ?v0)]).
proof(87, dog_count(alice, 5), rule(8), [uses(70, has_dog(alice, dog1)), collected([dog1, dog2, dog3, dog4, dog5], ?v0, [call(has_dog(alice, ?v0))], [82, 83, 84, 85, 86], complete), calculated(5, function("count", [value([dog1, dog2, dog3, dog4, dog5])]))]).
substitution(88, []).
proof(88, has_dog(alice, dog1), rule(1), []).
substitution(89, []).
proof(89, has_dog(alice, dog2), rule(2), []).
substitution(90, []).
proof(90, has_dog(alice, dog3), rule(3), []).
substitution(91, []).
proof(91, has_dog(alice, dog4), rule(4), []).
substitution(92, []).
proof(92, has_dog(alice, dog5), rule(5), []).
substitution(93, [binding("dog", dog1)]).
proof(93, solution([dog1]), query, [uses(88, has_dog(alice, dog1))]).
substitution(94, [binding("dog", dog2)]).
proof(94, solution([dog2]), query, [uses(89, has_dog(alice, dog2))]).
substitution(95, [binding("dog", dog3)]).
proof(95, solution([dog3]), query, [uses(90, has_dog(alice, dog3))]).
substitution(96, [binding("dog", dog4)]).
proof(96, solution([dog4]), query, [uses(91, has_dog(alice, dog4))]).
substitution(97, [binding("dog", dog5)]).
proof(97, solution([dog5]), query, [uses(92, has_dog(alice, dog5))]).
substitution(98, []).
proof(98, has_dog(alice, dog1), rule(1), []).
substitution(99, []).
proof(99, has_dog(alice, dog2), rule(2), []).
substitution(100, []).
proof(100, has_dog(alice, dog3), rule(3), []).
substitution(101, []).
proof(101, has_dog(alice, dog4), rule(4), []).
substitution(102, []).
proof(102, has_dog(alice, dog5), rule(5), []).
substitution(103, [binding("dog", dog1)]).
proof(103, solution([dog1]), query, [uses(98, has_dog(alice, dog1))]).
substitution(104, [binding("dog", dog2)]).
proof(104, solution([dog2]), query, [uses(99, has_dog(alice, dog2))]).
substitution(105, [binding("dog", dog3)]).
proof(105, solution([dog3]), query, [uses(100, has_dog(alice, dog3))]).
substitution(106, [binding("dog", dog4)]).
proof(106, solution([dog4]), query, [uses(101, has_dog(alice, dog4))]).
substitution(107, [binding("dog", dog5)]).
proof(107, solution([dog5]), query, [uses(102, has_dog(alice, dog5))]).
substitution(108, []).
proof(108, has_dog(alice, dog1), rule(1), []).
substitution(109, []).
proof(109, has_dog(alice, dog2), rule(2), []).
substitution(110, []).
proof(110, has_dog(alice, dog3), rule(3), []).
substitution(111, []).
proof(111, has_dog(alice, dog4), rule(4), []).
substitution(112, []).
proof(112, has_dog(alice, dog5), rule(5), []).
substitution(113, [binding("dog", dog1)]).
proof(113, solution([dog1]), query, [uses(108, has_dog(alice, dog1))]).
substitution(114, [binding("dog", dog2)]).
proof(114, solution([dog2]), query, [uses(109, has_dog(alice, dog2))]).
substitution(115, [binding("dog", dog3)]).
proof(115, solution([dog3]), query, [uses(110, has_dog(alice, dog3))]).
substitution(116, [binding("dog", dog4)]).
proof(116, solution([dog4]), query, [uses(111, has_dog(alice, dog4))]).
substitution(117, [binding("dog", dog5)]).
proof(117, solution([dog5]), query, [uses(112, has_dog(alice, dog5))]).
substitution(118, []).
proof(118, has_dog(alice, dog1), rule(1), []).
substitution(119, []).
proof(119, has_dog(alice, dog2), rule(2), []).
substitution(120, []).
proof(120, has_dog(alice, dog3), rule(3), []).
substitution(121, []).
proof(121, has_dog(alice, dog4), rule(4), []).
substitution(122, []).
proof(122, has_dog(alice, dog5), rule(5), []).
substitution(123, [binding("dog", dog1)]).
proof(123, solution([dog1]), query, [uses(118, has_dog(alice, dog1))]).
substitution(124, [binding("dog", dog2)]).
proof(124, solution([dog2]), query, [uses(119, has_dog(alice, dog2))]).
substitution(125, [binding("dog", dog3)]).
proof(125, solution([dog3]), query, [uses(120, has_dog(alice, dog3))]).
substitution(126, [binding("dog", dog4)]).
proof(126, solution([dog4]), query, [uses(121, has_dog(alice, dog4))]).
substitution(127, [binding("dog", dog5)]).
proof(127, solution([dog5]), query, [uses(122, has_dog(alice, dog5))]).
substitution(128, []).
proof(128, has_dog(bob, dog6), rule(6), []).
substitution(129, []).
proof(129, has_dog(bob, dog7), rule(7), []).
substitution(130, [binding("dog", dog6)]).
proof(130, solution([dog6]), query, [uses(128, has_dog(bob, dog6))]).
substitution(131, [binding("dog", dog7)]).
proof(131, solution([dog7]), query, [uses(129, has_dog(bob, dog7))]).
substitution(132, [binding("person", bob), binding("count", 2), binding("dogs", [dog6, dog7]), binding("dog", ?v0)]).
proof(132, dog_count(bob, 2), rule(8), [uses(75, has_dog(bob, dog6)), collected([dog6, dog7], ?v0, [call(has_dog(bob, ?v0))], [130, 131], complete), calculated(2, function("count", [value([dog6, dog7])]))]).
substitution(133, []).
proof(133, has_dog(bob, dog6), rule(6), []).
substitution(134, []).
proof(134, has_dog(bob, dog7), rule(7), []).
substitution(135, [binding("dog", dog6)]).
proof(135, solution([dog6]), query, [uses(133, has_dog(bob, dog6))]).
substitution(136, [binding("dog", dog7)]).
proof(136, solution([dog7]), query, [uses(134, has_dog(bob, dog7))]).
substitution(137, [binding("person", alice), binding("count", 5)]).
proof(137, solution([alice, 5]), query, [uses(87, dog_count(alice, 5))]).
substitution(138, [binding("person", bob), binding("count", 2)]).
proof(138, solution([bob, 2]), query, [uses(132, dog_count(bob, 2))]).
