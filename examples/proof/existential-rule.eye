# Eyelang result format 2
query(1, [call(is_(?v0, ?v1))], [binding("s", ?v0), binding("w", ?v1)]).
result(1, complete, 2).
answer(1, [binding("s", socrates), binding("w", witness(socrates))]).
why(1, [binding("s", socrates), binding("w", witness(socrates))], 5).
answer(1, [binding("s", plato), binding("w", witness(plato))]).
why(1, [binding("s", plato), binding("w", witness(plato))], 6).
clause(1, human(socrates), []).
clause(2, human(plato), []).
clause(3, is_(var("s"), witness(var("s"))), [call(human(var("s")))]).
substitution(1, []).
proof(1, human(socrates), rule(1), []).
substitution(2, []).
proof(2, human(plato), rule(2), []).
substitution(3, [binding("s", socrates)]).
proof(3, is_(socrates, witness(socrates)), rule(3), [uses(1, human(socrates))]).
substitution(4, [binding("s", plato)]).
proof(4, is_(plato, witness(plato)), rule(3), [uses(2, human(plato))]).
substitution(5, [binding("s", socrates), binding("w", witness(socrates))]).
proof(5, solution([socrates, witness(socrates)]), query, [uses(3, is_(socrates, witness(socrates)))]).
substitution(6, [binding("s", plato), binding("w", witness(plato))]).
proof(6, solution([plato, witness(plato)]), query, [uses(4, is_(plato, witness(plato)))]).
