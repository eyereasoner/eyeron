% Prolog example: list-iterate.
% Companion to list-iterate.n3/.srl: N3's list:iterate produces every
% (0-based index, item) pair for a list, defined here as an ordinary
% recursive relation over Prolog's own list syntax.
param(letv, [huey, dewey, louie]).

iterate([X|Xs], 0, X).
iterate([X|Xs], I, Y) :-
    iterate(Xs, Prev, Y),
    I is Prev + 1.

test_iterate(X, I, Y) :-
    param(letv, X),
    iterate(X, I, Y).
test_is(true) :-
    test_iterate(X, 1, dewey).

?- test_iterate(X, I, Y).
?- test_is(R).
