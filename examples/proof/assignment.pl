% Prolog result format 3
query(1, grade(_0, _1), ['Person' = _0, 'Grade' = _1]).
result(1, complete, 1).
answer(1, ['Person' = alice, 'Grade' = pass(7)]).
why(1, ['Person' = alice, 'Grade' = pass(7)], 4).
clause(1, score(alice, 7), true).
clause(2, score(bob, 3), true).
clause(3, grade(var('Person'), pass(var('Score'))), (score(var('Person'), var('Score')), var('Score') >= 5)).
substitution(1, []).
proof(1, score(alice, 7), rule(1), []).
substitution(2, []).
proof(2, score(bob, 3), rule(2), []).
substitution(3, ['Person' = alice, 'Score' = 7]).
proof(3, grade(alice, pass(7)), rule(3), [uses(1, score(alice, 7)), builtin(7 >= 5)]).
substitution(4, ['Person' = alice, 'Grade' = pass(7)]).
proof(4, solution([alice, pass(7)]), query, [uses(3, grade(alice, pass(7)))]).
