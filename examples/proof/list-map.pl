% Prolog result format 3
query(1, test1(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 21).
query(2, test2(_0), ['R' = _0]).
result(2, complete, 1).
answer(2, ['R' = true]).
why(2, ['R' = true], 58).
query(3, test3(_0), ['R' = _0]).
result(3, complete, 1).
answer(3, ['R' = true]).
why(3, ['R' = true], 63).
query(4, test4(_0), ['R' = _0]).
result(4, complete, 1).
answer(4, ['R' = true]).
why(4, ['R' = true], 68).
clause(1, p1(s1, o1), true).
clause(2, p1(s2, o2), true).
clause(3, p1(s3, o3), true).
clause(4, p1(s3, o4), true).
clause(6, append([], var('Ys'), var('Ys')), true).
clause(7, append([var('X')|var('Xs')], var('Ys'), [var('X')|var('Zs')]), append(var('Xs'), var('Ys'), var('Zs'))).
clause(8, flat_map_p1([], []), true).
clause(9, flat_map_p1([var('S')|var('Ss')], var('Result')), (findall(var('O'), p1(var('S'), var('O')), var('Bag1')), sort(var('Bag1'), var('Os')), flat_map_p1(var('Ss'), var('Rest')), append(var('Os'), var('Rest'), var('Result')))).
clause(10, flat_map_p2([], []), true).
clause(11, flat_map_p2([var('S')|var('Ss')], var('Result')), (findall(var('O'), p2(var('S'), var('O')), var('Bag1')), sort(var('Bag1'), var('Os')), flat_map_p2(var('Ss'), var('Rest')), append(var('Os'), var('Rest'), var('Result')))).
clause(12, test1(true), flat_map_p1([s1, s2], [o1, o2])).
clause(13, test2(true), flat_map_p1([s1, s2, s3], [o1, o2, o3, o4])).
clause(14, test3(true), flat_map_p1([s4], [])).
clause(15, test4(true), flat_map_p2([s1], [])).
substitution(1, []).
proof(1, p1(s1, o1), rule(1), []).
substitution(2, ['O' = o1]).
proof(2, solution([o1]), query, [uses(1, p1(s1, o1))]).
substitution(3, []).
proof(3, p1(s2, o2), rule(2), []).
substitution(4, ['O' = o2]).
proof(4, solution([o2]), query, [uses(3, p1(s2, o2))]).
substitution(5, []).
proof(5, flat_map_p1([], []), rule(8), []).
substitution(6, []).
proof(6, p1(s2, o2), rule(2), []).
substitution(7, ['O' = o2]).
proof(7, solution([o2]), query, [uses(6, p1(s2, o2))]).
substitution(8, ['Ys' = []]).
proof(8, append([], [], []), rule(6), []).
substitution(9, ['X' = o2, 'Xs' = [], 'Ys' = [], 'Zs' = []]).
proof(9, append([o2], [], [o2]), rule(7), [uses(8, append([], [], []))]).
substitution(10, []).
proof(10, p1(s2, o2), rule(2), []).
substitution(11, ['O' = o2]).
proof(11, solution([o2]), query, [uses(10, p1(s2, o2))]).
substitution(12, ['S' = s2, 'Ss' = [], 'Result' = [o2], 'O' = _0, 'Bag1' = [o2], 'Os' = [o2], 'Rest' = []]).
proof(12, flat_map_p1([s2], [o2]), rule(9), [collected([o2], _0, p1(s2, _0), [11], complete), builtin(sort([o2], [o2])), uses(5, flat_map_p1([], [])), uses(9, append([o2], [], [o2]))]).
substitution(13, []).
proof(13, p1(s1, o1), rule(1), []).
substitution(14, ['O' = o1]).
proof(14, solution([o1]), query, [uses(13, p1(s1, o1))]).
substitution(15, ['Ys' = [o2]]).
proof(15, append([], [o2], [o2]), rule(6), []).
substitution(16, ['X' = o1, 'Xs' = [], 'Ys' = [o2], 'Zs' = [o2]]).
proof(16, append([o1], [o2], [o1, o2]), rule(7), [uses(15, append([], [o2], [o2]))]).
substitution(17, []).
proof(17, p1(s1, o1), rule(1), []).
substitution(18, ['O' = o1]).
proof(18, solution([o1]), query, [uses(17, p1(s1, o1))]).
substitution(19, ['S' = s1, 'Ss' = [s2], 'Result' = [o1, o2], 'O' = _0, 'Bag1' = [o1], 'Os' = [o1], 'Rest' = [o2]]).
proof(19, flat_map_p1([s1, s2], [o1, o2]), rule(9), [collected([o1], _0, p1(s1, _0), [18], complete), builtin(sort([o1], [o1])), uses(12, flat_map_p1([s2], [o2])), uses(16, append([o1], [o2], [o1, o2]))]).
substitution(20, []).
proof(20, test1(true), rule(12), [uses(19, flat_map_p1([s1, s2], [o1, o2]))]).
substitution(21, ['R' = true]).
proof(21, solution([true]), query, [uses(20, test1(true))]).
substitution(22, []).
proof(22, p1(s1, o1), rule(1), []).
substitution(23, ['O' = o1]).
proof(23, solution([o1]), query, [uses(22, p1(s1, o1))]).
substitution(24, []).
proof(24, p1(s2, o2), rule(2), []).
substitution(25, ['O' = o2]).
proof(25, solution([o2]), query, [uses(24, p1(s2, o2))]).
substitution(26, []).
proof(26, p1(s3, o3), rule(3), []).
substitution(27, []).
proof(27, p1(s3, o4), rule(4), []).
substitution(28, ['O' = o3]).
proof(28, solution([o3]), query, [uses(26, p1(s3, o3))]).
substitution(29, ['O' = o4]).
proof(29, solution([o4]), query, [uses(27, p1(s3, o4))]).
substitution(30, []).
proof(30, flat_map_p1([], []), rule(8), []).
substitution(31, []).
proof(31, p1(s3, o3), rule(3), []).
substitution(32, []).
proof(32, p1(s3, o4), rule(4), []).
substitution(33, ['O' = o3]).
proof(33, solution([o3]), query, [uses(31, p1(s3, o3))]).
substitution(34, ['O' = o4]).
proof(34, solution([o4]), query, [uses(32, p1(s3, o4))]).
substitution(35, ['Ys' = []]).
proof(35, append([], [], []), rule(6), []).
substitution(36, ['X' = o4, 'Xs' = [], 'Ys' = [], 'Zs' = []]).
proof(36, append([o4], [], [o4]), rule(7), [uses(35, append([], [], []))]).
substitution(37, ['X' = o3, 'Xs' = [o4], 'Ys' = [], 'Zs' = [o4]]).
proof(37, append([o3, o4], [], [o3, o4]), rule(7), [uses(36, append([o4], [], [o4]))]).
substitution(38, []).
proof(38, p1(s3, o3), rule(3), []).
substitution(39, []).
proof(39, p1(s3, o4), rule(4), []).
substitution(40, ['O' = o3]).
proof(40, solution([o3]), query, [uses(38, p1(s3, o3))]).
substitution(41, ['O' = o4]).
proof(41, solution([o4]), query, [uses(39, p1(s3, o4))]).
substitution(42, ['S' = s3, 'Ss' = [], 'Result' = [o3, o4], 'O' = _0, 'Bag1' = [o3, o4], 'Os' = [o3, o4], 'Rest' = []]).
proof(42, flat_map_p1([s3], [o3, o4]), rule(9), [collected([o3, o4], _0, p1(s3, _0), [40, 41], complete), builtin(sort([o3, o4], [o3, o4])), uses(30, flat_map_p1([], [])), uses(37, append([o3, o4], [], [o3, o4]))]).
substitution(43, []).
proof(43, p1(s2, o2), rule(2), []).
substitution(44, ['O' = o2]).
proof(44, solution([o2]), query, [uses(43, p1(s2, o2))]).
substitution(45, ['Ys' = [o3, o4]]).
proof(45, append([], [o3, o4], [o3, o4]), rule(6), []).
substitution(46, ['X' = o2, 'Xs' = [], 'Ys' = [o3, o4], 'Zs' = [o3, o4]]).
proof(46, append([o2], [o3, o4], [o2, o3, o4]), rule(7), [uses(45, append([], [o3, o4], [o3, o4]))]).
substitution(47, []).
proof(47, p1(s2, o2), rule(2), []).
substitution(48, ['O' = o2]).
proof(48, solution([o2]), query, [uses(47, p1(s2, o2))]).
substitution(49, ['S' = s2, 'Ss' = [s3], 'Result' = [o2, o3, o4], 'O' = _0, 'Bag1' = [o2], 'Os' = [o2], 'Rest' = [o3, o4]]).
proof(49, flat_map_p1([s2, s3], [o2, o3, o4]), rule(9), [collected([o2], _0, p1(s2, _0), [48], complete), builtin(sort([o2], [o2])), uses(42, flat_map_p1([s3], [o3, o4])), uses(46, append([o2], [o3, o4], [o2, o3, o4]))]).
substitution(50, []).
proof(50, p1(s1, o1), rule(1), []).
substitution(51, ['O' = o1]).
proof(51, solution([o1]), query, [uses(50, p1(s1, o1))]).
substitution(52, ['Ys' = [o2, o3, o4]]).
proof(52, append([], [o2, o3, o4], [o2, o3, o4]), rule(6), []).
substitution(53, ['X' = o1, 'Xs' = [], 'Ys' = [o2, o3, o4], 'Zs' = [o2, o3, o4]]).
proof(53, append([o1], [o2, o3, o4], [o1, o2, o3, o4]), rule(7), [uses(52, append([], [o2, o3, o4], [o2, o3, o4]))]).
substitution(54, []).
proof(54, p1(s1, o1), rule(1), []).
substitution(55, ['O' = o1]).
proof(55, solution([o1]), query, [uses(54, p1(s1, o1))]).
substitution(56, ['S' = s1, 'Ss' = [s2, s3], 'Result' = [o1, o2, o3, o4], 'O' = _0, 'Bag1' = [o1], 'Os' = [o1], 'Rest' = [o2, o3, o4]]).
proof(56, flat_map_p1([s1, s2, s3], [o1, o2, o3, o4]), rule(9), [collected([o1], _0, p1(s1, _0), [55], complete), builtin(sort([o1], [o1])), uses(49, flat_map_p1([s2, s3], [o2, o3, o4])), uses(53, append([o1], [o2, o3, o4], [o1, o2, o3, o4]))]).
substitution(57, []).
proof(57, test2(true), rule(13), [uses(56, flat_map_p1([s1, s2, s3], [o1, o2, o3, o4]))]).
substitution(58, ['R' = true]).
proof(58, solution([true]), query, [uses(57, test2(true))]).
substitution(59, []).
proof(59, flat_map_p1([], []), rule(8), []).
substitution(60, ['Ys' = []]).
proof(60, append([], [], []), rule(6), []).
substitution(61, ['S' = s4, 'Ss' = [], 'Result' = [], 'O' = _0, 'Bag1' = [], 'Os' = [], 'Rest' = []]).
proof(61, flat_map_p1([s4], []), rule(9), [collected([], _0, p1(s4, _0), [], complete), builtin(sort([], [])), uses(59, flat_map_p1([], [])), uses(60, append([], [], []))]).
substitution(62, []).
proof(62, test3(true), rule(14), [uses(61, flat_map_p1([s4], []))]).
substitution(63, ['R' = true]).
proof(63, solution([true]), query, [uses(62, test3(true))]).
substitution(64, []).
proof(64, flat_map_p2([], []), rule(10), []).
substitution(65, ['Ys' = []]).
proof(65, append([], [], []), rule(6), []).
substitution(66, ['S' = s1, 'Ss' = [], 'Result' = [], 'O' = _0, 'Bag1' = [], 'Os' = [], 'Rest' = []]).
proof(66, flat_map_p2([s1], []), rule(11), [collected([], _0, p2(s1, _0), [], complete), builtin(sort([], [])), uses(64, flat_map_p2([], [])), uses(65, append([], [], []))]).
substitution(67, []).
proof(67, test4(true), rule(15), [uses(66, flat_map_p2([s1], []))]).
substitution(68, ['R' = true]).
proof(68, solution([true]), query, [uses(67, test4(true))]).
