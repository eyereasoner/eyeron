% Prolog result format 3
query(1, knows_named(_0, _1), ['Person' = _0, 'Name' = _1]).
result(1, complete, 1).
answer(1, ['Person' = alice, 'Name' = "Bob"]).
query(2, first_member(_0), ['First' = _0]).
result(2, complete, 1).
answer(2, ['First' = alice]).
