% Prolog example: negation-orphan.
% Companion to negation-orphan.srl: stratified negation as failure.
person(alice).
person(bob).
child_of(alice, carol).
has_a_parent(X) :-
    child_of(X, _).
orphan(X) :-
    person(X),
    \+ has_a_parent(X).
?- orphan(X).
