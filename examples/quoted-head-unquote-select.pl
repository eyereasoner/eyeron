% Prolog example: quoted-head-unquote-select.
% Companion to quoted-head-unquote-select.n3/.srl: the N3 source picks
% which of several stored quoted rules to activate via metadata
% (class -> rule -> formula) and then unquotes it -- again a reflective
% capability Prolog has no counterpart for. This keeps the same
% class-to-rule metadata shape (`activates/2`) but dispatches with an
% ordinary, statically-resolved rule per class instead of unquoting a
% formula chosen at runtime.
activates(cat, ruleCat).
activates(dog, ruleDog).
class_of(c, cat).

animal(X) :-
    class_of(X, cat),
    activates(cat, ruleCat).
pet(X) :-
    class_of(X, dog),
    activates(dog, ruleDog).

test_is(true) :-
    animal(c).
?- test_is(R).
