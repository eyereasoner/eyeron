% Prolog result format 4
query(1, score(_0, _1), ['Disease' = _0, 'Score' = _1]).
result(1, complete, 4).
answer(1, ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002]).
why(1,
    ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002],
    [score('COVID19', 0.0015470000000000002)]).
answer(1, ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001]).
why(1,
    ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001],
    [score('Influenza', 0.00004800000000000001)]).
answer(1, ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7]).
why(1,
    ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7],
    [score('AllergicRhinitis', 7.500000000000003e-7)]).
answer(1, ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999]).
why(1,
    ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999],
    [score('BacterialPneumonia', 0.00004787999999999999)]).
query(2, screened_in(_0), ['Disease' = _0]).
result(2, complete, 1).
answer(2, ['Disease' = 'COVID19']).
why(2, ['Disease' = 'COVID19'], [screened_in('COVID19')]).
query(3, rank(_0, _1), ['Disease' = _0, 'Rank' = _1]).
result(3, complete, 4).
answer(3, ['Disease' = 'COVID19', 'Rank' = "high"]).
why(3, ['Disease' = 'COVID19', 'Rank' = "high"], [rank('COVID19', "high")]).
answer(3, ['Disease' = 'Influenza', 'Rank' = "low"]).
why(3, ['Disease' = 'Influenza', 'Rank' = "low"], [rank('Influenza', "low")]).
answer(3, ['Disease' = 'AllergicRhinitis', 'Rank' = "low"]).
why(3, ['Disease' = 'AllergicRhinitis', 'Rank' = "low"], [rank('AllergicRhinitis', "low")]).
answer(3, ['Disease' = 'BacterialPneumonia', 'Rank' = "low"]).
why(3, ['Disease' = 'BacterialPneumonia', 'Rank' = "low"], [rank('BacterialPneumonia', "low")]).

clause(1, model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2), true).
clause(2, model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1), true).
clause(3, model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05), true).
clause(4, model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6), true).
clause(5,
       score(var('Disease'), var('Score')),
       (model(var('Disease'), var('Prior'), var('Fever'), var('Cough'), var('Smell'), var('NoSneezing'), var('Breath')),
        var('Score') is var('Prior') * var('Fever') * var('Cough') * var('Smell') * var('NoSneezing') * var('Breath'))).
clause(6,
       screened_in(var('Disease')),
       (score(var('Disease'), var('Score')), var('Score') >= 0.001)).
clause(7,
       rank(var('Disease'), "high"),
       (score(var('Disease'), var('Score')), var('Score') >= 0.0015)).
clause(9,
       rank(var('Disease'), "low"),
       (score(var('Disease'), var('Score')), var('Score') < 0.0005)).

step(score('COVID19', 0.0015470000000000002),
     rule(5),
     ['Disease' = 'COVID19',
      'Score' = 0.0015470000000000002,
      'Prior' = 0.05,
      'Fever' = 0.7,
      'Cough' = 0.65,
      'Smell' = 0.4,
      'NoSneezing' = 0.85,
      'Breath' = 0.2],
     [model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2),
      0.0015470000000000002 is 0.05 * 0.7 * 0.65 * 0.4 * 0.85 * 0.2]).
step(model('COVID19', 0.05, 0.7, 0.65, 0.4, 0.85, 0.2), fact(1), [], []).
step(0.0015470000000000002 is 0.05 * 0.7 * 0.65 * 0.4 * 0.85 * 0.2, builtin, [], []).
step(score('Influenza', 0.00004800000000000001),
     rule(5),
     ['Disease' = 'Influenza',
      'Score' = 0.00004800000000000001,
      'Prior' = 0.03,
      'Fever' = 0.8,
      'Cough' = 0.5,
      'Smell' = 0.05,
      'NoSneezing' = 0.8,
      'Breath' = 0.1],
     [model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1),
      0.00004800000000000001 is 0.03 * 0.8 * 0.5 * 0.05 * 0.8 * 0.1]).
step(model('Influenza', 0.03, 0.8, 0.5, 0.05, 0.8, 0.1), fact(2), [], []).
step(0.00004800000000000001 is 0.03 * 0.8 * 0.5 * 0.05 * 0.8 * 0.1, builtin, [], []).
step(score('AllergicRhinitis', 7.500000000000003e-7),
     rule(5),
     ['Disease' = 'AllergicRhinitis',
      'Score' = 7.500000000000003e-7,
      'Prior' = 0.1,
      'Fever' = 0.05,
      'Cough' = 0.15,
      'Smell' = 0.1,
      'NoSneezing' = 0.2,
      'Breath' = 0.05],
     [model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05),
      7.500000000000003e-7 is 0.1 * 0.05 * 0.15 * 0.1 * 0.2 * 0.05]).
step(model('AllergicRhinitis', 0.1, 0.05, 0.15, 0.1, 0.2, 0.05), fact(3), [], []).
step(7.500000000000003e-7 is 0.1 * 0.05 * 0.15 * 0.1 * 0.2 * 0.05, builtin, [], []).
step(score('BacterialPneumonia', 0.00004787999999999999),
     rule(5),
     ['Disease' = 'BacterialPneumonia',
      'Score' = 0.00004787999999999999,
      'Prior' = 0.01,
      'Fever' = 0.7,
      'Cough' = 0.6,
      'Smell' = 0.02,
      'NoSneezing' = 0.95,
      'Breath' = 0.6],
     [model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6),
      0.00004787999999999999 is 0.01 * 0.7 * 0.6 * 0.02 * 0.95 * 0.6]).
step(model('BacterialPneumonia', 0.01, 0.7, 0.6, 0.02, 0.95, 0.6), fact(4), [], []).
step(0.00004787999999999999 is 0.01 * 0.7 * 0.6 * 0.02 * 0.95 * 0.6, builtin, [], []).
step(screened_in('COVID19'),
     rule(6),
     ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002],
     [score('COVID19', 0.0015470000000000002), 0.0015470000000000002 >= 0.001]).
step(0.0015470000000000002 >= 0.001, builtin, [], []).
step(rank('COVID19', "high"),
     rule(7),
     ['Disease' = 'COVID19', 'Score' = 0.0015470000000000002],
     [score('COVID19', 0.0015470000000000002), 0.0015470000000000002 >= 0.0015]).
step(0.0015470000000000002 >= 0.0015, builtin, [], []).
step(rank('Influenza', "low"),
     rule(9),
     ['Disease' = 'Influenza', 'Score' = 0.00004800000000000001],
     [score('Influenza', 0.00004800000000000001), 0.00004800000000000001 < 0.0005]).
step(0.00004800000000000001 < 0.0005, builtin, [], []).
step(rank('AllergicRhinitis', "low"),
     rule(9),
     ['Disease' = 'AllergicRhinitis', 'Score' = 7.500000000000003e-7],
     [score('AllergicRhinitis', 7.500000000000003e-7), 7.500000000000003e-7 < 0.0005]).
step(7.500000000000003e-7 < 0.0005, builtin, [], []).
step(rank('BacterialPneumonia', "low"),
     rule(9),
     ['Disease' = 'BacterialPneumonia', 'Score' = 0.00004787999999999999],
     [score('BacterialPneumonia', 0.00004787999999999999), 0.00004787999999999999 < 0.0005]).
step(0.00004787999999999999 < 0.0005, builtin, [], []).
