# Eyelang result format 2
query(1, [call(eligible(?v0))], [binding("person", ?v0)]).
result(1, complete, 1).
answer(1, [binding("person", bob)]).
why(1, [binding("person", bob)], 10).
clause(1, person(alice), []).
clause(2, person(bob), []).
clause(3, person(carol), []).
clause(4, blocked(alice), []).
clause(5, flagged(carol), []).
clause(6, eligible(var("person")), [call(person(var("person"))), absent(blocked(var("person")))]).
clause(7, blocked(var("person")), [call(flagged(var("person")))]).
substitution(1, []).
proof(1, person(alice), rule(1), []).
substitution(2, []).
proof(2, person(bob), rule(2), []).
substitution(3, []).
proof(3, person(carol), rule(3), []).
substitution(4, []).
proof(4, blocked(alice), rule(4), []).
substitution(5, []).
proof(5, solution([]), query, [uses(4, blocked(alice))]).
substitution(6, [binding("person", bob)]).
proof(6, eligible(bob), rule(6), [uses(2, person(bob)), absent(blocked(bob), complete)]).
substitution(7, []).
proof(7, flagged(carol), rule(5), []).
substitution(8, [binding("person", carol)]).
proof(8, blocked(carol), rule(7), [uses(7, flagged(carol))]).
substitution(9, []).
proof(9, solution([]), query, [uses(8, blocked(carol))]).
substitution(10, [binding("person", bob)]).
proof(10, solution([bob]), query, [uses(6, eligible(bob))]).
