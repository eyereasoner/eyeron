% Prolog result format 3
query(1, result_query(_0, _1, _2), ['X' = _0, 'Y' = _1, 'Z' = _2]).
result(1, complete, 18).
answer(1, ['X' = a, 'Y' = b, 'Z' = b]).
why(1, ['X' = a, 'Y' = b, 'Z' = b], 109).
answer(1, ['X' = c, 'Y' = b, 'Z' = b]).
why(1, ['X' = c, 'Y' = b, 'Z' = b], 110).
answer(1, ['X' = a, 'Y' = b, 'Z' = a]).
why(1, ['X' = a, 'Y' = b, 'Z' = a], 111).
answer(1, ['X' = b, 'Y' = a, 'Z' = b]).
why(1, ['X' = b, 'Y' = a, 'Z' = b], 112).
answer(1, ['X' = b, 'Y' = c, 'Z' = b]).
why(1, ['X' = b, 'Y' = c, 'Z' = b], 113).
answer(1, ['X' = c, 'Y' = b, 'Z' = c]).
why(1, ['X' = c, 'Y' = b, 'Z' = c], 114).
answer(1, ['X' = b, 'Y' = a, 'Z' = a]).
why(1, ['X' = b, 'Y' = a, 'Z' = a], 115).
answer(1, ['X' = b, 'Y' = c, 'Z' = a]).
why(1, ['X' = b, 'Y' = c, 'Z' = a], 116).
answer(1, ['X' = b, 'Y' = c, 'Z' = c]).
why(1, ['X' = b, 'Y' = c, 'Z' = c], 117).
answer(1, ['X' = b, 'Y' = a, 'Z' = c]).
why(1, ['X' = b, 'Y' = a, 'Z' = c], 118).
answer(1, ['X' = c, 'Y' = b, 'Z' = a]).
why(1, ['X' = c, 'Y' = b, 'Z' = a], 119).
answer(1, ['X' = a, 'Y' = b, 'Z' = c]).
why(1, ['X' = a, 'Y' = b, 'Z' = c], 120).
answer(1, ['X' = a, 'Y' = c, 'Z' = b]).
why(1, ['X' = a, 'Y' = c, 'Z' = b], 127).
answer(1, ['X' = c, 'Y' = a, 'Z' = b]).
why(1, ['X' = c, 'Y' = a, 'Z' = b], 128).
answer(1, ['X' = a, 'Y' = c, 'Z' = a]).
why(1, ['X' = a, 'Y' = c, 'Z' = a], 129).
answer(1, ['X' = c, 'Y' = a, 'Z' = c]).
why(1, ['X' = c, 'Y' = a, 'Z' = c], 130).
answer(1, ['X' = c, 'Y' = a, 'Z' = a]).
why(1, ['X' = c, 'Y' = a, 'Z' = a], 131).
answer(1, ['X' = a, 'Y' = c, 'Z' = c]).
why(1, ['X' = a, 'Y' = c, 'Z' = c], 132).
clause(1, in_x(a), true).
clause(2, in_x(b), true).
clause(3, in_x(c), true).
clause(4, sim(var('X'), var('X')), in_x(var('X'))).
clause(5, sim(var('Y'), var('X')), sim(var('X'), var('Y'))).
clause(6, sim(var('X'), var('Z')), (sim(var('X'), var('Y')), sim(var('Y'), var('Z')))).
clause(7, in_class_of(var('U'), var('X')), sim(var('U'), var('X'))).
clause(8, same_class(var('X'), var('Y')), sim(var('X'), var('Y'))).
clause(10, shared_member_shows_same_class(var('X'), var('Y'), var('Z')), (in_class_of(var('Z'), var('X')), in_class_of(var('Z'), var('Y')), same_class(var('X'), var('Y')))).
clause(11, sim(b, a), true).
clause(12, sim(b, c), true).
clause(13, result_query(var('X'), var('Y'), var('Z')), (shared_member_shows_same_class(var('X'), var('Y'), var('Z')), var('X') \== var('Y'))).
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
substitution(6, ['U' = b, 'X' = a]).
proof(6, in_class_of(b, a), rule(7), [uses(1, sim(b, a))]).
substitution(7, ['U' = b, 'X' = c]).
proof(7, in_class_of(b, c), rule(7), [uses(2, sim(b, c))]).
substitution(8, ['X' = a]).
proof(8, sim(a, a), rule(4), [uses(3, in_x(a))]).
substitution(9, ['X' = b]).
proof(9, sim(b, b), rule(4), [uses(4, in_x(b))]).
substitution(10, ['X' = c]).
proof(10, sim(c, c), rule(4), [uses(5, in_x(c))]).
substitution(11, ['Y' = a, 'X' = b]).
proof(11, sim(a, b), rule(5), [uses(1, sim(b, a))]).
substitution(12, ['Y' = c, 'X' = b]).
proof(12, sim(c, b), rule(5), [uses(2, sim(b, c))]).
substitution(13, ['U' = a, 'X' = a]).
proof(13, in_class_of(a, a), rule(7), [uses(8, sim(a, a))]).
substitution(14, ['U' = b, 'X' = b]).
proof(14, in_class_of(b, b), rule(7), [uses(9, sim(b, b))]).
substitution(15, ['U' = c, 'X' = c]).
proof(15, in_class_of(c, c), rule(7), [uses(10, sim(c, c))]).
substitution(16, ['U' = a, 'X' = b]).
proof(16, in_class_of(a, b), rule(7), [uses(11, sim(a, b))]).
substitution(17, ['U' = c, 'X' = b]).
proof(17, in_class_of(c, b), rule(7), [uses(12, sim(c, b))]).
substitution(18, []).
proof(18, sim(b, a), rule(11), []).
substitution(19, []).
proof(19, sim(b, c), rule(12), []).
substitution(20, ['U' = b, 'X' = a]).
proof(20, in_class_of(b, a), rule(7), [uses(18, sim(b, a))]).
substitution(21, ['U' = b, 'X' = c]).
proof(21, in_class_of(b, c), rule(7), [uses(19, sim(b, c))]).
substitution(22, []).
proof(22, in_x(a), rule(1), []).
substitution(23, ['X' = a]).
proof(23, sim(a, a), rule(4), [uses(22, in_x(a))]).
substitution(24, []).
proof(24, sim(b, a), rule(11), []).
substitution(25, []).
proof(25, in_x(c), rule(3), []).
substitution(26, ['X' = c]).
proof(26, sim(c, c), rule(4), [uses(25, in_x(c))]).
substitution(27, []).
proof(27, sim(b, c), rule(12), []).
substitution(28, []).
proof(28, in_x(b), rule(2), []).
substitution(29, ['X' = b]).
proof(29, sim(b, b), rule(4), [uses(28, in_x(b))]).
substitution(30, ['Y' = a, 'X' = b]).
proof(30, sim(a, b), rule(5), [uses(18, sim(b, a))]).
substitution(31, ['Y' = c, 'X' = b]).
proof(31, sim(c, b), rule(5), [uses(19, sim(b, c))]).
substitution(32, ['X' = a, 'Z' = c, 'Y' = b]).
proof(32, sim(a, c), rule(6), [uses(11, sim(a, b)), uses(19, sim(b, c))]).
substitution(33, ['X' = c, 'Z' = a, 'Y' = b]).
proof(33, sim(c, a), rule(6), [uses(12, sim(c, b)), uses(18, sim(b, a))]).
substitution(34, ['X' = b]).
proof(34, sim(b, b), rule(4), [uses(28, in_x(b))]).
substitution(35, ['X' = a]).
proof(35, sim(a, a), rule(4), [uses(22, in_x(a))]).
substitution(36, ['Y' = a, 'X' = b]).
proof(36, sim(a, b), rule(5), [uses(24, sim(b, a))]).
substitution(37, ['X' = a, 'Z' = c, 'Y' = b]).
proof(37, sim(a, c), rule(6), [uses(36, sim(a, b)), uses(19, sim(b, c))]).
substitution(38, ['X' = a]).
proof(38, sim(a, a), rule(4), [uses(22, in_x(a))]).
substitution(39, ['X' = b, 'Z' = a, 'Y' = a]).
proof(39, sim(b, a), rule(6), [uses(18, sim(b, a)), uses(38, sim(a, a))]).
substitution(40, ['X' = c]).
proof(40, sim(c, c), rule(4), [uses(25, in_x(c))]).
substitution(41, ['Y' = c, 'X' = b]).
proof(41, sim(c, b), rule(5), [uses(27, sim(b, c))]).
substitution(42, ['X' = c, 'Z' = a, 'Y' = b]).
proof(42, sim(c, a), rule(6), [uses(41, sim(c, b)), uses(18, sim(b, a))]).
substitution(43, ['X' = c]).
proof(43, sim(c, c), rule(4), [uses(25, in_x(c))]).
substitution(44, ['X' = b, 'Z' = c, 'Y' = c]).
proof(44, sim(b, c), rule(6), [uses(19, sim(b, c)), uses(43, sim(c, c))]).
substitution(45, ['Y' = a, 'X' = b]).
proof(45, sim(a, b), rule(5), [uses(39, sim(b, a))]).
substitution(46, ['Y' = c, 'X' = b]).
proof(46, sim(c, b), rule(5), [uses(44, sim(b, c))]).
substitution(47, ['X' = b]).
proof(47, sim(b, b), rule(4), [uses(28, in_x(b))]).
substitution(48, ['U' = a, 'X' = c]).
proof(48, in_class_of(a, c), rule(7), [uses(32, sim(a, c))]).
substitution(49, ['U' = c, 'X' = a]).
proof(49, in_class_of(c, a), rule(7), [uses(33, sim(c, a))]).
substitution(50, ['Y' = c, 'X' = a]).
proof(50, sim(c, a), rule(5), [uses(37, sim(a, c))]).
substitution(51, ['Y' = a, 'X' = c]).
proof(51, sim(a, c), rule(5), [uses(42, sim(c, a))]).
substitution(52, ['U' = b, 'X' = b]).
proof(52, in_class_of(b, b), rule(7), [uses(34, sim(b, b))]).
substitution(53, ['X' = a, 'Y' = b]).
proof(53, same_class(a, b), rule(8), [uses(45, sim(a, b))]).
substitution(54, ['X' = c, 'Y' = b]).
proof(54, same_class(c, b), rule(8), [uses(46, sim(c, b))]).
substitution(55, ['U' = a, 'X' = a]).
proof(55, in_class_of(a, a), rule(7), [uses(35, sim(a, a))]).
substitution(56, ['U' = a, 'X' = b]).
proof(56, in_class_of(a, b), rule(7), [uses(36, sim(a, b))]).
substitution(57, ['U' = a, 'X' = c]).
proof(57, in_class_of(a, c), rule(7), [uses(37, sim(a, c))]).
substitution(58, ['X' = a, 'Y' = a]).
proof(58, same_class(a, a), rule(8), [uses(38, sim(a, a))]).
substitution(59, ['X' = b, 'Y' = a]).
proof(59, same_class(b, a), rule(8), [uses(39, sim(b, a))]).
substitution(60, ['U' = c, 'X' = c]).
proof(60, in_class_of(c, c), rule(7), [uses(40, sim(c, c))]).
substitution(61, ['U' = c, 'X' = b]).
proof(61, in_class_of(c, b), rule(7), [uses(41, sim(c, b))]).
substitution(62, ['U' = c, 'X' = a]).
proof(62, in_class_of(c, a), rule(7), [uses(42, sim(c, a))]).
substitution(63, ['X' = c, 'Z' = a, 'Y' = b]).
proof(63, sim(c, a), rule(6), [uses(41, sim(c, b)), uses(39, sim(b, a))]).
substitution(64, ['X' = c, 'Y' = c]).
proof(64, same_class(c, c), rule(8), [uses(43, sim(c, c))]).
substitution(65, ['Y' = a, 'X' = c]).
proof(65, sim(a, c), rule(5), [uses(63, sim(c, a))]).
substitution(66, ['X' = b, 'Y' = c]).
proof(66, same_class(b, c), rule(8), [uses(44, sim(b, c))]).
substitution(67, ['X' = a, 'Y' = a, 'Z' = b]).
proof(67, shared_member_shows_same_class(a, a, b), rule(10), [uses(6, in_class_of(b, a)), uses(20, in_class_of(b, a)), uses(58, same_class(a, a))]).
substitution(68, ['X' = a, 'Y' = b, 'Z' = b]).
proof(68, shared_member_shows_same_class(a, b, b), rule(10), [uses(6, in_class_of(b, a)), uses(52, in_class_of(b, b)), uses(53, same_class(a, b))]).
substitution(69, ['X' = c, 'Y' = c, 'Z' = b]).
proof(69, shared_member_shows_same_class(c, c, b), rule(10), [uses(7, in_class_of(b, c)), uses(21, in_class_of(b, c)), uses(64, same_class(c, c))]).
substitution(70, ['X' = c, 'Y' = b, 'Z' = b]).
proof(70, shared_member_shows_same_class(c, b, b), rule(10), [uses(7, in_class_of(b, c)), uses(52, in_class_of(b, b)), uses(54, same_class(c, b))]).
substitution(71, ['X' = a, 'Y' = a, 'Z' = a]).
proof(71, shared_member_shows_same_class(a, a, a), rule(10), [uses(13, in_class_of(a, a)), uses(55, in_class_of(a, a)), uses(58, same_class(a, a))]).
substitution(72, ['X' = a, 'Y' = b, 'Z' = a]).
proof(72, shared_member_shows_same_class(a, b, a), rule(10), [uses(13, in_class_of(a, a)), uses(56, in_class_of(a, b)), uses(53, same_class(a, b))]).
substitution(73, ['X' = b, 'Y' = a, 'Z' = b]).
proof(73, shared_member_shows_same_class(b, a, b), rule(10), [uses(14, in_class_of(b, b)), uses(20, in_class_of(b, a)), uses(59, same_class(b, a))]).
substitution(74, ['X' = b, 'Y' = c, 'Z' = b]).
proof(74, shared_member_shows_same_class(b, c, b), rule(10), [uses(14, in_class_of(b, b)), uses(21, in_class_of(b, c)), uses(66, same_class(b, c))]).
substitution(75, ['X' = c, 'Y' = c, 'Z' = c]).
proof(75, shared_member_shows_same_class(c, c, c), rule(10), [uses(15, in_class_of(c, c)), uses(60, in_class_of(c, c)), uses(64, same_class(c, c))]).
substitution(76, ['X' = c, 'Y' = b, 'Z' = c]).
proof(76, shared_member_shows_same_class(c, b, c), rule(10), [uses(15, in_class_of(c, c)), uses(61, in_class_of(c, b)), uses(54, same_class(c, b))]).
substitution(77, ['X' = b, 'Y' = a, 'Z' = a]).
proof(77, shared_member_shows_same_class(b, a, a), rule(10), [uses(16, in_class_of(a, b)), uses(55, in_class_of(a, a)), uses(59, same_class(b, a))]).
substitution(78, ['X' = b, 'Y' = c, 'Z' = a]).
proof(78, shared_member_shows_same_class(b, c, a), rule(10), [uses(16, in_class_of(a, b)), uses(57, in_class_of(a, c)), uses(66, same_class(b, c))]).
substitution(79, ['X' = b, 'Y' = c, 'Z' = c]).
proof(79, shared_member_shows_same_class(b, c, c), rule(10), [uses(17, in_class_of(c, b)), uses(60, in_class_of(c, c)), uses(66, same_class(b, c))]).
substitution(80, ['X' = b, 'Y' = a, 'Z' = c]).
proof(80, shared_member_shows_same_class(b, a, c), rule(10), [uses(17, in_class_of(c, b)), uses(62, in_class_of(c, a)), uses(59, same_class(b, a))]).
substitution(81, ['X' = c, 'Y' = b, 'Z' = a]).
proof(81, shared_member_shows_same_class(c, b, a), rule(10), [uses(48, in_class_of(a, c)), uses(56, in_class_of(a, b)), uses(54, same_class(c, b))]).
substitution(82, ['X' = c, 'Y' = c, 'Z' = a]).
proof(82, shared_member_shows_same_class(c, c, a), rule(10), [uses(48, in_class_of(a, c)), uses(57, in_class_of(a, c)), uses(64, same_class(c, c))]).
substitution(83, ['X' = a, 'Y' = b, 'Z' = c]).
proof(83, shared_member_shows_same_class(a, b, c), rule(10), [uses(49, in_class_of(c, a)), uses(61, in_class_of(c, b)), uses(53, same_class(a, b))]).
substitution(84, ['X' = a, 'Y' = a, 'Z' = c]).
proof(84, shared_member_shows_same_class(a, a, c), rule(10), [uses(49, in_class_of(c, a)), uses(62, in_class_of(c, a)), uses(58, same_class(a, a))]).
substitution(85, ['X' = c, 'Y' = a]).
proof(85, same_class(c, a), rule(8), [uses(63, sim(c, a))]).
substitution(86, ['X' = a, 'Y' = c]).
proof(86, same_class(a, c), rule(8), [uses(65, sim(a, c))]).
substitution(87, ['X' = a, 'Y' = b, 'Z' = b]).
proof(87, result_query(a, b, b), rule(13), [uses(68, shared_member_shows_same_class(a, b, b)), builtin(a \== b)]).
substitution(88, ['X' = c, 'Y' = b, 'Z' = b]).
proof(88, result_query(c, b, b), rule(13), [uses(70, shared_member_shows_same_class(c, b, b)), builtin(c \== b)]).
substitution(89, ['X' = a, 'Y' = b, 'Z' = a]).
proof(89, result_query(a, b, a), rule(13), [uses(72, shared_member_shows_same_class(a, b, a)), builtin(a \== b)]).
substitution(90, ['X' = b, 'Y' = a, 'Z' = b]).
proof(90, result_query(b, a, b), rule(13), [uses(73, shared_member_shows_same_class(b, a, b)), builtin(b \== a)]).
substitution(91, ['X' = b, 'Y' = c, 'Z' = b]).
proof(91, result_query(b, c, b), rule(13), [uses(74, shared_member_shows_same_class(b, c, b)), builtin(b \== c)]).
substitution(92, ['X' = c, 'Y' = b, 'Z' = c]).
proof(92, result_query(c, b, c), rule(13), [uses(76, shared_member_shows_same_class(c, b, c)), builtin(c \== b)]).
substitution(93, ['X' = b, 'Y' = a, 'Z' = a]).
proof(93, result_query(b, a, a), rule(13), [uses(77, shared_member_shows_same_class(b, a, a)), builtin(b \== a)]).
substitution(94, ['X' = b, 'Y' = c, 'Z' = a]).
proof(94, result_query(b, c, a), rule(13), [uses(78, shared_member_shows_same_class(b, c, a)), builtin(b \== c)]).
substitution(95, ['X' = b, 'Y' = c, 'Z' = c]).
proof(95, result_query(b, c, c), rule(13), [uses(79, shared_member_shows_same_class(b, c, c)), builtin(b \== c)]).
substitution(96, ['X' = b, 'Y' = a, 'Z' = c]).
proof(96, result_query(b, a, c), rule(13), [uses(80, shared_member_shows_same_class(b, a, c)), builtin(b \== a)]).
substitution(97, ['X' = c, 'Y' = b, 'Z' = a]).
proof(97, result_query(c, b, a), rule(13), [uses(81, shared_member_shows_same_class(c, b, a)), builtin(c \== b)]).
substitution(98, ['X' = a, 'Y' = b, 'Z' = c]).
proof(98, result_query(a, b, c), rule(13), [uses(83, shared_member_shows_same_class(a, b, c)), builtin(a \== b)]).
substitution(99, ['X' = b, 'Y' = b]).
proof(99, same_class(b, b), rule(8), [uses(47, sim(b, b))]).
substitution(100, ['X' = a, 'Y' = c, 'Z' = b]).
proof(100, shared_member_shows_same_class(a, c, b), rule(10), [uses(6, in_class_of(b, a)), uses(21, in_class_of(b, c)), uses(86, same_class(a, c))]).
substitution(101, ['X' = c, 'Y' = a, 'Z' = b]).
proof(101, shared_member_shows_same_class(c, a, b), rule(10), [uses(7, in_class_of(b, c)), uses(20, in_class_of(b, a)), uses(85, same_class(c, a))]).
substitution(102, ['X' = a, 'Y' = c, 'Z' = a]).
proof(102, shared_member_shows_same_class(a, c, a), rule(10), [uses(13, in_class_of(a, a)), uses(57, in_class_of(a, c)), uses(86, same_class(a, c))]).
substitution(103, ['X' = b, 'Y' = b, 'Z' = b]).
proof(103, shared_member_shows_same_class(b, b, b), rule(10), [uses(14, in_class_of(b, b)), uses(52, in_class_of(b, b)), uses(99, same_class(b, b))]).
substitution(104, ['X' = c, 'Y' = a, 'Z' = c]).
proof(104, shared_member_shows_same_class(c, a, c), rule(10), [uses(15, in_class_of(c, c)), uses(62, in_class_of(c, a)), uses(85, same_class(c, a))]).
substitution(105, ['X' = b, 'Y' = b, 'Z' = a]).
proof(105, shared_member_shows_same_class(b, b, a), rule(10), [uses(16, in_class_of(a, b)), uses(56, in_class_of(a, b)), uses(99, same_class(b, b))]).
substitution(106, ['X' = b, 'Y' = b, 'Z' = c]).
proof(106, shared_member_shows_same_class(b, b, c), rule(10), [uses(17, in_class_of(c, b)), uses(61, in_class_of(c, b)), uses(99, same_class(b, b))]).
substitution(107, ['X' = c, 'Y' = a, 'Z' = a]).
proof(107, shared_member_shows_same_class(c, a, a), rule(10), [uses(48, in_class_of(a, c)), uses(55, in_class_of(a, a)), uses(85, same_class(c, a))]).
substitution(108, ['X' = a, 'Y' = c, 'Z' = c]).
proof(108, shared_member_shows_same_class(a, c, c), rule(10), [uses(49, in_class_of(c, a)), uses(60, in_class_of(c, c)), uses(86, same_class(a, c))]).
substitution(109, ['X' = a, 'Y' = b, 'Z' = b]).
proof(109, solution([a, b, b]), query, [uses(87, result_query(a, b, b))]).
substitution(110, ['X' = c, 'Y' = b, 'Z' = b]).
proof(110, solution([c, b, b]), query, [uses(88, result_query(c, b, b))]).
substitution(111, ['X' = a, 'Y' = b, 'Z' = a]).
proof(111, solution([a, b, a]), query, [uses(89, result_query(a, b, a))]).
substitution(112, ['X' = b, 'Y' = a, 'Z' = b]).
proof(112, solution([b, a, b]), query, [uses(90, result_query(b, a, b))]).
substitution(113, ['X' = b, 'Y' = c, 'Z' = b]).
proof(113, solution([b, c, b]), query, [uses(91, result_query(b, c, b))]).
substitution(114, ['X' = c, 'Y' = b, 'Z' = c]).
proof(114, solution([c, b, c]), query, [uses(92, result_query(c, b, c))]).
substitution(115, ['X' = b, 'Y' = a, 'Z' = a]).
proof(115, solution([b, a, a]), query, [uses(93, result_query(b, a, a))]).
substitution(116, ['X' = b, 'Y' = c, 'Z' = a]).
proof(116, solution([b, c, a]), query, [uses(94, result_query(b, c, a))]).
substitution(117, ['X' = b, 'Y' = c, 'Z' = c]).
proof(117, solution([b, c, c]), query, [uses(95, result_query(b, c, c))]).
substitution(118, ['X' = b, 'Y' = a, 'Z' = c]).
proof(118, solution([b, a, c]), query, [uses(96, result_query(b, a, c))]).
substitution(119, ['X' = c, 'Y' = b, 'Z' = a]).
proof(119, solution([c, b, a]), query, [uses(97, result_query(c, b, a))]).
substitution(120, ['X' = a, 'Y' = b, 'Z' = c]).
proof(120, solution([a, b, c]), query, [uses(98, result_query(a, b, c))]).
substitution(121, ['X' = a, 'Y' = c, 'Z' = b]).
proof(121, result_query(a, c, b), rule(13), [uses(100, shared_member_shows_same_class(a, c, b)), builtin(a \== c)]).
substitution(122, ['X' = c, 'Y' = a, 'Z' = b]).
proof(122, result_query(c, a, b), rule(13), [uses(101, shared_member_shows_same_class(c, a, b)), builtin(c \== a)]).
substitution(123, ['X' = a, 'Y' = c, 'Z' = a]).
proof(123, result_query(a, c, a), rule(13), [uses(102, shared_member_shows_same_class(a, c, a)), builtin(a \== c)]).
substitution(124, ['X' = c, 'Y' = a, 'Z' = c]).
proof(124, result_query(c, a, c), rule(13), [uses(104, shared_member_shows_same_class(c, a, c)), builtin(c \== a)]).
substitution(125, ['X' = c, 'Y' = a, 'Z' = a]).
proof(125, result_query(c, a, a), rule(13), [uses(107, shared_member_shows_same_class(c, a, a)), builtin(c \== a)]).
substitution(126, ['X' = a, 'Y' = c, 'Z' = c]).
proof(126, result_query(a, c, c), rule(13), [uses(108, shared_member_shows_same_class(a, c, c)), builtin(a \== c)]).
substitution(127, ['X' = a, 'Y' = c, 'Z' = b]).
proof(127, solution([a, c, b]), query, [uses(121, result_query(a, c, b))]).
substitution(128, ['X' = c, 'Y' = a, 'Z' = b]).
proof(128, solution([c, a, b]), query, [uses(122, result_query(c, a, b))]).
substitution(129, ['X' = a, 'Y' = c, 'Z' = a]).
proof(129, solution([a, c, a]), query, [uses(123, result_query(a, c, a))]).
substitution(130, ['X' = c, 'Y' = a, 'Z' = c]).
proof(130, solution([c, a, c]), query, [uses(124, result_query(c, a, c))]).
substitution(131, ['X' = c, 'Y' = a, 'Z' = a]).
proof(131, solution([c, a, a]), query, [uses(125, result_query(c, a, a))]).
substitution(132, ['X' = a, 'Y' = c, 'Z' = c]).
proof(132, solution([a, c, c]), query, [uses(126, result_query(a, c, c))]).
