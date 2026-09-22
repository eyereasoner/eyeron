% Prolog result format 3
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], 5).
clause(1, fact(alice, type, human), true).
clause(2, fact(bob, type, human), true).
clause(3, similar(var('A'), var('B')), (fact(var('A'), var('Pred'), var('Obj')), fact(var('B'), var('Pred'), var('Obj')), var('A') \== var('B'))).
clause(4, test_is(true), similar(alice, bob)).
substitution(1, []).
proof(1, fact(alice, type, human), rule(1), []).
substitution(2, []).
proof(2, fact(bob, type, human), rule(2), []).
substitution(3, ['A' = alice, 'B' = bob, 'Pred' = type, 'Obj' = human]).
proof(3, similar(alice, bob), rule(3), [uses(1, fact(alice, type, human)), uses(2, fact(bob, type, human)), builtin(alice \== bob)]).
substitution(4, []).
proof(4, test_is(true), rule(4), [uses(3, similar(alice, bob))]).
substitution(5, ['R' = true]).
proof(5, solution([true]), query, [uses(4, test_is(true))]).
