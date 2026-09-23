statement_source(alice, chat).
statement_source(bob, email).
reifies(claim1, triple(alice, says, hello)).
reifies(claim2, triple(bob, says, hi)).

clause(1, reifies(claim1, triple(alice, says, hello)), true).
clause(2, source(claim1, chat), true).
clause(3, reifies(claim2, triple(bob, says, hi)), true).
clause(4, source(claim2, email), true).
clause(5,
       statement_source(var('Speaker'), var('Source')),
       (reifies(var('Claim'), triple(var('Speaker'), says, var('Object'))),
        source(var('Claim'), var('Source')))).

step(statement_source(alice, chat),
     rule(5),
     ['Speaker' = alice, 'Source' = chat, 'Claim' = claim1, 'Object' = hello],
     [reifies(claim1, triple(alice, says, hello)), source(claim1, chat)]).
step(reifies(claim1, triple(alice, says, hello)), fact(1), [], []).
step(source(claim1, chat), fact(2), [], []).
step(statement_source(bob, email),
     rule(5),
     ['Speaker' = bob, 'Source' = email, 'Claim' = claim2, 'Object' = hi],
     [reifies(claim2, triple(bob, says, hi)), source(claim2, email)]).
step(reifies(claim2, triple(bob, says, hi)), fact(3), [], []).
step(source(claim2, email), fact(4), [], []).
