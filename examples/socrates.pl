instance_of(socrates, human).

subclass_of(human, mortal).

instance_of(Individual, Superclass) :-
    instance_of(Individual, Class),
    subclass_of(Class, Superclass).

?- instance_of(socrates, mortal).
