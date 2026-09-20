# Eyelang result format 2
query(1, [call(test_append(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 5).
query(2, [call(test_first(?v0))], [binding("r", ?v0)]).
result(2, complete, 1).
answer(2, [binding("r", true)]).
why(2, [binding("r", true)], 7).
query(3, [call(test_in(?v0))], [binding("r", ?v0)]).
result(3, complete, 1).
answer(3, [binding("r", true)]).
why(3, [binding("r", true)], 12).
query(4, [call(test_iterate(?v0))], [binding("r", ?v0)]).
result(4, complete, 1).
answer(4, [binding("r", true)]).
why(4, [binding("r", true)], 17).
query(5, [call(test_last(?v0))], [binding("r", ?v0)]).
result(5, complete, 1).
answer(5, [binding("r", true)]).
why(5, [binding("r", true)], 23).
query(6, [call(test_length(?v0))], [binding("r", ?v0)]).
result(6, complete, 1).
answer(6, [binding("r", true)]).
why(6, [binding("r", true)], 25).
query(7, [call(test_member(?v0))], [binding("r", ?v0)]).
result(7, complete, 1).
answer(7, [binding("r", true)]).
why(7, [binding("r", true)], 30).
query(8, [call(test_member_at(?v0))], [binding("r", ?v0)]).
result(8, complete, 1).
answer(8, [binding("r", true)]).
why(8, [binding("r", true)], 35).
query(9, [call(test_remove(?v0))], [binding("r", ?v0)]).
result(9, complete, 1).
answer(9, [binding("r", true)]).
why(9, [binding("r", true)], 42).
query(10, [call(test_rest(?v0))], [binding("r", ?v0)]).
result(10, complete, 1).
answer(10, [binding("r", true)]).
why(10, [binding("r", true)], 44).
query(11, [call(test_first_rest(?v0))], [binding("r", ?v0)]).
result(11, complete, 1).
answer(11, [binding("r", true)]).
why(11, [binding("r", true)], 46).
clause(1, append([], var("ys"), var("ys")), []).
clause(2, append([var("x") | var("xs")], var("ys"), [var("x") | var("zs")]), [call(append(var("xs"), var("ys"), var("zs")))]).
clause(3, member(var("x"), [var("x") | anonymous(1)]), []).
clause(4, member(var("x"), [anonymous(1) | var("tail")]), [call(member(var("x"), var("tail")))]).
clause(5, last_([var("x")], var("x")), []).
clause(6, last_([anonymous(1) | var("xs")], var("x")), [call(last_(var("xs"), var("x")))]).
clause(7, member_at([var("x") | anonymous(1)], 0, var("x")), []).
clause(8, member_at([anonymous(1) | var("xs")], var("i"), var("x")), [compare(">", var("i"), 0), calculate(var("prev"), binary("-", value(var("i")), value(1))), call(member_at(var("xs"), var("prev"), var("x")))]).
clause(9, remove_all([], anonymous(1), []), []).
clause(10, remove_all([var("target") | var("xs")], var("target"), var("result")), [call(remove_all(var("xs"), var("target"), var("result")))]).
clause(11, remove_all([var("x") | var("xs")], var("target"), [var("x") | var("result")]), [compare("!=", var("x"), var("target")), call(remove_all(var("xs"), var("target"), var("result")))]).
clause(12, iterate([var("x") | var("xs")], 0, var("x")), []).
clause(13, iterate([var("x") | var("xs")], var("i"), var("y")), [call(iterate(var("xs"), var("prev"), var("y"))), calculate(var("i"), binary("+", value(var("prev")), value(1)))]).
clause(14, test_append(true), [call(append([1, 2], [3, 4], [1, 2, 3, 4]))]).
clause(15, test_first(true), [compare("=", [1, 2, 3, 4], [var("h") | var("t")]), compare("=", var("h"), 1)]).
clause(16, test_in(true), [call(member("cat", ["dog", "penguin", "cat"]))]).
clause(17, test_iterate(true), [call(iterate(["dog", "penguin", "cat"], var("index"), "cat"))]).
clause(18, test_last(true), [call(last_([1, 2, 3, 4], 4))]).
clause(19, test_length(true), [call(length([1, 2, 3, 4], 4))]).
clause(20, test_member(true), [call(member("cat", ["dog", "penguin", "cat"]))]).
clause(21, test_member_at(true), [call(member_at(["dog", "penguin", "cat"], 2, "cat"))]).
clause(22, test_remove(true), [call(remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"]))]).
clause(23, test_rest(true), [compare("=", [1, 2, 3, 4], [var("h") | var("t")]), compare("=", var("t"), [2, 3, 4])]).
clause(24, test_first_rest(true), [compare("=", [1, 2, 3, 4], [var("h") | var("t")]), compare("=", var("h"), 1), compare("=", var("t"), [2, 3, 4])]).
substitution(1, [binding("ys", [3, 4])]).
proof(1, append([], [3, 4], [3, 4]), rule(1), []).
substitution(2, [binding("x", 2), binding("xs", []), binding("ys", [3, 4]), binding("zs", [3, 4])]).
proof(2, append([2], [3, 4], [2, 3, 4]), rule(2), [uses(1, append([], [3, 4], [3, 4]))]).
substitution(3, [binding("x", 1), binding("xs", [2]), binding("ys", [3, 4]), binding("zs", [2, 3, 4])]).
proof(3, append([1, 2], [3, 4], [1, 2, 3, 4]), rule(2), [uses(2, append([2], [3, 4], [2, 3, 4]))]).
substitution(4, []).
proof(4, test_append(true), rule(14), [uses(3, append([1, 2], [3, 4], [1, 2, 3, 4]))]).
substitution(5, [binding("r", true)]).
proof(5, solution([true]), query, [uses(4, test_append(true))]).
substitution(6, [binding("h", 1), binding("t", [2, 3, 4])]).
proof(6, test_first(true), rule(15), [compared("=", [1, 2, 3, 4], [1, 2, 3, 4]), compared("=", 1, 1)]).
substitution(7, [binding("r", true)]).
proof(7, solution([true]), query, [uses(6, test_first(true))]).
substitution(8, [binding("x", "cat")]).
proof(8, member("cat", ["cat"]), rule(3), []).
substitution(9, [binding("x", "cat"), binding("tail", ["cat"])]).
proof(9, member("cat", ["penguin", "cat"]), rule(4), [uses(8, member("cat", ["cat"]))]).
substitution(10, [binding("x", "cat"), binding("tail", ["penguin", "cat"])]).
proof(10, member("cat", ["dog", "penguin", "cat"]), rule(4), [uses(9, member("cat", ["penguin", "cat"]))]).
substitution(11, []).
proof(11, test_in(true), rule(16), [uses(10, member("cat", ["dog", "penguin", "cat"]))]).
substitution(12, [binding("r", true)]).
proof(12, solution([true]), query, [uses(11, test_in(true))]).
substitution(13, [binding("x", "cat"), binding("xs", [])]).
proof(13, iterate(["cat"], 0, "cat"), rule(12), []).
substitution(14, [binding("x", "penguin"), binding("xs", ["cat"]), binding("i", 1), binding("y", "cat"), binding("prev", 0)]).
proof(14, iterate(["penguin", "cat"], 1, "cat"), rule(13), [uses(13, iterate(["cat"], 0, "cat")), calculated(1, binary("+", value(0), value(1)))]).
substitution(15, [binding("x", "dog"), binding("xs", ["penguin", "cat"]), binding("i", 2), binding("y", "cat"), binding("prev", 1)]).
proof(15, iterate(["dog", "penguin", "cat"], 2, "cat"), rule(13), [uses(14, iterate(["penguin", "cat"], 1, "cat")), calculated(2, binary("+", value(1), value(1)))]).
substitution(16, [binding("index", 2)]).
proof(16, test_iterate(true), rule(17), [uses(15, iterate(["dog", "penguin", "cat"], 2, "cat"))]).
substitution(17, [binding("r", true)]).
proof(17, solution([true]), query, [uses(16, test_iterate(true))]).
substitution(18, [binding("x", 4)]).
proof(18, last_([4], 4), rule(5), []).
substitution(19, [binding("xs", [4]), binding("x", 4)]).
proof(19, last_([3, 4], 4), rule(6), [uses(18, last_([4], 4))]).
substitution(20, [binding("xs", [3, 4]), binding("x", 4)]).
proof(20, last_([2, 3, 4], 4), rule(6), [uses(19, last_([3, 4], 4))]).
substitution(21, [binding("xs", [2, 3, 4]), binding("x", 4)]).
proof(21, last_([1, 2, 3, 4], 4), rule(6), [uses(20, last_([2, 3, 4], 4))]).
substitution(22, []).
proof(22, test_last(true), rule(18), [uses(21, last_([1, 2, 3, 4], 4))]).
substitution(23, [binding("r", true)]).
proof(23, solution([true]), query, [uses(22, test_last(true))]).
substitution(24, []).
proof(24, test_length(true), rule(19), [builtin(length([1, 2, 3, 4], 4))]).
substitution(25, [binding("r", true)]).
proof(25, solution([true]), query, [uses(24, test_length(true))]).
substitution(26, [binding("x", "cat")]).
proof(26, member("cat", ["cat"]), rule(3), []).
substitution(27, [binding("x", "cat"), binding("tail", ["cat"])]).
proof(27, member("cat", ["penguin", "cat"]), rule(4), [uses(26, member("cat", ["cat"]))]).
substitution(28, [binding("x", "cat"), binding("tail", ["penguin", "cat"])]).
proof(28, member("cat", ["dog", "penguin", "cat"]), rule(4), [uses(27, member("cat", ["penguin", "cat"]))]).
substitution(29, []).
proof(29, test_member(true), rule(20), [uses(28, member("cat", ["dog", "penguin", "cat"]))]).
substitution(30, [binding("r", true)]).
proof(30, solution([true]), query, [uses(29, test_member(true))]).
substitution(31, [binding("x", "cat")]).
proof(31, member_at(["cat"], 0, "cat"), rule(7), []).
substitution(32, [binding("xs", ["cat"]), binding("i", 1), binding("x", "cat"), binding("prev", 0)]).
proof(32, member_at(["penguin", "cat"], 1, "cat"), rule(8), [compared(">", 1, 0), calculated(0, binary("-", value(1), value(1))), uses(31, member_at(["cat"], 0, "cat"))]).
substitution(33, [binding("xs", ["penguin", "cat"]), binding("i", 2), binding("x", "cat"), binding("prev", 1)]).
proof(33, member_at(["dog", "penguin", "cat"], 2, "cat"), rule(8), [compared(">", 2, 0), calculated(1, binary("-", value(2), value(1))), uses(32, member_at(["penguin", "cat"], 1, "cat"))]).
substitution(34, []).
proof(34, test_member_at(true), rule(21), [uses(33, member_at(["dog", "penguin", "cat"], 2, "cat"))]).
substitution(35, [binding("r", true)]).
proof(35, solution([true]), query, [uses(34, test_member_at(true))]).
substitution(36, []).
proof(36, remove_all([], "penguin", []), rule(9), []).
substitution(37, [binding("target", "penguin"), binding("xs", []), binding("result", [])]).
proof(37, remove_all(["penguin"], "penguin", []), rule(10), [uses(36, remove_all([], "penguin", []))]).
substitution(38, [binding("x", "cat"), binding("xs", ["penguin"]), binding("target", "penguin"), binding("result", [])]).
proof(38, remove_all(["cat", "penguin"], "penguin", ["cat"]), rule(11), [compared("!=", "cat", "penguin"), uses(37, remove_all(["penguin"], "penguin", []))]).
substitution(39, [binding("target", "penguin"), binding("xs", ["cat", "penguin"]), binding("result", ["cat"])]).
proof(39, remove_all(["penguin", "cat", "penguin"], "penguin", ["cat"]), rule(10), [uses(38, remove_all(["cat", "penguin"], "penguin", ["cat"]))]).
substitution(40, [binding("x", "dog"), binding("xs", ["penguin", "cat", "penguin"]), binding("target", "penguin"), binding("result", ["cat"])]).
proof(40, remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"]), rule(11), [compared("!=", "dog", "penguin"), uses(39, remove_all(["penguin", "cat", "penguin"], "penguin", ["cat"]))]).
substitution(41, []).
proof(41, test_remove(true), rule(22), [uses(40, remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"]))]).
substitution(42, [binding("r", true)]).
proof(42, solution([true]), query, [uses(41, test_remove(true))]).
substitution(43, [binding("h", 1), binding("t", [2, 3, 4])]).
proof(43, test_rest(true), rule(23), [compared("=", [1, 2, 3, 4], [1, 2, 3, 4]), compared("=", [2, 3, 4], [2, 3, 4])]).
substitution(44, [binding("r", true)]).
proof(44, solution([true]), query, [uses(43, test_rest(true))]).
substitution(45, [binding("h", 1), binding("t", [2, 3, 4])]).
proof(45, test_first_rest(true), rule(24), [compared("=", [1, 2, 3, 4], [1, 2, 3, 4]), compared("=", 1, 1), compared("=", [2, 3, 4], [2, 3, 4])]).
substitution(46, [binding("r", true)]).
proof(46, solution([true]), query, [uses(45, test_first_rest(true))]).
