% Prolog result format 3
query(1, witch(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = girl]).
why(1, ['X' = girl], 10).
clause(1, burns(var('X')), is_made_of_wood(var('X'))).
clause(2, is_made_of_wood(var('X')), floats(var('X'))).
clause(3, floats(duck), true).
clause(4, floats(var('Y')), (floats(var('X')), same_weight(var('X'), var('Y')))).
clause(5, same_weight(duck, girl), true).
clause(6, woman(girl), true).
clause(7, witch(var('X')), (burns(var('X')), woman(var('X')))).
substitution(1, []).
proof(1, floats(duck), rule(3), []).
substitution(2, ['X' = duck]).
proof(2, is_made_of_wood(duck), rule(2), [uses(1, floats(duck))]).
substitution(3, []).
proof(3, same_weight(duck, girl), rule(5), []).
substitution(4, ['X' = duck]).
proof(4, burns(duck), rule(1), [uses(2, is_made_of_wood(duck))]).
substitution(5, ['Y' = girl, 'X' = duck]).
proof(5, floats(girl), rule(4), [uses(1, floats(duck)), uses(3, same_weight(duck, girl))]).
substitution(6, ['X' = girl]).
proof(6, is_made_of_wood(girl), rule(2), [uses(5, floats(girl))]).
substitution(7, ['X' = girl]).
proof(7, burns(girl), rule(1), [uses(6, is_made_of_wood(girl))]).
substitution(8, []).
proof(8, woman(girl), rule(6), []).
substitution(9, ['X' = girl]).
proof(9, witch(girl), rule(7), [uses(7, burns(girl)), uses(8, woman(girl))]).
substitution(10, ['X' = girl]).
proof(10, solution([girl]), query, [uses(9, witch(girl))]).
