# Eyelang example: list-map.
# Companion to list-map.n3/.srl: N3's list:map behaves like flatMap over
# a subject list and a fixed predicate, so this defines the equivalent as
# a recursive relation combining `collect` (gathering one subject's
# objects) and `append` (concatenating them across the list), matching
# each of the source's four cases (multiple objects per subject, an
# absent subject, and an absent predicate).
p1(s1, o1). p1(s2, o2). p1(s3, o3). p1(s3, o4).
p2(never_used_subject, never_used_object).

append([], ?ys, ?ys).
append([?x | ?xs], ?ys, [?x | ?zs]) if append(?xs, ?ys, ?zs).

flat_map_p1([], []).

flat_map_p1([?s | ?ss], ?result) if
    collect ?os = ?o where { p1(?s, ?o) },
    flat_map_p1(?ss, ?rest),
    append(?os, ?rest, ?result).

flat_map_p2([], []).

flat_map_p2([?s | ?ss], ?result) if
    collect ?os = ?o where { p2(?s, ?o) },
    flat_map_p2(?ss, ?rest),
    append(?os, ?rest, ?result).

test1(true) if flat_map_p1([s1, s2], [o1, o2]).
test2(true) if flat_map_p1([s1, s2, s3], [o1, o2, o3, o4]).
test3(true) if flat_map_p1([s4], []).
test4(true) if flat_map_p2([s1], []).

ask test1(?r). ask test2(?r). ask test3(?r). ask test4(?r).
