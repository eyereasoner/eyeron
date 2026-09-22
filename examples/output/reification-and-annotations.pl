% Prolog result format 3
query(1, statement_source(_0, _1), ['Speaker' = _0, 'Source' = _1]).
result(1, complete, 2).
answer(1, ['Speaker' = alice, 'Source' = chat]).
answer(1, ['Speaker' = bob, 'Source' = email]).
query(2, statement(bob, says, hi), []).
result(2, complete, 0).
query(3, certainty(blank(claim1), _0), ['Certainty' = _0]).
result(3, complete, 1).
answer(3, ['Certainty' = 0.9]).
