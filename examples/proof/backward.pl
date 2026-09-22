% Prolog result format 3
query(1, indeed_more_interesting(_0, _1), ['X' = _0, 'Y' = _1]).
result(1, complete, 1).
answer(1, ['X' = five, 'Y' = three]).
why(1, ['X' = five, 'Y' = three], 5).
clause(1, value(five, 5), true).
clause(2, value(three, 3), true).
clause(3, more_interesting(var('X'), var('Y')), (value(var('X'), var('Left')), value(var('Y'), var('Right')), var('Left') > var('Right'))).
clause(4, indeed_more_interesting(var('X'), var('Y')), more_interesting(var('X'), var('Y'))).
substitution(1, []).
proof(1, value(five, 5), rule(1), []).
substitution(2, []).
proof(2, value(three, 3), rule(2), []).
substitution(3, ['X' = five, 'Y' = three, 'Left' = 5, 'Right' = 3]).
proof(3, more_interesting(five, three), rule(3), [uses(1, value(five, 5)), uses(2, value(three, 3)), builtin(5 > 3)]).
substitution(4, ['X' = five, 'Y' = three]).
proof(4, indeed_more_interesting(five, three), rule(4), [uses(3, more_interesting(five, three))]).
substitution(5, ['X' = five, 'Y' = three]).
proof(5, solution([five, three]), query, [uses(4, indeed_more_interesting(five, three))]).
