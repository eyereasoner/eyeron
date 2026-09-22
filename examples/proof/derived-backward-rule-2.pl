% Prolog result format 3
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 7).
query(2, type_(_0, _1), ['S' = _0, 'T' = _1]).
result(2, complete, 2).
answer(2, ['S' = socrates, 'T' = human]).
why(2, ['S' = socrates, 'T' = human], 9).
answer(2, ['S' = socrates, 'T' = mortal]).
why(2, ['S' = socrates, 'T' = mortal], 12).
clause(1, type_(socrates, human), true).
clause(2, subclass_of(human, mortal), true).
clause(3, type_(var('S'), var('B')), (type_(var('S'), var('A')), subclass_of(var('A'), var('B')))).
clause(4, test_is(true), type_(socrates, mortal)).
substitution(1, []).
proof(1, type_(socrates, human), rule(1), []).
substitution(2, []).
proof(2, subclass_of(human, mortal), rule(2), []).
substitution(3, []).
proof(3, subclass_of(human, mortal), rule(2), []).
substitution(4, ['S' = socrates, 'B' = mortal, 'A' = human]).
proof(4, type_(socrates, mortal), rule(3), [uses(1, type_(socrates, human)), uses(2, subclass_of(human, mortal))]).
substitution(5, ['S' = socrates, 'B' = mortal, 'A' = human]).
proof(5, type_(socrates, mortal), rule(3), [uses(1, type_(socrates, human)), uses(3, subclass_of(human, mortal))]).
substitution(6, []).
proof(6, test_is(true), rule(4), [uses(5, type_(socrates, mortal))]).
substitution(7, ['R' = true]).
proof(7, solution([true]), query, [uses(6, test_is(true))]).
substitution(8, []).
proof(8, type_(socrates, human), rule(1), []).
substitution(9, ['S' = socrates, 'T' = human]).
proof(9, solution([socrates, human]), query, [uses(8, type_(socrates, human))]).
substitution(10, []).
proof(10, subclass_of(human, mortal), rule(2), []).
substitution(11, ['S' = socrates, 'B' = mortal, 'A' = human]).
proof(11, type_(socrates, mortal), rule(3), [uses(8, type_(socrates, human)), uses(10, subclass_of(human, mortal))]).
substitution(12, ['S' = socrates, 'T' = mortal]).
proof(12, solution([socrates, mortal]), query, [uses(11, type_(socrates, mortal))]).
