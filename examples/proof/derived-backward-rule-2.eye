# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("r", ?v0)]).
result(1, complete, 1).
answer(1, [binding("r", true)]).
why(1, [binding("r", true)], 7).
query(2, [call(type_(?v0, ?v1))], [binding("s", ?v0), binding("t", ?v1)]).
result(2, complete, 2).
answer(2, [binding("s", socrates), binding("t", human)]).
why(2, [binding("s", socrates), binding("t", human)], 9).
answer(2, [binding("s", socrates), binding("t", mortal)]).
why(2, [binding("s", socrates), binding("t", mortal)], 12).
clause(1, type_(socrates, human), []).
clause(2, subclass_of(human, mortal), []).
clause(3, type_(var("s"), var("b")), [call(type_(var("s"), var("a"))), call(subclass_of(var("a"), var("b")))]).
clause(4, test_is(true), [call(type_(socrates, mortal))]).
substitution(1, []).
proof(1, type_(socrates, human), rule(1), []).
substitution(2, []).
proof(2, subclass_of(human, mortal), rule(2), []).
substitution(3, []).
proof(3, subclass_of(human, mortal), rule(2), []).
substitution(4, [binding("s", socrates), binding("b", mortal), binding("a", human)]).
proof(4, type_(socrates, mortal), rule(3), [uses(1, type_(socrates, human)), uses(2, subclass_of(human, mortal))]).
substitution(5, [binding("s", socrates), binding("b", mortal), binding("a", human)]).
proof(5, type_(socrates, mortal), rule(3), [uses(1, type_(socrates, human)), uses(3, subclass_of(human, mortal))]).
substitution(6, []).
proof(6, test_is(true), rule(4), [uses(5, type_(socrates, mortal))]).
substitution(7, [binding("r", true)]).
proof(7, solution([true]), query, [uses(6, test_is(true))]).
substitution(8, []).
proof(8, type_(socrates, human), rule(1), []).
substitution(9, [binding("s", socrates), binding("t", human)]).
proof(9, solution([socrates, human]), query, [uses(8, type_(socrates, human))]).
substitution(10, []).
proof(10, subclass_of(human, mortal), rule(2), []).
substitution(11, [binding("s", socrates), binding("b", mortal), binding("a", human)]).
proof(11, type_(socrates, mortal), rule(3), [uses(8, type_(socrates, human)), uses(10, subclass_of(human, mortal))]).
substitution(12, [binding("s", socrates), binding("t", mortal)]).
proof(12, solution([socrates, mortal]), query, [uses(11, type_(socrates, mortal))]).
