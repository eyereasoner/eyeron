# Eyelang result format 2
query(1, [call(has_parent(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(1, complete, 1).
answer(1, [binding("x", bob), binding("y", alice)]).
why(1, [binding("x", bob), binding("y", alice)], 4).
query(2, [call(child_of(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(2, complete, 1).
answer(2, [binding("x", bob), binding("y", alice)]).
why(2, [binding("x", bob), binding("y", alice)], 7).
clause(1, parent_of(alice, bob), []).
clause(2, child_of(var("x"), var("y")), [call(parent_of(var("y"), var("x")))]).
clause(3, has_parent(var("x"), var("y")), [call(child_of(var("x"), var("y")))]).
substitution(1, []).
proof(1, parent_of(alice, bob), rule(1), []).
substitution(2, [binding("x", bob), binding("y", alice)]).
proof(2, child_of(bob, alice), rule(2), [uses(1, parent_of(alice, bob))]).
substitution(3, [binding("x", bob), binding("y", alice)]).
proof(3, has_parent(bob, alice), rule(3), [uses(2, child_of(bob, alice))]).
substitution(4, [binding("x", bob), binding("y", alice)]).
proof(4, solution([bob, alice]), query, [uses(3, has_parent(bob, alice))]).
substitution(5, []).
proof(5, parent_of(alice, bob), rule(1), []).
substitution(6, [binding("x", bob), binding("y", alice)]).
proof(6, child_of(bob, alice), rule(2), [uses(5, parent_of(alice, bob))]).
substitution(7, [binding("x", bob), binding("y", alice)]).
proof(7, solution([bob, alice]), query, [uses(6, child_of(bob, alice))]).
