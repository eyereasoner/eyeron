# Eyelang result format 2
query(1, [call(orphan(?v0))], [binding("x", ?v0)]).
result(1, complete, 1).
answer(1, [binding("x", bob)]).
why(1, [binding("x", bob)], 7).
clause(1, person(alice), []).
clause(2, person(bob), []).
clause(3, child_of(alice, carol), []).
clause(4, has_a_parent(var("x")), [call(child_of(var("x"), anonymous(1)))]).
clause(5, orphan(var("x")), [call(person(var("x"))), absent(has_a_parent(var("x")))]).
substitution(1, []).
proof(1, person(alice), rule(1), []).
substitution(2, []).
proof(2, person(bob), rule(2), []).
substitution(3, []).
proof(3, child_of(alice, carol), rule(3), []).
substitution(4, [binding("x", alice)]).
proof(4, has_a_parent(alice), rule(4), [uses(3, child_of(alice, carol))]).
substitution(5, []).
proof(5, solution([]), query, [uses(4, has_a_parent(alice))]).
substitution(6, [binding("x", bob)]).
proof(6, orphan(bob), rule(5), [uses(2, person(bob)), absent(has_a_parent(bob), complete)]).
substitution(7, [binding("x", bob)]).
proof(7, solution([bob]), query, [uses(6, orphan(bob))]).
