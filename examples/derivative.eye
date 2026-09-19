# Symbolic differentiation over constructor terms.
d(const(?_), ?_, const(0)).
d(var(?x), ?x, const(1)).
d(var(?y), ?x, const(0)) if ?x != ?y.
d(add(?u, ?v), ?x, add(?du, ?dv)) if d(?u, ?x, ?du), d(?v, ?x, ?dv).
d(mul(?u, ?v), ?x, add(mul(?du, ?v), mul(?u, ?dv))) if
    d(?u, ?x, ?du), d(?v, ?x, ?dv).
ask d(mul(var(x), var(x)), x, ?derivative).
