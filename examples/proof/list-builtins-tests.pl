% Prolog result format 4
query(1, test_append(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], [test_append(true)]).
query(2, test_first(_0), ['R' = _0]).
result(2, complete, 1).
answer(2, ['R' = true]).
why(2, ['R' = true], [test_first(true)]).
query(3, test_in(_0), ['R' = _0]).
result(3, complete, 1).
answer(3, ['R' = true]).
why(3, ['R' = true], [test_in(true)]).
query(4, test_iterate(_0), ['R' = _0]).
result(4, complete, 1).
answer(4, ['R' = true]).
why(4, ['R' = true], [test_iterate(true)]).
query(5, test_last(_0), ['R' = _0]).
result(5, complete, 1).
answer(5, ['R' = true]).
why(5, ['R' = true], [test_last(true)]).
query(6, test_length(_0), ['R' = _0]).
result(6, complete, 1).
answer(6, ['R' = true]).
why(6, ['R' = true], [test_length(true)]).
query(7, test_member(_0), ['R' = _0]).
result(7, complete, 1).
answer(7, ['R' = true]).
why(7, ['R' = true], [test_member(true)]).
query(8, test_member_at(_0), ['R' = _0]).
result(8, complete, 1).
answer(8, ['R' = true]).
why(8, ['R' = true], [test_member_at(true)]).
query(9, test_remove(_0), ['R' = _0]).
result(9, complete, 1).
answer(9, ['R' = true]).
why(9, ['R' = true], [test_remove(true)]).
query(10, test_rest(_0), ['R' = _0]).
result(10, complete, 1).
answer(10, ['R' = true]).
why(10, ['R' = true], [test_rest(true)]).
query(11, test_first_rest(_0), ['R' = _0]).
result(11, complete, 1).
answer(11, ['R' = true]).
why(11, ['R' = true], [test_first_rest(true)]).

clause(1, append([], var('Ys'), var('Ys')), true).
clause(2,
       append([var('X')|var('Xs')], var('Ys'), [var('X')|var('Zs')]),
       append(var('Xs'), var('Ys'), var('Zs'))).
clause(3, member(var('X'), [var('X')|anonymous(1)]), true).
clause(4, member(var('X'), [anonymous(1)|var('Tail')]), member(var('X'), var('Tail'))).
clause(5, last_([var('X')], var('X')), true).
clause(6, last_([anonymous(1)|var('Xs')], var('X')), last_(var('Xs'), var('X'))).
clause(7, member_at([var('X')|anonymous(1)], 0, var('X')), true).
clause(8,
       member_at([anonymous(1)|var('Xs')], var('I'), var('X')),
       (var('I') > 0, var('Prev') is var('I') - 1, member_at(var('Xs'), var('Prev'), var('X')))).
clause(9, remove_all([], anonymous(1), []), true).
clause(10,
       remove_all([var('Target')|var('Xs')], var('Target'), var('Result')),
       remove_all(var('Xs'), var('Target'), var('Result'))).
clause(11,
       remove_all([var('X')|var('Xs')], var('Target'), [var('X')|var('Result')]),
       (var('X') \== var('Target'), remove_all(var('Xs'), var('Target'), var('Result')))).
clause(12, iterate([var('X')|var('Xs')], 0, var('X')), true).
clause(13,
       iterate([var('X')|var('Xs')], var('I'), var('Y')),
       (iterate(var('Xs'), var('Prev'), var('Y')), var('I') is var('Prev') + 1)).
clause(14, test_append(true), append([1, 2], [3, 4], [1, 2, 3, 4])).
clause(15, test_first(true), ([1, 2, 3, 4] = [var('H')|var('T')], var('H') = 1)).
clause(16, test_in(true), member("cat", ["dog", "penguin", "cat"])).
clause(17, test_iterate(true), iterate(["dog", "penguin", "cat"], var('Index'), "cat")).
clause(18, test_last(true), last_([1, 2, 3, 4], 4)).
clause(19, test_length(true), length([1, 2, 3, 4], 4)).
clause(20, test_member(true), member("cat", ["dog", "penguin", "cat"])).
clause(21, test_member_at(true), member_at(["dog", "penguin", "cat"], 2, "cat")).
clause(22,
       test_remove(true),
       remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"])).
clause(23, test_rest(true), ([1, 2, 3, 4] = [var('H')|var('T')], var('T') = [2, 3, 4])).
clause(24,
       test_first_rest(true),
       ([1, 2, 3, 4] = [var('H')|var('T')], var('H') = 1, var('T') = [2, 3, 4])).

step(test_append(true), rule(14), [], [append([1, 2], [3, 4], [1, 2, 3, 4])]).
step(append([1, 2], [3, 4], [1, 2, 3, 4]),
     rule(2),
     ['X' = 1, 'Xs' = [2], 'Ys' = [3, 4], 'Zs' = [2, 3, 4]],
     [append([2], [3, 4], [2, 3, 4])]).
step(append([2], [3, 4], [2, 3, 4]),
     rule(2),
     ['X' = 2, 'Xs' = [], 'Ys' = [3, 4], 'Zs' = [3, 4]],
     [append([], [3, 4], [3, 4])]).
step(append([], [3, 4], [3, 4]), fact(1), ['Ys' = [3, 4]], []).
step(test_first(true),
     rule(15),
     ['H' = 1, 'T' = [2, 3, 4]],
     [[1, 2, 3, 4] = [1, 2, 3, 4], 1 = 1]).
step([1, 2, 3, 4] = [1, 2, 3, 4], builtin, [], []).
step(1 = 1, builtin, [], []).
step(test_in(true), rule(16), [], [member("cat", ["dog", "penguin", "cat"])]).
step(member("cat", ["dog", "penguin", "cat"]),
     rule(4),
     ['X' = "cat", 'Tail' = ["penguin", "cat"]],
     [member("cat", ["penguin", "cat"])]).
step(member("cat", ["penguin", "cat"]),
     rule(4),
     ['X' = "cat", 'Tail' = ["cat"]],
     [member("cat", ["cat"])]).
step(member("cat", ["cat"]), fact(3), ['X' = "cat"], []).
step(test_iterate(true),
     rule(17),
     ['Index' = 2],
     [iterate(["dog", "penguin", "cat"], 2, "cat")]).
step(iterate(["dog", "penguin", "cat"], 2, "cat"),
     rule(13),
     ['X' = "dog", 'Xs' = ["penguin", "cat"], 'I' = 2, 'Y' = "cat", 'Prev' = 1],
     [iterate(["penguin", "cat"], 1, "cat"), 2 is 1 + 1]).
step(iterate(["penguin", "cat"], 1, "cat"),
     rule(13),
     ['X' = "penguin", 'Xs' = ["cat"], 'I' = 1, 'Y' = "cat", 'Prev' = 0],
     [iterate(["cat"], 0, "cat"), 1 is 0 + 1]).
step(iterate(["cat"], 0, "cat"), fact(12), ['X' = "cat", 'Xs' = []], []).
step(1 is 0 + 1, builtin, [], []).
step(2 is 1 + 1, builtin, [], []).
step(test_last(true), rule(18), [], [last_([1, 2, 3, 4], 4)]).
step(last_([1, 2, 3, 4], 4), rule(6), ['Xs' = [2, 3, 4], 'X' = 4], [last_([2, 3, 4], 4)]).
step(last_([2, 3, 4], 4), rule(6), ['Xs' = [3, 4], 'X' = 4], [last_([3, 4], 4)]).
step(last_([3, 4], 4), rule(6), ['Xs' = [4], 'X' = 4], [last_([4], 4)]).
step(last_([4], 4), fact(5), ['X' = 4], []).
step(test_length(true), rule(19), [], [length([1, 2, 3, 4], 4)]).
step(length([1, 2, 3, 4], 4), builtin, [], []).
step(test_member(true), rule(20), [], [member("cat", ["dog", "penguin", "cat"])]).
step(test_member_at(true), rule(21), [], [member_at(["dog", "penguin", "cat"], 2, "cat")]).
step(member_at(["dog", "penguin", "cat"], 2, "cat"),
     rule(8),
     ['Xs' = ["penguin", "cat"], 'I' = 2, 'X' = "cat", 'Prev' = 1],
     [2 > 0, 1 is 2 - 1, member_at(["penguin", "cat"], 1, "cat")]).
step(2 > 0, builtin, [], []).
step(1 is 2 - 1, builtin, [], []).
step(member_at(["penguin", "cat"], 1, "cat"),
     rule(8),
     ['Xs' = ["cat"], 'I' = 1, 'X' = "cat", 'Prev' = 0],
     [1 > 0, 0 is 1 - 1, member_at(["cat"], 0, "cat")]).
step(1 > 0, builtin, [], []).
step(0 is 1 - 1, builtin, [], []).
step(member_at(["cat"], 0, "cat"), fact(7), ['X' = "cat"], []).
step(test_remove(true),
     rule(22),
     [],
     [remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"])]).
step(remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"]),
     rule(11),
     ['X' = "dog",
      'Xs' = ["penguin", "cat", "penguin"],
      'Target' = "penguin",
      'Result' = ["cat"]],
     ["dog" \== "penguin", remove_all(["penguin", "cat", "penguin"], "penguin", ["cat"])]).
step("dog" \== "penguin", builtin, [], []).
step(remove_all(["penguin", "cat", "penguin"], "penguin", ["cat"]),
     rule(10),
     ['Target' = "penguin", 'Xs' = ["cat", "penguin"], 'Result' = ["cat"]],
     [remove_all(["cat", "penguin"], "penguin", ["cat"])]).
step(remove_all(["cat", "penguin"], "penguin", ["cat"]),
     rule(11),
     ['X' = "cat", 'Xs' = ["penguin"], 'Target' = "penguin", 'Result' = []],
     ["cat" \== "penguin", remove_all(["penguin"], "penguin", [])]).
step("cat" \== "penguin", builtin, [], []).
step(remove_all(["penguin"], "penguin", []),
     rule(10),
     ['Target' = "penguin", 'Xs' = [], 'Result' = []],
     [remove_all([], "penguin", [])]).
step(remove_all([], "penguin", []), fact(9), [], []).
step(test_rest(true),
     rule(23),
     ['H' = 1, 'T' = [2, 3, 4]],
     [[1, 2, 3, 4] = [1, 2, 3, 4], [2, 3, 4] = [2, 3, 4]]).
step([2, 3, 4] = [2, 3, 4], builtin, [], []).
step(test_first_rest(true),
     rule(24),
     ['H' = 1, 'T' = [2, 3, 4]],
     [[1, 2, 3, 4] = [1, 2, 3, 4], 1 = 1, [2, 3, 4] = [2, 3, 4]]).
