% Prolog example: collections-and-blank-nodes.
knows(alice, blank(person1)).
name(blank(person1), "Bob").
tag(blank(person1), friend).
members(team, [alice, bob, carol]).
knows_named(Person, Name) :-
    knows(Person, Node),
    name(Node, Name).
first_member(First) :-
    members(team, [First|Rest]).
?- knows_named(Person, Name).
?- first_member(First).
