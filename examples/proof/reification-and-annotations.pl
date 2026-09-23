statement_source(alice, chat).
statement_source(bob, email).
certainty(blank(claim1), 0.9).

clause(2, reifies(blank(claim1), triple(alice, says, hello)), true).
clause(3, source(blank(claim1), chat), true).
clause(4, certainty(blank(claim1), 0.9), true).
clause(5, reifies(bobClaim, triple(bob, says, hi)), true).
clause(6, source(bobClaim, email), true).
clause(7,
       statement_source(var('Speaker'), var('Source')),
       (reifies(var('Claim'), triple(var('Speaker'), says, var('Object'))),
        source(var('Claim'), var('Source')))).

step(statement_source(alice, chat),
     rule(7),
     ['Speaker' = alice, 'Source' = chat, 'Claim' = blank(claim1), 'Object' = hello],
     [reifies(blank(claim1), triple(alice, says, hello)), source(blank(claim1), chat)]).
step(reifies(blank(claim1), triple(alice, says, hello)), fact(2), [], []).
step(source(blank(claim1), chat), fact(3), [], []).
step(statement_source(bob, email),
     rule(7),
     ['Speaker' = bob, 'Source' = email, 'Claim' = bobClaim, 'Object' = hi],
     [reifies(bobClaim, triple(bob, says, hi)), source(bobClaim, email)]).
step(reifies(bobClaim, triple(bob, says, hi)), fact(5), [], []).
step(source(bobClaim, email), fact(6), [], []).
step(certainty(blank(claim1), 0.9), fact(4), [], []).
