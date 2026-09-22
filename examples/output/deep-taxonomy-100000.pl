% Prolog result format 4
query(1, arc(_0, _1), ['Check' = _0, 'Message' = _1]).
result(1, complete, 6).
answer(1, ['Check' = check1, 'Message' = "C1 OK - the starting classification n0 is present."]).
answer(1,
       ['Check' = check2,
        'Message' = "C2 OK - the first expansion produced n1 together with side labels i1 and j1."]).
answer(1,
       ['Check' = check3,
        'Message' = "C3 OK - the chain reaches the midpoint n50000 and still carries both side-label branches."]).
answer(1,
       ['Check' = check4,
        'Message' = "C4 OK - the final taxonomy step from n99999 to n100000 was completed."]).
answer(1,
       ['Check' = check5,
        'Message' = "C5 OK - once n100000 is reached, the terminal class a2 is derived."]).
answer(1,
       ['Check' = check6,
        'Message' = "C6 OK - the success flag is raised only after the terminal class a2 is present."]).
query(2, holds_result(test, true), []).
result(2, complete, 1).
answer(2, []).
