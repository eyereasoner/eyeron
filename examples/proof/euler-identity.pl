% Prolog result format 4
query(1, phase_pi(_0, _1), ['Re' = _0, 'Im' = _1]).
result(1, complete, 1).
answer(1, ['Re' = -1, 'Im' = 0]).
why(1, ['Re' = -1, 'Im' = 0], [phase_pi(-1, 0)]).
query(2, lhs(_0, _1), ['Re' = _0, 'Im' = _1]).
result(2, complete, 1).
answer(2, ['Re' = 0, 'Im' = 0]).
why(2, ['Re' = 0, 'Im' = 0], [lhs(0, 0)]).
query(3, holds(_0), ['Ok' = _0]).
result(3, complete, 1).
answer(3, ['Ok' = true]).
why(3, ['Ok' = true], [holds(true)]).
query(4, mod_sq(_0), ['M' = _0]).
result(4, complete, 1).
answer(4, ['M' = 1]).
why(4, ['M' = 1], [mod_sq(1)]).
query(5, mod_sq_is_one(_0), ['Ok' = _0]).
result(5, complete, 1).
answer(5, ['Ok' = true]).
why(5, ['Ok' = true], [mod_sq_is_one(true)]).

clause(1, phase_pi(var('Re'), var('Im')), (var('Re') is 0 - 1, var('Im') is 0)).
clause(2,
       lhs(var('SumRe'), var('SumIm')),
       (phase_pi(var('Re'), var('Im')),
        var('SumRe') is var('Re') + 1,
        var('SumIm') is var('Im') + 0)).
clause(3, holds(true), lhs(0, 0)).
clause(4,
       mod_sq(var('M')),
       (phase_pi(var('Re'), var('Im')),
        var('Re2') is var('Re') * var('Re'),
        var('Im2') is var('Im') * var('Im'),
        var('M') is var('Re2') + var('Im2'))).
clause(5, mod_sq_is_one(true), mod_sq(1)).

step(phase_pi(-1, 0), rule(1), ['Re' = -1, 'Im' = 0], [-1 is 0 - 1, 0 is 0]).
step(-1 is 0 - 1, builtin, [], []).
step(0 is 0, builtin, [], []).
step(lhs(0, 0),
     rule(2),
     ['SumRe' = 0, 'SumIm' = 0, 'Re' = -1, 'Im' = 0],
     [phase_pi(-1, 0), 0 is -1 + 1, 0 is 0 + 0]).
step(0 is -1 + 1, builtin, [], []).
step(0 is 0 + 0, builtin, [], []).
step(holds(true), rule(3), [], [lhs(0, 0)]).
step(mod_sq(1),
     rule(4),
     ['M' = 1, 'Re' = -1, 'Im' = 0, 'Re2' = 1, 'Im2' = 0],
     [phase_pi(-1, 0), 1 is -1 * -1, 0 is 0 * 0, 1 is 1 + 0]).
step(1 is -1 * -1, builtin, [], []).
step(0 is 0 * 0, builtin, [], []).
step(1 is 1 + 0, builtin, [], []).
step(mod_sq_is_one(true), rule(5), [], [mod_sq(1)]).
