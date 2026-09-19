# Eyelang result format 2
query(1, [call(ancestor(alice, ?v0))], [binding("who", ?v0)]).
result(1, complete, 2).
answer(1, [binding("who", bob)]).
why(1, [binding("who", bob)], 3).
answer(1, [binding("who", carol)]).
why(1, [binding("who", carol)], 7).
clause(1, parent(alice, bob), []).
clause(2, parent(bob, carol), []).
clause(3, ancestor(var("x"), var("y")), [call(parent(var("x"), var("y")))]).
clause(4, ancestor(var("x"), var("z")), [call(parent(var("x"), var("y"))), call(ancestor(var("y"), var("z")))]).
substitution(1, []).
proof(1, parent(alice, bob), rule(1), []).
substitution(2, [binding("x", alice), binding("y", bob)]).
proof(2, ancestor(alice, bob), rule(3), [uses(1, parent(alice, bob))]).
substitution(3, [binding("who", bob)]).
proof(3, solution([bob]), query, [uses(2, ancestor(alice, bob))]).
substitution(4, []).
proof(4, parent(bob, carol), rule(2), []).
substitution(5, [binding("x", bob), binding("y", carol)]).
proof(5, ancestor(bob, carol), rule(3), [uses(4, parent(bob, carol))]).
substitution(6, [binding("x", alice), binding("z", carol), binding("y", bob)]).
proof(6, ancestor(alice, carol), rule(4), [uses(1, parent(alice, bob)), uses(5, ancestor(bob, carol))]).
substitution(7, [binding("who", carol)]).
proof(7, solution([carol]), query, [uses(6, ancestor(alice, carol))]).
