known_by(bob, alice, 8).
known_by(carol, alice, 8).

clause(1, knows(alice, bob), true).
clause(2, knows(alice, carol), true).
clause(3, score(alice, 8), true).
clause(5,
       known_by(var('Friend'), var('Person'), var('Score')),
       (knows(var('Person'), var('Friend')),
        score(var('Person'), var('Score')),
        var('Score') >= 5)).

step(known_by(bob, alice, 8),
     rule(5),
     ['Friend' = bob, 'Person' = alice, 'Score' = 8],
     [knows(alice, bob), score(alice, 8), 8 >= 5]).
step(knows(alice, bob), fact(1), [], []).
step(score(alice, 8), fact(3), [], []).
step(8 >= 5, builtin, [], []).
step(known_by(carol, alice, 8),
     rule(5),
     ['Friend' = carol, 'Person' = alice, 'Score' = 8],
     [knows(alice, carol), score(alice, 8), 8 >= 5]).
step(knows(alice, carol), fact(2), [], []).
