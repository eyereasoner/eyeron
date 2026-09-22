% Prolog result format 4
query(1, arc(_0, _1), ['Check' = _0, 'Message' = _1]).
result(1, complete, 6).
answer(1, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."]).
why(1,
    ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."],
    [arc(check1, "C1 OK - the starting classification n0 is present.")]).
answer(1,
       ['Check' = check2,
        'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]).
why(1,
    ['Check' = check2,
     'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."],
    [arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1.")]).
answer(1,
       ['Check' = check3,
        'Message' = "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."]).
why(1,
    ['Check' = check3,
     'Message' = "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."],
    [arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches.")]).
answer(1,
       ['Check' = check4,
        'Message' = "C4 OK - the final taxonomy step from n9 to n10 was completed."]).
why(1,
    ['Check' = check4,
     'Message' = "C4 OK - the final taxonomy step from n9 to n10 was completed."],
    [arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed.")]).
answer(1,
       ['Check' = check5,
        'Message' = "C5 OK - once n10 is reached, the terminal class a2 is derived."]).
why(1,
    ['Check' = check5,
     'Message' = "C5 OK - once n10 is reached, the terminal class a2 is derived."],
    [arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived.")]).
answer(1,
       ['Check' = check6,
        'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."]).
why(1,
    ['Check' = check6,
     'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."],
    [arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present.")]).
query(2, holds_result(test, true), []).
result(2, complete, 1).
answer(2, []).
why(2, [], [holds_result(test, true)]).

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
clause(35,
       arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."),
       (a(ind, n1), a(ind, i1), a(ind, j1))).
clause(36,
       arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."),
       (a(ind, n5), a(ind, i5), a(ind, j5))).
clause(37,
       arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."),
       (a(ind, n9), a(ind, n10))).
clause(38,
       arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."),
       (a(ind, n10), a(ind, a2))).
clause(39,
       arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."),
       (a(ind, a2), holds_result(test, true))).

step(arc(check1, "C1 OK - the starting classification n0 is present."),
     rule(34),
     [],
     [a(ind, n0)]).
step(a(ind, n0), fact(1), [], []).
step(arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1."),
     rule(35),
     [],
     [a(ind, n1), a(ind, i1), a(ind, j1)]).
step(a(ind, n1), rule(2), ['X' = ind], [a(ind, n0)]).
step(a(ind, i1), rule(3), ['X' = ind], [a(ind, n0)]).
step(a(ind, j1), rule(4), ['X' = ind], [a(ind, n0)]).
step(arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches."),
     rule(36),
     [],
     [a(ind, n5), a(ind, i5), a(ind, j5)]).
step(a(ind, n5), rule(14), ['X' = ind], [a(ind, n4)]).
step(a(ind, n4), rule(11), ['X' = ind], [a(ind, n3)]).
step(a(ind, n3), rule(8), ['X' = ind], [a(ind, n2)]).
step(a(ind, n2), rule(5), ['X' = ind], [a(ind, n1)]).
step(a(ind, i5), rule(15), ['X' = ind], [a(ind, n4)]).
step(a(ind, j5), rule(16), ['X' = ind], [a(ind, n4)]).
step(arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed."),
     rule(37),
     [],
     [a(ind, n9), a(ind, n10)]).
step(a(ind, n9), rule(26), ['X' = ind], [a(ind, n8)]).
step(a(ind, n8), rule(23), ['X' = ind], [a(ind, n7)]).
step(a(ind, n7), rule(20), ['X' = ind], [a(ind, n6)]).
step(a(ind, n6), rule(17), ['X' = ind], [a(ind, n5)]).
step(a(ind, n10), rule(29), ['X' = ind], [a(ind, n9)]).
step(arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived."),
     rule(38),
     [],
     [a(ind, n10), a(ind, a2)]).
step(a(ind, a2), rule(32), ['X' = ind], [a(ind, n10)]).
step(arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present."),
     rule(39),
     [],
     [a(ind, a2), holds_result(test, true)]).
step(holds_result(test, true), rule(33), [], [a(ind, a2)]).
