# Eyelang result format 2
query(1, [call(score(?v0, ?v1))], [binding("disease", ?v0), binding("score", ?v1)]).
result(1, complete, 4).
answer(1, [binding("disease", COVID19), binding("score", 0.0015470000000000002)]).
answer(1, [binding("disease", Influenza), binding("score", 0.00004800000000000001)]).
answer(1, [binding("disease", AllergicRhinitis), binding("score", 7.500000000000003e-7)]).
answer(1, [binding("disease", BacterialPneumonia), binding("score", 0.00004787999999999999)]).
query(2, [call(screened_in(?v0))], [binding("disease", ?v0)]).
result(2, complete, 1).
answer(2, [binding("disease", COVID19)]).
query(3, [call(rank(?v0, ?v1))], [binding("disease", ?v0), binding("rank", ?v1)]).
result(3, complete, 4).
answer(3, [binding("disease", COVID19), binding("rank", "high")]).
answer(3, [binding("disease", Influenza), binding("rank", "low")]).
answer(3, [binding("disease", AllergicRhinitis), binding("rank", "low")]).
answer(3, [binding("disease", BacterialPneumonia), binding("rank", "low")]).
