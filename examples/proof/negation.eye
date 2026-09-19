# Eyelang result format 2
query(1, [call(eligible(?v0))], [binding("person", ?v0)]).
result(1, complete, 1).
answer(1, [binding("person", alice)]).
why(1, [binding("person", alice)], 6).
clause(1, person(alice), []).
clause(2, person(bob), []).
clause(3, blocked(bob), []).
clause(4, eligible(var("x")), [call(person(var("x"))), absent(blocked(var("x")))]).
substitution(1, []).
proof(1, person(alice), rule(1), []).
substitution(2, []).
proof(2, person(bob), rule(2), []).
substitution(3, [binding("x", alice)]).
proof(3, eligible(alice), rule(4), [uses(1, person(alice)), absent(blocked(alice), complete)]).
substitution(4, []).
proof(4, blocked(bob), rule(3), []).
substitution(5, []).
proof(5, solution([]), query, [uses(4, blocked(bob))]).
substitution(6, [binding("person", alice)]).
proof(6, solution([alice]), query, [uses(3, eligible(alice))]).
