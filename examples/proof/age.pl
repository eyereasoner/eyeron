% Prolog result format 3
query(1, test_is(_0), ['Result' = _0]).
result(1, complete, 1).
answer(1, ['Result' = true]).
why(1, ['Result' = true], 5).
clause(1, birth_year(patH, 1944), true).
clause(2, reference_year(2025), true).
clause(3, age_above(var('Person'), var('Years')), (birth_year(var('Person'), var('BirthYear')), reference_year(var('Now')), var('Age') is var('Now') - var('BirthYear'), var('Age') > var('Years'))).
clause(4, test_is(true), age_above(patH, 80)).
substitution(1, []).
proof(1, birth_year(patH, 1944), rule(1), []).
substitution(2, []).
proof(2, reference_year(2025), rule(2), []).
substitution(3, ['Person' = patH, 'Years' = 80, 'BirthYear' = 1944, 'Now' = 2025, 'Age' = 81]).
proof(3, age_above(patH, 80), rule(3), [uses(1, birth_year(patH, 1944)), uses(2, reference_year(2025)), builtin(81 is 2025 - 1944), builtin(81 > 80)]).
substitution(4, []).
proof(4, test_is(true), rule(4), [uses(3, age_above(patH, 80))]).
substitution(5, ['Result' = true]).
proof(5, solution([true]), query, [uses(4, test_is(true))]).
