% Prolog result format 3
query(1, known_by(_0, _1, _2), ['Friend' = _0, 'Person' = _1, 'Score' = _2]).
result(1, complete, 2).
answer(1, ['Friend' = bob, 'Person' = alice, 'Score' = 8]).
why(1, ['Friend' = bob, 'Person' = alice, 'Score' = 8], 6).
answer(1, ['Friend' = carol, 'Person' = alice, 'Score' = 8]).
why(1, ['Friend' = carol, 'Person' = alice, 'Score' = 8], 7).
clause(1, knows(alice, bob), true).
clause(2, knows(alice, carol), true).
clause(3, score(alice, 8), true).
clause(5, known_by(var('Friend'), var('Person'), var('Score')), (knows(var('Person'), var('Friend')), score(var('Person'), var('Score')), var('Score') >= 5)).
substitution(1, []).
proof(1, knows(alice, bob), rule(1), []).
substitution(2, []).
proof(2, knows(alice, carol), rule(2), []).
substitution(3, []).
proof(3, score(alice, 8), rule(3), []).
substitution(4, ['Friend' = bob, 'Person' = alice, 'Score' = 8]).
proof(4, known_by(bob, alice, 8), rule(5), [uses(1, knows(alice, bob)), uses(3, score(alice, 8)), builtin(8 >= 5)]).
substitution(5, ['Friend' = carol, 'Person' = alice, 'Score' = 8]).
proof(5, known_by(carol, alice, 8), rule(5), [uses(2, knows(alice, carol)), uses(3, score(alice, 8)), builtin(8 >= 5)]).
substitution(6, ['Friend' = bob, 'Person' = alice, 'Score' = 8]).
proof(6, solution([bob, alice, 8]), query, [uses(4, known_by(bob, alice, 8))]).
substitution(7, ['Friend' = carol, 'Person' = alice, 'Score' = 8]).
proof(7, solution([carol, alice, 8]), query, [uses(5, known_by(carol, alice, 8))]).
