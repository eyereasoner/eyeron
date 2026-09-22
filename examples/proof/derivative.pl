% Prolog result format 3
query(1, d(mul(var(x), var(x)), x, _0), ['Derivative' = _0]).
result(1, complete, 1).
answer(1, ['Derivative' = add(mul(const(1), var(x)), mul(var(x), const(1)))]).
why(1, ['Derivative' = add(mul(const(1), var(x)), mul(var(x), const(1)))], 3).
clause(2, d(var(var('X')), var('X'), const(1)), true).
clause(5, d(mul(var('U'), var('V')), var('X'), add(mul(var('Du'), var('V')), mul(var('U'), var('Dv')))), (d(var('U'), var('X'), var('Du')), d(var('V'), var('X'), var('Dv')))).
substitution(1, ['X' = x]).
proof(1, d(var(x), x, const(1)), rule(2), []).
substitution(2, ['U' = var(x), 'V' = var(x), 'X' = x, 'Du' = const(1), 'Dv' = const(1)]).
proof(2, d(mul(var(x), var(x)), x, add(mul(const(1), var(x)), mul(var(x), const(1)))), rule(5), [uses(1, d(var(x), x, const(1))), uses(1, d(var(x), x, const(1)))]).
substitution(3, ['Derivative' = add(mul(const(1), var(x)), mul(var(x), const(1)))]).
proof(3, solution([add(mul(const(1), var(x)), mul(var(x), const(1)))]), query, [uses(2, d(mul(var(x), var(x)), x, add(mul(const(1), var(x)), mul(var(x), const(1)))))]).
