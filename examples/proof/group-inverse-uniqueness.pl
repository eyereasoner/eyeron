% Prolog result format 3
query(1, result_query(_0, _1, _2), ['X_' = _0, 'Y_' = _1, 'Z_' = _2]).
result(1, complete, 2).
answer(1, ['X_' = x_, 'Y_' = i_, 'Z_' = j_]).
why(1, ['X_' = x_, 'Y_' = i_, 'Z_' = j_], 51).
answer(1, ['X_' = x_, 'Y_' = j_, 'Z_' = i_]).
why(1, ['X_' = x_, 'Y_' = j_, 'Z_' = i_], 52).
clause(1, in_g(x_), true).
clause(2, in_g(i_), true).
clause(3, in_g(j_), true).
clause(4, in_g(e_), true).
clause(5, inverse_of(i_, x_), true).
clause(6, inverse_of(j_, x_), true).
clause(7, mul(var('A'), e_, var('A')), in_g(var('A'))).
clause(8, mul(e_, var('A'), var('A')), in_g(var('A'))).
clause(9, mul(var('X_'), var('Y_'), e_), (in_g(var('X_')), in_g(var('Y_')), inverse_of(var('Y_'), var('X_')))).
clause(10, mul(var('Y_'), var('X_'), e_), (in_g(var('X_')), in_g(var('Y_')), inverse_of(var('Y_'), var('X_')))).
clause(11, same_term(var('Left'), var('Right')), (mul(var('A'), var('B'), var('Ab')), mul(var('Ab'), var('C'), var('Left')), mul(var('B'), var('C'), var('Bc')), mul(var('A'), var('Bc'), var('Right')))).
clause(13, same_inverse(var('X_'), var('Y_'), var('Z_')), (inverse_of(var('Y_'), var('X_')), inverse_of(var('Z_'), var('X_')), same_term(var('Y_'), var('Z_')))).
clause(14, result_query(var('X_'), var('Y_'), var('Z_')), (same_inverse(var('X_'), var('Y_'), var('Z_')), var('Y_') \== var('Z_'))).
substitution(1, []).
proof(1, inverse_of(i_, x_), rule(5), []).
substitution(2, []).
proof(2, inverse_of(j_, x_), rule(6), []).
substitution(3, []).
proof(3, inverse_of(i_, x_), rule(5), []).
substitution(4, []).
proof(4, inverse_of(j_, x_), rule(6), []).
substitution(5, []).
proof(5, in_g(x_), rule(1), []).
substitution(6, []).
proof(6, in_g(i_), rule(2), []).
substitution(7, []).
proof(7, in_g(j_), rule(3), []).
substitution(8, []).
proof(8, in_g(e_), rule(4), []).
substitution(9, ['A' = x_]).
proof(9, mul(x_, e_, x_), rule(7), [uses(5, in_g(x_))]).
substitution(10, ['A' = i_]).
proof(10, mul(i_, e_, i_), rule(7), [uses(6, in_g(i_))]).
substitution(11, ['A' = j_]).
proof(11, mul(j_, e_, j_), rule(7), [uses(7, in_g(j_))]).
substitution(12, ['A' = e_]).
proof(12, mul(e_, e_, e_), rule(7), [uses(8, in_g(e_))]).
substitution(13, ['A' = x_]).
proof(13, mul(e_, x_, x_), rule(8), [uses(5, in_g(x_))]).
substitution(14, ['A' = i_]).
proof(14, mul(e_, i_, i_), rule(8), [uses(6, in_g(i_))]).
substitution(15, ['A' = j_]).
proof(15, mul(e_, j_, j_), rule(8), [uses(7, in_g(j_))]).
substitution(16, []).
proof(16, inverse_of(i_, x_), rule(5), []).
substitution(17, []).
proof(17, inverse_of(j_, x_), rule(6), []).
substitution(18, ['X_' = x_, 'Y_' = i_]).
proof(18, mul(x_, i_, e_), rule(9), [uses(5, in_g(x_)), uses(6, in_g(i_)), uses(16, inverse_of(i_, x_))]).
substitution(19, ['X_' = x_, 'Y_' = j_]).
proof(19, mul(x_, j_, e_), rule(9), [uses(5, in_g(x_)), uses(7, in_g(j_)), uses(17, inverse_of(j_, x_))]).
substitution(20, ['Y_' = i_, 'X_' = x_]).
proof(20, mul(i_, x_, e_), rule(10), [uses(5, in_g(x_)), uses(6, in_g(i_)), uses(16, inverse_of(i_, x_))]).
substitution(21, ['Y_' = j_, 'X_' = x_]).
proof(21, mul(j_, x_, e_), rule(10), [uses(5, in_g(x_)), uses(7, in_g(j_)), uses(17, inverse_of(j_, x_))]).
substitution(22, []).
proof(22, in_g(i_), rule(2), []).
substitution(23, []).
proof(23, in_g(j_), rule(3), []).
substitution(24, ['A' = i_]).
proof(24, mul(i_, e_, i_), rule(7), [uses(22, in_g(i_))]).
substitution(25, ['A' = i_]).
proof(25, mul(e_, i_, i_), rule(8), [uses(22, in_g(i_))]).
substitution(26, ['A' = j_]).
proof(26, mul(j_, e_, j_), rule(7), [uses(23, in_g(j_))]).
substitution(27, ['A' = j_]).
proof(27, mul(e_, j_, j_), rule(8), [uses(23, in_g(j_))]).
substitution(28, ['A' = i_]).
proof(28, mul(e_, i_, i_), rule(8), [uses(22, in_g(i_))]).
substitution(29, ['A' = i_]).
proof(29, mul(i_, e_, i_), rule(7), [uses(22, in_g(i_))]).
substitution(30, ['A' = j_]).
proof(30, mul(e_, j_, j_), rule(8), [uses(23, in_g(j_))]).
substitution(31, ['A' = j_]).
proof(31, mul(j_, e_, j_), rule(7), [uses(23, in_g(j_))]).
substitution(32, []).
proof(32, in_g(e_), rule(4), []).
substitution(33, []).
proof(33, in_g(x_), rule(1), []).
substitution(34, ['A' = e_]).
proof(34, mul(e_, e_, e_), rule(7), [uses(32, in_g(e_))]).
substitution(35, ['A' = i_]).
proof(35, mul(e_, i_, i_), rule(8), [uses(22, in_g(i_))]).
substitution(36, ['X_' = x_, 'Y_' = i_]).
proof(36, mul(x_, i_, e_), rule(9), [uses(33, in_g(x_)), uses(22, in_g(i_)), uses(16, inverse_of(i_, x_))]).
substitution(37, ['X_' = x_, 'Y_' = j_]).
proof(37, mul(x_, j_, e_), rule(9), [uses(33, in_g(x_)), uses(23, in_g(j_)), uses(17, inverse_of(j_, x_))]).
substitution(38, ['A' = j_]).
proof(38, mul(e_, j_, j_), rule(8), [uses(23, in_g(j_))]).
substitution(39, ['Left' = i_, 'Right' = i_, 'A' = e_, 'B' = e_, 'Ab' = e_, 'C' = i_, 'Bc' = i_]).
proof(39, same_term(i_, i_), rule(11), [uses(12, mul(e_, e_, e_)), uses(25, mul(e_, i_, i_)), uses(28, mul(e_, i_, i_)), uses(35, mul(e_, i_, i_))]).
substitution(40, ['Left' = j_, 'Right' = j_, 'A' = e_, 'B' = e_, 'Ab' = e_, 'C' = j_, 'Bc' = j_]).
proof(40, same_term(j_, j_), rule(11), [uses(12, mul(e_, e_, e_)), uses(27, mul(e_, j_, j_)), uses(30, mul(e_, j_, j_)), uses(38, mul(e_, j_, j_))]).
substitution(41, ['A' = i_]).
proof(41, mul(i_, e_, i_), rule(7), [uses(22, in_g(i_))]).
substitution(42, ['X_' = x_, 'Y_' = i_, 'Z_' = i_]).
proof(42, same_inverse(x_, i_, i_), rule(13), [uses(1, inverse_of(i_, x_)), uses(3, inverse_of(i_, x_)), uses(39, same_term(i_, i_))]).
substitution(43, ['X_' = x_, 'Y_' = j_, 'Z_' = j_]).
proof(43, same_inverse(x_, j_, j_), rule(13), [uses(2, inverse_of(j_, x_)), uses(4, inverse_of(j_, x_)), uses(40, same_term(j_, j_))]).
substitution(44, ['A' = j_]).
proof(44, mul(j_, e_, j_), rule(7), [uses(23, in_g(j_))]).
substitution(45, ['Left' = j_, 'Right' = i_, 'A' = i_, 'B' = x_, 'Ab' = e_, 'C' = j_, 'Bc' = e_]).
proof(45, same_term(j_, i_), rule(11), [uses(20, mul(i_, x_, e_)), uses(27, mul(e_, j_, j_)), uses(37, mul(x_, j_, e_)), uses(41, mul(i_, e_, i_))]).
substitution(46, ['Left' = i_, 'Right' = j_, 'A' = j_, 'B' = x_, 'Ab' = e_, 'C' = i_, 'Bc' = e_]).
proof(46, same_term(i_, j_), rule(11), [uses(21, mul(j_, x_, e_)), uses(25, mul(e_, i_, i_)), uses(36, mul(x_, i_, e_)), uses(44, mul(j_, e_, j_))]).
substitution(47, ['X_' = x_, 'Y_' = i_, 'Z_' = j_]).
proof(47, same_inverse(x_, i_, j_), rule(13), [uses(1, inverse_of(i_, x_)), uses(4, inverse_of(j_, x_)), uses(46, same_term(i_, j_))]).
substitution(48, ['X_' = x_, 'Y_' = j_, 'Z_' = i_]).
proof(48, same_inverse(x_, j_, i_), rule(13), [uses(2, inverse_of(j_, x_)), uses(3, inverse_of(i_, x_)), uses(45, same_term(j_, i_))]).
substitution(49, ['X_' = x_, 'Y_' = i_, 'Z_' = j_]).
proof(49, result_query(x_, i_, j_), rule(14), [uses(47, same_inverse(x_, i_, j_)), builtin(i_ \== j_)]).
substitution(50, ['X_' = x_, 'Y_' = j_, 'Z_' = i_]).
proof(50, result_query(x_, j_, i_), rule(14), [uses(48, same_inverse(x_, j_, i_)), builtin(j_ \== i_)]).
substitution(51, ['X_' = x_, 'Y_' = i_, 'Z_' = j_]).
proof(51, solution([x_, i_, j_]), query, [uses(49, result_query(x_, i_, j_))]).
substitution(52, ['X_' = x_, 'Y_' = j_, 'Z_' = i_]).
proof(52, solution([x_, j_, i_]), query, [uses(50, result_query(x_, j_, i_))]).
