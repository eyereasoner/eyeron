% Prolog result format 4
query(1, unicode_decoded, []).
result(1, complete, 1).
answer(1, []).
why(1, [], [unicode_decoded]).
query(2, below_zero, []).
result(2, complete, 1).
answer(2, []).
why(2, [], [below_zero]).

clause(1, text(sample, "ABC"), true).
clause(2, delta(thermo, -12), true).
clause(3, unicode_decoded, text(sample, "ABC")).
clause(4, below_zero, (delta(thermo, var('D')), var('D') < 0)).

step(unicode_decoded, rule(3), [], [text(sample, "ABC")]).
step(text(sample, "ABC"), fact(1), [], []).
step(below_zero, rule(4), ['D' = -12], [delta(thermo, -12), -12 < 0]).
step(delta(thermo, -12), fact(2), [], []).
step(-12 < 0, builtin, [], []).
