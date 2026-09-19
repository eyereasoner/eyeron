# Eyelang result format 2
query(1, [call(unicode_decoded())], []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
query(2, [call(below_zero())], []).
result(2, complete, 1).
answer(2, []).
why(2, [], 6).
clause(1, text(sample, "ABC"), []).
clause(2, delta(thermo, -12), []).
clause(3, unicode_decoded(), [call(text(sample, "ABC"))]).
clause(4, below_zero(), [call(delta(thermo, var("d"))), compare("<", var("d"), 0)]).
substitution(1, []).
proof(1, text(sample, "ABC"), rule(1), []).
substitution(2, []).
proof(2, unicode_decoded(), rule(3), [uses(1, text(sample, "ABC"))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, unicode_decoded())]).
substitution(4, []).
proof(4, delta(thermo, -12), rule(2), []).
substitution(5, [binding("d", -12)]).
proof(5, below_zero(), rule(4), [uses(4, delta(thermo, -12)), compared("<", -12, 0)]).
substitution(6, []).
proof(6, solution([]), query, [uses(5, below_zero())]).
