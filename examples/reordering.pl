% Prolog example: reordering.
% Companion to reordering.n3/.srl: the N3 source specifically exercises
% premise reordering (its inequality check is written *before* the
% variables it compares are bound, relying on N3's selectivity-based
% reordering to defer it). Prolog does the opposite by design -- goals
% run strictly left to right, and `!=` requires its inputs already bound,
% reporting a mode error rather than reordering -- so this writes the
% two `has` calls first and the inequality check last.
has(alice, [book, 1]).
has(bob, [table, 1]).

test_is(true) :-
    has(W1, [O1, N1]),
    has(W2, [O2, N2]),
    O1 \== O2.

?- test_is(R).
