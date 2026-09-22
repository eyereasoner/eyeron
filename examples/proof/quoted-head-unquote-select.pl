% Prolog result format 3
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 5).
clause(1, activates(cat, ruleCat), true).
clause(3, class_of(c, cat), true).
clause(4, animal(var('X')), (class_of(var('X'), cat), activates(cat, ruleCat))).
clause(6, test_is(true), animal(c)).
substitution(1, []).
proof(1, class_of(c, cat), rule(3), []).
substitution(2, []).
proof(2, activates(cat, ruleCat), rule(1), []).
substitution(3, ['X' = c]).
proof(3, animal(c), rule(4), [uses(1, class_of(c, cat)), uses(2, activates(cat, ruleCat))]).
substitution(4, []).
proof(4, test_is(true), rule(6), [uses(3, animal(c))]).
substitution(5, ['R' = true]).
proof(5, solution([true]), query, [uses(4, test_is(true))]).
