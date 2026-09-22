% Prolog example: derived-backward-rule.
% Companion to derived-backward-rule.n3/.srl: the N3 source generates a
% *backward* rule from an :invOf metadata fact (again, a rule generated
% as a rule's own conclusion, with no Prolog counterpart). This reifies
% the resulting inverse relationship directly as an ordinary rule.
parent_of(alice, bob).
child_of(X, Y) :-
    parent_of(Y, X).
has_parent(X, Y) :-
    child_of(X, Y).
?- has_parent(X, Y).
?- child_of(X, Y).
