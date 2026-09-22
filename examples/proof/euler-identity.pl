% Prolog result format 3
query(1, phase_pi(_0, _1), ['Re' = _0, 'Im' = _1]).
result(1, complete, 1).
answer(1, ['Re' = -1, 'Im' = 0]).
why(1, ['Re' = -1, 'Im' = 0], 2).
query(2, lhs(_0, _1), ['Re' = _0, 'Im' = _1]).
result(2, complete, 1).
answer(2, ['Re' = 0, 'Im' = 0]).
why(2, ['Re' = 0, 'Im' = 0], 5).
query(3, holds(_0), ['Ok' = _0]).
result(3, complete, 1).
answer(3, ['Ok' = true]).
why(3, ['Ok' = true], 9).
query(4, mod_sq(_0), ['M' = _0]).
result(4, complete, 1).
answer(4, ['M' = 1]).
why(4, ['M' = 1], 12).
query(5, mod_sq_is_one(_0), ['Ok' = _0]).
result(5, complete, 1).
answer(5, ['Ok' = true]).
why(5, ['Ok' = true], 16).
clause(1, phase_pi(var('Re'), var('Im')), (var('Re') is 0 - 1, var('Im') is 0)).
clause(2, lhs(var('SumRe'), var('SumIm')), (phase_pi(var('Re'), var('Im')), var('SumRe') is var('Re') + 1, var('SumIm') is var('Im') + 0)).
clause(3, holds(true), lhs(0, 0)).
clause(4, mod_sq(var('M')), (phase_pi(var('Re'), var('Im')), var('Re2') is var('Re') * var('Re'), var('Im2') is var('Im') * var('Im'), var('M') is var('Re2') + var('Im2'))).
clause(5, mod_sq_is_one(true), mod_sq(1)).
substitution(1, ['Re' = -1, 'Im' = 0]).
proof(1, phase_pi(-1, 0), rule(1), [builtin(-1 is 0 - 1), builtin(0 is 0)]).
substitution(2, ['Re' = -1, 'Im' = 0]).
proof(2, solution([-1, 0]), query, [uses(1, phase_pi(-1, 0))]).
substitution(3, ['Re' = -1, 'Im' = 0]).
proof(3, phase_pi(-1, 0), rule(1), [builtin(-1 is 0 - 1), builtin(0 is 0)]).
substitution(4, ['SumRe' = 0, 'SumIm' = 0, 'Re' = -1, 'Im' = 0]).
proof(4, lhs(0, 0), rule(2), [uses(3, phase_pi(-1, 0)), builtin(0 is -1 + 1), builtin(0 is 0 + 0)]).
substitution(5, ['Re' = 0, 'Im' = 0]).
proof(5, solution([0, 0]), query, [uses(4, lhs(0, 0))]).
substitution(6, ['Re' = -1, 'Im' = 0]).
proof(6, phase_pi(-1, 0), rule(1), [builtin(-1 is 0 - 1), builtin(0 is 0)]).
substitution(7, ['SumRe' = 0, 'SumIm' = 0, 'Re' = -1, 'Im' = 0]).
proof(7, lhs(0, 0), rule(2), [uses(6, phase_pi(-1, 0)), builtin(0 is -1 + 1), builtin(0 is 0 + 0)]).
substitution(8, []).
proof(8, holds(true), rule(3), [uses(7, lhs(0, 0))]).
substitution(9, ['Ok' = true]).
proof(9, solution([true]), query, [uses(8, holds(true))]).
substitution(10, ['Re' = -1, 'Im' = 0]).
proof(10, phase_pi(-1, 0), rule(1), [builtin(-1 is 0 - 1), builtin(0 is 0)]).
substitution(11, ['M' = 1, 'Re' = -1, 'Im' = 0, 'Re2' = 1, 'Im2' = 0]).
proof(11, mod_sq(1), rule(4), [uses(10, phase_pi(-1, 0)), builtin(1 is -1 * -1), builtin(0 is 0 * 0), builtin(1 is 1 + 0)]).
substitution(12, ['M' = 1]).
proof(12, solution([1]), query, [uses(11, mod_sq(1))]).
substitution(13, ['Re' = -1, 'Im' = 0]).
proof(13, phase_pi(-1, 0), rule(1), [builtin(-1 is 0 - 1), builtin(0 is 0)]).
substitution(14, ['M' = 1, 'Re' = -1, 'Im' = 0, 'Re2' = 1, 'Im2' = 0]).
proof(14, mod_sq(1), rule(4), [uses(13, phase_pi(-1, 0)), builtin(1 is -1 * -1), builtin(0 is 0 * 0), builtin(1 is 1 + 0)]).
substitution(15, []).
proof(15, mod_sq_is_one(true), rule(5), [uses(14, mod_sq(1))]).
substitution(16, ['Ok' = true]).
proof(16, solution([true]), query, [uses(15, mod_sq_is_one(true))]).
