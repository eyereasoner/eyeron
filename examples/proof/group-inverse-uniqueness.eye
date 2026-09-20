# Eyelang result format 2
query(1, [call(result_query(?v0, ?v1, ?v2))], [binding("x_", ?v0), binding("y_", ?v1), binding("z_", ?v2)]).
result(1, complete, 2).
answer(1, [binding("x_", x_), binding("y_", i_), binding("z_", j_)]).
why(1, [binding("x_", x_), binding("y_", i_), binding("z_", j_)], 51).
answer(1, [binding("x_", x_), binding("y_", j_), binding("z_", i_)]).
why(1, [binding("x_", x_), binding("y_", j_), binding("z_", i_)], 52).
clause(1, in_g(x_), []).
clause(2, in_g(i_), []).
clause(3, in_g(j_), []).
clause(4, in_g(e_), []).
clause(5, inverse_of(i_, x_), []).
clause(6, inverse_of(j_, x_), []).
clause(7, mul(var("a"), e_, var("a")), [call(in_g(var("a")))]).
clause(8, mul(e_, var("a"), var("a")), [call(in_g(var("a")))]).
clause(9, mul(var("x_"), var("y_"), e_), [call(in_g(var("x_"))), call(in_g(var("y_"))), call(inverse_of(var("y_"), var("x_")))]).
clause(10, mul(var("y_"), var("x_"), e_), [call(in_g(var("x_"))), call(in_g(var("y_"))), call(inverse_of(var("y_"), var("x_")))]).
clause(11, same_term(var("left"), var("right")), [call(mul(var("a"), var("b"), var("ab"))), call(mul(var("ab"), var("c"), var("left"))), call(mul(var("b"), var("c"), var("bc"))), call(mul(var("a"), var("bc"), var("right")))]).
clause(13, same_inverse(var("x_"), var("y_"), var("z_")), [call(inverse_of(var("y_"), var("x_"))), call(inverse_of(var("z_"), var("x_"))), call(same_term(var("y_"), var("z_")))]).
clause(14, result_query(var("x_"), var("y_"), var("z_")), [call(same_inverse(var("x_"), var("y_"), var("z_"))), compare("!=", var("y_"), var("z_"))]).
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
substitution(9, [binding("a", x_)]).
proof(9, mul(x_, e_, x_), rule(7), [uses(5, in_g(x_))]).
substitution(10, [binding("a", i_)]).
proof(10, mul(i_, e_, i_), rule(7), [uses(6, in_g(i_))]).
substitution(11, [binding("a", j_)]).
proof(11, mul(j_, e_, j_), rule(7), [uses(7, in_g(j_))]).
substitution(12, [binding("a", e_)]).
proof(12, mul(e_, e_, e_), rule(7), [uses(8, in_g(e_))]).
substitution(13, [binding("a", x_)]).
proof(13, mul(e_, x_, x_), rule(8), [uses(5, in_g(x_))]).
substitution(14, [binding("a", i_)]).
proof(14, mul(e_, i_, i_), rule(8), [uses(6, in_g(i_))]).
substitution(15, [binding("a", j_)]).
proof(15, mul(e_, j_, j_), rule(8), [uses(7, in_g(j_))]).
substitution(16, []).
proof(16, inverse_of(i_, x_), rule(5), []).
substitution(17, []).
proof(17, inverse_of(j_, x_), rule(6), []).
substitution(18, [binding("x_", x_), binding("y_", i_)]).
proof(18, mul(x_, i_, e_), rule(9), [uses(5, in_g(x_)), uses(6, in_g(i_)), uses(16, inverse_of(i_, x_))]).
substitution(19, [binding("x_", x_), binding("y_", j_)]).
proof(19, mul(x_, j_, e_), rule(9), [uses(5, in_g(x_)), uses(7, in_g(j_)), uses(17, inverse_of(j_, x_))]).
substitution(20, [binding("y_", i_), binding("x_", x_)]).
proof(20, mul(i_, x_, e_), rule(10), [uses(5, in_g(x_)), uses(6, in_g(i_)), uses(16, inverse_of(i_, x_))]).
substitution(21, [binding("y_", j_), binding("x_", x_)]).
proof(21, mul(j_, x_, e_), rule(10), [uses(5, in_g(x_)), uses(7, in_g(j_)), uses(17, inverse_of(j_, x_))]).
substitution(22, []).
proof(22, in_g(i_), rule(2), []).
substitution(23, []).
proof(23, in_g(j_), rule(3), []).
substitution(24, [binding("a", i_)]).
proof(24, mul(i_, e_, i_), rule(7), [uses(22, in_g(i_))]).
substitution(25, [binding("a", i_)]).
proof(25, mul(e_, i_, i_), rule(8), [uses(22, in_g(i_))]).
substitution(26, [binding("a", j_)]).
proof(26, mul(j_, e_, j_), rule(7), [uses(23, in_g(j_))]).
substitution(27, [binding("a", j_)]).
proof(27, mul(e_, j_, j_), rule(8), [uses(23, in_g(j_))]).
substitution(28, [binding("a", i_)]).
proof(28, mul(e_, i_, i_), rule(8), [uses(22, in_g(i_))]).
substitution(29, [binding("a", i_)]).
proof(29, mul(i_, e_, i_), rule(7), [uses(22, in_g(i_))]).
substitution(30, [binding("a", j_)]).
proof(30, mul(e_, j_, j_), rule(8), [uses(23, in_g(j_))]).
substitution(31, [binding("a", j_)]).
proof(31, mul(j_, e_, j_), rule(7), [uses(23, in_g(j_))]).
substitution(32, []).
proof(32, in_g(e_), rule(4), []).
substitution(33, []).
proof(33, in_g(x_), rule(1), []).
substitution(34, [binding("a", e_)]).
proof(34, mul(e_, e_, e_), rule(7), [uses(32, in_g(e_))]).
substitution(35, [binding("a", i_)]).
proof(35, mul(e_, i_, i_), rule(8), [uses(22, in_g(i_))]).
substitution(36, [binding("x_", x_), binding("y_", i_)]).
proof(36, mul(x_, i_, e_), rule(9), [uses(33, in_g(x_)), uses(22, in_g(i_)), uses(16, inverse_of(i_, x_))]).
substitution(37, [binding("x_", x_), binding("y_", j_)]).
proof(37, mul(x_, j_, e_), rule(9), [uses(33, in_g(x_)), uses(23, in_g(j_)), uses(17, inverse_of(j_, x_))]).
substitution(38, [binding("a", j_)]).
proof(38, mul(e_, j_, j_), rule(8), [uses(23, in_g(j_))]).
substitution(39, [binding("left", i_), binding("right", i_), binding("a", e_), binding("b", e_), binding("ab", e_), binding("c", i_), binding("bc", i_)]).
proof(39, same_term(i_, i_), rule(11), [uses(12, mul(e_, e_, e_)), uses(25, mul(e_, i_, i_)), uses(28, mul(e_, i_, i_)), uses(35, mul(e_, i_, i_))]).
substitution(40, [binding("left", j_), binding("right", j_), binding("a", e_), binding("b", e_), binding("ab", e_), binding("c", j_), binding("bc", j_)]).
proof(40, same_term(j_, j_), rule(11), [uses(12, mul(e_, e_, e_)), uses(27, mul(e_, j_, j_)), uses(30, mul(e_, j_, j_)), uses(38, mul(e_, j_, j_))]).
substitution(41, [binding("a", i_)]).
proof(41, mul(i_, e_, i_), rule(7), [uses(22, in_g(i_))]).
substitution(42, [binding("x_", x_), binding("y_", i_), binding("z_", i_)]).
proof(42, same_inverse(x_, i_, i_), rule(13), [uses(1, inverse_of(i_, x_)), uses(3, inverse_of(i_, x_)), uses(39, same_term(i_, i_))]).
substitution(43, [binding("x_", x_), binding("y_", j_), binding("z_", j_)]).
proof(43, same_inverse(x_, j_, j_), rule(13), [uses(2, inverse_of(j_, x_)), uses(4, inverse_of(j_, x_)), uses(40, same_term(j_, j_))]).
substitution(44, [binding("a", j_)]).
proof(44, mul(j_, e_, j_), rule(7), [uses(23, in_g(j_))]).
substitution(45, [binding("left", j_), binding("right", i_), binding("a", i_), binding("b", x_), binding("ab", e_), binding("c", j_), binding("bc", e_)]).
proof(45, same_term(j_, i_), rule(11), [uses(20, mul(i_, x_, e_)), uses(27, mul(e_, j_, j_)), uses(37, mul(x_, j_, e_)), uses(41, mul(i_, e_, i_))]).
substitution(46, [binding("left", i_), binding("right", j_), binding("a", j_), binding("b", x_), binding("ab", e_), binding("c", i_), binding("bc", e_)]).
proof(46, same_term(i_, j_), rule(11), [uses(21, mul(j_, x_, e_)), uses(25, mul(e_, i_, i_)), uses(36, mul(x_, i_, e_)), uses(44, mul(j_, e_, j_))]).
substitution(47, [binding("x_", x_), binding("y_", i_), binding("z_", j_)]).
proof(47, same_inverse(x_, i_, j_), rule(13), [uses(1, inverse_of(i_, x_)), uses(4, inverse_of(j_, x_)), uses(46, same_term(i_, j_))]).
substitution(48, [binding("x_", x_), binding("y_", j_), binding("z_", i_)]).
proof(48, same_inverse(x_, j_, i_), rule(13), [uses(2, inverse_of(j_, x_)), uses(3, inverse_of(i_, x_)), uses(45, same_term(j_, i_))]).
substitution(49, [binding("x_", x_), binding("y_", i_), binding("z_", j_)]).
proof(49, result_query(x_, i_, j_), rule(14), [uses(47, same_inverse(x_, i_, j_)), compared("!=", i_, j_)]).
substitution(50, [binding("x_", x_), binding("y_", j_), binding("z_", i_)]).
proof(50, result_query(x_, j_, i_), rule(14), [uses(48, same_inverse(x_, j_, i_)), compared("!=", j_, i_)]).
substitution(51, [binding("x_", x_), binding("y_", i_), binding("z_", j_)]).
proof(51, solution([x_, i_, j_]), query, [uses(49, result_query(x_, i_, j_))]).
substitution(52, [binding("x_", x_), binding("y_", j_), binding("z_", i_)]).
proof(52, solution([x_, j_, i_]), query, [uses(50, result_query(x_, j_, i_))]).
