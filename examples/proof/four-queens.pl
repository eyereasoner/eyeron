% Prolog result format 3
query(1, place(4, 4, [], _0), ['Rows' = _0]).
result(1, complete, 2).
answer(1, ['Rows' = [3, 1, 4, 2]]).
why(1, ['Rows' = [3, 1, 4, 2]], 45).
answer(1, ['Rows' = [2, 4, 1, 3]]).
why(1, ['Rows' = [2, 4, 1, 3]], 46).
clause(1, safe(anonymous(1), [], anonymous(2)), true).
clause(2, safe(var('Row'), [var('Other')|var('Rest')], var('Distance')), (var('Row') \== var('Other'), var('Delta') is abs(var('Row') - var('Other')), var('Delta') \== var('Distance'), var('Next') is var('Distance') + 1, safe(var('Row'), var('Rest'), var('Next')))).
clause(3, place(0, anonymous(1), var('Placed'), var('Placed')), true).
clause(4, place(var('Remaining'), var('Size'), var('Placed'), var('Rows')), (var('Remaining') > 0, between(1, var('Size'), var('Row')), safe(var('Row'), var('Placed'), 1), var('Next') is var('Remaining') - 1, place(var('Next'), var('Size'), [var('Row')|var('Placed')], var('Rows')))).
substitution(1, []).
proof(1, safe(1, [], 1), rule(1), []).
substitution(2, []).
proof(2, safe(2, [], 1), rule(1), []).
substitution(3, []).
proof(3, safe(3, [], 1), rule(1), []).
substitution(4, []).
proof(4, safe(4, [], 1), rule(1), []).
substitution(5, []).
proof(5, safe(3, [], 2), rule(1), []).
substitution(6, []).
proof(6, safe(4, [], 2), rule(1), []).
substitution(7, []).
proof(7, safe(1, [], 2), rule(1), []).
substitution(8, []).
proof(8, safe(2, [], 2), rule(1), []).
substitution(9, ['Row' = 3, 'Other' = 1, 'Rest' = [], 'Distance' = 1, 'Delta' = 2, 'Next' = 2]).
proof(9, safe(3, [1], 1), rule(2), [builtin(3 \== 1), builtin(2 is abs(3 - 1)), builtin(2 \== 1), builtin(2 is 1 + 1), uses(5, safe(3, [], 2))]).
substitution(10, ['Row' = 4, 'Other' = 1, 'Rest' = [], 'Distance' = 1, 'Delta' = 3, 'Next' = 2]).
proof(10, safe(4, [1], 1), rule(2), [builtin(4 \== 1), builtin(3 is abs(4 - 1)), builtin(3 \== 1), builtin(2 is 1 + 1), uses(6, safe(4, [], 2))]).
substitution(11, ['Row' = 4, 'Other' = 2, 'Rest' = [], 'Distance' = 1, 'Delta' = 2, 'Next' = 2]).
proof(11, safe(4, [2], 1), rule(2), [builtin(4 \== 2), builtin(2 is abs(4 - 2)), builtin(2 \== 1), builtin(2 is 1 + 1), uses(6, safe(4, [], 2))]).
substitution(12, ['Row' = 1, 'Other' = 3, 'Rest' = [], 'Distance' = 1, 'Delta' = 2, 'Next' = 2]).
proof(12, safe(1, [3], 1), rule(2), [builtin(1 \== 3), builtin(2 is abs(1 - 3)), builtin(2 \== 1), builtin(2 is 1 + 1), uses(7, safe(1, [], 2))]).
substitution(13, ['Row' = 1, 'Other' = 4, 'Rest' = [], 'Distance' = 1, 'Delta' = 3, 'Next' = 2]).
proof(13, safe(1, [4], 1), rule(2), [builtin(1 \== 4), builtin(3 is abs(1 - 4)), builtin(3 \== 1), builtin(2 is 1 + 1), uses(7, safe(1, [], 2))]).
substitution(14, ['Row' = 2, 'Other' = 4, 'Rest' = [], 'Distance' = 1, 'Delta' = 2, 'Next' = 2]).
proof(14, safe(2, [4], 1), rule(2), [builtin(2 \== 4), builtin(2 is abs(2 - 4)), builtin(2 \== 1), builtin(2 is 1 + 1), uses(8, safe(2, [], 2))]).
substitution(15, []).
proof(15, safe(2, [], 3), rule(1), []).
substitution(16, []).
proof(16, safe(1, [], 3), rule(1), []).
substitution(17, []).
proof(17, safe(4, [], 3), rule(1), []).
substitution(18, []).
proof(18, safe(3, [], 3), rule(1), []).
substitution(19, ['Row' = 2, 'Other' = 1, 'Rest' = [], 'Distance' = 2, 'Delta' = 1, 'Next' = 3]).
proof(19, safe(2, [1], 2), rule(2), [builtin(2 \== 1), builtin(1 is abs(2 - 1)), builtin(1 \== 2), builtin(3 is 2 + 1), uses(15, safe(2, [], 3))]).
substitution(20, ['Row' = 1, 'Other' = 2, 'Rest' = [], 'Distance' = 2, 'Delta' = 1, 'Next' = 3]).
proof(20, safe(1, [2], 2), rule(2), [builtin(1 \== 2), builtin(1 is abs(1 - 2)), builtin(1 \== 2), builtin(3 is 2 + 1), uses(16, safe(1, [], 3))]).
substitution(21, ['Row' = 4, 'Other' = 3, 'Rest' = [], 'Distance' = 2, 'Delta' = 1, 'Next' = 3]).
proof(21, safe(4, [3], 2), rule(2), [builtin(4 \== 3), builtin(1 is abs(4 - 3)), builtin(1 \== 2), builtin(3 is 2 + 1), uses(17, safe(4, [], 3))]).
substitution(22, ['Row' = 3, 'Other' = 4, 'Rest' = [], 'Distance' = 2, 'Delta' = 1, 'Next' = 3]).
proof(22, safe(3, [4], 2), rule(2), [builtin(3 \== 4), builtin(1 is abs(3 - 4)), builtin(1 \== 2), builtin(3 is 2 + 1), uses(18, safe(3, [], 3))]).
substitution(23, ['Row' = 2, 'Other' = 4, 'Rest' = [1], 'Distance' = 1, 'Delta' = 2, 'Next' = 2]).
proof(23, safe(2, [4, 1], 1), rule(2), [builtin(2 \== 4), builtin(2 is abs(2 - 4)), builtin(2 \== 1), builtin(2 is 1 + 1), uses(19, safe(2, [1], 2))]).
substitution(24, ['Row' = 1, 'Other' = 4, 'Rest' = [2], 'Distance' = 1, 'Delta' = 3, 'Next' = 2]).
proof(24, safe(1, [4, 2], 1), rule(2), [builtin(1 \== 4), builtin(3 is abs(1 - 4)), builtin(3 \== 1), builtin(2 is 1 + 1), uses(20, safe(1, [2], 2))]).
substitution(25, ['Row' = 4, 'Other' = 1, 'Rest' = [3], 'Distance' = 1, 'Delta' = 3, 'Next' = 2]).
proof(25, safe(4, [1, 3], 1), rule(2), [builtin(4 \== 1), builtin(3 is abs(4 - 1)), builtin(3 \== 1), builtin(2 is 1 + 1), uses(21, safe(4, [3], 2))]).
substitution(26, ['Row' = 3, 'Other' = 1, 'Rest' = [4], 'Distance' = 1, 'Delta' = 2, 'Next' = 2]).
proof(26, safe(3, [1, 4], 1), rule(2), [builtin(3 \== 1), builtin(2 is abs(3 - 1)), builtin(2 \== 1), builtin(2 is 1 + 1), uses(22, safe(3, [4], 2))]).
substitution(27, []).
proof(27, safe(3, [], 4), rule(1), []).
substitution(28, []).
proof(28, safe(2, [], 4), rule(1), []).
substitution(29, ['Row' = 3, 'Other' = 2, 'Rest' = [], 'Distance' = 3, 'Delta' = 1, 'Next' = 4]).
proof(29, safe(3, [2], 3), rule(2), [builtin(3 \== 2), builtin(1 is abs(3 - 2)), builtin(1 \== 3), builtin(4 is 3 + 1), uses(27, safe(3, [], 4))]).
substitution(30, ['Row' = 2, 'Other' = 3, 'Rest' = [], 'Distance' = 3, 'Delta' = 1, 'Next' = 4]).
proof(30, safe(2, [3], 3), rule(2), [builtin(2 \== 3), builtin(1 is abs(2 - 3)), builtin(1 \== 3), builtin(4 is 3 + 1), uses(28, safe(2, [], 4))]).
substitution(31, ['Row' = 3, 'Other' = 4, 'Rest' = [2], 'Distance' = 2, 'Delta' = 1, 'Next' = 3]).
proof(31, safe(3, [4, 2], 2), rule(2), [builtin(3 \== 4), builtin(1 is abs(3 - 4)), builtin(1 \== 2), builtin(3 is 2 + 1), uses(29, safe(3, [2], 3))]).
substitution(32, ['Row' = 2, 'Other' = 1, 'Rest' = [3], 'Distance' = 2, 'Delta' = 1, 'Next' = 3]).
proof(32, safe(2, [1, 3], 2), rule(2), [builtin(2 \== 1), builtin(1 is abs(2 - 1)), builtin(1 \== 2), builtin(3 is 2 + 1), uses(30, safe(2, [3], 3))]).
substitution(33, ['Row' = 3, 'Other' = 1, 'Rest' = [4, 2], 'Distance' = 1, 'Delta' = 2, 'Next' = 2]).
proof(33, safe(3, [1, 4, 2], 1), rule(2), [builtin(3 \== 1), builtin(2 is abs(3 - 1)), builtin(2 \== 1), builtin(2 is 1 + 1), uses(31, safe(3, [4, 2], 2))]).
substitution(34, ['Row' = 2, 'Other' = 4, 'Rest' = [1, 3], 'Distance' = 1, 'Delta' = 2, 'Next' = 2]).
proof(34, safe(2, [4, 1, 3], 1), rule(2), [builtin(2 \== 4), builtin(2 is abs(2 - 4)), builtin(2 \== 1), builtin(2 is 1 + 1), uses(32, safe(2, [1, 3], 2))]).
substitution(35, ['Placed' = [3, 1, 4, 2]]).
proof(35, place(0, 4, [3, 1, 4, 2], [3, 1, 4, 2]), rule(3), []).
substitution(36, ['Placed' = [2, 4, 1, 3]]).
proof(36, place(0, 4, [2, 4, 1, 3], [2, 4, 1, 3]), rule(3), []).
substitution(37, ['Remaining' = 1, 'Size' = 4, 'Placed' = [1, 4, 2], 'Rows' = [3, 1, 4, 2], 'Row' = 3, 'Next' = 0]).
proof(37, place(1, 4, [1, 4, 2], [3, 1, 4, 2]), rule(4), [builtin(1 > 0), builtin(between(1, 4, 3)), uses(33, safe(3, [1, 4, 2], 1)), builtin(0 is 1 - 1), uses(35, place(0, 4, [3, 1, 4, 2], [3, 1, 4, 2]))]).
substitution(38, ['Remaining' = 1, 'Size' = 4, 'Placed' = [4, 1, 3], 'Rows' = [2, 4, 1, 3], 'Row' = 2, 'Next' = 0]).
proof(38, place(1, 4, [4, 1, 3], [2, 4, 1, 3]), rule(4), [builtin(1 > 0), builtin(between(1, 4, 2)), uses(34, safe(2, [4, 1, 3], 1)), builtin(0 is 1 - 1), uses(36, place(0, 4, [2, 4, 1, 3], [2, 4, 1, 3]))]).
substitution(39, ['Remaining' = 2, 'Size' = 4, 'Placed' = [4, 2], 'Rows' = [3, 1, 4, 2], 'Row' = 1, 'Next' = 1]).
proof(39, place(2, 4, [4, 2], [3, 1, 4, 2]), rule(4), [builtin(2 > 0), builtin(between(1, 4, 1)), uses(24, safe(1, [4, 2], 1)), builtin(1 is 2 - 1), uses(37, place(1, 4, [1, 4, 2], [3, 1, 4, 2]))]).
substitution(40, ['Remaining' = 2, 'Size' = 4, 'Placed' = [1, 3], 'Rows' = [2, 4, 1, 3], 'Row' = 4, 'Next' = 1]).
proof(40, place(2, 4, [1, 3], [2, 4, 1, 3]), rule(4), [builtin(2 > 0), builtin(between(1, 4, 4)), uses(25, safe(4, [1, 3], 1)), builtin(1 is 2 - 1), uses(38, place(1, 4, [4, 1, 3], [2, 4, 1, 3]))]).
substitution(41, ['Remaining' = 3, 'Size' = 4, 'Placed' = [2], 'Rows' = [3, 1, 4, 2], 'Row' = 4, 'Next' = 2]).
proof(41, place(3, 4, [2], [3, 1, 4, 2]), rule(4), [builtin(3 > 0), builtin(between(1, 4, 4)), uses(11, safe(4, [2], 1)), builtin(2 is 3 - 1), uses(39, place(2, 4, [4, 2], [3, 1, 4, 2]))]).
substitution(42, ['Remaining' = 3, 'Size' = 4, 'Placed' = [3], 'Rows' = [2, 4, 1, 3], 'Row' = 1, 'Next' = 2]).
proof(42, place(3, 4, [3], [2, 4, 1, 3]), rule(4), [builtin(3 > 0), builtin(between(1, 4, 1)), uses(12, safe(1, [3], 1)), builtin(2 is 3 - 1), uses(40, place(2, 4, [1, 3], [2, 4, 1, 3]))]).
substitution(43, ['Remaining' = 4, 'Size' = 4, 'Placed' = [], 'Rows' = [3, 1, 4, 2], 'Row' = 2, 'Next' = 3]).
proof(43, place(4, 4, [], [3, 1, 4, 2]), rule(4), [builtin(4 > 0), builtin(between(1, 4, 2)), uses(2, safe(2, [], 1)), builtin(3 is 4 - 1), uses(41, place(3, 4, [2], [3, 1, 4, 2]))]).
substitution(44, ['Remaining' = 4, 'Size' = 4, 'Placed' = [], 'Rows' = [2, 4, 1, 3], 'Row' = 3, 'Next' = 3]).
proof(44, place(4, 4, [], [2, 4, 1, 3]), rule(4), [builtin(4 > 0), builtin(between(1, 4, 3)), uses(3, safe(3, [], 1)), builtin(3 is 4 - 1), uses(42, place(3, 4, [3], [2, 4, 1, 3]))]).
substitution(45, ['Rows' = [3, 1, 4, 2]]).
proof(45, solution([[3, 1, 4, 2]]), query, [uses(43, place(4, 4, [], [3, 1, 4, 2]))]).
substitution(46, ['Rows' = [2, 4, 1, 3]]).
proof(46, solution([[2, 4, 1, 3]]), query, [uses(44, place(4, 4, [], [2, 4, 1, 3]))]).
