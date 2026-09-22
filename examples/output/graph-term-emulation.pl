% Prolog result format 4
query(1, social(_0), ['Graph' = _0]).
result(1, complete, 1).
answer(1, ['Graph' = g1]).
query(2, mentions(_0, _1), ['Graph' = _0, 'Resource' = _1]).
result(2, complete, 5).
answer(2, ['Graph' = g1, 'Resource' = alice]).
answer(2, ['Graph' = g2, 'Resource' = alice]).
answer(2, ['Graph' = g1, 'Resource' = bob]).
answer(2, ['Graph' = g2, 'Resource' = tea]).
answer(2, ['Graph' = g1, 'Resource' = carol]).
