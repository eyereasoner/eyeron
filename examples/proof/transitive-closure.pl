% Prolog result format 4
query(1, direct_links(_0), ['Links' = _0]).
result(1, complete, 1).
answer(1, ['Links' = 69]).
why(1, ['Links' = 69], [direct_links(69)]).
query(2, reachable_pairs(_0), ['Pairs' = _0]).
result(2, complete, 1).
answer(2, ['Pairs' = 2415]).
why(2, ['Pairs' = 2415], [reachable_pairs(2415)]).
query(3, test_is(_0), ['R' = _0]).
result(3, complete, 1).
answer(3, ['R' = true]).
why(3, ['R' = true], [test_is(true)]).

clause(1,
       link(n(var('N')), n(var('Next'))),
       (between(1, 69, var('N')), var('Next') is var('N') + 1)).
clause(2, reaches(var('From'), var('To')), link(var('From'), var('To'))).
clause(3,
       reaches(var('From'), var('To')),
       (link(var('From'), var('Via')), reaches(var('Via'), var('To')))).
clause(4, direct_links(var('Links')), var('Links') is 70 - 1).
clause(5,
       reachable_pairs(var('Pairs')),
       (var('Max') is 70,
        var('Previous') is var('Max') - 1,
        var('Twice') is var('Max') * var('Previous'),
        var('Pairs') is var('Twice') // 2)).
clause(6, test_is(true), reaches(n(1), n(70))).

step(direct_links(69), rule(4), ['Links' = 69], [69 is 70 - 1]).
step(69 is 70 - 1, builtin, [], []).
step(reachable_pairs(2415),
     rule(5),
     ['Pairs' = 2415, 'Max' = 70, 'Previous' = 69, 'Twice' = 4830],
     [70 is 70, 69 is 70 - 1, 4830 is 70 * 69, 2415 is 4830 // 2]).
step(70 is 70, builtin, [], []).
step(4830 is 70 * 69, builtin, [], []).
step(2415 is 4830 // 2, builtin, [], []).
step(test_is(true), rule(6), [], [reaches(n(1), n(70))]).
step(reaches(n(1), n(70)),
     rule(3),
     ['From' = n(1), 'To' = n(70), 'Via' = n(2)],
     [link(n(1), n(2)), reaches(n(2), n(70))]).
step(link(n(1), n(2)), rule(1), ['N' = 1, 'Next' = 2], [between(1, 69, 1), 2 is 1 + 1]).
step(between(1, 69, 1), builtin, [], []).
step(2 is 1 + 1, builtin, [], []).
step(reaches(n(2), n(70)),
     rule(3),
     ['From' = n(2), 'To' = n(70), 'Via' = n(3)],
     [link(n(2), n(3)), reaches(n(3), n(70))]).
step(link(n(2), n(3)), rule(1), ['N' = 2, 'Next' = 3], [between(1, 69, 2), 3 is 2 + 1]).
step(between(1, 69, 2), builtin, [], []).
step(3 is 2 + 1, builtin, [], []).
step(reaches(n(3), n(70)),
     rule(3),
     ['From' = n(3), 'To' = n(70), 'Via' = n(4)],
     [link(n(3), n(4)), reaches(n(4), n(70))]).
step(link(n(3), n(4)), rule(1), ['N' = 3, 'Next' = 4], [between(1, 69, 3), 4 is 3 + 1]).
step(between(1, 69, 3), builtin, [], []).
step(4 is 3 + 1, builtin, [], []).
step(reaches(n(4), n(70)),
     rule(3),
     ['From' = n(4), 'To' = n(70), 'Via' = n(5)],
     [link(n(4), n(5)), reaches(n(5), n(70))]).
step(link(n(4), n(5)), rule(1), ['N' = 4, 'Next' = 5], [between(1, 69, 4), 5 is 4 + 1]).
step(between(1, 69, 4), builtin, [], []).
step(5 is 4 + 1, builtin, [], []).
step(reaches(n(5), n(70)),
     rule(3),
     ['From' = n(5), 'To' = n(70), 'Via' = n(6)],
     [link(n(5), n(6)), reaches(n(6), n(70))]).
step(link(n(5), n(6)), rule(1), ['N' = 5, 'Next' = 6], [between(1, 69, 5), 6 is 5 + 1]).
step(between(1, 69, 5), builtin, [], []).
step(6 is 5 + 1, builtin, [], []).
step(reaches(n(6), n(70)),
     rule(3),
     ['From' = n(6), 'To' = n(70), 'Via' = n(7)],
     [link(n(6), n(7)), reaches(n(7), n(70))]).
step(link(n(6), n(7)), rule(1), ['N' = 6, 'Next' = 7], [between(1, 69, 6), 7 is 6 + 1]).
step(between(1, 69, 6), builtin, [], []).
step(7 is 6 + 1, builtin, [], []).
step(reaches(n(7), n(70)),
     rule(3),
     ['From' = n(7), 'To' = n(70), 'Via' = n(8)],
     [link(n(7), n(8)), reaches(n(8), n(70))]).
step(link(n(7), n(8)), rule(1), ['N' = 7, 'Next' = 8], [between(1, 69, 7), 8 is 7 + 1]).
step(between(1, 69, 7), builtin, [], []).
step(8 is 7 + 1, builtin, [], []).
step(reaches(n(8), n(70)),
     rule(3),
     ['From' = n(8), 'To' = n(70), 'Via' = n(9)],
     [link(n(8), n(9)), reaches(n(9), n(70))]).
step(link(n(8), n(9)), rule(1), ['N' = 8, 'Next' = 9], [between(1, 69, 8), 9 is 8 + 1]).
step(between(1, 69, 8), builtin, [], []).
step(9 is 8 + 1, builtin, [], []).
step(reaches(n(9), n(70)),
     rule(3),
     ['From' = n(9), 'To' = n(70), 'Via' = n(10)],
     [link(n(9), n(10)), reaches(n(10), n(70))]).
step(link(n(9), n(10)), rule(1), ['N' = 9, 'Next' = 10], [between(1, 69, 9), 10 is 9 + 1]).
step(between(1, 69, 9), builtin, [], []).
step(10 is 9 + 1, builtin, [], []).
step(reaches(n(10), n(70)),
     rule(3),
     ['From' = n(10), 'To' = n(70), 'Via' = n(11)],
     [link(n(10), n(11)), reaches(n(11), n(70))]).
step(link(n(10), n(11)), rule(1), ['N' = 10, 'Next' = 11], [between(1, 69, 10), 11 is 10 + 1]).
step(between(1, 69, 10), builtin, [], []).
step(11 is 10 + 1, builtin, [], []).
step(reaches(n(11), n(70)),
     rule(3),
     ['From' = n(11), 'To' = n(70), 'Via' = n(12)],
     [link(n(11), n(12)), reaches(n(12), n(70))]).
step(link(n(11), n(12)), rule(1), ['N' = 11, 'Next' = 12], [between(1, 69, 11), 12 is 11 + 1]).
step(between(1, 69, 11), builtin, [], []).
step(12 is 11 + 1, builtin, [], []).
step(reaches(n(12), n(70)),
     rule(3),
     ['From' = n(12), 'To' = n(70), 'Via' = n(13)],
     [link(n(12), n(13)), reaches(n(13), n(70))]).
step(link(n(12), n(13)), rule(1), ['N' = 12, 'Next' = 13], [between(1, 69, 12), 13 is 12 + 1]).
step(between(1, 69, 12), builtin, [], []).
step(13 is 12 + 1, builtin, [], []).
step(reaches(n(13), n(70)),
     rule(3),
     ['From' = n(13), 'To' = n(70), 'Via' = n(14)],
     [link(n(13), n(14)), reaches(n(14), n(70))]).
step(link(n(13), n(14)), rule(1), ['N' = 13, 'Next' = 14], [between(1, 69, 13), 14 is 13 + 1]).
step(between(1, 69, 13), builtin, [], []).
step(14 is 13 + 1, builtin, [], []).
step(reaches(n(14), n(70)),
     rule(3),
     ['From' = n(14), 'To' = n(70), 'Via' = n(15)],
     [link(n(14), n(15)), reaches(n(15), n(70))]).
step(link(n(14), n(15)), rule(1), ['N' = 14, 'Next' = 15], [between(1, 69, 14), 15 is 14 + 1]).
step(between(1, 69, 14), builtin, [], []).
step(15 is 14 + 1, builtin, [], []).
step(reaches(n(15), n(70)),
     rule(3),
     ['From' = n(15), 'To' = n(70), 'Via' = n(16)],
     [link(n(15), n(16)), reaches(n(16), n(70))]).
step(link(n(15), n(16)), rule(1), ['N' = 15, 'Next' = 16], [between(1, 69, 15), 16 is 15 + 1]).
step(between(1, 69, 15), builtin, [], []).
step(16 is 15 + 1, builtin, [], []).
step(reaches(n(16), n(70)),
     rule(3),
     ['From' = n(16), 'To' = n(70), 'Via' = n(17)],
     [link(n(16), n(17)), reaches(n(17), n(70))]).
step(link(n(16), n(17)), rule(1), ['N' = 16, 'Next' = 17], [between(1, 69, 16), 17 is 16 + 1]).
step(between(1, 69, 16), builtin, [], []).
step(17 is 16 + 1, builtin, [], []).
step(reaches(n(17), n(70)),
     rule(3),
     ['From' = n(17), 'To' = n(70), 'Via' = n(18)],
     [link(n(17), n(18)), reaches(n(18), n(70))]).
step(link(n(17), n(18)), rule(1), ['N' = 17, 'Next' = 18], [between(1, 69, 17), 18 is 17 + 1]).
step(between(1, 69, 17), builtin, [], []).
step(18 is 17 + 1, builtin, [], []).
step(reaches(n(18), n(70)),
     rule(3),
     ['From' = n(18), 'To' = n(70), 'Via' = n(19)],
     [link(n(18), n(19)), reaches(n(19), n(70))]).
step(link(n(18), n(19)), rule(1), ['N' = 18, 'Next' = 19], [between(1, 69, 18), 19 is 18 + 1]).
step(between(1, 69, 18), builtin, [], []).
step(19 is 18 + 1, builtin, [], []).
step(reaches(n(19), n(70)),
     rule(3),
     ['From' = n(19), 'To' = n(70), 'Via' = n(20)],
     [link(n(19), n(20)), reaches(n(20), n(70))]).
step(link(n(19), n(20)), rule(1), ['N' = 19, 'Next' = 20], [between(1, 69, 19), 20 is 19 + 1]).
step(between(1, 69, 19), builtin, [], []).
step(20 is 19 + 1, builtin, [], []).
step(reaches(n(20), n(70)),
     rule(3),
     ['From' = n(20), 'To' = n(70), 'Via' = n(21)],
     [link(n(20), n(21)), reaches(n(21), n(70))]).
step(link(n(20), n(21)), rule(1), ['N' = 20, 'Next' = 21], [between(1, 69, 20), 21 is 20 + 1]).
step(between(1, 69, 20), builtin, [], []).
step(21 is 20 + 1, builtin, [], []).
step(reaches(n(21), n(70)),
     rule(3),
     ['From' = n(21), 'To' = n(70), 'Via' = n(22)],
     [link(n(21), n(22)), reaches(n(22), n(70))]).
step(link(n(21), n(22)), rule(1), ['N' = 21, 'Next' = 22], [between(1, 69, 21), 22 is 21 + 1]).
step(between(1, 69, 21), builtin, [], []).
step(22 is 21 + 1, builtin, [], []).
step(reaches(n(22), n(70)),
     rule(3),
     ['From' = n(22), 'To' = n(70), 'Via' = n(23)],
     [link(n(22), n(23)), reaches(n(23), n(70))]).
step(link(n(22), n(23)), rule(1), ['N' = 22, 'Next' = 23], [between(1, 69, 22), 23 is 22 + 1]).
step(between(1, 69, 22), builtin, [], []).
step(23 is 22 + 1, builtin, [], []).
step(reaches(n(23), n(70)),
     rule(3),
     ['From' = n(23), 'To' = n(70), 'Via' = n(24)],
     [link(n(23), n(24)), reaches(n(24), n(70))]).
step(link(n(23), n(24)), rule(1), ['N' = 23, 'Next' = 24], [between(1, 69, 23), 24 is 23 + 1]).
step(between(1, 69, 23), builtin, [], []).
step(24 is 23 + 1, builtin, [], []).
step(reaches(n(24), n(70)),
     rule(3),
     ['From' = n(24), 'To' = n(70), 'Via' = n(25)],
     [link(n(24), n(25)), reaches(n(25), n(70))]).
step(link(n(24), n(25)), rule(1), ['N' = 24, 'Next' = 25], [between(1, 69, 24), 25 is 24 + 1]).
step(between(1, 69, 24), builtin, [], []).
step(25 is 24 + 1, builtin, [], []).
step(reaches(n(25), n(70)),
     rule(3),
     ['From' = n(25), 'To' = n(70), 'Via' = n(26)],
     [link(n(25), n(26)), reaches(n(26), n(70))]).
step(link(n(25), n(26)), rule(1), ['N' = 25, 'Next' = 26], [between(1, 69, 25), 26 is 25 + 1]).
step(between(1, 69, 25), builtin, [], []).
step(26 is 25 + 1, builtin, [], []).
step(reaches(n(26), n(70)),
     rule(3),
     ['From' = n(26), 'To' = n(70), 'Via' = n(27)],
     [link(n(26), n(27)), reaches(n(27), n(70))]).
step(link(n(26), n(27)), rule(1), ['N' = 26, 'Next' = 27], [between(1, 69, 26), 27 is 26 + 1]).
step(between(1, 69, 26), builtin, [], []).
step(27 is 26 + 1, builtin, [], []).
step(reaches(n(27), n(70)),
     rule(3),
     ['From' = n(27), 'To' = n(70), 'Via' = n(28)],
     [link(n(27), n(28)), reaches(n(28), n(70))]).
step(link(n(27), n(28)), rule(1), ['N' = 27, 'Next' = 28], [between(1, 69, 27), 28 is 27 + 1]).
step(between(1, 69, 27), builtin, [], []).
step(28 is 27 + 1, builtin, [], []).
step(reaches(n(28), n(70)),
     rule(3),
     ['From' = n(28), 'To' = n(70), 'Via' = n(29)],
     [link(n(28), n(29)), reaches(n(29), n(70))]).
step(link(n(28), n(29)), rule(1), ['N' = 28, 'Next' = 29], [between(1, 69, 28), 29 is 28 + 1]).
step(between(1, 69, 28), builtin, [], []).
step(29 is 28 + 1, builtin, [], []).
step(reaches(n(29), n(70)),
     rule(3),
     ['From' = n(29), 'To' = n(70), 'Via' = n(30)],
     [link(n(29), n(30)), reaches(n(30), n(70))]).
step(link(n(29), n(30)), rule(1), ['N' = 29, 'Next' = 30], [between(1, 69, 29), 30 is 29 + 1]).
step(between(1, 69, 29), builtin, [], []).
step(30 is 29 + 1, builtin, [], []).
step(reaches(n(30), n(70)),
     rule(3),
     ['From' = n(30), 'To' = n(70), 'Via' = n(31)],
     [link(n(30), n(31)), reaches(n(31), n(70))]).
step(link(n(30), n(31)), rule(1), ['N' = 30, 'Next' = 31], [between(1, 69, 30), 31 is 30 + 1]).
step(between(1, 69, 30), builtin, [], []).
step(31 is 30 + 1, builtin, [], []).
step(reaches(n(31), n(70)),
     rule(3),
     ['From' = n(31), 'To' = n(70), 'Via' = n(32)],
     [link(n(31), n(32)), reaches(n(32), n(70))]).
step(link(n(31), n(32)), rule(1), ['N' = 31, 'Next' = 32], [between(1, 69, 31), 32 is 31 + 1]).
step(between(1, 69, 31), builtin, [], []).
step(32 is 31 + 1, builtin, [], []).
step(reaches(n(32), n(70)),
     rule(3),
     ['From' = n(32), 'To' = n(70), 'Via' = n(33)],
     [link(n(32), n(33)), reaches(n(33), n(70))]).
step(link(n(32), n(33)), rule(1), ['N' = 32, 'Next' = 33], [between(1, 69, 32), 33 is 32 + 1]).
step(between(1, 69, 32), builtin, [], []).
step(33 is 32 + 1, builtin, [], []).
step(reaches(n(33), n(70)),
     rule(3),
     ['From' = n(33), 'To' = n(70), 'Via' = n(34)],
     [link(n(33), n(34)), reaches(n(34), n(70))]).
step(link(n(33), n(34)), rule(1), ['N' = 33, 'Next' = 34], [between(1, 69, 33), 34 is 33 + 1]).
step(between(1, 69, 33), builtin, [], []).
step(34 is 33 + 1, builtin, [], []).
step(reaches(n(34), n(70)),
     rule(3),
     ['From' = n(34), 'To' = n(70), 'Via' = n(35)],
     [link(n(34), n(35)), reaches(n(35), n(70))]).
step(link(n(34), n(35)), rule(1), ['N' = 34, 'Next' = 35], [between(1, 69, 34), 35 is 34 + 1]).
step(between(1, 69, 34), builtin, [], []).
step(35 is 34 + 1, builtin, [], []).
step(reaches(n(35), n(70)),
     rule(3),
     ['From' = n(35), 'To' = n(70), 'Via' = n(36)],
     [link(n(35), n(36)), reaches(n(36), n(70))]).
step(link(n(35), n(36)), rule(1), ['N' = 35, 'Next' = 36], [between(1, 69, 35), 36 is 35 + 1]).
step(between(1, 69, 35), builtin, [], []).
step(36 is 35 + 1, builtin, [], []).
step(reaches(n(36), n(70)),
     rule(3),
     ['From' = n(36), 'To' = n(70), 'Via' = n(37)],
     [link(n(36), n(37)), reaches(n(37), n(70))]).
step(link(n(36), n(37)), rule(1), ['N' = 36, 'Next' = 37], [between(1, 69, 36), 37 is 36 + 1]).
step(between(1, 69, 36), builtin, [], []).
step(37 is 36 + 1, builtin, [], []).
step(reaches(n(37), n(70)),
     rule(3),
     ['From' = n(37), 'To' = n(70), 'Via' = n(38)],
     [link(n(37), n(38)), reaches(n(38), n(70))]).
step(link(n(37), n(38)), rule(1), ['N' = 37, 'Next' = 38], [between(1, 69, 37), 38 is 37 + 1]).
step(between(1, 69, 37), builtin, [], []).
step(38 is 37 + 1, builtin, [], []).
step(reaches(n(38), n(70)),
     rule(3),
     ['From' = n(38), 'To' = n(70), 'Via' = n(39)],
     [link(n(38), n(39)), reaches(n(39), n(70))]).
step(link(n(38), n(39)), rule(1), ['N' = 38, 'Next' = 39], [between(1, 69, 38), 39 is 38 + 1]).
step(between(1, 69, 38), builtin, [], []).
step(39 is 38 + 1, builtin, [], []).
step(reaches(n(39), n(70)),
     rule(3),
     ['From' = n(39), 'To' = n(70), 'Via' = n(40)],
     [link(n(39), n(40)), reaches(n(40), n(70))]).
step(link(n(39), n(40)), rule(1), ['N' = 39, 'Next' = 40], [between(1, 69, 39), 40 is 39 + 1]).
step(between(1, 69, 39), builtin, [], []).
step(40 is 39 + 1, builtin, [], []).
step(reaches(n(40), n(70)),
     rule(3),
     ['From' = n(40), 'To' = n(70), 'Via' = n(41)],
     [link(n(40), n(41)), reaches(n(41), n(70))]).
step(link(n(40), n(41)), rule(1), ['N' = 40, 'Next' = 41], [between(1, 69, 40), 41 is 40 + 1]).
step(between(1, 69, 40), builtin, [], []).
step(41 is 40 + 1, builtin, [], []).
step(reaches(n(41), n(70)),
     rule(3),
     ['From' = n(41), 'To' = n(70), 'Via' = n(42)],
     [link(n(41), n(42)), reaches(n(42), n(70))]).
step(link(n(41), n(42)), rule(1), ['N' = 41, 'Next' = 42], [between(1, 69, 41), 42 is 41 + 1]).
step(between(1, 69, 41), builtin, [], []).
step(42 is 41 + 1, builtin, [], []).
step(reaches(n(42), n(70)),
     rule(3),
     ['From' = n(42), 'To' = n(70), 'Via' = n(43)],
     [link(n(42), n(43)), reaches(n(43), n(70))]).
step(link(n(42), n(43)), rule(1), ['N' = 42, 'Next' = 43], [between(1, 69, 42), 43 is 42 + 1]).
step(between(1, 69, 42), builtin, [], []).
step(43 is 42 + 1, builtin, [], []).
step(reaches(n(43), n(70)),
     rule(3),
     ['From' = n(43), 'To' = n(70), 'Via' = n(44)],
     [link(n(43), n(44)), reaches(n(44), n(70))]).
step(link(n(43), n(44)), rule(1), ['N' = 43, 'Next' = 44], [between(1, 69, 43), 44 is 43 + 1]).
step(between(1, 69, 43), builtin, [], []).
step(44 is 43 + 1, builtin, [], []).
step(reaches(n(44), n(70)),
     rule(3),
     ['From' = n(44), 'To' = n(70), 'Via' = n(45)],
     [link(n(44), n(45)), reaches(n(45), n(70))]).
step(link(n(44), n(45)), rule(1), ['N' = 44, 'Next' = 45], [between(1, 69, 44), 45 is 44 + 1]).
step(between(1, 69, 44), builtin, [], []).
step(45 is 44 + 1, builtin, [], []).
step(reaches(n(45), n(70)),
     rule(3),
     ['From' = n(45), 'To' = n(70), 'Via' = n(46)],
     [link(n(45), n(46)), reaches(n(46), n(70))]).
step(link(n(45), n(46)), rule(1), ['N' = 45, 'Next' = 46], [between(1, 69, 45), 46 is 45 + 1]).
step(between(1, 69, 45), builtin, [], []).
step(46 is 45 + 1, builtin, [], []).
step(reaches(n(46), n(70)),
     rule(3),
     ['From' = n(46), 'To' = n(70), 'Via' = n(47)],
     [link(n(46), n(47)), reaches(n(47), n(70))]).
step(link(n(46), n(47)), rule(1), ['N' = 46, 'Next' = 47], [between(1, 69, 46), 47 is 46 + 1]).
step(between(1, 69, 46), builtin, [], []).
step(47 is 46 + 1, builtin, [], []).
step(reaches(n(47), n(70)),
     rule(3),
     ['From' = n(47), 'To' = n(70), 'Via' = n(48)],
     [link(n(47), n(48)), reaches(n(48), n(70))]).
step(link(n(47), n(48)), rule(1), ['N' = 47, 'Next' = 48], [between(1, 69, 47), 48 is 47 + 1]).
step(between(1, 69, 47), builtin, [], []).
step(48 is 47 + 1, builtin, [], []).
step(reaches(n(48), n(70)),
     rule(3),
     ['From' = n(48), 'To' = n(70), 'Via' = n(49)],
     [link(n(48), n(49)), reaches(n(49), n(70))]).
step(link(n(48), n(49)), rule(1), ['N' = 48, 'Next' = 49], [between(1, 69, 48), 49 is 48 + 1]).
step(between(1, 69, 48), builtin, [], []).
step(49 is 48 + 1, builtin, [], []).
step(reaches(n(49), n(70)),
     rule(3),
     ['From' = n(49), 'To' = n(70), 'Via' = n(50)],
     [link(n(49), n(50)), reaches(n(50), n(70))]).
step(link(n(49), n(50)), rule(1), ['N' = 49, 'Next' = 50], [between(1, 69, 49), 50 is 49 + 1]).
step(between(1, 69, 49), builtin, [], []).
step(50 is 49 + 1, builtin, [], []).
step(reaches(n(50), n(70)),
     rule(3),
     ['From' = n(50), 'To' = n(70), 'Via' = n(51)],
     [link(n(50), n(51)), reaches(n(51), n(70))]).
step(link(n(50), n(51)), rule(1), ['N' = 50, 'Next' = 51], [between(1, 69, 50), 51 is 50 + 1]).
step(between(1, 69, 50), builtin, [], []).
step(51 is 50 + 1, builtin, [], []).
step(reaches(n(51), n(70)),
     rule(3),
     ['From' = n(51), 'To' = n(70), 'Via' = n(52)],
     [link(n(51), n(52)), reaches(n(52), n(70))]).
step(link(n(51), n(52)), rule(1), ['N' = 51, 'Next' = 52], [between(1, 69, 51), 52 is 51 + 1]).
step(between(1, 69, 51), builtin, [], []).
step(52 is 51 + 1, builtin, [], []).
step(reaches(n(52), n(70)),
     rule(3),
     ['From' = n(52), 'To' = n(70), 'Via' = n(53)],
     [link(n(52), n(53)), reaches(n(53), n(70))]).
step(link(n(52), n(53)), rule(1), ['N' = 52, 'Next' = 53], [between(1, 69, 52), 53 is 52 + 1]).
step(between(1, 69, 52), builtin, [], []).
step(53 is 52 + 1, builtin, [], []).
step(reaches(n(53), n(70)),
     rule(3),
     ['From' = n(53), 'To' = n(70), 'Via' = n(54)],
     [link(n(53), n(54)), reaches(n(54), n(70))]).
step(link(n(53), n(54)), rule(1), ['N' = 53, 'Next' = 54], [between(1, 69, 53), 54 is 53 + 1]).
step(between(1, 69, 53), builtin, [], []).
step(54 is 53 + 1, builtin, [], []).
step(reaches(n(54), n(70)),
     rule(3),
     ['From' = n(54), 'To' = n(70), 'Via' = n(55)],
     [link(n(54), n(55)), reaches(n(55), n(70))]).
step(link(n(54), n(55)), rule(1), ['N' = 54, 'Next' = 55], [between(1, 69, 54), 55 is 54 + 1]).
step(between(1, 69, 54), builtin, [], []).
step(55 is 54 + 1, builtin, [], []).
step(reaches(n(55), n(70)),
     rule(3),
     ['From' = n(55), 'To' = n(70), 'Via' = n(56)],
     [link(n(55), n(56)), reaches(n(56), n(70))]).
step(link(n(55), n(56)), rule(1), ['N' = 55, 'Next' = 56], [between(1, 69, 55), 56 is 55 + 1]).
step(between(1, 69, 55), builtin, [], []).
step(56 is 55 + 1, builtin, [], []).
step(reaches(n(56), n(70)),
     rule(3),
     ['From' = n(56), 'To' = n(70), 'Via' = n(57)],
     [link(n(56), n(57)), reaches(n(57), n(70))]).
step(link(n(56), n(57)), rule(1), ['N' = 56, 'Next' = 57], [between(1, 69, 56), 57 is 56 + 1]).
step(between(1, 69, 56), builtin, [], []).
step(57 is 56 + 1, builtin, [], []).
step(reaches(n(57), n(70)),
     rule(3),
     ['From' = n(57), 'To' = n(70), 'Via' = n(58)],
     [link(n(57), n(58)), reaches(n(58), n(70))]).
step(link(n(57), n(58)), rule(1), ['N' = 57, 'Next' = 58], [between(1, 69, 57), 58 is 57 + 1]).
step(between(1, 69, 57), builtin, [], []).
step(58 is 57 + 1, builtin, [], []).
step(reaches(n(58), n(70)),
     rule(3),
     ['From' = n(58), 'To' = n(70), 'Via' = n(59)],
     [link(n(58), n(59)), reaches(n(59), n(70))]).
step(link(n(58), n(59)), rule(1), ['N' = 58, 'Next' = 59], [between(1, 69, 58), 59 is 58 + 1]).
step(between(1, 69, 58), builtin, [], []).
step(59 is 58 + 1, builtin, [], []).
step(reaches(n(59), n(70)),
     rule(3),
     ['From' = n(59), 'To' = n(70), 'Via' = n(60)],
     [link(n(59), n(60)), reaches(n(60), n(70))]).
step(link(n(59), n(60)), rule(1), ['N' = 59, 'Next' = 60], [between(1, 69, 59), 60 is 59 + 1]).
step(between(1, 69, 59), builtin, [], []).
step(60 is 59 + 1, builtin, [], []).
step(reaches(n(60), n(70)),
     rule(3),
     ['From' = n(60), 'To' = n(70), 'Via' = n(61)],
     [link(n(60), n(61)), reaches(n(61), n(70))]).
step(link(n(60), n(61)), rule(1), ['N' = 60, 'Next' = 61], [between(1, 69, 60), 61 is 60 + 1]).
step(between(1, 69, 60), builtin, [], []).
step(61 is 60 + 1, builtin, [], []).
step(reaches(n(61), n(70)),
     rule(3),
     ['From' = n(61), 'To' = n(70), 'Via' = n(62)],
     [link(n(61), n(62)), reaches(n(62), n(70))]).
step(link(n(61), n(62)), rule(1), ['N' = 61, 'Next' = 62], [between(1, 69, 61), 62 is 61 + 1]).
step(between(1, 69, 61), builtin, [], []).
step(62 is 61 + 1, builtin, [], []).
step(reaches(n(62), n(70)),
     rule(3),
     ['From' = n(62), 'To' = n(70), 'Via' = n(63)],
     [link(n(62), n(63)), reaches(n(63), n(70))]).
step(link(n(62), n(63)), rule(1), ['N' = 62, 'Next' = 63], [between(1, 69, 62), 63 is 62 + 1]).
step(between(1, 69, 62), builtin, [], []).
step(63 is 62 + 1, builtin, [], []).
step(reaches(n(63), n(70)),
     rule(3),
     ['From' = n(63), 'To' = n(70), 'Via' = n(64)],
     [link(n(63), n(64)), reaches(n(64), n(70))]).
step(link(n(63), n(64)), rule(1), ['N' = 63, 'Next' = 64], [between(1, 69, 63), 64 is 63 + 1]).
step(between(1, 69, 63), builtin, [], []).
step(64 is 63 + 1, builtin, [], []).
step(reaches(n(64), n(70)),
     rule(3),
     ['From' = n(64), 'To' = n(70), 'Via' = n(65)],
     [link(n(64), n(65)), reaches(n(65), n(70))]).
step(link(n(64), n(65)), rule(1), ['N' = 64, 'Next' = 65], [between(1, 69, 64), 65 is 64 + 1]).
step(between(1, 69, 64), builtin, [], []).
step(65 is 64 + 1, builtin, [], []).
step(reaches(n(65), n(70)),
     rule(3),
     ['From' = n(65), 'To' = n(70), 'Via' = n(66)],
     [link(n(65), n(66)), reaches(n(66), n(70))]).
step(link(n(65), n(66)), rule(1), ['N' = 65, 'Next' = 66], [between(1, 69, 65), 66 is 65 + 1]).
step(between(1, 69, 65), builtin, [], []).
step(66 is 65 + 1, builtin, [], []).
step(reaches(n(66), n(70)),
     rule(3),
     ['From' = n(66), 'To' = n(70), 'Via' = n(67)],
     [link(n(66), n(67)), reaches(n(67), n(70))]).
step(link(n(66), n(67)), rule(1), ['N' = 66, 'Next' = 67], [between(1, 69, 66), 67 is 66 + 1]).
step(between(1, 69, 66), builtin, [], []).
step(67 is 66 + 1, builtin, [], []).
step(reaches(n(67), n(70)),
     rule(3),
     ['From' = n(67), 'To' = n(70), 'Via' = n(68)],
     [link(n(67), n(68)), reaches(n(68), n(70))]).
step(link(n(67), n(68)), rule(1), ['N' = 67, 'Next' = 68], [between(1, 69, 67), 68 is 67 + 1]).
step(between(1, 69, 67), builtin, [], []).
step(68 is 67 + 1, builtin, [], []).
step(reaches(n(68), n(70)),
     rule(3),
     ['From' = n(68), 'To' = n(70), 'Via' = n(69)],
     [link(n(68), n(69)), reaches(n(69), n(70))]).
step(link(n(68), n(69)), rule(1), ['N' = 68, 'Next' = 69], [between(1, 69, 68), 69 is 68 + 1]).
step(between(1, 69, 68), builtin, [], []).
step(69 is 68 + 1, builtin, [], []).
step(reaches(n(69), n(70)), rule(2), ['From' = n(69), 'To' = n(70)], [link(n(69), n(70))]).
step(link(n(69), n(70)), rule(1), ['N' = 69, 'Next' = 70], [between(1, 69, 69), 70 is 69 + 1]).
step(between(1, 69, 69), builtin, [], []).
step(70 is 69 + 1, builtin, [], []).
