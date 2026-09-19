# Eyelang result format 2
query(1, [call(priority(?v0))], [binding("person", ?v0)]).
result(1, complete, 2).
answer(1, [binding("person", alice)]).
why(1, [binding("person", alice)], 5).
answer(1, [binding("person", carol)]).
why(1, [binding("person", carol)], 6).
query(2, [call(ordinary(?v0))], [binding("person", ?v0)]).
result(2, complete, 1).
answer(2, [binding("person", bob)]).
why(2, [binding("person", bob)], 17).
clause(1, level(alice, gold), []).
clause(2, level(bob, bronze), []).
clause(3, level(carol, platinum), []).
clause(4, priority(var("x")), [call(level(var("x"), gold))]).
clause(5, priority(var("x")), [call(level(var("x"), platinum))]).
clause(6, ordinary(var("x")), [call(level(var("x"), var("level"))), absent(priority(var("x")))]).
substitution(1, []).
proof(1, level(alice, gold), rule(1), []).
substitution(2, []).
proof(2, level(carol, platinum), rule(3), []).
substitution(3, [binding("x", alice)]).
proof(3, priority(alice), rule(4), [uses(1, level(alice, gold))]).
substitution(4, [binding("x", carol)]).
proof(4, priority(carol), rule(5), [uses(2, level(carol, platinum))]).
substitution(5, [binding("person", alice)]).
proof(5, solution([alice]), query, [uses(3, priority(alice))]).
substitution(6, [binding("person", carol)]).
proof(6, solution([carol]), query, [uses(4, priority(carol))]).
substitution(7, []).
proof(7, level(alice, gold), rule(1), []).
substitution(8, []).
proof(8, level(bob, bronze), rule(2), []).
substitution(9, []).
proof(9, level(carol, platinum), rule(3), []).
substitution(10, []).
proof(10, level(alice, gold), rule(1), []).
substitution(11, [binding("x", alice)]).
proof(11, priority(alice), rule(4), [uses(10, level(alice, gold))]).
substitution(12, []).
proof(12, solution([]), query, [uses(11, priority(alice))]).
substitution(13, [binding("x", bob), binding("level", bronze)]).
proof(13, ordinary(bob), rule(6), [uses(8, level(bob, bronze)), absent(priority(bob), complete)]).
substitution(14, []).
proof(14, level(carol, platinum), rule(3), []).
substitution(15, [binding("x", carol)]).
proof(15, priority(carol), rule(5), [uses(14, level(carol, platinum))]).
substitution(16, []).
proof(16, solution([]), query, [uses(15, priority(carol))]).
substitution(17, [binding("person", bob)]).
proof(17, solution([bob]), query, [uses(13, ordinary(bob))]).
