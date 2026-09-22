% Prolog result format 3
query(1, must_have(_0, _1), ['Person' = _0, 'License' = _1]).
result(1, complete, 1).
answer(1, ['Person' = alice, 'License' = dogLicense]).
query(2, dog_count(_0, _1), ['Person' = _0, 'Count' = _1]).
result(2, complete, 2).
answer(2, ['Person' = alice, 'Count' = 5]).
answer(2, ['Person' = bob, 'Count' = 2]).
