% Prolog result format 4
query(1, foaf_person(_0), ['P' = _0]).
result(1, complete, 1).
answer(1, ['P' = alice]).
query(2, foaf_name(_0, _1), ['P' = _0, 'Name' = _1]).
result(2, complete, 1).
answer(2, ['P' = alice, 'Name' = "Alice Example"]).
query(3, foaf_given_name(_0, _1), ['P' = _0, 'Given' = _1]).
result(3, complete, 1).
answer(3, ['P' = alice, 'Given' = "Alice"]).
query(4, foaf_family_name(_0, _1), ['P' = _0, 'Family' = _1]).
result(4, complete, 1).
answer(4, ['P' = alice, 'Family' = "Example"]).
