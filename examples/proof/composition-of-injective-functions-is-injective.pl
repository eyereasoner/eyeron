% Prolog result format 3
query(1, result_query(_0, _1, _2), ['H' = _0, 'X' = _1, 'Y' = _2]).
result(1, complete, 2).
answer(1, ['H' = h, 'X' = a, 'Y' = b]).
why(1, ['H' = h, 'X' = a, 'Y' = b], 45).
answer(1, ['H' = h, 'X' = b, 'Y' = a]).
why(1, ['H' = h, 'X' = b, 'Y' = a], 46).
clause(1, in_x(a), true).
clause(2, in_x(b), true).
clause(3, in_y(p), true).
clause(4, in_y(q), true).
clause(5, in_z(r), true).
clause(6, same_term(var('X'), var('X')), in_x(var('X'))).
clause(8, same_term(var('Z'), var('Z')), in_z(var('Z'))).
clause(9, same_term(var('B_'), var('A_')), same_term(var('A_'), var('B_'))).
clause(11, same_term(var('X'), var('Y')), (injective(var('F')), app(var('F'), var('X'), var('U')), app(var('F'), var('Y'), var('V')), same_term(var('U'), var('V')))).
clause(12, app(var('H'), var('X'), var('Z')), (composite_of(var('H'), var('G'), var('F')), app(var('F'), var('X'), var('Y')), app(var('G'), var('Y'), var('Z')))).
clause(13, same_input_under_equal_composite_output(var('H'), var('X'), var('Y')), (composite_of(var('H'), var('G'), var('F')), injective(var('F')), injective(var('G')), app(var('F'), var('X'), var('Fx')), app(var('F'), var('Y'), var('Fy')), app(var('G'), var('Fx'), var('U')), app(var('G'), var('Fy'), var('V')), same_term(var('U'), var('V')), same_term(var('X'), var('Y')))).
clause(14, injective(f), true).
clause(15, injective(g), true).
clause(16, composite_of(h, g, f), true).
clause(17, app(f, a, p), true).
clause(18, app(f, b, q), true).
clause(19, app(g, p, r), true).
clause(20, app(g, q, r), true).
clause(21, result_query(var('H'), var('X'), var('Y')), (same_input_under_equal_composite_output(var('H'), var('X'), var('Y')), var('X') \== var('Y'))).
substitution(1, []).
proof(1, composite_of(h, g, f), rule(16), []).
substitution(2, []).
proof(2, injective(f), rule(14), []).
substitution(3, []).
proof(3, injective(g), rule(15), []).
substitution(4, []).
proof(4, app(f, a, p), rule(17), []).
substitution(5, []).
proof(5, app(f, b, q), rule(18), []).
substitution(6, []).
proof(6, app(g, p, r), rule(19), []).
substitution(7, []).
proof(7, app(g, q, r), rule(20), []).
substitution(8, []).
proof(8, in_z(r), rule(5), []).
substitution(9, []).
proof(9, app(g, p, r), rule(19), []).
substitution(10, []).
proof(10, app(g, q, r), rule(20), []).
substitution(11, []).
proof(11, injective(f), rule(14), []).
substitution(12, []).
proof(12, injective(g), rule(15), []).
substitution(13, ['Z' = r]).
proof(13, same_term(r, r), rule(8), [uses(8, in_z(r))]).
substitution(14, []).
proof(14, app(g, p, r), rule(19), []).
substitution(15, []).
proof(15, app(g, q, r), rule(20), []).
substitution(16, ['H' = h, 'X' = a, 'Z' = r, 'G' = g, 'F' = f, 'Y' = p]).
proof(16, app(h, a, r), rule(12), [uses(1, composite_of(h, g, f)), uses(4, app(f, a, p)), uses(14, app(g, p, r))]).
substitution(17, ['H' = h, 'X' = b, 'Z' = r, 'G' = g, 'F' = f, 'Y' = q]).
proof(17, app(h, b, r), rule(12), [uses(1, composite_of(h, g, f)), uses(5, app(f, b, q)), uses(15, app(g, q, r))]).
substitution(18, []).
proof(18, in_x(a), rule(1), []).
substitution(19, []).
proof(19, app(f, a, p), rule(17), []).
substitution(20, []).
proof(20, app(f, b, q), rule(18), []).
substitution(21, []).
proof(21, in_x(b), rule(2), []).
substitution(22, ['X' = a]).
proof(22, same_term(a, a), rule(6), [uses(18, in_x(a))]).
substitution(23, ['X' = b]).
proof(23, same_term(b, b), rule(6), [uses(21, in_x(b))]).
substitution(24, []).
proof(24, composite_of(h, g, f), rule(16), []).
substitution(25, ['H' = h, 'X' = a, 'Y' = a, 'G' = g, 'F' = f, 'Fx' = p, 'Fy' = p, 'U' = r, 'V' = r]).
proof(25, same_input_under_equal_composite_output(h, a, a), rule(13), [uses(1, composite_of(h, g, f)), uses(2, injective(f)), uses(3, injective(g)), uses(4, app(f, a, p)), uses(4, app(f, a, p)), uses(6, app(g, p, r)), uses(6, app(g, p, r)), uses(13, same_term(r, r)), uses(22, same_term(a, a))]).
substitution(26, ['H' = h, 'X' = b, 'Y' = b, 'G' = g, 'F' = f, 'Fx' = q, 'Fy' = q, 'U' = r, 'V' = r]).
proof(26, same_input_under_equal_composite_output(h, b, b), rule(13), [uses(1, composite_of(h, g, f)), uses(2, injective(f)), uses(3, injective(g)), uses(5, app(f, b, q)), uses(5, app(f, b, q)), uses(7, app(g, q, r)), uses(7, app(g, q, r)), uses(13, same_term(r, r)), uses(23, same_term(b, b))]).
substitution(27, ['X' = p, 'Y' = p, 'F' = g, 'U' = r, 'V' = r]).
proof(27, same_term(p, p), rule(11), [uses(12, injective(g)), uses(6, app(g, p, r)), uses(6, app(g, p, r)), uses(13, same_term(r, r))]).
substitution(28, ['X' = p, 'Y' = q, 'F' = g, 'U' = r, 'V' = r]).
proof(28, same_term(p, q), rule(11), [uses(12, injective(g)), uses(6, app(g, p, r)), uses(7, app(g, q, r)), uses(13, same_term(r, r))]).
substitution(29, ['B_' = q, 'A_' = p]).
proof(29, same_term(q, p), rule(9), [uses(28, same_term(p, q))]).
substitution(30, ['X' = q, 'Y' = q, 'F' = g, 'U' = r, 'V' = r]).
proof(30, same_term(q, q), rule(11), [uses(12, injective(g)), uses(7, app(g, q, r)), uses(7, app(g, q, r)), uses(13, same_term(r, r))]).
substitution(31, ['H' = h, 'X' = a, 'Z' = r, 'G' = g, 'F' = f, 'Y' = p]).
proof(31, app(h, a, r), rule(12), [uses(24, composite_of(h, g, f)), uses(19, app(f, a, p)), uses(14, app(g, p, r))]).
substitution(32, ['H' = h, 'X' = b, 'Z' = r, 'G' = g, 'F' = f, 'Y' = q]).
proof(32, app(h, b, r), rule(12), [uses(24, composite_of(h, g, f)), uses(20, app(f, b, q)), uses(15, app(g, q, r))]).
substitution(33, []).
proof(33, in_y(p), rule(3), []).
substitution(34, []).
proof(34, app(f, a, p), rule(17), []).
substitution(35, ['X' = a, 'Y' = b, 'F' = f, 'U' = p, 'V' = q]).
proof(35, same_term(a, b), rule(11), [uses(11, injective(f)), uses(19, app(f, a, p)), uses(20, app(f, b, q)), uses(28, same_term(p, q))]).
substitution(36, ['B_' = b, 'A_' = a]).
proof(36, same_term(b, a), rule(9), [uses(35, same_term(a, b))]).
substitution(37, []).
proof(37, app(f, b, q), rule(18), []).
substitution(38, []).
proof(38, in_y(q), rule(4), []).
substitution(39, []).
proof(39, app(f, a, p), rule(17), []).
substitution(40, ['H' = h, 'X' = a, 'Y' = b, 'G' = g, 'F' = f, 'Fx' = p, 'Fy' = q, 'U' = r, 'V' = r]).
proof(40, same_input_under_equal_composite_output(h, a, b), rule(13), [uses(1, composite_of(h, g, f)), uses(2, injective(f)), uses(3, injective(g)), uses(4, app(f, a, p)), uses(5, app(f, b, q)), uses(6, app(g, p, r)), uses(7, app(g, q, r)), uses(13, same_term(r, r)), uses(35, same_term(a, b))]).
substitution(41, ['H' = h, 'X' = b, 'Y' = a, 'G' = g, 'F' = f, 'Fx' = q, 'Fy' = p, 'U' = r, 'V' = r]).
proof(41, same_input_under_equal_composite_output(h, b, a), rule(13), [uses(1, composite_of(h, g, f)), uses(2, injective(f)), uses(3, injective(g)), uses(5, app(f, b, q)), uses(4, app(f, a, p)), uses(7, app(g, q, r)), uses(6, app(g, p, r)), uses(13, same_term(r, r)), uses(36, same_term(b, a))]).
substitution(42, []).
proof(42, app(f, b, q), rule(18), []).
substitution(43, ['H' = h, 'X' = a, 'Y' = b]).
proof(43, result_query(h, a, b), rule(21), [uses(40, same_input_under_equal_composite_output(h, a, b)), builtin(a \== b)]).
substitution(44, ['H' = h, 'X' = b, 'Y' = a]).
proof(44, result_query(h, b, a), rule(21), [uses(41, same_input_under_equal_composite_output(h, b, a)), builtin(b \== a)]).
substitution(45, ['H' = h, 'X' = a, 'Y' = b]).
proof(45, solution([h, a, b]), query, [uses(43, result_query(h, a, b))]).
substitution(46, ['H' = h, 'X' = b, 'Y' = a]).
proof(46, solution([h, b, a]), query, [uses(44, result_query(h, b, a))]).
