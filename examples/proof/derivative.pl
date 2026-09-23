d(mul(var(x), var(x)), x, add(mul(const(1), var(x)), mul(var(x), const(1)))).

clause(2, d(var(var('X')), var('X'), const(1)), true).
clause(5,
       d(mul(var('U'), var('V')), var('X'), add(mul(var('Du'), var('V')), mul(var('U'), var('Dv')))),
       (d(var('U'), var('X'), var('Du')), d(var('V'), var('X'), var('Dv')))).

step(d(mul(var(x), var(x)), x, add(mul(const(1), var(x)), mul(var(x), const(1)))),
     rule(5),
     ['U' = var(x), 'V' = var(x), 'X' = x, 'Du' = const(1), 'Dv' = const(1)],
     [d(var(x), x, const(1)), d(var(x), x, const(1))]).
step(d(var(x), x, const(1)), fact(2), ['X' = x], []).
