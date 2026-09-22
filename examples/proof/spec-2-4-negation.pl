% Prolog result format 3
query(1, unclassified(_0), ['Place' = _0]).
result(1, complete, 1).
answer(1, ['Place' = x3]).
why(1, ['Place' = x3], 11).
clause(1, place(x1), true).
clause(2, place(x2), true).
clause(3, place(x3), true).
clause(4, population(x1, 1000), true).
clause(5, population(x2, 2000), true).
clause(6, unclassified(var('Place')), (place(var('Place')), \+has_population(var('Place')))).
clause(7, has_population(var('Place')), population(var('Place'), var('Amount'))).
substitution(1, []).
proof(1, place(x1), rule(1), []).
substitution(2, []).
proof(2, place(x2), rule(2), []).
substitution(3, []).
proof(3, place(x3), rule(3), []).
substitution(4, []).
proof(4, population(x1, 1000), rule(4), []).
substitution(5, ['Place' = x1, 'Amount' = 1000]).
proof(5, has_population(x1), rule(7), [uses(4, population(x1, 1000))]).
substitution(6, []).
proof(6, solution([]), query, [uses(5, has_population(x1))]).
substitution(7, []).
proof(7, population(x2, 2000), rule(5), []).
substitution(8, ['Place' = x2, 'Amount' = 2000]).
proof(8, has_population(x2), rule(7), [uses(7, population(x2, 2000))]).
substitution(9, []).
proof(9, solution([]), query, [uses(8, has_population(x2))]).
substitution(10, ['Place' = x3]).
proof(10, unclassified(x3), rule(6), [uses(3, place(x3)), absent(has_population(x3), complete)]).
substitution(11, ['Place' = x3]).
proof(11, solution([x3]), query, [uses(10, unclassified(x3))]).
