# Eyelang result format 2
query(1, [call(grandparent_of(?v0, ?v1))], [binding("person", ?v0), binding("grandchild", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", alice), binding("grandchild", carol)]).
why(1, [binding("person", alice), binding("grandchild", carol)], 5).
query(2, [call(has_parent(?v0, ?v1))], [binding("child", ?v0), binding("parent", ?v1)]).
result(2, complete, 2).
answer(2, [binding("child", bob), binding("parent", alice)]).
why(2, [binding("child", bob), binding("parent", alice)], 10).
answer(2, [binding("child", carol), binding("parent", bob)]).
why(2, [binding("child", carol), binding("parent", bob)], 11).
clause(1, parent_of(alice, bob), []).
clause(2, parent_of(bob, carol), []).
clause(3, grandparent_of(var("x"), var("z")), [call(parent_of(var("x"), var("y"))), call(parent_of(var("y"), var("z")))]).
clause(4, has_parent(var("child"), var("parent")), [call(parent_of(var("parent"), var("child")))]).
substitution(1, []).
proof(1, parent_of(alice, bob), rule(1), []).
substitution(2, []).
proof(2, parent_of(bob, carol), rule(2), []).
substitution(3, []).
proof(3, parent_of(bob, carol), rule(2), []).
substitution(4, [binding("x", alice), binding("z", carol), binding("y", bob)]).
proof(4, grandparent_of(alice, carol), rule(3), [uses(1, parent_of(alice, bob)), uses(3, parent_of(bob, carol))]).
substitution(5, [binding("person", alice), binding("grandchild", carol)]).
proof(5, solution([alice, carol]), query, [uses(4, grandparent_of(alice, carol))]).
substitution(6, []).
proof(6, parent_of(alice, bob), rule(1), []).
substitution(7, []).
proof(7, parent_of(bob, carol), rule(2), []).
substitution(8, [binding("child", bob), binding("parent", alice)]).
proof(8, has_parent(bob, alice), rule(4), [uses(6, parent_of(alice, bob))]).
substitution(9, [binding("child", carol), binding("parent", bob)]).
proof(9, has_parent(carol, bob), rule(4), [uses(7, parent_of(bob, carol))]).
substitution(10, [binding("child", bob), binding("parent", alice)]).
proof(10, solution([bob, alice]), query, [uses(8, has_parent(bob, alice))]).
substitution(11, [binding("child", carol), binding("parent", bob)]).
proof(11, solution([carol, bob]), query, [uses(9, has_parent(carol, bob))]).
