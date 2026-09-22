% Prolog result format 3
query(1, grandparent_of(_0, _1), ['Person' = _0, 'Grandchild' = _1]).
result(1, complete, 1).
answer(1, ['Person' = alice, 'Grandchild' = carol]).
why(1, ['Person' = alice, 'Grandchild' = carol], 5).
query(2, has_parent(_0, _1), ['Child' = _0, 'Parent' = _1]).
result(2, complete, 2).
answer(2, ['Child' = bob, 'Parent' = alice]).
why(2, ['Child' = bob, 'Parent' = alice], 10).
answer(2, ['Child' = carol, 'Parent' = bob]).
why(2, ['Child' = carol, 'Parent' = bob], 11).
clause(1, parent_of(alice, bob), true).
clause(2, parent_of(bob, carol), true).
clause(3, grandparent_of(var('X'), var('Z')), (parent_of(var('X'), var('Y')), parent_of(var('Y'), var('Z')))).
clause(4, has_parent(var('Child'), var('Parent')), parent_of(var('Parent'), var('Child'))).
substitution(1, []).
proof(1, parent_of(alice, bob), rule(1), []).
substitution(2, []).
proof(2, parent_of(bob, carol), rule(2), []).
substitution(3, []).
proof(3, parent_of(bob, carol), rule(2), []).
substitution(4, ['X' = alice, 'Z' = carol, 'Y' = bob]).
proof(4, grandparent_of(alice, carol), rule(3), [uses(1, parent_of(alice, bob)), uses(3, parent_of(bob, carol))]).
substitution(5, ['Person' = alice, 'Grandchild' = carol]).
proof(5, solution([alice, carol]), query, [uses(4, grandparent_of(alice, carol))]).
substitution(6, []).
proof(6, parent_of(alice, bob), rule(1), []).
substitution(7, []).
proof(7, parent_of(bob, carol), rule(2), []).
substitution(8, ['Child' = bob, 'Parent' = alice]).
proof(8, has_parent(bob, alice), rule(4), [uses(6, parent_of(alice, bob))]).
substitution(9, ['Child' = carol, 'Parent' = bob]).
proof(9, has_parent(carol, bob), rule(4), [uses(7, parent_of(bob, carol))]).
substitution(10, ['Child' = bob, 'Parent' = alice]).
proof(10, solution([bob, alice]), query, [uses(8, has_parent(bob, alice))]).
substitution(11, ['Child' = carol, 'Parent' = bob]).
proof(11, solution([carol, bob]), query, [uses(9, has_parent(carol, bob))]).
