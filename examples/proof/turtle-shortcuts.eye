# Eyelang result format 2
query(1, [call(known_by(?v0, ?v1, ?v2))], [binding("friend", ?v0), binding("person", ?v1), binding("score", ?v2)]).
result(1, complete, 2).
answer(1, [binding("friend", bob), binding("person", alice), binding("score", 8)]).
why(1, [binding("friend", bob), binding("person", alice), binding("score", 8)], 6).
answer(1, [binding("friend", carol), binding("person", alice), binding("score", 8)]).
why(1, [binding("friend", carol), binding("person", alice), binding("score", 8)], 7).
clause(1, knows(alice, bob), []).
clause(2, knows(alice, carol), []).
clause(3, score(alice, 8), []).
clause(5, known_by(var("friend"), var("person"), var("score")), [call(knows(var("person"), var("friend"))), call(score(var("person"), var("score"))), compare(">=", var("score"), 5)]).
substitution(1, []).
proof(1, knows(alice, bob), rule(1), []).
substitution(2, []).
proof(2, knows(alice, carol), rule(2), []).
substitution(3, []).
proof(3, score(alice, 8), rule(3), []).
substitution(4, [binding("friend", bob), binding("person", alice), binding("score", 8)]).
proof(4, known_by(bob, alice, 8), rule(5), [uses(1, knows(alice, bob)), uses(3, score(alice, 8)), compared(">=", 8, 5)]).
substitution(5, [binding("friend", carol), binding("person", alice), binding("score", 8)]).
proof(5, known_by(carol, alice, 8), rule(5), [uses(2, knows(alice, carol)), uses(3, score(alice, 8)), compared(">=", 8, 5)]).
substitution(6, [binding("friend", bob), binding("person", alice), binding("score", 8)]).
proof(6, solution([bob, alice, 8]), query, [uses(4, known_by(bob, alice, 8))]).
substitution(7, [binding("friend", carol), binding("person", alice), binding("score", 8)]).
proof(7, solution([carol, alice, 8]), query, [uses(5, known_by(carol, alice, 8))]).
