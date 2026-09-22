% Prolog result format 4
query(1, witch(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = girl]).
why(1, ['X' = girl], [witch(girl)]).

clause(1, burns(var('X')), is_made_of_wood(var('X'))).
clause(2, is_made_of_wood(var('X')), floats(var('X'))).
clause(3, floats(duck), true).
clause(4, floats(var('Y')), (floats(var('X')), same_weight(var('X'), var('Y')))).
clause(5, same_weight(duck, girl), true).
clause(6, woman(girl), true).
clause(7, witch(var('X')), (burns(var('X')), woman(var('X')))).

step(witch(girl), rule(7), ['X' = girl], [burns(girl), woman(girl)]).
step(burns(girl), rule(1), ['X' = girl], [is_made_of_wood(girl)]).
step(is_made_of_wood(girl), rule(2), ['X' = girl], [floats(girl)]).
step(floats(girl), rule(4), ['Y' = girl, 'X' = duck], [floats(duck), same_weight(duck, girl)]).
step(floats(duck), fact(3), [], []).
step(same_weight(duck, girl), fact(5), [], []).
step(woman(girl), fact(6), [], []).
