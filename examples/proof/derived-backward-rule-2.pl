% Prolog result format 4
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], [test_is(true)]).
query(2, type_(_0, _1), ['S' = _0, 'T' = _1]).
result(2, complete, 2).
answer(2, ['S' = socrates, 'T' = human]).
why(2, ['S' = socrates, 'T' = human], [type_(socrates, human)]).
answer(2, ['S' = socrates, 'T' = mortal]).
why(2, ['S' = socrates, 'T' = mortal], [type_(socrates, mortal)]).

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
