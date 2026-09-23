test_is(true).
type_(socrates, human).
type_(socrates, mortal).

clause(1, type_(socrates, human), true).
clause(2, subclass_of(human, mortal), true).
clause(3,
       type_(var('S'), var('B')),
       (type_(var('S'), var('A')), subclass_of(var('A'), var('B')))).
clause(4, test_is(true), type_(socrates, mortal)).

step(test_is(true), rule(4), [], [type_(socrates, mortal)]).
step(type_(socrates, mortal),
     rule(3),
     ['S' = socrates, 'B' = mortal, 'A' = human],
     [type_(socrates, human), subclass_of(human, mortal)]).
step(type_(socrates, human), fact(1), [], []).
step(subclass_of(human, mortal), fact(2), [], []).
