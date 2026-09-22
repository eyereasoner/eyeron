% Prolog result format 3
query(1, test_append(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 5).
query(2, test_first(_0), ['R' = _0]).
result(2, complete, 1).
answer(2, ['R' = true]).
why(2, ['R' = true], 7).
query(3, test_in(_0), ['R' = _0]).
result(3, complete, 1).
answer(3, ['R' = true]).
why(3, ['R' = true], 12).
query(4, test_iterate(_0), ['R' = _0]).
result(4, complete, 1).
answer(4, ['R' = true]).
why(4, ['R' = true], 17).
query(5, test_last(_0), ['R' = _0]).
result(5, complete, 1).
answer(5, ['R' = true]).
why(5, ['R' = true], 23).
query(6, test_length(_0), ['R' = _0]).
result(6, complete, 1).
answer(6, ['R' = true]).
why(6, ['R' = true], 25).
query(7, test_member(_0), ['R' = _0]).
result(7, complete, 1).
answer(7, ['R' = true]).
why(7, ['R' = true], 30).
query(8, test_member_at(_0), ['R' = _0]).
result(8, complete, 1).
answer(8, ['R' = true]).
why(8, ['R' = true], 35).
query(9, test_remove(_0), ['R' = _0]).
result(9, complete, 1).
answer(9, ['R' = true]).
why(9, ['R' = true], 42).
query(10, test_rest(_0), ['R' = _0]).
result(10, complete, 1).
answer(10, ['R' = true]).
why(10, ['R' = true], 44).
query(11, test_first_rest(_0), ['R' = _0]).
result(11, complete, 1).
answer(11, ['R' = true]).
why(11, ['R' = true], 46).
clause(1, append([], var('Ys'), var('Ys')), true).
clause(2, append([var('X')|var('Xs')], var('Ys'), [var('X')|var('Zs')]), append(var('Xs'), var('Ys'), var('Zs'))).
clause(3, member(var('X'), [var('X')|anonymous(1)]), true).
clause(4, member(var('X'), [anonymous(1)|var('Tail')]), member(var('X'), var('Tail'))).
clause(5, last_([var('X')], var('X')), true).
clause(6, last_([anonymous(1)|var('Xs')], var('X')), last_(var('Xs'), var('X'))).
clause(7, member_at([var('X')|anonymous(1)], 0, var('X')), true).
clause(8, member_at([anonymous(1)|var('Xs')], var('I'), var('X')), (var('I') > 0, var('Prev') is var('I') - 1, member_at(var('Xs'), var('Prev'), var('X')))).
clause(9, remove_all([], anonymous(1), []), true).
clause(10, remove_all([var('Target')|var('Xs')], var('Target'), var('Result')), remove_all(var('Xs'), var('Target'), var('Result'))).
clause(11, remove_all([var('X')|var('Xs')], var('Target'), [var('X')|var('Result')]), (var('X') \== var('Target'), remove_all(var('Xs'), var('Target'), var('Result')))).
clause(12, iterate([var('X')|var('Xs')], 0, var('X')), true).
clause(13, iterate([var('X')|var('Xs')], var('I'), var('Y')), (iterate(var('Xs'), var('Prev'), var('Y')), var('I') is var('Prev') + 1)).
clause(14, test_append(true), append([1, 2], [3, 4], [1, 2, 3, 4])).
clause(15, test_first(true), ([1, 2, 3, 4] = [var('H')|var('T')], var('H') = 1)).
clause(16, test_in(true), member("cat", ["dog", "penguin", "cat"])).
clause(17, test_iterate(true), iterate(["dog", "penguin", "cat"], var('Index'), "cat")).
clause(18, test_last(true), last_([1, 2, 3, 4], 4)).
clause(19, test_length(true), length([1, 2, 3, 4], 4)).
clause(20, test_member(true), member("cat", ["dog", "penguin", "cat"])).
clause(21, test_member_at(true), member_at(["dog", "penguin", "cat"], 2, "cat")).
clause(22, test_remove(true), remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"])).
clause(23, test_rest(true), ([1, 2, 3, 4] = [var('H')|var('T')], var('T') = [2, 3, 4])).
clause(24, test_first_rest(true), ([1, 2, 3, 4] = [var('H')|var('T')], var('H') = 1, var('T') = [2, 3, 4])).
substitution(1, ['Ys' = [3, 4]]).
proof(1, append([], [3, 4], [3, 4]), rule(1), []).
substitution(2, ['X' = 2, 'Xs' = [], 'Ys' = [3, 4], 'Zs' = [3, 4]]).
proof(2, append([2], [3, 4], [2, 3, 4]), rule(2), [uses(1, append([], [3, 4], [3, 4]))]).
substitution(3, ['X' = 1, 'Xs' = [2], 'Ys' = [3, 4], 'Zs' = [2, 3, 4]]).
proof(3, append([1, 2], [3, 4], [1, 2, 3, 4]), rule(2), [uses(2, append([2], [3, 4], [2, 3, 4]))]).
substitution(4, []).
proof(4, test_append(true), rule(14), [uses(3, append([1, 2], [3, 4], [1, 2, 3, 4]))]).
substitution(5, ['R' = true]).
proof(5, solution([true]), query, [uses(4, test_append(true))]).
substitution(6, ['H' = 1, 'T' = [2, 3, 4]]).
proof(6, test_first(true), rule(15), [builtin([1, 2, 3, 4] = [1, 2, 3, 4]), builtin(1 = 1)]).
substitution(7, ['R' = true]).
proof(7, solution([true]), query, [uses(6, test_first(true))]).
substitution(8, ['X' = "cat"]).
proof(8, member("cat", ["cat"]), rule(3), []).
substitution(9, ['X' = "cat", 'Tail' = ["cat"]]).
proof(9, member("cat", ["penguin", "cat"]), rule(4), [uses(8, member("cat", ["cat"]))]).
substitution(10, ['X' = "cat", 'Tail' = ["penguin", "cat"]]).
proof(10, member("cat", ["dog", "penguin", "cat"]), rule(4), [uses(9, member("cat", ["penguin", "cat"]))]).
substitution(11, []).
proof(11, test_in(true), rule(16), [uses(10, member("cat", ["dog", "penguin", "cat"]))]).
substitution(12, ['R' = true]).
proof(12, solution([true]), query, [uses(11, test_in(true))]).
substitution(13, ['X' = "cat", 'Xs' = []]).
proof(13, iterate(["cat"], 0, "cat"), rule(12), []).
substitution(14, ['X' = "penguin", 'Xs' = ["cat"], 'I' = 1, 'Y' = "cat", 'Prev' = 0]).
proof(14, iterate(["penguin", "cat"], 1, "cat"), rule(13), [uses(13, iterate(["cat"], 0, "cat")), builtin(1 is 0 + 1)]).
substitution(15, ['X' = "dog", 'Xs' = ["penguin", "cat"], 'I' = 2, 'Y' = "cat", 'Prev' = 1]).
proof(15, iterate(["dog", "penguin", "cat"], 2, "cat"), rule(13), [uses(14, iterate(["penguin", "cat"], 1, "cat")), builtin(2 is 1 + 1)]).
substitution(16, ['Index' = 2]).
proof(16, test_iterate(true), rule(17), [uses(15, iterate(["dog", "penguin", "cat"], 2, "cat"))]).
substitution(17, ['R' = true]).
proof(17, solution([true]), query, [uses(16, test_iterate(true))]).
substitution(18, ['X' = 4]).
proof(18, last_([4], 4), rule(5), []).
substitution(19, ['Xs' = [4], 'X' = 4]).
proof(19, last_([3, 4], 4), rule(6), [uses(18, last_([4], 4))]).
substitution(20, ['Xs' = [3, 4], 'X' = 4]).
proof(20, last_([2, 3, 4], 4), rule(6), [uses(19, last_([3, 4], 4))]).
substitution(21, ['Xs' = [2, 3, 4], 'X' = 4]).
proof(21, last_([1, 2, 3, 4], 4), rule(6), [uses(20, last_([2, 3, 4], 4))]).
substitution(22, []).
proof(22, test_last(true), rule(18), [uses(21, last_([1, 2, 3, 4], 4))]).
substitution(23, ['R' = true]).
proof(23, solution([true]), query, [uses(22, test_last(true))]).
substitution(24, []).
proof(24, test_length(true), rule(19), [builtin(length([1, 2, 3, 4], 4))]).
substitution(25, ['R' = true]).
proof(25, solution([true]), query, [uses(24, test_length(true))]).
substitution(26, ['X' = "cat"]).
proof(26, member("cat", ["cat"]), rule(3), []).
substitution(27, ['X' = "cat", 'Tail' = ["cat"]]).
proof(27, member("cat", ["penguin", "cat"]), rule(4), [uses(26, member("cat", ["cat"]))]).
substitution(28, ['X' = "cat", 'Tail' = ["penguin", "cat"]]).
proof(28, member("cat", ["dog", "penguin", "cat"]), rule(4), [uses(27, member("cat", ["penguin", "cat"]))]).
substitution(29, []).
proof(29, test_member(true), rule(20), [uses(28, member("cat", ["dog", "penguin", "cat"]))]).
substitution(30, ['R' = true]).
proof(30, solution([true]), query, [uses(29, test_member(true))]).
substitution(31, ['X' = "cat"]).
proof(31, member_at(["cat"], 0, "cat"), rule(7), []).
substitution(32, ['Xs' = ["cat"], 'I' = 1, 'X' = "cat", 'Prev' = 0]).
proof(32, member_at(["penguin", "cat"], 1, "cat"), rule(8), [builtin(1 > 0), builtin(0 is 1 - 1), uses(31, member_at(["cat"], 0, "cat"))]).
substitution(33, ['Xs' = ["penguin", "cat"], 'I' = 2, 'X' = "cat", 'Prev' = 1]).
proof(33, member_at(["dog", "penguin", "cat"], 2, "cat"), rule(8), [builtin(2 > 0), builtin(1 is 2 - 1), uses(32, member_at(["penguin", "cat"], 1, "cat"))]).
substitution(34, []).
proof(34, test_member_at(true), rule(21), [uses(33, member_at(["dog", "penguin", "cat"], 2, "cat"))]).
substitution(35, ['R' = true]).
proof(35, solution([true]), query, [uses(34, test_member_at(true))]).
substitution(36, []).
proof(36, remove_all([], "penguin", []), rule(9), []).
substitution(37, ['Target' = "penguin", 'Xs' = [], 'Result' = []]).
proof(37, remove_all(["penguin"], "penguin", []), rule(10), [uses(36, remove_all([], "penguin", []))]).
substitution(38, ['X' = "cat", 'Xs' = ["penguin"], 'Target' = "penguin", 'Result' = []]).
proof(38, remove_all(["cat", "penguin"], "penguin", ["cat"]), rule(11), [builtin("cat" \== "penguin"), uses(37, remove_all(["penguin"], "penguin", []))]).
substitution(39, ['Target' = "penguin", 'Xs' = ["cat", "penguin"], 'Result' = ["cat"]]).
proof(39, remove_all(["penguin", "cat", "penguin"], "penguin", ["cat"]), rule(10), [uses(38, remove_all(["cat", "penguin"], "penguin", ["cat"]))]).
substitution(40, ['X' = "dog", 'Xs' = ["penguin", "cat", "penguin"], 'Target' = "penguin", 'Result' = ["cat"]]).
proof(40, remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"]), rule(11), [builtin("dog" \== "penguin"), uses(39, remove_all(["penguin", "cat", "penguin"], "penguin", ["cat"]))]).
substitution(41, []).
proof(41, test_remove(true), rule(22), [uses(40, remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"]))]).
substitution(42, ['R' = true]).
proof(42, solution([true]), query, [uses(41, test_remove(true))]).
substitution(43, ['H' = 1, 'T' = [2, 3, 4]]).
proof(43, test_rest(true), rule(23), [builtin([1, 2, 3, 4] = [1, 2, 3, 4]), builtin([2, 3, 4] = [2, 3, 4])]).
substitution(44, ['R' = true]).
proof(44, solution([true]), query, [uses(43, test_rest(true))]).
substitution(45, ['H' = 1, 'T' = [2, 3, 4]]).
proof(45, test_first_rest(true), rule(24), [builtin([1, 2, 3, 4] = [1, 2, 3, 4]), builtin(1 = 1), builtin([2, 3, 4] = [2, 3, 4])]).
substitution(46, ['R' = true]).
proof(46, solution([true]), query, [uses(45, test_first_rest(true))]).
