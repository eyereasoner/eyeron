% Prolog result format 4
query(1, large_town(_0), ['Town' = _0]).
result(1, complete, 1).
answer(1, ['Town' = town2]).
why(1, ['Town' = town2], [large_town(town2)]).

clause(2, population(town2, 2000), true).
clause(3,
       large_town(var('Town')),
       (population(var('Town'), var('Population')), var('Population') > 1500)).

step(large_town(town2),
     rule(3),
     ['Town' = town2, 'Population' = 2000],
     [population(town2, 2000), 2000 > 1500]).
step(population(town2, 2000), fact(2), [], []).
step(2000 > 1500, builtin, [], []).
