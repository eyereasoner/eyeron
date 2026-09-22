% Prolog result format 3
query(1, eligible(_0), ['Person' = _0]).
result(1, complete, 1).
answer(1, ['Person' = bob]).
why(1, ['Person' = bob], 11).
clause(1, person(alice), true).
clause(2, person(bob), true).
clause(3, person(carol), true).
clause(4, directly_blocked(alice), true).
clause(5, flagged(carol), true).
clause(6, blocked(var('X')), directly_blocked(var('X'))).
clause(7, blocked(var('X')), flagged(var('X'))).
clause(8, eligible(var('X')), (person(var('X')), \+blocked(var('X')))).
substitution(1, []).
proof(1, person(alice), rule(1), []).
substitution(2, []).
proof(2, person(bob), rule(2), []).
substitution(3, []).
proof(3, person(carol), rule(3), []).
substitution(4, []).
proof(4, directly_blocked(alice), rule(4), []).
substitution(5, ['X' = alice]).
proof(5, blocked(alice), rule(6), [uses(4, directly_blocked(alice))]).
substitution(6, []).
proof(6, solution([]), query, [uses(5, blocked(alice))]).
substitution(7, ['X' = bob]).
proof(7, eligible(bob), rule(8), [uses(2, person(bob)), absent(blocked(bob), complete)]).
substitution(8, []).
proof(8, flagged(carol), rule(5), []).
substitution(9, ['X' = carol]).
proof(9, blocked(carol), rule(7), [uses(8, flagged(carol))]).
substitution(10, []).
proof(10, solution([]), query, [uses(9, blocked(carol))]).
substitution(11, ['Person' = bob]).
proof(11, solution([bob]), query, [uses(7, eligible(bob))]).
