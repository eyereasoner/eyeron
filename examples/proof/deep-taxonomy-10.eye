# Eyelang result format 2
query(1, [call(arc(?v0, ?v1))], [binding("check", ?v0), binding("message", ?v1)]).
result(1, complete, 6).
answer(1, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")]).
why(1, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")], 4).
answer(1, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")]).
why(1, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")], 11).
answer(1, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches.")]).
why(1, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches.")], 21).
answer(1, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n9 to n10 was completed.")]).
why(1, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n9 to n10 was completed.")], 24).
answer(1, [binding("check", check5), binding("message", "C5 OK - once n10 is reached, the terminal class a2 is derived.")]).
why(1, [binding("check", check5), binding("message", "C5 OK - once n10 is reached, the terminal class a2 is derived.")], 26).
answer(1, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")]).
why(1, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")], 29).
query(2, [call(holds_result(test, true))], []).
result(2, complete, 1).
answer(2, []).
why(2, [], 43).
clause(1, a(ind, n0), []).
clause(2, a(var("x"), n1), [call(a(var("x"), n0))]).
clause(3, a(var("x"), i1), [call(a(var("x"), n0))]).
clause(4, a(var("x"), j1), [call(a(var("x"), n0))]).
clause(5, a(var("x"), n2), [call(a(var("x"), n1))]).
clause(8, a(var("x"), n3), [call(a(var("x"), n2))]).
clause(11, a(var("x"), n4), [call(a(var("x"), n3))]).
clause(14, a(var("x"), n5), [call(a(var("x"), n4))]).
clause(15, a(var("x"), i5), [call(a(var("x"), n4))]).
clause(16, a(var("x"), j5), [call(a(var("x"), n4))]).
clause(17, a(var("x"), n6), [call(a(var("x"), n5))]).
clause(20, a(var("x"), n7), [call(a(var("x"), n6))]).
clause(23, a(var("x"), n8), [call(a(var("x"), n7))]).
clause(26, a(var("x"), n9), [call(a(var("x"), n8))]).
clause(29, a(var("x"), n10), [call(a(var("x"), n9))]).
clause(32, a(var("x"), a2), [call(a(var("x"), n10))]).
clause(33, holds_result(test, true), [call(a(ind, a2))]).
clause(34, arc(check1, "C1 OK - the starting classification n0 is present."), [call(a(ind, n0))]).
clause(35, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), [call(a(ind, n1)), call(a(ind, i1)), call(a(ind, j1))]).
clause(36, arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."), [call(a(ind, n5)), call(a(ind, i5)), call(a(ind, j5))]).
clause(37, arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."), [call(a(ind, n9)), call(a(ind, n10))]).
clause(38, arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."), [call(a(ind, n10)), call(a(ind, a2))]).
clause(39, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), [call(a(ind, a2)), call(holds_result(test, true))]).
substitution(1, []).
proof(1, a(ind, n0), rule(1), []).
substitution(2, [binding("x", ind)]).
proof(2, a(ind, n1), rule(2), [uses(1, a(ind, n0))]).
substitution(3, []).
proof(3, arc(check1, "C1 OK - the starting classification n0 is present."), rule(34), [uses(1, a(ind, n0))]).
substitution(4, [binding("check", check1), binding("message", "C1 OK - the starting classification n0 is present.")]).
proof(4, solution([check1, "C1 OK - the starting classification n0 is present."]), query, [uses(3, arc(check1, "C1 OK - the starting classification n0 is present."))]).
substitution(5, [binding("x", ind)]).
proof(5, a(ind, i1), rule(3), [uses(1, a(ind, n0))]).
substitution(6, [binding("x", ind)]).
proof(6, a(ind, n2), rule(5), [uses(2, a(ind, n1))]).
substitution(7, [binding("x", ind)]).
proof(7, a(ind, j1), rule(4), [uses(1, a(ind, n0))]).
substitution(8, [binding("x", ind)]).
proof(8, a(ind, n3), rule(8), [uses(6, a(ind, n2))]).
substitution(9, []).
proof(9, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."), rule(35), [uses(2, a(ind, n1)), uses(5, a(ind, i1)), uses(7, a(ind, j1))]).
substitution(10, [binding("x", ind)]).
proof(10, a(ind, n4), rule(11), [uses(8, a(ind, n3))]).
substitution(11, [binding("check", check2), binding("message", "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")]).
proof(11, solution([check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]), query, [uses(9, arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."))]).
substitution(12, [binding("x", ind)]).
proof(12, a(ind, n5), rule(14), [uses(10, a(ind, n4))]).
substitution(13, [binding("x", ind)]).
proof(13, a(ind, n6), rule(17), [uses(12, a(ind, n5))]).
substitution(14, [binding("x", ind)]).
proof(14, a(ind, i5), rule(15), [uses(10, a(ind, n4))]).
substitution(15, [binding("x", ind)]).
proof(15, a(ind, n7), rule(20), [uses(13, a(ind, n6))]).
substitution(16, [binding("x", ind)]).
proof(16, a(ind, n8), rule(23), [uses(15, a(ind, n7))]).
substitution(17, [binding("x", ind)]).
proof(17, a(ind, j5), rule(16), [uses(10, a(ind, n4))]).
substitution(18, [binding("x", ind)]).
proof(18, a(ind, n9), rule(26), [uses(16, a(ind, n8))]).
substitution(19, []).
proof(19, arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."), rule(36), [uses(12, a(ind, n5)), uses(14, a(ind, i5)), uses(17, a(ind, j5))]).
substitution(20, [binding("x", ind)]).
proof(20, a(ind, n10), rule(29), [uses(18, a(ind, n9))]).
substitution(21, [binding("check", check3), binding("message", "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches.")]).
proof(21, solution([check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."]), query, [uses(19, arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."))]).
substitution(22, []).
proof(22, arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."), rule(37), [uses(18, a(ind, n9)), uses(20, a(ind, n10))]).
substitution(23, [binding("x", ind)]).
proof(23, a(ind, a2), rule(32), [uses(20, a(ind, n10))]).
substitution(24, [binding("check", check4), binding("message", "C4 OK - the final taxonomy step from n9 to n10 was completed.")]).
proof(24, solution([check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."]), query, [uses(22, arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."))]).
substitution(25, []).
proof(25, arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."), rule(38), [uses(20, a(ind, n10)), uses(23, a(ind, a2))]).
substitution(26, [binding("check", check5), binding("message", "C5 OK - once n10 is reached, the terminal class a2 is derived.")]).
proof(26, solution([check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."]), query, [uses(25, arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."))]).
substitution(27, []).
proof(27, holds_result(test, true), rule(33), [uses(23, a(ind, a2))]).
substitution(28, []).
proof(28, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."), rule(39), [uses(23, a(ind, a2)), uses(27, holds_result(test, true))]).
substitution(29, [binding("check", check6), binding("message", "C6 OK - the success flag is raised only after the terminal class a2 is present.")]).
proof(29, solution([check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."]), query, [uses(28, arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."))]).
substitution(30, []).
proof(30, a(ind, n0), rule(1), []).
substitution(31, [binding("x", ind)]).
proof(31, a(ind, n1), rule(2), [uses(30, a(ind, n0))]).
substitution(32, [binding("x", ind)]).
proof(32, a(ind, n2), rule(5), [uses(31, a(ind, n1))]).
substitution(33, [binding("x", ind)]).
proof(33, a(ind, n3), rule(8), [uses(32, a(ind, n2))]).
substitution(34, [binding("x", ind)]).
proof(34, a(ind, n4), rule(11), [uses(33, a(ind, n3))]).
substitution(35, [binding("x", ind)]).
proof(35, a(ind, n5), rule(14), [uses(34, a(ind, n4))]).
substitution(36, [binding("x", ind)]).
proof(36, a(ind, n6), rule(17), [uses(35, a(ind, n5))]).
substitution(37, [binding("x", ind)]).
proof(37, a(ind, n7), rule(20), [uses(36, a(ind, n6))]).
substitution(38, [binding("x", ind)]).
proof(38, a(ind, n8), rule(23), [uses(37, a(ind, n7))]).
substitution(39, [binding("x", ind)]).
proof(39, a(ind, n9), rule(26), [uses(38, a(ind, n8))]).
substitution(40, [binding("x", ind)]).
proof(40, a(ind, n10), rule(29), [uses(39, a(ind, n9))]).
substitution(41, [binding("x", ind)]).
proof(41, a(ind, a2), rule(32), [uses(40, a(ind, n10))]).
substitution(42, []).
proof(42, holds_result(test, true), rule(33), [uses(41, a(ind, a2))]).
substitution(43, []).
proof(43, solution([]), query, [uses(42, holds_result(test, true))]).
