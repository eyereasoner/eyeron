# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 5).
clause(1, fact(alice, type, human), []).
clause(2, fact(bob, type, human), []).
clause(3, similar(var("a"), var("b")), [call(fact(var("a"), var("pred"), var("obj"))), call(fact(var("b"), var("pred"), var("obj"))), compare("!=", var("a"), var("b"))]).
clause(4, test_is(true), [call(similar(alice, bob))]).
substitution(1, []).
proof(1, fact(alice, type, human), rule(1), []).
substitution(2, []).
proof(2, fact(bob, type, human), rule(2), []).
substitution(3, [binding("a", alice), binding("b", bob), binding("pred", type), binding("obj", human)]).
proof(3, similar(alice, bob), rule(3), [uses(1, fact(alice, type, human)), uses(2, fact(bob, type, human)), compared("!=", alice, bob)]).
substitution(4, []).
proof(4, test_is(true), rule(4), [uses(3, similar(alice, bob))]).
substitution(5, [binding("r", true)]).
proof(5, solution([true]), query, [uses(4, test_is(true))]).
