% Prolog result format 4
query(1, unclassified(_0), ['Place' = _0]).
result(1, complete, 1).
answer(1, ['Place' = x3]).
why(1, ['Place' = x3], [unclassified(x3)]).

clause(3, place(x3), true).
clause(6, unclassified(var('Place')), (place(var('Place')), \+has_population(var('Place')))).

step(unclassified(x3), rule(6), ['Place' = x3], [place(x3), \+has_population(x3)]).
step(place(x3), fact(3), [], []).
step(\+has_population(x3), absent, [], []).
