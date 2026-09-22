% Prolog example: rdf-list.
% Companion to rdf-list.n3/.srl: decomposing a list into its head and
% tail. Prolog has native list/cons syntax, so this uses structural
% pattern matching directly instead of N3's rdf:first/rdf:rest backward
% rules.
val(x, [1, 2]).
test_is(true) :-
    val(x, [H|T]),
    H = 1,
    T = [2].
?- test_is(R).
