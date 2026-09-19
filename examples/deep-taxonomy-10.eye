# Eyelang example: deep-taxonomy-10.
# Adjacent rules mirror the Eyeling N3 deep-taxonomy chain (ported the same way
# eyeprolog's own deep-taxonomy examples are): one `a/2` predicate derives an
# individual's classification one level at a time via a plain fact per level, so
# classifying `ind` as a2 genuinely chains through every intervening level --
# matching the .n3/.srl versions of this benchmark -- instead of a closed-form
# arithmetic shortcut. Each step derives the next taxonomy class together with
# two side labels; the final spine class is directly below a2.
a(ind, n0).

a(?x, n1) if a(?x, n0).
a(?x, i1) if a(?x, n0).
a(?x, j1) if a(?x, n0).
a(?x, n2) if a(?x, n1).
a(?x, i2) if a(?x, n1).
a(?x, j2) if a(?x, n1).
a(?x, n3) if a(?x, n2).
a(?x, i3) if a(?x, n2).
a(?x, j3) if a(?x, n2).
a(?x, n4) if a(?x, n3).
a(?x, i4) if a(?x, n3).
a(?x, j4) if a(?x, n3).
a(?x, n5) if a(?x, n4).
a(?x, i5) if a(?x, n4).
a(?x, j5) if a(?x, n4).
a(?x, n6) if a(?x, n5).
a(?x, i6) if a(?x, n5).
a(?x, j6) if a(?x, n5).
a(?x, n7) if a(?x, n6).
a(?x, i7) if a(?x, n6).
a(?x, j7) if a(?x, n6).
a(?x, n8) if a(?x, n7).
a(?x, i8) if a(?x, n7).
a(?x, j8) if a(?x, n7).
a(?x, n9) if a(?x, n8).
a(?x, i9) if a(?x, n8).
a(?x, j9) if a(?x, n8).
a(?x, n10) if a(?x, n9).
a(?x, i10) if a(?x, n9).
a(?x, j10) if a(?x, n9).
a(?x, a2) if a(?x, n10).

holds_result(test, true) if a(ind, a2).

# Spine reachability, both side branches, terminal classification, and the
# success flag are all observable acceptance conditions.
arc(check1, "C1 OK - the starting classification n0 is present.") if a(ind, n0).
arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1.") if a(ind, n1), a(ind, i1), a(ind, j1).
arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches.") if a(ind, n5), a(ind, i5), a(ind, j5).
arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed.") if a(ind, n9), a(ind, n10).
arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived.") if a(ind, n10), a(ind, a2).
arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present.") if a(ind, a2), holds_result(test, true).

ask arc(?check, ?message).
ask holds_result(test, true).
