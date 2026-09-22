% Prolog result format 4
query(1, instance_of(socrates, mortal), []).
result(1, complete, 1).
answer(1, []).
why(1, [], [instance_of(socrates, mortal)]).

clause(1, instance_of(socrates, human), true).
clause(2, subclass_of(human, mortal), true).
clause(3,
       instance_of(var('Individual'), var('Superclass')),
       (instance_of(var('Individual'), var('Class')),
        subclass_of(var('Class'), var('Superclass')))).

step(instance_of(socrates, mortal),
     rule(3),
     ['Individual' = socrates, 'Superclass' = mortal, 'Class' = human],
     [instance_of(socrates, human), subclass_of(human, mortal)]).
step(instance_of(socrates, human), fact(1), [], []).
step(subclass_of(human, mortal), fact(2), [], []).
