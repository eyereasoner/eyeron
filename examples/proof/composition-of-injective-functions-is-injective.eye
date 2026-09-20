# Eyelang result format 2
query(1, [call(result_query(?v0, ?v1, ?v2))], [binding("h", ?v0), binding("x", ?v1), binding("y", ?v2)]).
result(1, complete, 2).
answer(1, [binding("h", h), binding("x", a), binding("y", b)]).
why(1, [binding("h", h), binding("x", a), binding("y", b)], 45).
answer(1, [binding("h", h), binding("x", b), binding("y", a)]).
why(1, [binding("h", h), binding("x", b), binding("y", a)], 46).
clause(1, in_x(a), []).
clause(2, in_x(b), []).
clause(3, in_y(p), []).
clause(4, in_y(q), []).
clause(5, in_z(r), []).
clause(6, same_term(var("x"), var("x")), [call(in_x(var("x")))]).
clause(8, same_term(var("z"), var("z")), [call(in_z(var("z")))]).
clause(9, same_term(var("b_"), var("a_")), [call(same_term(var("a_"), var("b_")))]).
clause(11, same_term(var("x"), var("y")), [call(injective(var("f"))), call(app(var("f"), var("x"), var("u"))), call(app(var("f"), var("y"), var("v"))), call(same_term(var("u"), var("v")))]).
clause(12, app(var("h"), var("x"), var("z")), [call(composite_of(var("h"), var("g"), var("f"))), call(app(var("f"), var("x"), var("y"))), call(app(var("g"), var("y"), var("z")))]).
clause(13, same_input_under_equal_composite_output(var("h"), var("x"), var("y")), [call(composite_of(var("h"), var("g"), var("f"))), call(injective(var("f"))), call(injective(var("g"))), call(app(var("f"), var("x"), var("fx"))), call(app(var("f"), var("y"), var("fy"))), call(app(var("g"), var("fx"), var("u"))), call(app(var("g"), var("fy"), var("v"))), call(same_term(var("u"), var("v"))), call(same_term(var("x"), var("y")))]).
clause(14, injective(f), []).
clause(15, injective(g), []).
clause(16, composite_of(h, g, f), []).
clause(17, app(f, a, p), []).
clause(18, app(f, b, q), []).
clause(19, app(g, p, r), []).
clause(20, app(g, q, r), []).
clause(21, result_query(var("h"), var("x"), var("y")), [call(same_input_under_equal_composite_output(var("h"), var("x"), var("y"))), compare("!=", var("x"), var("y"))]).
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
substitution(13, [binding("z", r)]).
proof(13, same_term(r, r), rule(8), [uses(8, in_z(r))]).
substitution(14, []).
proof(14, app(g, p, r), rule(19), []).
substitution(15, []).
proof(15, app(g, q, r), rule(20), []).
substitution(16, [binding("h", h), binding("x", a), binding("z", r), binding("g", g), binding("f", f), binding("y", p)]).
proof(16, app(h, a, r), rule(12), [uses(1, composite_of(h, g, f)), uses(4, app(f, a, p)), uses(14, app(g, p, r))]).
substitution(17, [binding("h", h), binding("x", b), binding("z", r), binding("g", g), binding("f", f), binding("y", q)]).
proof(17, app(h, b, r), rule(12), [uses(1, composite_of(h, g, f)), uses(5, app(f, b, q)), uses(15, app(g, q, r))]).
substitution(18, []).
proof(18, in_x(a), rule(1), []).
substitution(19, []).
proof(19, app(f, a, p), rule(17), []).
substitution(20, []).
proof(20, app(f, b, q), rule(18), []).
substitution(21, []).
proof(21, in_x(b), rule(2), []).
substitution(22, [binding("x", a)]).
proof(22, same_term(a, a), rule(6), [uses(18, in_x(a))]).
substitution(23, [binding("x", b)]).
proof(23, same_term(b, b), rule(6), [uses(21, in_x(b))]).
substitution(24, []).
proof(24, composite_of(h, g, f), rule(16), []).
substitution(25, [binding("h", h), binding("x", a), binding("y", a), binding("g", g), binding("f", f), binding("fx", p), binding("fy", p), binding("u", r), binding("v", r)]).
proof(25, same_input_under_equal_composite_output(h, a, a), rule(13), [uses(1, composite_of(h, g, f)), uses(2, injective(f)), uses(3, injective(g)), uses(4, app(f, a, p)), uses(4, app(f, a, p)), uses(6, app(g, p, r)), uses(6, app(g, p, r)), uses(13, same_term(r, r)), uses(22, same_term(a, a))]).
substitution(26, [binding("h", h), binding("x", b), binding("y", b), binding("g", g), binding("f", f), binding("fx", q), binding("fy", q), binding("u", r), binding("v", r)]).
proof(26, same_input_under_equal_composite_output(h, b, b), rule(13), [uses(1, composite_of(h, g, f)), uses(2, injective(f)), uses(3, injective(g)), uses(5, app(f, b, q)), uses(5, app(f, b, q)), uses(7, app(g, q, r)), uses(7, app(g, q, r)), uses(13, same_term(r, r)), uses(23, same_term(b, b))]).
substitution(27, [binding("x", p), binding("y", p), binding("f", g), binding("u", r), binding("v", r)]).
proof(27, same_term(p, p), rule(11), [uses(12, injective(g)), uses(6, app(g, p, r)), uses(6, app(g, p, r)), uses(13, same_term(r, r))]).
substitution(28, [binding("x", p), binding("y", q), binding("f", g), binding("u", r), binding("v", r)]).
proof(28, same_term(p, q), rule(11), [uses(12, injective(g)), uses(6, app(g, p, r)), uses(7, app(g, q, r)), uses(13, same_term(r, r))]).
substitution(29, [binding("b_", q), binding("a_", p)]).
proof(29, same_term(q, p), rule(9), [uses(28, same_term(p, q))]).
substitution(30, [binding("x", q), binding("y", q), binding("f", g), binding("u", r), binding("v", r)]).
proof(30, same_term(q, q), rule(11), [uses(12, injective(g)), uses(7, app(g, q, r)), uses(7, app(g, q, r)), uses(13, same_term(r, r))]).
substitution(31, [binding("h", h), binding("x", a), binding("z", r), binding("g", g), binding("f", f), binding("y", p)]).
proof(31, app(h, a, r), rule(12), [uses(24, composite_of(h, g, f)), uses(19, app(f, a, p)), uses(14, app(g, p, r))]).
substitution(32, [binding("h", h), binding("x", b), binding("z", r), binding("g", g), binding("f", f), binding("y", q)]).
proof(32, app(h, b, r), rule(12), [uses(24, composite_of(h, g, f)), uses(20, app(f, b, q)), uses(15, app(g, q, r))]).
substitution(33, []).
proof(33, in_y(p), rule(3), []).
substitution(34, []).
proof(34, app(f, a, p), rule(17), []).
substitution(35, [binding("x", a), binding("y", b), binding("f", f), binding("u", p), binding("v", q)]).
proof(35, same_term(a, b), rule(11), [uses(11, injective(f)), uses(19, app(f, a, p)), uses(20, app(f, b, q)), uses(28, same_term(p, q))]).
substitution(36, [binding("b_", b), binding("a_", a)]).
proof(36, same_term(b, a), rule(9), [uses(35, same_term(a, b))]).
substitution(37, []).
proof(37, app(f, b, q), rule(18), []).
substitution(38, []).
proof(38, in_y(q), rule(4), []).
substitution(39, []).
proof(39, app(f, a, p), rule(17), []).
substitution(40, [binding("h", h), binding("x", a), binding("y", b), binding("g", g), binding("f", f), binding("fx", p), binding("fy", q), binding("u", r), binding("v", r)]).
proof(40, same_input_under_equal_composite_output(h, a, b), rule(13), [uses(1, composite_of(h, g, f)), uses(2, injective(f)), uses(3, injective(g)), uses(4, app(f, a, p)), uses(5, app(f, b, q)), uses(6, app(g, p, r)), uses(7, app(g, q, r)), uses(13, same_term(r, r)), uses(35, same_term(a, b))]).
substitution(41, [binding("h", h), binding("x", b), binding("y", a), binding("g", g), binding("f", f), binding("fx", q), binding("fy", p), binding("u", r), binding("v", r)]).
proof(41, same_input_under_equal_composite_output(h, b, a), rule(13), [uses(1, composite_of(h, g, f)), uses(2, injective(f)), uses(3, injective(g)), uses(5, app(f, b, q)), uses(4, app(f, a, p)), uses(7, app(g, q, r)), uses(6, app(g, p, r)), uses(13, same_term(r, r)), uses(36, same_term(b, a))]).
substitution(42, []).
proof(42, app(f, b, q), rule(18), []).
substitution(43, [binding("h", h), binding("x", a), binding("y", b)]).
proof(43, result_query(h, a, b), rule(21), [uses(40, same_input_under_equal_composite_output(h, a, b)), compared("!=", a, b)]).
substitution(44, [binding("h", h), binding("x", b), binding("y", a)]).
proof(44, result_query(h, b, a), rule(21), [uses(41, same_input_under_equal_composite_output(h, b, a)), compared("!=", b, a)]).
substitution(45, [binding("h", h), binding("x", a), binding("y", b)]).
proof(45, solution([h, a, b]), query, [uses(43, result_query(h, a, b))]).
substitution(46, [binding("h", h), binding("x", b), binding("y", a)]).
proof(46, solution([h, b, a]), query, [uses(44, result_query(h, b, a))]).
