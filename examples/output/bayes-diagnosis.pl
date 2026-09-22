% Prolog result format 3
query(1, score(_0, _1), ['Disease' = _0, 'Score' = _1]).
result(1, complete, 4).
answer(1, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002]).
answer(1, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001]).
answer(1, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7]).
answer(1, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999]).
query(2, screened_in(_0), ['Disease' = _0]).
result(2, complete, 1).
answer(2, ['Disease' = 'COVID19']).
query(3, rank(_0, _1), ['Disease' = _0, 'Rank' = _1]).
result(3, complete, 4).
answer(3, ['Disease' = 'COVID19', 'Rank' = "high"]).
answer(3, ['Disease' = 'Influenza', 'Rank' = "low"]).
answer(3, ['Disease' = 'AllergicRhinitis', 'Rank' = "low"]).
answer(3, ['Disease' = 'BacterialPneumonia', 'Rank' = "low"]).
