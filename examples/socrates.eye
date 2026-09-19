instance_of(socrates, human).

subclass_of(human, mortal).

instance_of(?individual, ?superclass) if
    instance_of(?individual, ?class), subclass_of(?class, ?superclass).

ask instance_of(socrates, mortal).
