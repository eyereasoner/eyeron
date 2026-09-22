% Prolog result format 3
query(1, priority(_0), ['Person' = _0]).
result(1, complete, 2).
answer(1, ['Person' = alice]).
why(1, ['Person' = alice], 5).
answer(1, ['Person' = carol]).
why(1, ['Person' = carol], 6).
query(2, ordinary(_0), ['Person' = _0]).
result(2, complete, 1).
answer(2, ['Person' = bob]).
why(2, ['Person' = bob], 17).
clause(1, level(alice, gold), true).
clause(2, level(bob, bronze), true).
clause(3, level(carol, platinum), true).
clause(4, priority(var('X')), level(var('X'), gold)).
clause(5, priority(var('X')), level(var('X'), platinum)).
clause(6, ordinary(var('X')), (level(var('X'), var('Level')), \+priority(var('X')))).
substitution(1, []).
proof(1, level(alice, gold), rule(1), []).
substitution(2, []).
proof(2, level(carol, platinum), rule(3), []).
substitution(3, ['X' = alice]).
proof(3, priority(alice), rule(4), [uses(1, level(alice, gold))]).
substitution(4, ['X' = carol]).
proof(4, priority(carol), rule(5), [uses(2, level(carol, platinum))]).
substitution(5, ['Person' = alice]).
proof(5, solution([alice]), query, [uses(3, priority(alice))]).
substitution(6, ['Person' = carol]).
proof(6, solution([carol]), query, [uses(4, priority(carol))]).
substitution(7, []).
proof(7, level(alice, gold), rule(1), []).
substitution(8, []).
proof(8, level(bob, bronze), rule(2), []).
substitution(9, []).
proof(9, level(carol, platinum), rule(3), []).
substitution(10, []).
proof(10, level(alice, gold), rule(1), []).
substitution(11, ['X' = alice]).
proof(11, priority(alice), rule(4), [uses(10, level(alice, gold))]).
substitution(12, []).
proof(12, solution([]), query, [uses(11, priority(alice))]).
substitution(13, ['X' = bob, 'Level' = bronze]).
proof(13, ordinary(bob), rule(6), [uses(8, level(bob, bronze)), absent(priority(bob), complete)]).
substitution(14, []).
proof(14, level(carol, platinum), rule(3), []).
substitution(15, ['X' = carol]).
proof(15, priority(carol), rule(5), [uses(14, level(carol, platinum))]).
substitution(16, []).
proof(16, solution([]), query, [uses(15, priority(carol))]).
substitution(17, ['Person' = bob]).
proof(17, solution([bob]), query, [uses(13, ordinary(bob))]).
