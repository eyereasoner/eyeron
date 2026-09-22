% Prolog result format 3
query(1, arc(_0, _1), ['Check' = _0, 'Message' = _1]).
result(1, complete, 6).
answer(1, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."]).
why(1, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."], 4).
answer(1, ['Check' = check2, 'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]).
why(1, ['Check' = check2, 'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."], 11).
answer(1, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."]).
why(1, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."], 21).
answer(1, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n9 to n10 was completed."]).
why(1, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n9 to n10 was completed."], 24).
answer(1, ['Check' = check5, 'Message' = "C5 OK - once n10 is reached, the terminal class a2 is derived."]).
why(1, ['Check' = check5, 'Message' = "C5 OK - once n10 is reached, the terminal class a2 is derived."], 26).
answer(1, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."]).
why(1, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."], 29).
query(2, holds_result(test, true), []).
result(2, complete, 1).
answer(2, []).
why(2, [], 43).
clause(1, a(ind, n0), true).
clause(2, a(var('X'), n1), a(var('X'), n0)).
clause(3, a(var('X'), i1), a(var('X'), n0)).
clause(4, a(var('X'), j1), a(var('X'), n0)).
clause(5, a(var('X'), n2), a(var('X'), n1)).
clause(8, a(var('X'), n3), a(var('X'), n2)).
clause(11, a(var('X'), n4), a(var('X'), n3)).
clause(14, a(var('X'), n5), a(var('X'), n4)).
clause(15, a(var('X'), i5), a(var('X'), n4)).
clause(16, a(var('X'), j5), a(var('X'), n4)).
clause(17, a(var('X'), n6), a(var('X'), n5)).
clause(20, a(var('X'), n7), a(var('X'), n6)).
clause(23, a(var('X'), n8), a(var('X'), n7)).
clause(26, a(var('X'), n9), a(var('X'), n8)).
clause(29, a(var('X'), n10), a(var('X'), n9)).
clause(32, a(var('X'), a2), a(var('X'), n10)).
clause(33, holds_result(test, true), a(ind, a2)).
clause(34, arc(check1, "C1 OK - the starting classification n0 is present."), a(ind, n0)).
clause(35, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), (a(ind, n1), a(ind, i1), a(ind, j1))).
clause(36, arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."), (a(ind, n5), a(ind, i5), a(ind, j5))).
clause(37, arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."), (a(ind, n9), a(ind, n10))).
clause(38, arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."), (a(ind, n10), a(ind, a2))).
clause(39, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), (a(ind, a2), holds_result(test, true))).
substitution(1, []).
proof(1, a(ind, n0), rule(1), []).
substitution(2, ['X' = ind]).
proof(2, a(ind, n1), rule(2), [uses(1, a(ind, n0))]).
substitution(3, []).
proof(3, arc(check1, "C1 OK - the starting classification n0 is present."), rule(34), [uses(1, a(ind, n0))]).
substitution(4, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."]).
proof(4, solution([check1, "C1 OK - the starting classification n0 is present."]), query, [uses(3, arc(check1, "C1 OK - the starting classification n0 is present."))]).
substitution(5, ['X' = ind]).
proof(5, a(ind, i1), rule(3), [uses(1, a(ind, n0))]).
substitution(6, ['X' = ind]).
proof(6, a(ind, n2), rule(5), [uses(2, a(ind, n1))]).
substitution(7, ['X' = ind]).
proof(7, a(ind, j1), rule(4), [uses(1, a(ind, n0))]).
substitution(8, ['X' = ind]).
proof(8, a(ind, n3), rule(8), [uses(6, a(ind, n2))]).
substitution(9, []).
proof(9, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), rule(35), [uses(2, a(ind, n1)), uses(5, a(ind, i1)), uses(7, a(ind, j1))]).
substitution(10, ['X' = ind]).
proof(10, a(ind, n4), rule(11), [uses(8, a(ind, n3))]).
substitution(11, ['Check' = check2, 'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]).
proof(11, solution([check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]), query, [uses(9, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."))]).
substitution(12, ['X' = ind]).
proof(12, a(ind, n5), rule(14), [uses(10, a(ind, n4))]).
substitution(13, ['X' = ind]).
proof(13, a(ind, n6), rule(17), [uses(12, a(ind, n5))]).
substitution(14, ['X' = ind]).
proof(14, a(ind, i5), rule(15), [uses(10, a(ind, n4))]).
substitution(15, ['X' = ind]).
proof(15, a(ind, n7), rule(20), [uses(13, a(ind, n6))]).
substitution(16, ['X' = ind]).
proof(16, a(ind, n8), rule(23), [uses(15, a(ind, n7))]).
substitution(17, ['X' = ind]).
proof(17, a(ind, j5), rule(16), [uses(10, a(ind, n4))]).
substitution(18, ['X' = ind]).
proof(18, a(ind, n9), rule(26), [uses(16, a(ind, n8))]).
substitution(19, []).
proof(19, arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."), rule(36), [uses(12, a(ind, n5)), uses(14, a(ind, i5)), uses(17, a(ind, j5))]).
substitution(20, ['X' = ind]).
proof(20, a(ind, n10), rule(29), [uses(18, a(ind, n9))]).
substitution(21, ['Check' = check3, 'Message' = "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."]).
proof(21, solution([check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."]), query, [uses(19, arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."))]).
substitution(22, []).
proof(22, arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."), rule(37), [uses(18, a(ind, n9)), uses(20, a(ind, n10))]).
substitution(23, ['X' = ind]).
proof(23, a(ind, a2), rule(32), [uses(20, a(ind, n10))]).
substitution(24, ['Check' = check4, 'Message' = "C4 OK - the final taxonomy step from n9 to n10 was completed."]).
proof(24, solution([check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."]), query, [uses(22, arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."))]).
substitution(25, []).
proof(25, arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."), rule(38), [uses(20, a(ind, n10)), uses(23, a(ind, a2))]).
substitution(26, ['Check' = check5, 'Message' = "C5 OK - once n10 is reached, the terminal class a2 is derived."]).
proof(26, solution([check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."]), query, [uses(25, arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."))]).
substitution(27, []).
proof(27, holds_result(test, true), rule(33), [uses(23, a(ind, a2))]).
substitution(28, []).
proof(28, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), rule(39), [uses(23, a(ind, a2)), uses(27, holds_result(test, true))]).
substitution(29, ['Check' = check6, 'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."]).
proof(29, solution([check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."]), query, [uses(28, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."))]).
substitution(30, []).
proof(30, a(ind, n0), rule(1), []).
substitution(31, ['X' = ind]).
proof(31, a(ind, n1), rule(2), [uses(30, a(ind, n0))]).
substitution(32, ['X' = ind]).
proof(32, a(ind, n2), rule(5), [uses(31, a(ind, n1))]).
substitution(33, ['X' = ind]).
proof(33, a(ind, n3), rule(8), [uses(32, a(ind, n2))]).
substitution(34, ['X' = ind]).
proof(34, a(ind, n4), rule(11), [uses(33, a(ind, n3))]).
substitution(35, ['X' = ind]).
proof(35, a(ind, n5), rule(14), [uses(34, a(ind, n4))]).
substitution(36, ['X' = ind]).
proof(36, a(ind, n6), rule(17), [uses(35, a(ind, n5))]).
substitution(37, ['X' = ind]).
proof(37, a(ind, n7), rule(20), [uses(36, a(ind, n6))]).
substitution(38, ['X' = ind]).
proof(38, a(ind, n8), rule(23), [uses(37, a(ind, n7))]).
substitution(39, ['X' = ind]).
proof(39, a(ind, n9), rule(26), [uses(38, a(ind, n8))]).
substitution(40, ['X' = ind]).
proof(40, a(ind, n10), rule(29), [uses(39, a(ind, n9))]).
substitution(41, ['X' = ind]).
proof(41, a(ind, a2), rule(32), [uses(40, a(ind, n10))]).
substitution(42, []).
proof(42, holds_result(test, true), rule(33), [uses(41, a(ind, a2))]).
substitution(43, []).
proof(43, solution([]), query, [uses(42, holds_result(test, true))]).
