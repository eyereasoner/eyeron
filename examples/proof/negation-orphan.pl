% Prolog result format 3
query(1, orphan(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = bob]).
why(1, ['X' = bob], 7).
clause(1, person(alice), true).
clause(2, person(bob), true).
clause(3, child_of(alice, carol), true).
clause(4, has_a_parent(var('X')), child_of(var('X'), anonymous(1))).
clause(5, orphan(var('X')), (person(var('X')), \+has_a_parent(var('X')))).
substitution(1, []).
proof(1, person(alice), rule(1), []).
substitution(2, []).
proof(2, person(bob), rule(2), []).
substitution(3, []).
proof(3, child_of(alice, carol), rule(3), []).
substitution(4, ['X' = alice]).
proof(4, has_a_parent(alice), rule(4), [uses(3, child_of(alice, carol))]).
substitution(5, []).
proof(5, solution([]), query, [uses(4, has_a_parent(alice))]).
substitution(6, ['X' = bob]).
proof(6, orphan(bob), rule(5), [uses(2, person(bob)), absent(has_a_parent(bob), complete)]).
substitution(7, ['X' = bob]).
proof(7, solution([bob]), query, [uses(6, orphan(bob))]).
