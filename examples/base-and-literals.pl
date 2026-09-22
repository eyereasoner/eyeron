% Prolog example: base-and-literals.
person(alice, literal("Alice Smith", en), typed(22, integer)).
person(bob, literal("Bob", nl), typed(17, integer)).
adult(Person) :-
    person(Person, literal(Name, en), typed(Age, integer)),
    Age >= 18.
?- adult(Person).
