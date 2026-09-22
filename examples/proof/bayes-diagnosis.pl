% Prolog result format 3
query(1, score(_0, _1), ['Disease' = _0, 'Score' = _1]).
result(1, complete, 4).
answer(1, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002]).
why(1, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002], 9).
answer(1, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001]).
why(1, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001], 10).
answer(1, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7]).
why(1, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7], 11).
answer(1, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999]).
why(1, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999], 12).
query(2, screened_in(_0), ['Disease' = _0]).
result(2, complete, 1).
answer(2, ['Disease' = 'COVID19']).
why(2, ['Disease' = 'COVID19'], 22).
query(3, rank(_0, _1), ['Disease' = _0, 'Rank' = _1]).
result(3, complete, 4).
answer(3, ['Disease' = 'COVID19', 'Rank' = "high"]).
why(3, ['Disease' = 'COVID19', 'Rank' = "high"], 35).
answer(3, ['Disease' = 'Influenza', 'Rank' = "low"]).
why(3, ['Disease' = 'Influenza', 'Rank' = "low"], 36).
answer(3, ['Disease' = 'AllergicRhinitis', 'Rank' = "low"]).
why(3, ['Disease' = 'AllergicRhinitis', 'Rank' = "low"], 37).
answer(3, ['Disease' = 'BacterialPneumonia', 'Rank' = "low"]).
why(3, ['Disease' = 'BacterialPneumonia', 'Rank' = "low"], 38).
clause(1, model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2), true).
clause(2, model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1), true).
clause(3, model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05), true).
clause(4, model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6), true).
clause(5, score(var('Disease'), var('Score')), (model(var('Disease'), var('Prior'), var('Fever'), var('Cough'), var('Smell'), var('NoSneezing'), var('Breath')), var('Score') is var('Prior') * var('Fever') * var('Cough') * var('Smell') * var('NoSneezing') * var('Breath'))).
clause(6, screened_in(var('Disease')), (score(var('Disease'), var('Score')), var('Score') >= 0.001)).
clause(7, rank(var('Disease'), "high"), (score(var('Disease'), var('Score')), var('Score') >= 0.0015)).
clause(9, rank(var('Disease'), "low"), (score(var('Disease'), var('Score')), var('Score') < 0.0005)).
substitution(1, []).
proof(1, model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2), rule(1), []).
substitution(2, []).
proof(2, model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1), rule(2), []).
substitution(3, []).
proof(3, model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05), rule(3), []).
substitution(4, []).
proof(4, model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6), rule(4), []).
substitution(5, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002, 'Prior' = 0.05, 'Fever' = 0.7, 'Cough' = 0.65, 'Smell' = 0.4, 'NoSneezing' = 0.85, 'Breath' = 0.2]).
proof(5, score('COVID19', 0.0015470000000000002), rule(5), [uses(1, model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2)), builtin(0.0015470000000000002 is 0.05 * 0.7 * 0.65 * 0.4 * 0.85 * 0.2)]).
substitution(6, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001, 'Prior' = 0.03, 'Fever' = 0.8, 'Cough' = 0.5, 'Smell' = 0.05, 'NoSneezing' = 0.8, 'Breath' = 0.1]).
proof(6, score('Influenza', 0.00004800000000000001), rule(5), [uses(2, model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1)), builtin(0.00004800000000000001 is 0.03 * 0.8 * 0.5 * 0.05 * 0.8 * 0.1)]).
substitution(7, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7, 'Prior' = 0.1, 'Fever' = 0.05, 'Cough' = 0.15, 'Smell' = 0.1, 'NoSneezing' = 0.2, 'Breath' = 0.05]).
proof(7, score('AllergicRhinitis', 7.500000000000003e-7), rule(5), [uses(3, model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05)), builtin(7.500000000000003e-7 is 0.1 * 0.05 * 0.15 * 0.1 * 0.2 * 0.05)]).
substitution(8, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999, 'Prior' = 0.01, 'Fever' = 0.7, 'Cough' = 0.6, 'Smell' = 0.02, 'NoSneezing' = 0.95, 'Breath' = 0.6]).
proof(8, score('BacterialPneumonia', 0.00004787999999999999), rule(5), [uses(4, model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6)), builtin(0.00004787999999999999 is 0.01 * 0.7 * 0.6 * 0.02 * 0.95 * 0.6)]).
substitution(9, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002]).
proof(9, solution(['COVID19', 0.0015470000000000002]), query, [uses(5, score('COVID19', 0.0015470000000000002))]).
substitution(10, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001]).
proof(10, solution(['Influenza', 0.00004800000000000001]), query, [uses(6, score('Influenza', 0.00004800000000000001))]).
substitution(11, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7]).
proof(11, solution(['AllergicRhinitis', 7.500000000000003e-7]), query, [uses(7, score('AllergicRhinitis', 7.500000000000003e-7))]).
substitution(12, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999]).
proof(12, solution(['BacterialPneumonia', 0.00004787999999999999]), query, [uses(8, score('BacterialPneumonia', 0.00004787999999999999))]).
substitution(13, []).
proof(13, model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2), rule(1), []).
substitution(14, []).
proof(14, model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1), rule(2), []).
substitution(15, []).
proof(15, model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05), rule(3), []).
substitution(16, []).
proof(16, model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6), rule(4), []).
substitution(17, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002, 'Prior' = 0.05, 'Fever' = 0.7, 'Cough' = 0.65, 'Smell' = 0.4, 'NoSneezing' = 0.85, 'Breath' = 0.2]).
proof(17, score('COVID19', 0.0015470000000000002), rule(5), [uses(13, model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2)), builtin(0.0015470000000000002 is 0.05 * 0.7 * 0.65 * 0.4 * 0.85 * 0.2)]).
substitution(18, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001, 'Prior' = 0.03, 'Fever' = 0.8, 'Cough' = 0.5, 'Smell' = 0.05, 'NoSneezing' = 0.8, 'Breath' = 0.1]).
proof(18, score('Influenza', 0.00004800000000000001), rule(5), [uses(14, model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1)), builtin(0.00004800000000000001 is 0.03 * 0.8 * 0.5 * 0.05 * 0.8 * 0.1)]).
substitution(19, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7, 'Prior' = 0.1, 'Fever' = 0.05, 'Cough' = 0.15, 'Smell' = 0.1, 'NoSneezing' = 0.2, 'Breath' = 0.05]).
proof(19, score('AllergicRhinitis', 7.500000000000003e-7), rule(5), [uses(15, model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05)), builtin(7.500000000000003e-7 is 0.1 * 0.05 * 0.15 * 0.1 * 0.2 * 0.05)]).
substitution(20, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999, 'Prior' = 0.01, 'Fever' = 0.7, 'Cough' = 0.6, 'Smell' = 0.02, 'NoSneezing' = 0.95, 'Breath' = 0.6]).
proof(20, score('BacterialPneumonia', 0.00004787999999999999), rule(5), [uses(16, model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6)), builtin(0.00004787999999999999 is 0.01 * 0.7 * 0.6 * 0.02 * 0.95 * 0.6)]).
substitution(21, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002]).
proof(21, screened_in('COVID19'), rule(6), [uses(17, score('COVID19', 0.0015470000000000002)), builtin(0.0015470000000000002 >= 0.001)]).
substitution(22, ['Disease' = 'COVID19']).
proof(22, solution(['COVID19']), query, [uses(21, screened_in('COVID19'))]).
substitution(23, []).
proof(23, model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2), rule(1), []).
substitution(24, []).
proof(24, model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1), rule(2), []).
substitution(25, []).
proof(25, model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05), rule(3), []).
substitution(26, []).
proof(26, model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6), rule(4), []).
substitution(27, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002, 'Prior' = 0.05, 'Fever' = 0.7, 'Cough' = 0.65, 'Smell' = 0.4, 'NoSneezing' = 0.85, 'Breath' = 0.2]).
proof(27, score('COVID19', 0.0015470000000000002), rule(5), [uses(23, model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2)), builtin(0.0015470000000000002 is 0.05 * 0.7 * 0.65 * 0.4 * 0.85 * 0.2)]).
substitution(28, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001, 'Prior' = 0.03, 'Fever' = 0.8, 'Cough' = 0.5, 'Smell' = 0.05, 'NoSneezing' = 0.8, 'Breath' = 0.1]).
proof(28, score('Influenza', 0.00004800000000000001), rule(5), [uses(24, model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1)), builtin(0.00004800000000000001 is 0.03 * 0.8 * 0.5 * 0.05 * 0.8 * 0.1)]).
substitution(29, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7, 'Prior' = 0.1, 'Fever' = 0.05, 'Cough' = 0.15, 'Smell' = 0.1, 'NoSneezing' = 0.2, 'Breath' = 0.05]).
proof(29, score('AllergicRhinitis', 7.500000000000003e-7), rule(5), [uses(25, model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05)), builtin(7.500000000000003e-7 is 0.1 * 0.05 * 0.15 * 0.1 * 0.2 * 0.05)]).
substitution(30, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999, 'Prior' = 0.01, 'Fever' = 0.7, 'Cough' = 0.6, 'Smell' = 0.02, 'NoSneezing' = 0.95, 'Breath' = 0.6]).
proof(30, score('BacterialPneumonia', 0.00004787999999999999), rule(5), [uses(26, model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6)), builtin(0.00004787999999999999 is 0.01 * 0.7 * 0.6 * 0.02 * 0.95 * 0.6)]).
substitution(31, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002]).
proof(31, rank('COVID19', "high"), rule(7), [uses(27, score('COVID19', 0.0015470000000000002)), builtin(0.0015470000000000002 >= 0.0015)]).
substitution(32, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001]).
proof(32, rank('Influenza', "low"), rule(9), [uses(28, score('Influenza', 0.00004800000000000001)), builtin(0.00004800000000000001 < 0.0005)]).
substitution(33, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7]).
proof(33, rank('AllergicRhinitis', "low"), rule(9), [uses(29, score('AllergicRhinitis', 7.500000000000003e-7)), builtin(7.500000000000003e-7 < 0.0005)]).
substitution(34, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999]).
proof(34, rank('BacterialPneumonia', "low"), rule(9), [uses(30, score('BacterialPneumonia', 0.00004787999999999999)), builtin(0.00004787999999999999 < 0.0005)]).
substitution(35, ['Disease' = 'COVID19', 'Rank' = "high"]).
proof(35, solution(['COVID19', "high"]), query, [uses(31, rank('COVID19', "high"))]).
substitution(36, ['Disease' = 'Influenza', 'Rank' = "low"]).
proof(36, solution(['Influenza', "low"]), query, [uses(32, rank('Influenza', "low"))]).
substitution(37, ['Disease' = 'AllergicRhinitis', 'Rank' = "low"]).
proof(37, solution(['AllergicRhinitis', "low"]), query, [uses(33, rank('AllergicRhinitis', "low"))]).
substitution(38, ['Disease' = 'BacterialPneumonia', 'Rank' = "low"]).
proof(38, solution(['BacterialPneumonia', "low"]), query, [uses(34, rank('BacterialPneumonia', "low"))]).
