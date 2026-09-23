solve(ancestor(ann, bob)).
solve(ancestor(ann, cid)).
steps(ancestor(ann, cid), 4).
clause(ancestor(_0, _1), parent(_0, _1)).
clause(ancestor(_0, _1), (parent(_0, _2), ancestor(_2, _1))).

clause(5, solve(true), true).
clause(6, solve((var('A'), var('B'))), (solve(var('A')), solve(var('B')))).
clause(7, solve(var('Head')), (clause(var('Head'), var('Body')), solve(var('Body')))).
clause(8, steps(true, 0), true).
clause(9,
       steps((var('A'), var('B')), var('Count')),
       (steps(var('A'), var('Left')),
        steps(var('B'), var('Right')),
        var('Count') is var('Left') + var('Right'))).
clause(10,
       steps(var('Goal'), var('Count')),
       (clause(var('Goal'), var('Body')),
        steps(var('Body'), var('Inner')),
        var('Count') is var('Inner') + 1)).

step(solve(ancestor(ann, bob)),
     rule(7),
     ['Head' = ancestor(ann, bob), 'Body' = parent(ann, bob)],
     [clause(ancestor(ann, bob), parent(ann, bob)), solve(parent(ann, bob))]).
step(clause(ancestor(ann, bob), parent(ann, bob)), builtin, [], []).
step(solve(parent(ann, bob)),
     rule(7),
     ['Head' = parent(ann, bob), 'Body' = true],
     [clause(parent(ann, bob), true), solve(true)]).
step(clause(parent(ann, bob), true), builtin, [], []).
step(solve(true), fact(5), [], []).
step(solve(ancestor(ann, cid)),
     rule(7),
     ['Head' = ancestor(ann, cid), 'Body' = (parent(ann, bob), ancestor(bob, cid))],
     [clause(ancestor(ann, cid), (parent(ann, bob), ancestor(bob, cid))),
      solve((parent(ann, bob), ancestor(bob, cid)))]).
step(clause(ancestor(ann, cid), (parent(ann, bob), ancestor(bob, cid))), builtin, [], []).
step(solve((parent(ann, bob), ancestor(bob, cid))),
     rule(6),
     ['A' = parent(ann, bob), 'B' = ancestor(bob, cid)],
     [solve(parent(ann, bob)), solve(ancestor(bob, cid))]).
step(solve(ancestor(bob, cid)),
     rule(7),
     ['Head' = ancestor(bob, cid), 'Body' = parent(bob, cid)],
     [clause(ancestor(bob, cid), parent(bob, cid)), solve(parent(bob, cid))]).
step(clause(ancestor(bob, cid), parent(bob, cid)), builtin, [], []).
step(solve(parent(bob, cid)),
     rule(7),
     ['Head' = parent(bob, cid), 'Body' = true],
     [clause(parent(bob, cid), true), solve(true)]).
step(clause(parent(bob, cid), true), builtin, [], []).
step(steps(ancestor(ann, cid), 4),
     rule(10),
     ['Goal' = ancestor(ann, cid),
      'Count' = 4,
      'Body' = (parent(ann, bob), ancestor(bob, cid)),
      'Inner' = 3],
     [clause(ancestor(ann, cid), (parent(ann, bob), ancestor(bob, cid))),
      steps((parent(ann, bob), ancestor(bob, cid)), 3),
      4 is 3 + 1]).
step(steps((parent(ann, bob), ancestor(bob, cid)), 3),
     rule(9),
     ['A' = parent(ann, bob), 'B' = ancestor(bob, cid), 'Count' = 3, 'Left' = 1, 'Right' = 2],
     [steps(parent(ann, bob), 1), steps(ancestor(bob, cid), 2), 3 is 1 + 2]).
step(steps(parent(ann, bob), 1),
     rule(10),
     ['Goal' = parent(ann, bob), 'Count' = 1, 'Body' = true, 'Inner' = 0],
     [clause(parent(ann, bob), true), steps(true, 0), 1 is 0 + 1]).
step(steps(true, 0), fact(8), [], []).
step(1 is 0 + 1, builtin, [], []).
step(steps(ancestor(bob, cid), 2),
     rule(10),
     ['Goal' = ancestor(bob, cid), 'Count' = 2, 'Body' = parent(bob, cid), 'Inner' = 1],
     [clause(ancestor(bob, cid), parent(bob, cid)), steps(parent(bob, cid), 1), 2 is 1 + 1]).
step(steps(parent(bob, cid), 1),
     rule(10),
     ['Goal' = parent(bob, cid), 'Count' = 1, 'Body' = true, 'Inner' = 0],
     [clause(parent(bob, cid), true), steps(true, 0), 1 is 0 + 1]).
step(2 is 1 + 1, builtin, [], []).
step(3 is 1 + 2, builtin, [], []).
step(4 is 3 + 1, builtin, [], []).
step(clause(ancestor(_0, _1), parent(_0, _1)), builtin, [], []).
step(clause(ancestor(_0, _1), (parent(_0, _2), ancestor(_2, _1))), builtin, [], []).
