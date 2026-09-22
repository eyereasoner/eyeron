% Prolog result format 3
query(1, solve(ancestor(ann, _0)), ['Descendant' = _0]).
result(1, complete, 2).
answer(1, ['Descendant' = bob]).
why(1, ['Descendant' = bob], 4).
answer(1, ['Descendant' = cid]).
why(1, ['Descendant' = cid], 9).
query(2, steps(ancestor(ann, cid), _0), ['Clauses' = _0]).
result(2, complete, 1).
answer(2, ['Clauses' = 4]).
why(2, ['Clauses' = 4], 17).
query(3, clause(ancestor(_0, _1), _2), ['Older' = _0, 'Younger' = _1, 'Body' = _2]).
result(3, complete, 2).
answer(3, ['Older' = _0, 'Younger' = _1, 'Body' = parent(_0, _1)]).
why(3, ['Older' = _0, 'Younger' = _1, 'Body' = parent(_0, _1)], 18).
answer(3, ['Older' = _0, 'Younger' = _1, 'Body' = (parent(_0, _2), ancestor(_2, _1))]).
why(3, ['Older' = _0, 'Younger' = _1, 'Body' = (parent(_0, _2), ancestor(_2, _1))], 19).
clause(5, solve(true), true).
clause(6, solve((var('A'), var('B'))), (solve(var('A')), solve(var('B')))).
clause(7, solve(var('Head')), (clause(var('Head'), var('Body')), solve(var('Body')))).
clause(8, steps(true, 0), true).
clause(9, steps((var('A'), var('B')), var('Count')), (steps(var('A'), var('Left')), steps(var('B'), var('Right')), var('Count') is var('Left') + var('Right'))).
clause(10, steps(var('Goal'), var('Count')), (clause(var('Goal'), var('Body')), steps(var('Body'), var('Inner')), var('Count') is var('Inner') + 1)).
substitution(1, []).
proof(1, solve(true), rule(5), []).
substitution(2, ['Head' = parent(ann, bob), 'Body' = true]).
proof(2, solve(parent(ann, bob)), rule(7), [builtin(clause(parent(ann, bob), true)), uses(1, solve(true))]).
substitution(3, ['Head' = ancestor(ann, bob), 'Body' = parent(ann, bob)]).
proof(3, solve(ancestor(ann, bob)), rule(7), [builtin(clause(ancestor(ann, bob), parent(ann, bob))), uses(2, solve(parent(ann, bob)))]).
substitution(4, ['Descendant' = bob]).
proof(4, solution([bob]), query, [uses(3, solve(ancestor(ann, bob)))]).
substitution(5, ['Head' = parent(bob, cid), 'Body' = true]).
proof(5, solve(parent(bob, cid)), rule(7), [builtin(clause(parent(bob, cid), true)), uses(1, solve(true))]).
substitution(6, ['Head' = ancestor(bob, cid), 'Body' = parent(bob, cid)]).
proof(6, solve(ancestor(bob, cid)), rule(7), [builtin(clause(ancestor(bob, cid), parent(bob, cid))), uses(5, solve(parent(bob, cid)))]).
substitution(7, ['A' = parent(ann, bob), 'B' = ancestor(bob, cid)]).
proof(7, solve((parent(ann, bob), ancestor(bob, cid))), rule(6), [uses(2, solve(parent(ann, bob))), uses(6, solve(ancestor(bob, cid)))]).
substitution(8, ['Head' = ancestor(ann, cid), 'Body' = (parent(ann, bob), ancestor(bob, cid))]).
proof(8, solve(ancestor(ann, cid)), rule(7), [builtin(clause(ancestor(ann, cid), (parent(ann, bob), ancestor(bob, cid)))), uses(7, solve((parent(ann, bob), ancestor(bob, cid))))]).
substitution(9, ['Descendant' = cid]).
proof(9, solution([cid]), query, [uses(8, solve(ancestor(ann, cid)))]).
substitution(10, []).
proof(10, steps(true, 0), rule(8), []).
substitution(11, ['Goal' = parent(ann, bob), 'Count' = 1, 'Body' = true, 'Inner' = 0]).
proof(11, steps(parent(ann, bob), 1), rule(10), [builtin(clause(parent(ann, bob), true)), uses(10, steps(true, 0)), builtin(1 is 0 + 1)]).
substitution(12, ['Goal' = parent(bob, cid), 'Count' = 1, 'Body' = true, 'Inner' = 0]).
proof(12, steps(parent(bob, cid), 1), rule(10), [builtin(clause(parent(bob, cid), true)), uses(10, steps(true, 0)), builtin(1 is 0 + 1)]).
substitution(13, ['Goal' = ancestor(bob, cid), 'Count' = 2, 'Body' = parent(bob, cid), 'Inner' = 1]).
proof(13, steps(ancestor(bob, cid), 2), rule(10), [builtin(clause(ancestor(bob, cid), parent(bob, cid))), uses(12, steps(parent(bob, cid), 1)), builtin(2 is 1 + 1)]).
substitution(14, ['Goal' = parent(bob, cid), 'Count' = 1, 'Body' = true, 'Inner' = 0]).
proof(14, steps(parent(bob, cid), 1), rule(10), [builtin(clause(parent(bob, cid), true)), uses(10, steps(true, 0)), builtin(1 is 0 + 1)]).
substitution(15, ['A' = parent(ann, bob), 'B' = ancestor(bob, cid), 'Count' = 3, 'Left' = 1, 'Right' = 2]).
proof(15, steps((parent(ann, bob), ancestor(bob, cid)), 3), rule(9), [uses(11, steps(parent(ann, bob), 1)), uses(13, steps(ancestor(bob, cid), 2)), builtin(3 is 1 + 2)]).
substitution(16, ['Goal' = ancestor(ann, cid), 'Count' = 4, 'Body' = (parent(ann, bob), ancestor(bob, cid)), 'Inner' = 3]).
proof(16, steps(ancestor(ann, cid), 4), rule(10), [builtin(clause(ancestor(ann, cid), (parent(ann, bob), ancestor(bob, cid)))), uses(15, steps((parent(ann, bob), ancestor(bob, cid)), 3)), builtin(4 is 3 + 1)]).
substitution(17, ['Clauses' = 4]).
proof(17, solution([4]), query, [uses(16, steps(ancestor(ann, cid), 4))]).
substitution(18, ['Older' = _0, 'Younger' = _1, 'Body' = parent(_0, _1)]).
proof(18, solution([_0, _1, parent(_0, _1)]), query, [builtin(clause(ancestor(_0, _1), parent(_0, _1)))]).
substitution(19, ['Older' = _0, 'Younger' = _1, 'Body' = (parent(_0, _2), ancestor(_2, _1))]).
proof(19, solution([_0, _1, (parent(_0, _2), ancestor(_2, _1))]), query, [builtin(clause(ancestor(_0, _1), (parent(_0, _2), ancestor(_2, _1))))]).
