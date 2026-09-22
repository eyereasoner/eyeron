% Prolog result format 3
query(1, statement_source(_0, _1), ['Speaker' = _0, 'Source' = _1]).
result(1, complete, 2).
answer(1, ['Speaker' = alice, 'Source' = chat]).
answer(1, ['Speaker' = bob, 'Source' = email]).
query(2, reifies(_0, _1), ['Claim' = _0, 'Statement' = _1]).
result(2, complete, 2).
answer(2, ['Claim' = claim1, 'Statement' = triple(alice, says, hello)]).
answer(2, ['Claim' = claim2, 'Statement' = triple(bob, says, hi)]).
