test_is(true).

clause(1, fact(alice, type, human), true).
clause(2, fact(bob, type, human), true).
clause(3,
       similar(var('A'), var('B')),
       (fact(var('A'), var('Pred'), var('Obj')),
        fact(var('B'), var('Pred'), var('Obj')),
        var('A') \== var('B'))).
clause(4, test_is(true), similar(alice, bob)).

step(test_is(true), rule(4), [], [similar(alice, bob)]).
step(similar(alice, bob),
     rule(3),
     ['A' = alice, 'B' = bob, 'Pred' = type, 'Obj' = human],
     [fact(alice, type, human), fact(bob, type, human), alice \== bob]).
step(fact(alice, type, human), fact(1), [], []).
step(fact(bob, type, human), fact(2), [], []).
step(alice \== bob, builtin, [], []).
