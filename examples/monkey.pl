% Prolog example: monkey.
% Companion to monkey.n3/.srl. Note the source's own subtlety: bobo is
% stated as an instance of an anonymous kind that is itself a monkey, not
% as a monkey directly -- so it is that kind, not bobo, that ends up
% classified an animal and satisfies the final check.
kind_of(bobo, bobos_kind).
monkey(bobos_kind).
animal(X) :-
    monkey(X).
test :-
    monkey(X),
    animal(X).
?- animal(X).
?- test.
