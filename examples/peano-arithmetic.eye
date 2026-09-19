# Compute (1 * 2 + 3)! structurally with 0 and s(...).
# The result is the actual successor term for 120, not a stored numeric answer.

peano_add(?a, 0, ?a).
peano_add(?a, s(?b), s(?c)) if peano_add(?a, ?b, ?c).
peano_multiply(?_, 0, 0).
peano_multiply(?a, s(?b), ?c) if
    peano_multiply(?a, ?b, ?d), peano_add(?a, ?d, ?c).

factorial_value(?a, ?b) if fac(?a, s(0), ?b).
fac(0, ?a, ?a).
fac(s(?a), ?b, ?c) if peano_multiply(?b, s(?a), ?d), fac(?a, ?d, ?c).

factorial(?five, ?result) if
    peano_multiply(s(0), s(s(0)), ?two),
    peano_add(?two, s(s(s(0))), ?five), factorial_value(?five, ?result).

ask factorial(?five, ?result).
