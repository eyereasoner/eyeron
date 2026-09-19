# Eyelang result format 2
query(1, [call(ancestor(alice, ?v0))], [binding("who", ?v0)]).
result(1, complete, 3).
answer(1, [binding("who", bob)]).
why(1, [binding("who", bob)], 3).
answer(1, [binding("who", carol)]).
why(1, [binding("who", carol)], 7).
answer(1, [binding("who", dana)]).
why(1, [binding("who", dana)], 12).
clause(1, parent(alice, bob), []).
clause(2, parent(bob, carol), []).
clause(3, parent(carol, dana), []).
clause(4, ancestor(var("x"), var("y")), [call(parent(var("x"), var("y")))]).
clause(5, ancestor(var("x"), var("z")), [call(parent(var("x"), var("y"))), call(ancestor(var("y"), var("z")))]).
substitution(1, []).
proof(1, parent(alice, bob), rule(1), []).
substitution(2, [binding("x", alice), binding("y", bob)]).
proof(2, ancestor(alice, bob), rule(4), [uses(1, parent(alice, bob))]).
substitution(3, [binding("who", bob)]).
proof(3, solution([bob]), query, [uses(2, ancestor(alice, bob))]).
substitution(4, []).
proof(4, parent(bob, carol), rule(2), []).
substitution(5, [binding("x", bob), binding("y", carol)]).
proof(5, ancestor(bob, carol), rule(4), [uses(4, parent(bob, carol))]).
substitution(6, [binding("x", alice), binding("z", carol), binding("y", bob)]).
proof(6, ancestor(alice, carol), rule(5), [uses(1, parent(alice, bob)), uses(5, ancestor(bob, carol))]).
substitution(7, [binding("who", carol)]).
proof(7, solution([carol]), query, [uses(6, ancestor(alice, carol))]).
substitution(8, []).
proof(8, parent(carol, dana), rule(3), []).
substitution(9, [binding("x", carol), binding("y", dana)]).
proof(9, ancestor(carol, dana), rule(4), [uses(8, parent(carol, dana))]).
substitution(10, [binding("x", bob), binding("z", dana), binding("y", carol)]).
proof(10, ancestor(bob, dana), rule(5), [uses(4, parent(bob, carol)), uses(9, ancestor(carol, dana))]).
substitution(11, [binding("x", alice), binding("z", dana), binding("y", bob)]).
proof(11, ancestor(alice, dana), rule(5), [uses(1, parent(alice, bob)), uses(10, ancestor(bob, dana))]).
substitution(12, [binding("who", dana)]).
proof(12, solution([dana]), query, [uses(11, ancestor(alice, dana))]).
