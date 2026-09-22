% Prolog result format 3
query(1, says(_0, _1), ['X' = _0, 'Msg' = _1]).
result(1, complete, 1).
answer(1, ['X' = felix, 'Msg' = "Meow"]).
why(1, ['X' = felix, 'Msg' = "Meow"], 3).
clause(1, cat(felix), true).
clause(2, says(var('X'), "Meow"), cat(var('X'))).
substitution(1, []).
proof(1, cat(felix), rule(1), []).
substitution(2, ['X' = felix]).
proof(2, says(felix, "Meow"), rule(2), [uses(1, cat(felix))]).
substitution(3, ['X' = felix, 'Msg' = "Meow"]).
proof(3, solution([felix, "Meow"]), query, [uses(2, says(felix, "Meow"))]).
