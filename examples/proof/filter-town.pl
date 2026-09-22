% Prolog result format 3
query(1, large_town(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = town2]).
why(1, ['X' = town2], 4).
clause(1, population(town1, 1000), true).
clause(2, population(town2, 2000), true).
clause(3, large_town(var('X')), (population(var('X'), var('P')), var('P') > 1500)).
substitution(1, []).
proof(1, population(town1, 1000), rule(1), []).
substitution(2, []).
proof(2, population(town2, 2000), rule(2), []).
substitution(3, ['X' = town2, 'P' = 2000]).
proof(3, large_town(town2), rule(3), [uses(2, population(town2, 2000)), builtin(2000 > 1500)]).
substitution(4, ['X' = town2]).
proof(4, solution([town2]), query, [uses(3, large_town(town2))]).
