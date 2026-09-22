% Prolog result format 3
query(1, negative(_0), ['X' = _0]).
result(1, complete, 1).
answer(1, ['X' = n1]).
why(1, ['X' = n1], 4).
query(2, language_direction(msg, _0), ['Direction' = _0]).
result(2, complete, 1).
answer(2, ['Direction' = ltr]).
why(2, ['Direction' = ltr], 7).
clause(1, value(n1, -3.5), true).
clause(2, value(n2, 7), true).
clause(3, directed_text(msg, literal("bonjour", fr, ltr)), true).
clause(4, negative(var('X')), (value(var('X'), var('V')), var('V') < 0)).
clause(5, language_direction(var('Message'), var('Direction')), directed_text(var('Message'), literal(var('Text'), var('Lang'), var('Direction')))).
substitution(1, []).
proof(1, value(n1, -3.5), rule(1), []).
substitution(2, []).
proof(2, value(n2, 7), rule(2), []).
substitution(3, ['X' = n1, 'V' = -3.5]).
proof(3, negative(n1), rule(4), [uses(1, value(n1, -3.5)), builtin(-3.5 < 0)]).
substitution(4, ['X' = n1]).
proof(4, solution([n1]), query, [uses(3, negative(n1))]).
substitution(5, []).
proof(5, directed_text(msg, literal("bonjour", fr, ltr)), rule(3), []).
substitution(6, ['Message' = msg, 'Direction' = ltr, 'Text' = "bonjour", 'Lang' = fr]).
proof(6, language_direction(msg, ltr), rule(5), [uses(5, directed_text(msg, literal("bonjour", fr, ltr)))]).
substitution(7, ['Direction' = ltr]).
proof(7, solution([ltr]), query, [uses(6, language_direction(msg, ltr))]).
