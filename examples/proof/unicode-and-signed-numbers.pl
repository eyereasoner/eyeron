% Prolog result format 3
query(1, unicode_decoded, []).
result(1, complete, 1).
answer(1, []).
why(1, [], 3).
query(2, below_zero, []).
result(2, complete, 1).
answer(2, []).
why(2, [], 6).
clause(1, text(sample, "ABC"), true).
clause(2, delta(thermo, -12), true).
clause(3, unicode_decoded, text(sample, "ABC")).
clause(4, below_zero, (delta(thermo, var('D')), var('D') < 0)).
substitution(1, []).
proof(1, text(sample, "ABC"), rule(1), []).
substitution(2, []).
proof(2, unicode_decoded, rule(3), [uses(1, text(sample, "ABC"))]).
substitution(3, []).
proof(3, solution([]), query, [uses(2, unicode_decoded)]).
substitution(4, []).
proof(4, delta(thermo, -12), rule(2), []).
substitution(5, ['D' = -12]).
proof(5, below_zero, rule(4), [uses(4, delta(thermo, -12)), builtin(-12 < 0)]).
substitution(6, []).
proof(6, solution([]), query, [uses(5, below_zero)]).
