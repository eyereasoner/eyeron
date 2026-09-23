arc(check1, "C1 OK - the starting classification n0 is present.").
arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1.").
arc(check3,
    "C3 OK - the chain reaches the midpoint n5000 and still carries both side-label branches.").
arc(check4, "C4 OK - the final taxonomy step from n9999 to n10000 was completed.").
arc(check5, "C5 OK - once n10000 is reached, the terminal class a2 is derived.").
arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present.").
holds_result(test, true).
