% Prolog result format 4
query(1, test_is(_0), ['Result' = _0]).
result(1, complete, 1).
answer(1, ['Result' = true]).
why(1, ['Result' = true], [test_is(true)]).

clause(1, birth_year(patH, 1944), true).
clause(2, reference_year(2025), true).
clause(3,
       age_above(var('Person'), var('Years')),
       (birth_year(var('Person'), var('BirthYear')),
        reference_year(var('Now')),
        var('Age') is var('Now') - var('BirthYear'),
        var('Age') > var('Years'))).
clause(4, test_is(true), age_above(patH, 80)).

step(test_is(true), rule(4), [], [age_above(patH, 80)]).
step(age_above(patH, 80),
     rule(3),
     ['Person' = patH, 'Years' = 80, 'BirthYear' = 1944, 'Now' = 2025, 'Age' = 81],
     [birth_year(patH, 1944), reference_year(2025), 81 is 2025 - 1944, 81 > 80]).
step(birth_year(patH, 1944), fact(1), [], []).
step(reference_year(2025), fact(2), [], []).
step(81 is 2025 - 1944, builtin, [], []).
step(81 > 80, builtin, [], []).
