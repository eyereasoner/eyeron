# Eyelang result format 2
query(1, [call(grade(?v0, ?v1))], [binding("person", ?v0), binding("grade", ?v1)]).
result(1, complete, 1).
answer(1, [binding("person", alice), binding("grade", pass(7))]).
why(1, [binding("person", alice), binding("grade", pass(7))], 4).
clause(1, score(alice, 7), []).
clause(2, score(bob, 3), []).
clause(3, grade(var("person"), pass(var("score"))), [call(score(var("person"), var("score"))), compare(">=", var("score"), 5)]).
substitution(1, []).
proof(1, score(alice, 7), rule(1), []).
substitution(2, []).
proof(2, score(bob, 3), rule(2), []).
substitution(3, [binding("person", alice), binding("score", 7)]).
proof(3, grade(alice, pass(7)), rule(3), [uses(1, score(alice, 7)), compared(">=", 7, 5)]).
substitution(4, [binding("person", alice), binding("grade", pass(7))]).
proof(4, solution([alice, pass(7)]), query, [uses(3, grade(alice, pass(7)))]).
