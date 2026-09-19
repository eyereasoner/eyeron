# Eyelang result format 2
query(1, [call(ancestor(?v0, ?v1))], [binding("x", ?v0), binding("y", ?v1)]).
result(1, complete, 4).
answer(1, [binding("x", alice), binding("y", bob)]).
why(1, [binding("x", alice), binding("y", bob)], 7).
answer(1, [binding("x", bob), binding("y", carol)]).
why(1, [binding("x", bob), binding("y", carol)], 8).
answer(1, [binding("x", dora), binding("y", emma)]).
why(1, [binding("x", dora), binding("y", emma)], 9).
answer(1, [binding("x", alice), binding("y", carol)]).
why(1, [binding("x", alice), binding("y", carol)], 13).
clause(1, parent(alice, bob), []).
clause(2, parent(bob, carol), []).
clause(3, parent(dora, emma), []).
clause(4, ancestor(var("x"), var("y")), [call(parent(var("x"), var("y")))]).
clause(5, ancestor(var("x"), var("z")), [call(parent(var("x"), var("y"))), call(ancestor(var("y"), var("z")))]).
substitution(1, []).
proof(1, parent(alice, bob), rule(1), []).
substitution(2, []).
proof(2, parent(bob, carol), rule(2), []).
substitution(3, []).
proof(3, parent(dora, emma), rule(3), []).
substitution(4, [binding("x", alice), binding("y", bob)]).
proof(4, ancestor(alice, bob), rule(4), [uses(1, parent(alice, bob))]).
substitution(5, [binding("x", bob), binding("y", carol)]).
proof(5, ancestor(bob, carol), rule(4), [uses(2, parent(bob, carol))]).
substitution(6, [binding("x", dora), binding("y", emma)]).
proof(6, ancestor(dora, emma), rule(4), [uses(3, parent(dora, emma))]).
substitution(7, [binding("x", alice), binding("y", bob)]).
proof(7, solution([alice, bob]), query, [uses(4, ancestor(alice, bob))]).
substitution(8, [binding("x", bob), binding("y", carol)]).
proof(8, solution([bob, carol]), query, [uses(5, ancestor(bob, carol))]).
substitution(9, [binding("x", dora), binding("y", emma)]).
proof(9, solution([dora, emma]), query, [uses(6, ancestor(dora, emma))]).
substitution(10, []).
proof(10, parent(bob, carol), rule(2), []).
substitution(11, [binding("x", bob), binding("y", carol)]).
proof(11, ancestor(bob, carol), rule(4), [uses(10, parent(bob, carol))]).
substitution(12, [binding("x", alice), binding("z", carol), binding("y", bob)]).
proof(12, ancestor(alice, carol), rule(5), [uses(1, parent(alice, bob)), uses(11, ancestor(bob, carol))]).
substitution(13, [binding("x", alice), binding("y", carol)]).
proof(13, solution([alice, carol]), query, [uses(12, ancestor(alice, carol))]).
