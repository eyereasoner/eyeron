% The producer of blocked appears after its consumer deliberately.
person(alice).
person(bob).
person(carol).
blocked(alice).
flagged(carol).
eligible(Person) :-
    person(Person),
    \+ blocked(Person).
blocked(Person) :-
    flagged(Person).
?- eligible(Person).
