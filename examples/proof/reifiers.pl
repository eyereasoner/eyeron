% Prolog result format 3
query(1, statement_source(_0, _1), ['Speaker' = _0, 'Source' = _1]).
result(1, complete, 2).
answer(1, ['Speaker' = alice, 'Source' = chat]).
why(1, ['Speaker' = alice, 'Source' = chat], 7).
answer(1, ['Speaker' = bob, 'Source' = email]).
why(1, ['Speaker' = bob, 'Source' = email], 8).
query(2, reifies(_0, _1), ['Claim' = _0, 'Statement' = _1]).
result(2, complete, 2).
answer(2, ['Claim' = claim1, 'Statement' = triple(alice, says, hello)]).
why(2, ['Claim' = claim1, 'Statement' = triple(alice, says, hello)], 11).
answer(2, ['Claim' = claim2, 'Statement' = triple(bob, says, hi)]).
why(2, ['Claim' = claim2, 'Statement' = triple(bob, says, hi)], 12).
clause(1, reifies(claim1, triple(alice, says, hello)), true).
clause(2, source(claim1, chat), true).
clause(3, reifies(claim2, triple(bob, says, hi)), true).
clause(4, source(claim2, email), true).
clause(5, statement_source(var('Speaker'), var('Source')), (reifies(var('Claim'), triple(var('Speaker'), says, var('Object'))), source(var('Claim'), var('Source')))).
substitution(1, []).
proof(1, reifies(claim1, triple(alice, says, hello)), rule(1), []).
substitution(2, []).
proof(2, reifies(claim2, triple(bob, says, hi)), rule(3), []).
substitution(3, []).
proof(3, source(claim1, chat), rule(2), []).
substitution(4, []).
proof(4, source(claim2, email), rule(4), []).
substitution(5, ['Speaker' = alice, 'Source' = chat, 'Claim' = claim1, 'Object' = hello]).
proof(5, statement_source(alice, chat), rule(5), [uses(1, reifies(claim1, triple(alice, says, hello))), uses(3, source(claim1, chat))]).
substitution(6, ['Speaker' = bob, 'Source' = email, 'Claim' = claim2, 'Object' = hi]).
proof(6, statement_source(bob, email), rule(5), [uses(2, reifies(claim2, triple(bob, says, hi))), uses(4, source(claim2, email))]).
substitution(7, ['Speaker' = alice, 'Source' = chat]).
proof(7, solution([alice, chat]), query, [uses(5, statement_source(alice, chat))]).
substitution(8, ['Speaker' = bob, 'Source' = email]).
proof(8, solution([bob, email]), query, [uses(6, statement_source(bob, email))]).
substitution(9, []).
proof(9, reifies(claim1, triple(alice, says, hello)), rule(1), []).
substitution(10, []).
proof(10, reifies(claim2, triple(bob, says, hi)), rule(3), []).
substitution(11, ['Claim' = claim1, 'Statement' = triple(alice, says, hello)]).
proof(11, solution([claim1, triple(alice, says, hello)]), query, [uses(9, reifies(claim1, triple(alice, says, hello)))]).
substitution(12, ['Claim' = claim2, 'Statement' = triple(bob, says, hi)]).
proof(12, solution([claim2, triple(bob, says, hi)]), query, [uses(10, reifies(claim2, triple(bob, says, hi)))]).
