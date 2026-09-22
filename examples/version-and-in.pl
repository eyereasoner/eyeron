% Prolog example: version-and-in.
level(alice, gold).
level(bob, bronze).
level(carol, platinum).
priority(X) :-
    level(X, gold).
priority(X) :-
    level(X, platinum).
ordinary(X) :-
    level(X, Level),
    \+ priority(X).
?- priority(Person).
?- ordinary(Person).
