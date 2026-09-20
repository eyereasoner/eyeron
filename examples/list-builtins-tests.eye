# Eyelang example: list-builtins-tests.
# Companion to list-builtins-tests.n3/.srl: covers the same eleven
# list: builtins. Eyelang has native list/cons syntax and only
# `length/2` as a built-in list relation, so `append`, `member`,
# last-element, `memberAt`, `remove`-all-occurrences, and index/item
# `iterate` are each defined as ordinary recursive relations; `first`,
# `rest`, and `firstRest` are plain structural pattern matching.
append([], ?ys, ?ys).
append([?x | ?xs], ?ys, [?x | ?zs]) if append(?xs, ?ys, ?zs).

member(?x, [?x | ?_]).
member(?x, [?_ | ?tail]) if member(?x, ?tail).

last_([?x], ?x).
last_([?_ | ?xs], ?x) if last_(?xs, ?x).

member_at([?x | ?_], 0, ?x).
member_at([?_ | ?xs], ?i, ?x) if ?i > 0, let ?prev = ?i - 1, member_at(?xs, ?prev, ?x).

remove_all([], ?_, []).
remove_all([?target | ?xs], ?target, ?result) if remove_all(?xs, ?target, ?result).
remove_all([?x | ?xs], ?target, [?x | ?result]) if ?x != ?target, remove_all(?xs, ?target, ?result).

iterate([?x | ?xs], 0, ?x).
iterate([?x | ?xs], ?i, ?y) if iterate(?xs, ?prev, ?y), let ?i = ?prev + 1.

test_append(true) if append([1,2],[3,4],[1,2,3,4]).
test_first(true) if [1,2,3,4] = [?h|?t], ?h = 1.
test_in(true) if member("cat", ["dog","penguin","cat"]).
test_iterate(true) if iterate(["dog","penguin","cat"], ?index, "cat").
test_last(true) if last_([1,2,3,4], 4).
test_length(true) if length([1,2,3,4], 4).
test_member(true) if member("cat", ["dog","penguin","cat"]).
test_member_at(true) if member_at(["dog","penguin","cat"], 2, "cat").
test_remove(true) if remove_all(["dog","penguin","cat","penguin"], "penguin", ["dog","cat"]).
test_rest(true) if [1,2,3,4] = [?h|?t], ?t = [2,3,4].
test_first_rest(true) if [1,2,3,4] = [?h|?t], ?h = 1, ?t = [2,3,4].

ask test_append(?r). ask test_first(?r). ask test_in(?r). ask test_iterate(?r). ask test_last(?r).
ask test_length(?r). ask test_member(?r). ask test_member_at(?r). ask test_remove(?r). ask test_rest(?r). ask test_first_rest(?r).
