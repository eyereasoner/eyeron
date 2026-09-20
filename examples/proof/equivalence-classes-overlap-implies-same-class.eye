# Eyelang result format 2
query(1, [call(result_query(?v0, ?v1, ?v2))], [binding("x", ?v0), binding("y", ?v1), binding("z", ?v2)]).
result(1, complete, 18).
answer(1, [binding("x", a), binding("y", b), binding("z", b)]).
why(1, [binding("x", a), binding("y", b), binding("z", b)], 109).
answer(1, [binding("x", c), binding("y", b), binding("z", b)]).
why(1, [binding("x", c), binding("y", b), binding("z", b)], 110).
answer(1, [binding("x", a), binding("y", b), binding("z", a)]).
why(1, [binding("x", a), binding("y", b), binding("z", a)], 111).
answer(1, [binding("x", b), binding("y", a), binding("z", b)]).
why(1, [binding("x", b), binding("y", a), binding("z", b)], 112).
answer(1, [binding("x", b), binding("y", c), binding("z", b)]).
why(1, [binding("x", b), binding("y", c), binding("z", b)], 113).
answer(1, [binding("x", c), binding("y", b), binding("z", c)]).
why(1, [binding("x", c), binding("y", b), binding("z", c)], 114).
answer(1, [binding("x", b), binding("y", a), binding("z", a)]).
why(1, [binding("x", b), binding("y", a), binding("z", a)], 115).
answer(1, [binding("x", b), binding("y", c), binding("z", a)]).
why(1, [binding("x", b), binding("y", c), binding("z", a)], 116).
answer(1, [binding("x", b), binding("y", c), binding("z", c)]).
why(1, [binding("x", b), binding("y", c), binding("z", c)], 117).
answer(1, [binding("x", b), binding("y", a), binding("z", c)]).
why(1, [binding("x", b), binding("y", a), binding("z", c)], 118).
answer(1, [binding("x", c), binding("y", b), binding("z", a)]).
why(1, [binding("x", c), binding("y", b), binding("z", a)], 119).
answer(1, [binding("x", a), binding("y", b), binding("z", c)]).
why(1, [binding("x", a), binding("y", b), binding("z", c)], 120).
answer(1, [binding("x", a), binding("y", c), binding("z", b)]).
why(1, [binding("x", a), binding("y", c), binding("z", b)], 127).
answer(1, [binding("x", c), binding("y", a), binding("z", b)]).
why(1, [binding("x", c), binding("y", a), binding("z", b)], 128).
answer(1, [binding("x", a), binding("y", c), binding("z", a)]).
why(1, [binding("x", a), binding("y", c), binding("z", a)], 129).
answer(1, [binding("x", c), binding("y", a), binding("z", c)]).
why(1, [binding("x", c), binding("y", a), binding("z", c)], 130).
answer(1, [binding("x", c), binding("y", a), binding("z", a)]).
why(1, [binding("x", c), binding("y", a), binding("z", a)], 131).
answer(1, [binding("x", a), binding("y", c), binding("z", c)]).
why(1, [binding("x", a), binding("y", c), binding("z", c)], 132).
clause(1, in_x(a), []).
clause(2, in_x(b), []).
clause(3, in_x(c), []).
clause(4, sim(var("x"), var("x")), [call(in_x(var("x")))]).
clause(5, sim(var("y"), var("x")), [call(sim(var("x"), var("y")))]).
clause(6, sim(var("x"), var("z")), [call(sim(var("x"), var("y"))), call(sim(var("y"), var("z")))]).
clause(7, in_class_of(var("u"), var("x")), [call(sim(var("u"), var("x")))]).
clause(8, same_class(var("x"), var("y")), [call(sim(var("x"), var("y")))]).
clause(10, shared_member_shows_same_class(var("x"), var("y"), var("z")), [call(in_class_of(var("z"), var("x"))), call(in_class_of(var("z"), var("y"))), call(same_class(var("x"), var("y")))]).
clause(11, sim(b, a), []).
clause(12, sim(b, c), []).
clause(13, result_query(var("x"), var("y"), var("z")), [call(shared_member_shows_same_class(var("x"), var("y"), var("z"))), compare("!=", var("x"), var("y"))]).
substitution(1, []).
proof(1, sim(b, a), rule(11), []).
substitution(2, []).
proof(2, sim(b, c), rule(12), []).
substitution(3, []).
proof(3, in_x(a), rule(1), []).
substitution(4, []).
proof(4, in_x(b), rule(2), []).
substitution(5, []).
proof(5, in_x(c), rule(3), []).
substitution(6, [binding("u", b), binding("x", a)]).
proof(6, in_class_of(b, a), rule(7), [uses(1, sim(b, a))]).
substitution(7, [binding("u", b), binding("x", c)]).
proof(7, in_class_of(b, c), rule(7), [uses(2, sim(b, c))]).
substitution(8, [binding("x", a)]).
proof(8, sim(a, a), rule(4), [uses(3, in_x(a))]).
substitution(9, [binding("x", b)]).
proof(9, sim(b, b), rule(4), [uses(4, in_x(b))]).
substitution(10, [binding("x", c)]).
proof(10, sim(c, c), rule(4), [uses(5, in_x(c))]).
substitution(11, [binding("y", a), binding("x", b)]).
proof(11, sim(a, b), rule(5), [uses(1, sim(b, a))]).
substitution(12, [binding("y", c), binding("x", b)]).
proof(12, sim(c, b), rule(5), [uses(2, sim(b, c))]).
substitution(13, [binding("u", a), binding("x", a)]).
proof(13, in_class_of(a, a), rule(7), [uses(8, sim(a, a))]).
substitution(14, [binding("u", b), binding("x", b)]).
proof(14, in_class_of(b, b), rule(7), [uses(9, sim(b, b))]).
substitution(15, [binding("u", c), binding("x", c)]).
proof(15, in_class_of(c, c), rule(7), [uses(10, sim(c, c))]).
substitution(16, [binding("u", a), binding("x", b)]).
proof(16, in_class_of(a, b), rule(7), [uses(11, sim(a, b))]).
substitution(17, [binding("u", c), binding("x", b)]).
proof(17, in_class_of(c, b), rule(7), [uses(12, sim(c, b))]).
substitution(18, []).
proof(18, sim(b, a), rule(11), []).
substitution(19, []).
proof(19, sim(b, c), rule(12), []).
substitution(20, [binding("u", b), binding("x", a)]).
proof(20, in_class_of(b, a), rule(7), [uses(18, sim(b, a))]).
substitution(21, [binding("u", b), binding("x", c)]).
proof(21, in_class_of(b, c), rule(7), [uses(19, sim(b, c))]).
substitution(22, []).
proof(22, in_x(a), rule(1), []).
substitution(23, [binding("x", a)]).
proof(23, sim(a, a), rule(4), [uses(22, in_x(a))]).
substitution(24, []).
proof(24, sim(b, a), rule(11), []).
substitution(25, []).
proof(25, in_x(c), rule(3), []).
substitution(26, [binding("x", c)]).
proof(26, sim(c, c), rule(4), [uses(25, in_x(c))]).
substitution(27, []).
proof(27, sim(b, c), rule(12), []).
substitution(28, []).
proof(28, in_x(b), rule(2), []).
substitution(29, [binding("x", b)]).
proof(29, sim(b, b), rule(4), [uses(28, in_x(b))]).
substitution(30, [binding("y", a), binding("x", b)]).
proof(30, sim(a, b), rule(5), [uses(18, sim(b, a))]).
substitution(31, [binding("y", c), binding("x", b)]).
proof(31, sim(c, b), rule(5), [uses(19, sim(b, c))]).
substitution(32, [binding("x", a), binding("z", c), binding("y", b)]).
proof(32, sim(a, c), rule(6), [uses(11, sim(a, b)), uses(19, sim(b, c))]).
substitution(33, [binding("x", c), binding("z", a), binding("y", b)]).
proof(33, sim(c, a), rule(6), [uses(12, sim(c, b)), uses(18, sim(b, a))]).
substitution(34, [binding("x", b)]).
proof(34, sim(b, b), rule(4), [uses(28, in_x(b))]).
substitution(35, [binding("x", a)]).
proof(35, sim(a, a), rule(4), [uses(22, in_x(a))]).
substitution(36, [binding("y", a), binding("x", b)]).
proof(36, sim(a, b), rule(5), [uses(24, sim(b, a))]).
substitution(37, [binding("x", a), binding("z", c), binding("y", b)]).
proof(37, sim(a, c), rule(6), [uses(36, sim(a, b)), uses(19, sim(b, c))]).
substitution(38, [binding("x", a)]).
proof(38, sim(a, a), rule(4), [uses(22, in_x(a))]).
substitution(39, [binding("x", b), binding("z", a), binding("y", a)]).
proof(39, sim(b, a), rule(6), [uses(18, sim(b, a)), uses(38, sim(a, a))]).
substitution(40, [binding("x", c)]).
proof(40, sim(c, c), rule(4), [uses(25, in_x(c))]).
substitution(41, [binding("y", c), binding("x", b)]).
proof(41, sim(c, b), rule(5), [uses(27, sim(b, c))]).
substitution(42, [binding("x", c), binding("z", a), binding("y", b)]).
proof(42, sim(c, a), rule(6), [uses(41, sim(c, b)), uses(18, sim(b, a))]).
substitution(43, [binding("x", c)]).
proof(43, sim(c, c), rule(4), [uses(25, in_x(c))]).
substitution(44, [binding("x", b), binding("z", c), binding("y", c)]).
proof(44, sim(b, c), rule(6), [uses(19, sim(b, c)), uses(43, sim(c, c))]).
substitution(45, [binding("y", a), binding("x", b)]).
proof(45, sim(a, b), rule(5), [uses(39, sim(b, a))]).
substitution(46, [binding("y", c), binding("x", b)]).
proof(46, sim(c, b), rule(5), [uses(44, sim(b, c))]).
substitution(47, [binding("x", b)]).
proof(47, sim(b, b), rule(4), [uses(28, in_x(b))]).
substitution(48, [binding("u", a), binding("x", c)]).
proof(48, in_class_of(a, c), rule(7), [uses(32, sim(a, c))]).
substitution(49, [binding("u", c), binding("x", a)]).
proof(49, in_class_of(c, a), rule(7), [uses(33, sim(c, a))]).
substitution(50, [binding("y", c), binding("x", a)]).
proof(50, sim(c, a), rule(5), [uses(37, sim(a, c))]).
substitution(51, [binding("y", a), binding("x", c)]).
proof(51, sim(a, c), rule(5), [uses(42, sim(c, a))]).
substitution(52, [binding("u", b), binding("x", b)]).
proof(52, in_class_of(b, b), rule(7), [uses(34, sim(b, b))]).
substitution(53, [binding("x", a), binding("y", b)]).
proof(53, same_class(a, b), rule(8), [uses(45, sim(a, b))]).
substitution(54, [binding("x", c), binding("y", b)]).
proof(54, same_class(c, b), rule(8), [uses(46, sim(c, b))]).
substitution(55, [binding("u", a), binding("x", a)]).
proof(55, in_class_of(a, a), rule(7), [uses(35, sim(a, a))]).
substitution(56, [binding("u", a), binding("x", b)]).
proof(56, in_class_of(a, b), rule(7), [uses(36, sim(a, b))]).
substitution(57, [binding("u", a), binding("x", c)]).
proof(57, in_class_of(a, c), rule(7), [uses(37, sim(a, c))]).
substitution(58, [binding("x", a), binding("y", a)]).
proof(58, same_class(a, a), rule(8), [uses(38, sim(a, a))]).
substitution(59, [binding("x", b), binding("y", a)]).
proof(59, same_class(b, a), rule(8), [uses(39, sim(b, a))]).
substitution(60, [binding("u", c), binding("x", c)]).
proof(60, in_class_of(c, c), rule(7), [uses(40, sim(c, c))]).
substitution(61, [binding("u", c), binding("x", b)]).
proof(61, in_class_of(c, b), rule(7), [uses(41, sim(c, b))]).
substitution(62, [binding("u", c), binding("x", a)]).
proof(62, in_class_of(c, a), rule(7), [uses(42, sim(c, a))]).
substitution(63, [binding("x", c), binding("z", a), binding("y", b)]).
proof(63, sim(c, a), rule(6), [uses(41, sim(c, b)), uses(39, sim(b, a))]).
substitution(64, [binding("x", c), binding("y", c)]).
proof(64, same_class(c, c), rule(8), [uses(43, sim(c, c))]).
substitution(65, [binding("y", a), binding("x", c)]).
proof(65, sim(a, c), rule(5), [uses(63, sim(c, a))]).
substitution(66, [binding("x", b), binding("y", c)]).
proof(66, same_class(b, c), rule(8), [uses(44, sim(b, c))]).
substitution(67, [binding("x", a), binding("y", a), binding("z", b)]).
proof(67, shared_member_shows_same_class(a, a, b), rule(10), [uses(6, in_class_of(b, a)), uses(20, in_class_of(b, a)), uses(58, same_class(a, a))]).
substitution(68, [binding("x", a), binding("y", b), binding("z", b)]).
proof(68, shared_member_shows_same_class(a, b, b), rule(10), [uses(6, in_class_of(b, a)), uses(52, in_class_of(b, b)), uses(53, same_class(a, b))]).
substitution(69, [binding("x", c), binding("y", c), binding("z", b)]).
proof(69, shared_member_shows_same_class(c, c, b), rule(10), [uses(7, in_class_of(b, c)), uses(21, in_class_of(b, c)), uses(64, same_class(c, c))]).
substitution(70, [binding("x", c), binding("y", b), binding("z", b)]).
proof(70, shared_member_shows_same_class(c, b, b), rule(10), [uses(7, in_class_of(b, c)), uses(52, in_class_of(b, b)), uses(54, same_class(c, b))]).
substitution(71, [binding("x", a), binding("y", a), binding("z", a)]).
proof(71, shared_member_shows_same_class(a, a, a), rule(10), [uses(13, in_class_of(a, a)), uses(55, in_class_of(a, a)), uses(58, same_class(a, a))]).
substitution(72, [binding("x", a), binding("y", b), binding("z", a)]).
proof(72, shared_member_shows_same_class(a, b, a), rule(10), [uses(13, in_class_of(a, a)), uses(56, in_class_of(a, b)), uses(53, same_class(a, b))]).
substitution(73, [binding("x", b), binding("y", a), binding("z", b)]).
proof(73, shared_member_shows_same_class(b, a, b), rule(10), [uses(14, in_class_of(b, b)), uses(20, in_class_of(b, a)), uses(59, same_class(b, a))]).
substitution(74, [binding("x", b), binding("y", c), binding("z", b)]).
proof(74, shared_member_shows_same_class(b, c, b), rule(10), [uses(14, in_class_of(b, b)), uses(21, in_class_of(b, c)), uses(66, same_class(b, c))]).
substitution(75, [binding("x", c), binding("y", c), binding("z", c)]).
proof(75, shared_member_shows_same_class(c, c, c), rule(10), [uses(15, in_class_of(c, c)), uses(60, in_class_of(c, c)), uses(64, same_class(c, c))]).
substitution(76, [binding("x", c), binding("y", b), binding("z", c)]).
proof(76, shared_member_shows_same_class(c, b, c), rule(10), [uses(15, in_class_of(c, c)), uses(61, in_class_of(c, b)), uses(54, same_class(c, b))]).
substitution(77, [binding("x", b), binding("y", a), binding("z", a)]).
proof(77, shared_member_shows_same_class(b, a, a), rule(10), [uses(16, in_class_of(a, b)), uses(55, in_class_of(a, a)), uses(59, same_class(b, a))]).
substitution(78, [binding("x", b), binding("y", c), binding("z", a)]).
proof(78, shared_member_shows_same_class(b, c, a), rule(10), [uses(16, in_class_of(a, b)), uses(57, in_class_of(a, c)), uses(66, same_class(b, c))]).
substitution(79, [binding("x", b), binding("y", c), binding("z", c)]).
proof(79, shared_member_shows_same_class(b, c, c), rule(10), [uses(17, in_class_of(c, b)), uses(60, in_class_of(c, c)), uses(66, same_class(b, c))]).
substitution(80, [binding("x", b), binding("y", a), binding("z", c)]).
proof(80, shared_member_shows_same_class(b, a, c), rule(10), [uses(17, in_class_of(c, b)), uses(62, in_class_of(c, a)), uses(59, same_class(b, a))]).
substitution(81, [binding("x", c), binding("y", b), binding("z", a)]).
proof(81, shared_member_shows_same_class(c, b, a), rule(10), [uses(48, in_class_of(a, c)), uses(56, in_class_of(a, b)), uses(54, same_class(c, b))]).
substitution(82, [binding("x", c), binding("y", c), binding("z", a)]).
proof(82, shared_member_shows_same_class(c, c, a), rule(10), [uses(48, in_class_of(a, c)), uses(57, in_class_of(a, c)), uses(64, same_class(c, c))]).
substitution(83, [binding("x", a), binding("y", b), binding("z", c)]).
proof(83, shared_member_shows_same_class(a, b, c), rule(10), [uses(49, in_class_of(c, a)), uses(61, in_class_of(c, b)), uses(53, same_class(a, b))]).
substitution(84, [binding("x", a), binding("y", a), binding("z", c)]).
proof(84, shared_member_shows_same_class(a, a, c), rule(10), [uses(49, in_class_of(c, a)), uses(62, in_class_of(c, a)), uses(58, same_class(a, a))]).
substitution(85, [binding("x", c), binding("y", a)]).
proof(85, same_class(c, a), rule(8), [uses(63, sim(c, a))]).
substitution(86, [binding("x", a), binding("y", c)]).
proof(86, same_class(a, c), rule(8), [uses(65, sim(a, c))]).
substitution(87, [binding("x", a), binding("y", b), binding("z", b)]).
proof(87, result_query(a, b, b), rule(13), [uses(68, shared_member_shows_same_class(a, b, b)), compared("!=", a, b)]).
substitution(88, [binding("x", c), binding("y", b), binding("z", b)]).
proof(88, result_query(c, b, b), rule(13), [uses(70, shared_member_shows_same_class(c, b, b)), compared("!=", c, b)]).
substitution(89, [binding("x", a), binding("y", b), binding("z", a)]).
proof(89, result_query(a, b, a), rule(13), [uses(72, shared_member_shows_same_class(a, b, a)), compared("!=", a, b)]).
substitution(90, [binding("x", b), binding("y", a), binding("z", b)]).
proof(90, result_query(b, a, b), rule(13), [uses(73, shared_member_shows_same_class(b, a, b)), compared("!=", b, a)]).
substitution(91, [binding("x", b), binding("y", c), binding("z", b)]).
proof(91, result_query(b, c, b), rule(13), [uses(74, shared_member_shows_same_class(b, c, b)), compared("!=", b, c)]).
substitution(92, [binding("x", c), binding("y", b), binding("z", c)]).
proof(92, result_query(c, b, c), rule(13), [uses(76, shared_member_shows_same_class(c, b, c)), compared("!=", c, b)]).
substitution(93, [binding("x", b), binding("y", a), binding("z", a)]).
proof(93, result_query(b, a, a), rule(13), [uses(77, shared_member_shows_same_class(b, a, a)), compared("!=", b, a)]).
substitution(94, [binding("x", b), binding("y", c), binding("z", a)]).
proof(94, result_query(b, c, a), rule(13), [uses(78, shared_member_shows_same_class(b, c, a)), compared("!=", b, c)]).
substitution(95, [binding("x", b), binding("y", c), binding("z", c)]).
proof(95, result_query(b, c, c), rule(13), [uses(79, shared_member_shows_same_class(b, c, c)), compared("!=", b, c)]).
substitution(96, [binding("x", b), binding("y", a), binding("z", c)]).
proof(96, result_query(b, a, c), rule(13), [uses(80, shared_member_shows_same_class(b, a, c)), compared("!=", b, a)]).
substitution(97, [binding("x", c), binding("y", b), binding("z", a)]).
proof(97, result_query(c, b, a), rule(13), [uses(81, shared_member_shows_same_class(c, b, a)), compared("!=", c, b)]).
substitution(98, [binding("x", a), binding("y", b), binding("z", c)]).
proof(98, result_query(a, b, c), rule(13), [uses(83, shared_member_shows_same_class(a, b, c)), compared("!=", a, b)]).
substitution(99, [binding("x", b), binding("y", b)]).
proof(99, same_class(b, b), rule(8), [uses(47, sim(b, b))]).
substitution(100, [binding("x", a), binding("y", c), binding("z", b)]).
proof(100, shared_member_shows_same_class(a, c, b), rule(10), [uses(6, in_class_of(b, a)), uses(21, in_class_of(b, c)), uses(86, same_class(a, c))]).
substitution(101, [binding("x", c), binding("y", a), binding("z", b)]).
proof(101, shared_member_shows_same_class(c, a, b), rule(10), [uses(7, in_class_of(b, c)), uses(20, in_class_of(b, a)), uses(85, same_class(c, a))]).
substitution(102, [binding("x", a), binding("y", c), binding("z", a)]).
proof(102, shared_member_shows_same_class(a, c, a), rule(10), [uses(13, in_class_of(a, a)), uses(57, in_class_of(a, c)), uses(86, same_class(a, c))]).
substitution(103, [binding("x", b), binding("y", b), binding("z", b)]).
proof(103, shared_member_shows_same_class(b, b, b), rule(10), [uses(14, in_class_of(b, b)), uses(52, in_class_of(b, b)), uses(99, same_class(b, b))]).
substitution(104, [binding("x", c), binding("y", a), binding("z", c)]).
proof(104, shared_member_shows_same_class(c, a, c), rule(10), [uses(15, in_class_of(c, c)), uses(62, in_class_of(c, a)), uses(85, same_class(c, a))]).
substitution(105, [binding("x", b), binding("y", b), binding("z", a)]).
proof(105, shared_member_shows_same_class(b, b, a), rule(10), [uses(16, in_class_of(a, b)), uses(56, in_class_of(a, b)), uses(99, same_class(b, b))]).
substitution(106, [binding("x", b), binding("y", b), binding("z", c)]).
proof(106, shared_member_shows_same_class(b, b, c), rule(10), [uses(17, in_class_of(c, b)), uses(61, in_class_of(c, b)), uses(99, same_class(b, b))]).
substitution(107, [binding("x", c), binding("y", a), binding("z", a)]).
proof(107, shared_member_shows_same_class(c, a, a), rule(10), [uses(48, in_class_of(a, c)), uses(55, in_class_of(a, a)), uses(85, same_class(c, a))]).
substitution(108, [binding("x", a), binding("y", c), binding("z", c)]).
proof(108, shared_member_shows_same_class(a, c, c), rule(10), [uses(49, in_class_of(c, a)), uses(60, in_class_of(c, c)), uses(86, same_class(a, c))]).
substitution(109, [binding("x", a), binding("y", b), binding("z", b)]).
proof(109, solution([a, b, b]), query, [uses(87, result_query(a, b, b))]).
substitution(110, [binding("x", c), binding("y", b), binding("z", b)]).
proof(110, solution([c, b, b]), query, [uses(88, result_query(c, b, b))]).
substitution(111, [binding("x", a), binding("y", b), binding("z", a)]).
proof(111, solution([a, b, a]), query, [uses(89, result_query(a, b, a))]).
substitution(112, [binding("x", b), binding("y", a), binding("z", b)]).
proof(112, solution([b, a, b]), query, [uses(90, result_query(b, a, b))]).
substitution(113, [binding("x", b), binding("y", c), binding("z", b)]).
proof(113, solution([b, c, b]), query, [uses(91, result_query(b, c, b))]).
substitution(114, [binding("x", c), binding("y", b), binding("z", c)]).
proof(114, solution([c, b, c]), query, [uses(92, result_query(c, b, c))]).
substitution(115, [binding("x", b), binding("y", a), binding("z", a)]).
proof(115, solution([b, a, a]), query, [uses(93, result_query(b, a, a))]).
substitution(116, [binding("x", b), binding("y", c), binding("z", a)]).
proof(116, solution([b, c, a]), query, [uses(94, result_query(b, c, a))]).
substitution(117, [binding("x", b), binding("y", c), binding("z", c)]).
proof(117, solution([b, c, c]), query, [uses(95, result_query(b, c, c))]).
substitution(118, [binding("x", b), binding("y", a), binding("z", c)]).
proof(118, solution([b, a, c]), query, [uses(96, result_query(b, a, c))]).
substitution(119, [binding("x", c), binding("y", b), binding("z", a)]).
proof(119, solution([c, b, a]), query, [uses(97, result_query(c, b, a))]).
substitution(120, [binding("x", a), binding("y", b), binding("z", c)]).
proof(120, solution([a, b, c]), query, [uses(98, result_query(a, b, c))]).
substitution(121, [binding("x", a), binding("y", c), binding("z", b)]).
proof(121, result_query(a, c, b), rule(13), [uses(100, shared_member_shows_same_class(a, c, b)), compared("!=", a, c)]).
substitution(122, [binding("x", c), binding("y", a), binding("z", b)]).
proof(122, result_query(c, a, b), rule(13), [uses(101, shared_member_shows_same_class(c, a, b)), compared("!=", c, a)]).
substitution(123, [binding("x", a), binding("y", c), binding("z", a)]).
proof(123, result_query(a, c, a), rule(13), [uses(102, shared_member_shows_same_class(a, c, a)), compared("!=", a, c)]).
substitution(124, [binding("x", c), binding("y", a), binding("z", c)]).
proof(124, result_query(c, a, c), rule(13), [uses(104, shared_member_shows_same_class(c, a, c)), compared("!=", c, a)]).
substitution(125, [binding("x", c), binding("y", a), binding("z", a)]).
proof(125, result_query(c, a, a), rule(13), [uses(107, shared_member_shows_same_class(c, a, a)), compared("!=", c, a)]).
substitution(126, [binding("x", a), binding("y", c), binding("z", c)]).
proof(126, result_query(a, c, c), rule(13), [uses(108, shared_member_shows_same_class(a, c, c)), compared("!=", a, c)]).
substitution(127, [binding("x", a), binding("y", c), binding("z", b)]).
proof(127, solution([a, c, b]), query, [uses(121, result_query(a, c, b))]).
substitution(128, [binding("x", c), binding("y", a), binding("z", b)]).
proof(128, solution([c, a, b]), query, [uses(122, result_query(c, a, b))]).
substitution(129, [binding("x", a), binding("y", c), binding("z", a)]).
proof(129, solution([a, c, a]), query, [uses(123, result_query(a, c, a))]).
substitution(130, [binding("x", c), binding("y", a), binding("z", c)]).
proof(130, solution([c, a, c]), query, [uses(124, result_query(c, a, c))]).
substitution(131, [binding("x", c), binding("y", a), binding("z", a)]).
proof(131, solution([c, a, a]), query, [uses(125, result_query(c, a, a))]).
substitution(132, [binding("x", a), binding("y", c), binding("z", c)]).
proof(132, solution([a, c, c]), query, [uses(126, result_query(a, c, c))]).
