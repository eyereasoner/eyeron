test1(true).
test2(true).
test3(true).
test4(true).

clause(1, p1(s1, o1), true).
clause(2, p1(s2, o2), true).
clause(3, p1(s3, o3), true).
clause(4, p1(s3, o4), true).
clause(6, append([], var('Ys'), var('Ys')), true).
clause(7,
       append([var('X')|var('Xs')], var('Ys'), [var('X')|var('Zs')]),
       append(var('Xs'), var('Ys'), var('Zs'))).
clause(8, flat_map_p1([], []), true).
clause(9,
       flat_map_p1([var('S')|var('Ss')], var('Result')),
       (findall(var('O'), p1(var('S'), var('O')), var('Bag1')),
        sort(var('Bag1'), var('Os')),
        flat_map_p1(var('Ss'), var('Rest')),
        append(var('Os'), var('Rest'), var('Result')))).
clause(10, flat_map_p2([], []), true).
clause(11,
       flat_map_p2([var('S')|var('Ss')], var('Result')),
       (findall(var('O'), p2(var('S'), var('O')), var('Bag1')),
        sort(var('Bag1'), var('Os')),
        flat_map_p2(var('Ss'), var('Rest')),
        append(var('Os'), var('Rest'), var('Result')))).
clause(12, test1(true), flat_map_p1([s1, s2], [o1, o2])).
clause(13, test2(true), flat_map_p1([s1, s2, s3], [o1, o2, o3, o4])).
clause(14, test3(true), flat_map_p1([s4], [])).
clause(15, test4(true), flat_map_p2([s1], [])).

step(test1(true), rule(12), [], [flat_map_p1([s1, s2], [o1, o2])]).
step(flat_map_p1([s1, s2], [o1, o2]),
     rule(9),
     ['S' = s1,
      'Ss' = [s2],
      'Result' = [o1, o2],
      'O' = _0,
      'Bag1' = [o1],
      'Os' = [o1],
      'Rest' = [o2]],
     [findall(_1, p1(s1, _1), [o1]),
      sort([o1], [o1]),
      flat_map_p1([s2], [o2]),
      append([o1], [o2], [o1, o2])]).
step(findall(_0, p1(s1, _0), [o1]), collected, [], [p1(s1, o1)]).
step(p1(s1, o1), fact(1), [], []).
step(sort([o1], [o1]), builtin, [], []).
step(flat_map_p1([s2], [o2]),
     rule(9),
     ['S' = s2, 'Ss' = [], 'Result' = [o2], 'O' = _0, 'Bag1' = [o2], 'Os' = [o2], 'Rest' = []],
     [findall(_1, p1(s2, _1), [o2]),
      sort([o2], [o2]),
      flat_map_p1([], []),
      append([o2], [], [o2])]).
step(findall(_0, p1(s2, _0), [o2]), collected, [], [p1(s2, o2)]).
step(p1(s2, o2), fact(2), [], []).
step(sort([o2], [o2]), builtin, [], []).
step(flat_map_p1([], []), fact(8), [], []).
step(append([o2], [], [o2]),
     rule(7),
     ['X' = o2, 'Xs' = [], 'Ys' = [], 'Zs' = []],
     [append([], [], [])]).
step(append([], [], []), fact(6), ['Ys' = []], []).
step(append([o1], [o2], [o1, o2]),
     rule(7),
     ['X' = o1, 'Xs' = [], 'Ys' = [o2], 'Zs' = [o2]],
     [append([], [o2], [o2])]).
step(append([], [o2], [o2]), fact(6), ['Ys' = [o2]], []).
step(test2(true), rule(13), [], [flat_map_p1([s1, s2, s3], [o1, o2, o3, o4])]).
step(flat_map_p1([s1, s2, s3], [o1, o2, o3, o4]),
     rule(9),
     ['S' = s1,
      'Ss' = [s2, s3],
      'Result' = [o1, o2, o3, o4],
      'O' = _0,
      'Bag1' = [o1],
      'Os' = [o1],
      'Rest' = [o2, o3, o4]],
     [findall(_1, p1(s1, _1), [o1]),
      sort([o1], [o1]),
      flat_map_p1([s2, s3], [o2, o3, o4]),
      append([o1], [o2, o3, o4], [o1, o2, o3, o4])]).
step(flat_map_p1([s2, s3], [o2, o3, o4]),
     rule(9),
     ['S' = s2,
      'Ss' = [s3],
      'Result' = [o2, o3, o4],
      'O' = _0,
      'Bag1' = [o2],
      'Os' = [o2],
      'Rest' = [o3, o4]],
     [findall(_1, p1(s2, _1), [o2]),
      sort([o2], [o2]),
      flat_map_p1([s3], [o3, o4]),
      append([o2], [o3, o4], [o2, o3, o4])]).
step(flat_map_p1([s3], [o3, o4]),
     rule(9),
     ['S' = s3,
      'Ss' = [],
      'Result' = [o3, o4],
      'O' = _0,
      'Bag1' = [o3, o4],
      'Os' = [o3, o4],
      'Rest' = []],
     [findall(_1, p1(s3, _1), [o3, o4]),
      sort([o3, o4], [o3, o4]),
      flat_map_p1([], []),
      append([o3, o4], [], [o3, o4])]).
step(findall(_0, p1(s3, _0), [o3, o4]), collected, [], [p1(s3, o3), p1(s3, o4)]).
step(p1(s3, o3), fact(3), [], []).
step(p1(s3, o4), fact(4), [], []).
step(sort([o3, o4], [o3, o4]), builtin, [], []).
step(append([o3, o4], [], [o3, o4]),
     rule(7),
     ['X' = o3, 'Xs' = [o4], 'Ys' = [], 'Zs' = [o4]],
     [append([o4], [], [o4])]).
step(append([o4], [], [o4]),
     rule(7),
     ['X' = o4, 'Xs' = [], 'Ys' = [], 'Zs' = []],
     [append([], [], [])]).
step(append([o2], [o3, o4], [o2, o3, o4]),
     rule(7),
     ['X' = o2, 'Xs' = [], 'Ys' = [o3, o4], 'Zs' = [o3, o4]],
     [append([], [o3, o4], [o3, o4])]).
step(append([], [o3, o4], [o3, o4]), fact(6), ['Ys' = [o3, o4]], []).
step(append([o1], [o2, o3, o4], [o1, o2, o3, o4]),
     rule(7),
     ['X' = o1, 'Xs' = [], 'Ys' = [o2, o3, o4], 'Zs' = [o2, o3, o4]],
     [append([], [o2, o3, o4], [o2, o3, o4])]).
step(append([], [o2, o3, o4], [o2, o3, o4]), fact(6), ['Ys' = [o2, o3, o4]], []).
step(test3(true), rule(14), [], [flat_map_p1([s4], [])]).
step(flat_map_p1([s4], []),
     rule(9),
     ['S' = s4, 'Ss' = [], 'Result' = [], 'O' = _0, 'Bag1' = [], 'Os' = [], 'Rest' = []],
     [findall(_1, p1(s4, _1), []), sort([], []), flat_map_p1([], []), append([], [], [])]).
step(findall(_0, p1(s4, _0), []), collected, [], []).
step(sort([], []), builtin, [], []).
step(test4(true), rule(15), [], [flat_map_p2([s1], [])]).
step(flat_map_p2([s1], []),
     rule(11),
     ['S' = s1, 'Ss' = [], 'Result' = [], 'O' = _0, 'Bag1' = [], 'Os' = [], 'Rest' = []],
     [findall(_1, p2(s1, _1), []), sort([], []), flat_map_p2([], []), append([], [], [])]).
step(findall(_0, p2(s1, _0), []), collected, [], []).
step(flat_map_p2([], []), fact(10), [], []).
