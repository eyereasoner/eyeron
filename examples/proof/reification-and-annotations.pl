% Prolog result format 4
query(1, statement_source(_0, _1), ['Speaker' = _0, 'Source' = _1]).
result(1, complete, 2).
answer(1, ['Speaker' = alice, 'Source' = chat]).
why(1, ['Speaker' = alice, 'Source' = chat], [statement_source(alice, chat)]).
answer(1, ['Speaker' = bob, 'Source' = email]).
why(1, ['Speaker' = bob, 'Source' = email], [statement_source(bob, email)]).
query(2, statement(bob, says, hi), []).
result(2, complete, 0).
query(3, certainty(blank(claim1), _0), ['Certainty' = _0]).
result(3, complete, 1).
answer(3, ['Certainty' = 0.9]).
why(3, ['Certainty' = 0.9], [certainty(blank(claim1), 0.9)]).

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
