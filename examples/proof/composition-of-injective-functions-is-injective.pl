result_query(h, a, b).
result_query(h, b, a).

clause(5, in_z(r), true).
clause(8, same_term(var('Z'), var('Z')), in_z(var('Z'))).
clause(9, same_term(var('B_'), var('A_')), same_term(var('A_'), var('B_'))).
clause(11,
       same_term(var('X'), var('Y')),
       (injective(var('F')),
        app(var('F'), var('X'), var('U')),
        app(var('F'), var('Y'), var('V')),
        same_term(var('U'), var('V')))).
clause(13,
       same_input_under_equal_composite_output(var('H'), var('X'), var('Y')),
       (composite_of(var('H'), var('G'), var('F')),
        injective(var('F')),
        injective(var('G')),
        app(var('F'), var('X'), var('Fx')),
        app(var('F'), var('Y'), var('Fy')),
        app(var('G'), var('Fx'), var('U')),
        app(var('G'), var('Fy'), var('V')),
        same_term(var('U'), var('V')),
        same_term(var('X'), var('Y')))).
clause(14, injective(f), true).
clause(15, injective(g), true).
clause(16, composite_of(h, g, f), true).
clause(17, app(f, a, p), true).
clause(18, app(f, b, q), true).
clause(19, app(g, p, r), true).
clause(20, app(g, q, r), true).
clause(21,
       result_query(var('H'), var('X'), var('Y')),
       (same_input_under_equal_composite_output(var('H'), var('X'), var('Y')),
        var('X') \== var('Y'))).

step(result_query(h, a, b),
     rule(21),
     ['H' = h, 'X' = a, 'Y' = b],
     [same_input_under_equal_composite_output(h, a, b), a \== b]).
step(same_input_under_equal_composite_output(h, a, b),
     rule(13),
     ['H' = h, 'X' = a, 'Y' = b, 'G' = g, 'F' = f, 'Fx' = p, 'Fy' = q, 'U' = r, 'V' = r],
     [composite_of(h, g, f),
      injective(f),
      injective(g),
      app(f, a, p),
      app(f, b, q),
      app(g, p, r),
      app(g, q, r),
      same_term(r, r),
      same_term(a, b)]).
step(composite_of(h, g, f), fact(16), [], []).
step(injective(f), fact(14), [], []).
step(injective(g), fact(15), [], []).
step(app(f, a, p), fact(17), [], []).
step(app(f, b, q), fact(18), [], []).
step(app(g, p, r), fact(19), [], []).
step(app(g, q, r), fact(20), [], []).
step(same_term(r, r), rule(8), ['Z' = r], [in_z(r)]).
step(in_z(r), fact(5), [], []).
step(same_term(a, b),
     rule(11),
     ['X' = a, 'Y' = b, 'F' = f, 'U' = p, 'V' = q],
     [injective(f), app(f, a, p), app(f, b, q), same_term(p, q)]).
step(same_term(p, q),
     rule(11),
     ['X' = p, 'Y' = q, 'F' = g, 'U' = r, 'V' = r],
     [injective(g), app(g, p, r), app(g, q, r), same_term(r, r)]).
step(a \== b, builtin, [], []).
step(result_query(h, b, a),
     rule(21),
     ['H' = h, 'X' = b, 'Y' = a],
     [same_input_under_equal_composite_output(h, b, a), b \== a]).
step(same_input_under_equal_composite_output(h, b, a),
     rule(13),
     ['H' = h, 'X' = b, 'Y' = a, 'G' = g, 'F' = f, 'Fx' = q, 'Fy' = p, 'U' = r, 'V' = r],
     [composite_of(h, g, f),
      injective(f),
      injective(g),
      app(f, b, q),
      app(f, a, p),
      app(g, q, r),
      app(g, p, r),
      same_term(r, r),
      same_term(b, a)]).
step(same_term(b, a), rule(9), ['B_' = b, 'A_' = a], [same_term(a, b)]).
step(b \== a, builtin, [], []).
