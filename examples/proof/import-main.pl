% Prolog result format 3
query(1, ancestor(alice, _0), ['Who' = _0]).
result(1, complete, 2).
answer(1, ['Who' = bob]).
why(1, ['Who' = bob], 3).
answer(1, ['Who' = carol]).
why(1, ['Who' = carol], 7).
clause(1, parent(alice, bob), true).
clause(2, parent(bob, carol), true).
clause(3, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(4, ancestor(var('X'), var('Z')), (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).
substitution(1, []).
proof(1, parent(alice, bob), rule(1), []).
substitution(2, ['X' = alice, 'Y' = bob]).
proof(2, ancestor(alice, bob), rule(3), [uses(1, parent(alice, bob))]).
substitution(3, ['Who' = bob]).
proof(3, solution([bob]), query, [uses(2, ancestor(alice, bob))]).
substitution(4, []).
proof(4, parent(bob, carol), rule(2), []).
substitution(5, ['X' = bob, 'Y' = carol]).
proof(5, ancestor(bob, carol), rule(3), [uses(4, parent(bob, carol))]).
substitution(6, ['X' = alice, 'Z' = carol, 'Y' = bob]).
proof(6, ancestor(alice, carol), rule(4), [uses(1, parent(alice, bob)), uses(5, ancestor(bob, carol))]).
substitution(7, ['Who' = carol]).
proof(7, solution([carol]), query, [uses(6, ancestor(alice, carol))]).
