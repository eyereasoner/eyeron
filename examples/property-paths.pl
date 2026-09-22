% Direct expansion of the source's sequence and inverse paths into relations.
% This example covers sequence and inverse paths, not a full path grammar.

parent_of(alice, bob).
parent_of(bob, carol).
grandparent_of(X, Z) :-
    parent_of(X, Y),
    parent_of(Y, Z).
has_parent(Child, Parent) :-
    parent_of(Parent, Child).

?- grandparent_of(Person, Grandchild).
?- has_parent(Child, Parent).
