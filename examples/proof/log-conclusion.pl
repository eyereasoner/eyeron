% Prolog result format 4
query(1, says(_0, _1), ['X' = _0, 'Msg' = _1]).
result(1, complete, 1).
answer(1, ['X' = felix, 'Msg' = "Meow"]).
why(1, ['X' = felix, 'Msg' = "Meow"], [says(felix, "Meow")]).

clause(1, cat(felix), true).
clause(2, says(var('X'), "Meow"), cat(var('X'))).

step(says(felix, "Meow"), rule(2), ['X' = felix], [cat(felix)]).
step(cat(felix), fact(1), [], []).
