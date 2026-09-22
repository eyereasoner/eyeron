% Prolog example: deep-taxonomy-10.
% Adjacent rules mirror the Eyeling N3 deep-taxonomy chain (ported the same way
% eyeprolog's own deep-taxonomy examples are): one `a/2` predicate derives an
% individual's classification one level at a time via a plain fact per level, so
% classifying `ind` as a2 genuinely chains through every intervening level --
% matching the .n3/.srl versions of this benchmark -- instead of a closed-form
% arithmetic shortcut. Each step derives the next taxonomy class together with
% two side labels; the final spine class is directly below a2.
a(ind, n0).

a(X, n1) :-
    a(X, n0).
a(X, i1) :-
    a(X, n0).
a(X, j1) :-
    a(X, n0).
a(X, n2) :-
    a(X, n1).
a(X, i2) :-
    a(X, n1).
a(X, j2) :-
    a(X, n1).
a(X, n3) :-
    a(X, n2).
a(X, i3) :-
    a(X, n2).
a(X, j3) :-
    a(X, n2).
a(X, n4) :-
    a(X, n3).
a(X, i4) :-
    a(X, n3).
a(X, j4) :-
    a(X, n3).
a(X, n5) :-
    a(X, n4).
a(X, i5) :-
    a(X, n4).
a(X, j5) :-
    a(X, n4).
a(X, n6) :-
    a(X, n5).
a(X, i6) :-
    a(X, n5).
a(X, j6) :-
    a(X, n5).
a(X, n7) :-
    a(X, n6).
a(X, i7) :-
    a(X, n6).
a(X, j7) :-
    a(X, n6).
a(X, n8) :-
    a(X, n7).
a(X, i8) :-
    a(X, n7).
a(X, j8) :-
    a(X, n7).
a(X, n9) :-
    a(X, n8).
a(X, i9) :-
    a(X, n8).
a(X, j9) :-
    a(X, n8).
a(X, n10) :-
    a(X, n9).
a(X, i10) :-
    a(X, n9).
a(X, j10) :-
    a(X, n9).
a(X, a2) :-
    a(X, n10).

holds_result(test, true) :-
    a(ind, a2).

% Spine reachability, both side branches, terminal classification, and the
% success flag are all observable acceptance conditions.
arc(check1, "C1 OK - the starting classification n0 is present.") :-
    a(ind, n0).
arc(check2, "C2 OK - the first expansion produced n1 together with side labels i1 and j1.") :-
    a(ind, n1),
    a(ind, i1),
    a(ind, j1).
arc(check3, "C3 OK - the chain reaches the midpoint n5 and still carries both side-label branches.") :-
    a(ind, n5),
    a(ind, i5),
    a(ind, j5).
arc(check4, "C4 OK - the final taxonomy step from n9 to n10 was completed.") :-
    a(ind, n9),
    a(ind, n10).
arc(check5, "C5 OK - once n10 is reached, the terminal class a2 is derived.") :-
    a(ind, n10),
    a(ind, a2).
arc(check6, "C6 OK - the success flag is raised only after the terminal class a2 is present.") :-
    a(ind, a2),
    holds_result(test, true).

?- arc(Check, Message).
?- holds_result(test, true).
