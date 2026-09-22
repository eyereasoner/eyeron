% Prolog example: list-map.
% Companion to list-map.n3/.srl: N3's list:map behaves like flatMap over
% a subject list and a fixed predicate, so this defines the equivalent as
% a recursive relation combining `collect` (gathering one subject's
% objects) and `append` (concatenating them across the list), matching
% each of the source's four cases (multiple objects per subject, an
% absent subject, and an absent predicate).
p1(s1, o1).
p1(s2, o2).
p1(s3, o3).
p1(s3, o4).
p2(never_used_subject, never_used_object).

append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :-
    append(Xs, Ys, Zs).

flat_map_p1([], []).

flat_map_p1([S|Ss], Result) :-
    findall(O, p1(S, O), Bag1),
    sort(Bag1, Os),
    flat_map_p1(Ss, Rest),
    append(Os, Rest, Result).

flat_map_p2([], []).

flat_map_p2([S|Ss], Result) :-
    findall(O, p2(S, O), Bag1),
    sort(Bag1, Os),
    flat_map_p2(Ss, Rest),
    append(Os, Rest, Result).

test1(true) :-
    flat_map_p1([s1, s2], [o1, o2]).
test2(true) :-
    flat_map_p1([s1, s2, s3], [o1, o2, o3, o4]).
test3(true) :-
    flat_map_p1([s4], []).
test4(true) :-
    flat_map_p2([s1], []).

?- test1(R).
?- test2(R).
?- test3(R).
?- test4(R).
