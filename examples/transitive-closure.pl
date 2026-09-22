% Prolog example: transitive-closure.
% Companion to transitive-closure.n3/.srl: the same 70-node chain and its
% transitive reachability closure. Prolog's built-in `range/3` replaces
% the N3 source's own recursive :range generator, and each node is the
% compound term n(N) rather than a string-concatenated IRI
% ("http://example.org/closure#n1", ...), since Prolog isn't an RDF
% triple language.
link(n(N), n(Next)) :-
    between(1, 69, N),
    Next is N + 1.
reaches(From, To) :-
    link(From, To).
reaches(From, To) :-
    link(From, Via),
    reaches(Via, To).

direct_links(Links) :-
    Links is 70 - 1.
reachable_pairs(Pairs) :-
    Max is 70,
    Previous is Max - 1,
    Twice is Max * Previous,
    Pairs is Twice // 2.

test_is(true) :-
    reaches(n(1), n(70)).

?- direct_links(Links).
?- reachable_pairs(Pairs).
?- test_is(R).
