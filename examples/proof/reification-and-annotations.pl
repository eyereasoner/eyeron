% Prolog result format 3
query(1, statement_source(_0, _1), ['Speaker' = _0, 'Source' = _1]).
result(1, complete, 2).
answer(1, ['Speaker' = alice, 'Source' = chat]).
why(1, ['Speaker' = alice, 'Source' = chat], 7).
answer(1, ['Speaker' = bob, 'Source' = email]).
why(1, ['Speaker' = bob, 'Source' = email], 8).
query(2, statement(bob, says, hi), []).
result(2, complete, 0).
query(3, certainty(blank(claim1), _0), ['Certainty' = _0]).
result(3, complete, 1).
answer(3, ['Certainty' = 0.9]).
why(3, ['Certainty' = 0.9], 10).
clause(2, reifies(blank(claim1), triple(alice, says, hello)), true).
clause(3, source(blank(claim1), chat), true).
clause(4, certainty(blank(claim1), 0.9), true).
clause(5, reifies(bobClaim, triple(bob, says, hi)), true).
clause(6, source(bobClaim, email), true).
clause(7, statement_source(var('Speaker'), var('Source')), (reifies(var('Claim'), triple(var('Speaker'), says, var('Object'))), source(var('Claim'), var('Source')))).
substitution(1, []).
proof(1, reifies(blank(claim1), triple(alice, says, hello)), rule(2), []).
substitution(2, []).
proof(2, reifies(bobClaim, triple(bob, says, hi)), rule(5), []).
substitution(3, []).
proof(3, source(blank(claim1), chat), rule(3), []).
substitution(4, []).
proof(4, source(bobClaim, email), rule(6), []).
substitution(5, ['Speaker' = alice, 'Source' = chat, 'Claim' = blank(claim1), 'Object' = hello]).
proof(5, statement_source(alice, chat), rule(7), [uses(1, reifies(blank(claim1), triple(alice, says, hello))), uses(3, source(blank(claim1), chat))]).
substitution(6, ['Speaker' = bob, 'Source' = email, 'Claim' = bobClaim, 'Object' = hi]).
proof(6, statement_source(bob, email), rule(7), [uses(2, reifies(bobClaim, triple(bob, says, hi))), uses(4, source(bobClaim, email))]).
substitution(7, ['Speaker' = alice, 'Source' = chat]).
proof(7, solution([alice, chat]), query, [uses(5, statement_source(alice, chat))]).
substitution(8, ['Speaker' = bob, 'Source' = email]).
proof(8, solution([bob, email]), query, [uses(6, statement_source(bob, email))]).
substitution(9, []).
proof(9, certainty(blank(claim1), 0.9), rule(4), []).
substitution(10, ['Certainty' = 0.9]).
proof(10, solution([0.9]), query, [uses(9, certainty(blank(claim1), 0.9))]).
