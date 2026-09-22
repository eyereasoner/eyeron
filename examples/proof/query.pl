% Prolog result format 3
query(1, ancestor(_0, _1), ['X' = _0, 'Y' = _1]).
result(1, complete, 4).
answer(1, ['X' = alice, 'Y' = bob]).
why(1, ['X' = alice, 'Y' = bob], 7).
answer(1, ['X' = bob, 'Y' = carol]).
why(1, ['X' = bob, 'Y' = carol], 8).
answer(1, ['X' = dora, 'Y' = emma]).
why(1, ['X' = dora, 'Y' = emma], 9).
answer(1, ['X' = alice, 'Y' = carol]).
why(1, ['X' = alice, 'Y' = carol], 13).
clause(1, parent(alice, bob), true).
clause(2, parent(bob, carol), true).
clause(3, parent(dora, emma), true).
clause(4, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(5, ancestor(var('X'), var('Z')), (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).
substitution(1, []).
proof(1, parent(alice, bob), rule(1), []).
substitution(2, []).
proof(2, parent(bob, carol), rule(2), []).
substitution(3, []).
proof(3, parent(dora, emma), rule(3), []).
substitution(4, ['X' = alice, 'Y' = bob]).
proof(4, ancestor(alice, bob), rule(4), [uses(1, parent(alice, bob))]).
substitution(5, ['X' = bob, 'Y' = carol]).
proof(5, ancestor(bob, carol), rule(4), [uses(2, parent(bob, carol))]).
substitution(6, ['X' = dora, 'Y' = emma]).
proof(6, ancestor(dora, emma), rule(4), [uses(3, parent(dora, emma))]).
substitution(7, ['X' = alice, 'Y' = bob]).
proof(7, solution([alice, bob]), query, [uses(4, ancestor(alice, bob))]).
substitution(8, ['X' = bob, 'Y' = carol]).
proof(8, solution([bob, carol]), query, [uses(5, ancestor(bob, carol))]).
substitution(9, ['X' = dora, 'Y' = emma]).
proof(9, solution([dora, emma]), query, [uses(6, ancestor(dora, emma))]).
substitution(10, []).
proof(10, parent(bob, carol), rule(2), []).
substitution(11, ['X' = bob, 'Y' = carol]).
proof(11, ancestor(bob, carol), rule(4), [uses(10, parent(bob, carol))]).
substitution(12, ['X' = alice, 'Z' = carol, 'Y' = bob]).
proof(12, ancestor(alice, carol), rule(5), [uses(1, parent(alice, bob)), uses(11, ancestor(bob, carol))]).
substitution(13, ['X' = alice, 'Y' = carol]).
proof(13, solution([alice, carol]), query, [uses(12, ancestor(alice, carol))]).
