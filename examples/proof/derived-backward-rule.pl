% Prolog result format 3
query(1, has_parent(_0, _1), ['X' = _0, 'Y' = _1]).
result(1, complete, 1).
answer(1, ['X' = bob, 'Y' = alice]).
why(1, ['X' = bob, 'Y' = alice], 4).
query(2, child_of(_0, _1), ['X' = _0, 'Y' = _1]).
result(2, complete, 1).
answer(2, ['X' = bob, 'Y' = alice]).
why(2, ['X' = bob, 'Y' = alice], 7).
clause(1, parent_of(alice, bob), true).
clause(2, child_of(var('X'), var('Y')), parent_of(var('Y'), var('X'))).
clause(3, has_parent(var('X'), var('Y')), child_of(var('X'), var('Y'))).
substitution(1, []).
proof(1, parent_of(alice, bob), rule(1), []).
substitution(2, ['X' = bob, 'Y' = alice]).
proof(2, child_of(bob, alice), rule(2), [uses(1, parent_of(alice, bob))]).
substitution(3, ['X' = bob, 'Y' = alice]).
proof(3, has_parent(bob, alice), rule(3), [uses(2, child_of(bob, alice))]).
substitution(4, ['X' = bob, 'Y' = alice]).
proof(4, solution([bob, alice]), query, [uses(3, has_parent(bob, alice))]).
substitution(5, []).
proof(5, parent_of(alice, bob), rule(1), []).
substitution(6, ['X' = bob, 'Y' = alice]).
proof(6, child_of(bob, alice), rule(2), [uses(5, parent_of(alice, bob))]).
substitution(7, ['X' = bob, 'Y' = alice]).
proof(7, solution([bob, alice]), query, [uses(6, child_of(bob, alice))]).
