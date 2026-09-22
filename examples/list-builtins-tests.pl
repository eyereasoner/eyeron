% Prolog example: list-builtins-tests.
% Companion to list-builtins-tests.n3/.srl: covers the same eleven
% list: builtins. Prolog has native list/cons syntax and only
% `length/2` as a built-in list relation, so `append`, `member`,
% last-element, `memberAt`, `remove`-all-occurrences, and index/item
% `iterate` are each defined as ordinary recursive relations; `first`,
% `rest`, and `firstRest` are plain structural pattern matching.
append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :-
    append(Xs, Ys, Zs).

member(X, [X|_]).
member(X, [_|Tail]) :-
    member(X, Tail).

last_([X], X).
last_([_|Xs], X) :-
    last_(Xs, X).

member_at([X|_], 0, X).
member_at([_|Xs], I, X) :-
    I > 0,
    Prev is I - 1,
    member_at(Xs, Prev, X).

remove_all([], _, []).
remove_all([Target|Xs], Target, Result) :-
    remove_all(Xs, Target, Result).
remove_all([X|Xs], Target, [X|Result]) :-
    X \== Target,
    remove_all(Xs, Target, Result).

iterate([X|Xs], 0, X).
iterate([X|Xs], I, Y) :-
    iterate(Xs, Prev, Y),
    I is Prev + 1.

test_append(true) :-
    append([1, 2], [3, 4], [1, 2, 3, 4]).
test_first(true) :-
    [1, 2, 3, 4] = [H|T],
    H = 1.
test_in(true) :-
    member("cat", ["dog", "penguin", "cat"]).
test_iterate(true) :-
    iterate(["dog", "penguin", "cat"], Index, "cat").
test_last(true) :-
    last_([1, 2, 3, 4], 4).
test_length(true) :-
    length([1, 2, 3, 4], 4).
test_member(true) :-
    member("cat", ["dog", "penguin", "cat"]).
test_member_at(true) :-
    member_at(["dog", "penguin", "cat"], 2, "cat").
test_remove(true) :-
    remove_all(["dog", "penguin", "cat", "penguin"], "penguin", ["dog", "cat"]).
test_rest(true) :-
    [1, 2, 3, 4] = [H|T],
    T = [2, 3, 4].
test_first_rest(true) :-
    [1, 2, 3, 4] = [H|T],
    H = 1,
    T = [2, 3, 4].

?- test_append(R).
?- test_first(R).
?- test_in(R).
?- test_iterate(R).
?- test_last(R).
?- test_length(R).
?- test_member(R).
?- test_member_at(R).
?- test_remove(R).
?- test_rest(R).
?- test_first_rest(R).
