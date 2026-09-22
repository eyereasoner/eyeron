% Prolog result format 3
query(1, grandparent_of(_0, _1), ['Person' = _0, 'Grandchild' = _1]).
result(1, complete, 1).
answer(1, ['Person' = alice, 'Grandchild' = carol]).
query(2, has_parent(_0, _1), ['Child' = _0, 'Parent' = _1]).
result(2, complete, 2).
answer(2, ['Child' = bob, 'Parent' = alice]).
answer(2, ['Child' = carol, 'Parent' = bob]).
