result_query(x_, i_, j_).
result_query(x_, j_, i_).

clause(1, in_g(x_), true).
clause(2, in_g(i_), true).
clause(3, in_g(j_), true).
clause(5, inverse_of(i_, x_), true).
clause(6, inverse_of(j_, x_), true).
clause(7, mul(var('A'), e_, var('A')), in_g(var('A'))).
clause(8, mul(e_, var('A'), var('A')), in_g(var('A'))).
clause(9,
       mul(var('X_'), var('Y_'), e_),
       (in_g(var('X_')), in_g(var('Y_')), inverse_of(var('Y_'), var('X_')))).
clause(10,
       mul(var('Y_'), var('X_'), e_),
       (in_g(var('X_')), in_g(var('Y_')), inverse_of(var('Y_'), var('X_')))).
clause(11,
       same_term(var('Left'), var('Right')),
       (mul(var('A'), var('B'), var('Ab')),
        mul(var('Ab'), var('C'), var('Left')),
        mul(var('B'), var('C'), var('Bc')),
        mul(var('A'), var('Bc'), var('Right')))).
clause(13,
       same_inverse(var('X_'), var('Y_'), var('Z_')),
       (inverse_of(var('Y_'), var('X_')),
        inverse_of(var('Z_'), var('X_')),
        same_term(var('Y_'), var('Z_')))).
clause(14,
       result_query(var('X_'), var('Y_'), var('Z_')),
       (same_inverse(var('X_'), var('Y_'), var('Z_')), var('Y_') \== var('Z_'))).

step(result_query(x_, i_, j_),
     rule(14),
     ['X_' = x_, 'Y_' = i_, 'Z_' = j_],
     [same_inverse(x_, i_, j_), i_ \== j_]).
step(same_inverse(x_, i_, j_),
     rule(13),
     ['X_' = x_, 'Y_' = i_, 'Z_' = j_],
     [inverse_of(i_, x_), inverse_of(j_, x_), same_term(i_, j_)]).
step(inverse_of(i_, x_), fact(5), [], []).
step(inverse_of(j_, x_), fact(6), [], []).
step(same_term(i_, j_),
     rule(11),
     ['Left' = i_, 'Right' = j_, 'A' = j_, 'B' = x_, 'Ab' = e_, 'C' = i_, 'Bc' = e_],
     [mul(j_, x_, e_), mul(e_, i_, i_), mul(x_, i_, e_), mul(j_, e_, j_)]).
step(mul(j_, x_, e_),
     rule(10),
     ['Y_' = j_, 'X_' = x_],
     [in_g(x_), in_g(j_), inverse_of(j_, x_)]).
step(in_g(x_), fact(1), [], []).
step(in_g(j_), fact(3), [], []).
step(mul(e_, i_, i_), rule(8), ['A' = i_], [in_g(i_)]).
step(in_g(i_), fact(2), [], []).
step(mul(x_, i_, e_), rule(9), ['X_' = x_, 'Y_' = i_], [in_g(x_), in_g(i_), inverse_of(i_, x_)]).
step(mul(j_, e_, j_), rule(7), ['A' = j_], [in_g(j_)]).
step(i_ \== j_, builtin, [], []).
step(result_query(x_, j_, i_),
     rule(14),
     ['X_' = x_, 'Y_' = j_, 'Z_' = i_],
     [same_inverse(x_, j_, i_), j_ \== i_]).
step(same_inverse(x_, j_, i_),
     rule(13),
     ['X_' = x_, 'Y_' = j_, 'Z_' = i_],
     [inverse_of(j_, x_), inverse_of(i_, x_), same_term(j_, i_)]).
step(same_term(j_, i_),
     rule(11),
     ['Left' = j_, 'Right' = i_, 'A' = i_, 'B' = x_, 'Ab' = e_, 'C' = j_, 'Bc' = e_],
     [mul(i_, x_, e_), mul(e_, j_, j_), mul(x_, j_, e_), mul(i_, e_, i_)]).
step(mul(i_, x_, e_),
     rule(10),
     ['Y_' = i_, 'X_' = x_],
     [in_g(x_), in_g(i_), inverse_of(i_, x_)]).
step(mul(e_, j_, j_), rule(8), ['A' = j_], [in_g(j_)]).
step(mul(x_, j_, e_), rule(9), ['X_' = x_, 'Y_' = j_], [in_g(x_), in_g(j_), inverse_of(j_, x_)]).
step(mul(i_, e_, i_), rule(7), ['A' = i_], [in_g(i_)]).
step(j_ \== i_, builtin, [], []).
