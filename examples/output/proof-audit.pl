query_dependency(instance_of(socrates, human)).
query_dependency(subclass_of(human, mortal)).
support(instance_of(socrates, human)).
support(subclass_of(human, mortal)).
answer_applied(instance_of(socrates, mortal), 'Individual', socrates).
answer_applied(instance_of(socrates, mortal), 'Superclass', mortal).
answer_applied(instance_of(socrates, mortal), 'Class', human).
