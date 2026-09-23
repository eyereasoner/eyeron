grade(alice, pass(7)).

clause(1, score(alice, 7), true).
clause(3,
       grade(var('Person'), pass(var('Score'))),
       (score(var('Person'), var('Score')), var('Score') >= 5)).

step(grade(alice, pass(7)), rule(3), ['Person' = alice, 'Score' = 7], [score(alice, 7), 7 >= 5]).
step(score(alice, 7), fact(1), [], []).
step(7 >= 5, builtin, [], []).
