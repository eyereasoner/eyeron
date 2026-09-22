% Prolog result format 4
query(1, best(a, f, _0, _1), ['Path' = _0, 'Cost' = _1]).
result(1, complete, 1).
answer(1, ['Path' = [a, c, b, d, e, f], 'Cost' = 13]).
why(1, ['Path' = [a, c, b, d, e, f], 'Cost' = 13], [best(a, f, [a, c, b, d, e, f], 13)]).

clause(1, edge(a, b, 4), true).
clause(2, edge(a, c, 2), true).
clause(3, edge(b, c, 1), true).
clause(4, edge(b, d, 5), true).
clause(5, edge(c, d, 8), true).
clause(6, edge(c, e, 10), true).
clause(7, edge(d, e, 2), true).
clause(8, edge(d, f, 6), true).
clause(9, edge(e, f, 3), true).
clause(10,
       connected(var('Right'), var('Left'), var('Weight')),
       edge(var('Left'), var('Right'), var('Weight'))).
clause(11,
       connected(var('Left'), var('Right'), var('Weight')),
       edge(var('Left'), var('Right'), var('Weight'))).
clause(14, route(var('Goal'), var('Goal'), anonymous(1), [var('Goal')], 0), true).
clause(15,
       route(var('From'), var('Goal'), var('Visited'), [var('From')|var('Path')], var('Cost')),
       (connected(var('From'), var('Next'), var('Step')),
        \+member(var('Next'), var('Visited')),
        route(var('Next'), var('Goal'), [var('Next')|var('Visited')], var('Path'), var('Remaining')),
        var('Cost') is var('Step') + var('Remaining'))).
clause(16,
       best(var('From'), var('To'), var('Path'), var('Cost')),
       (findall(var('Candidate'), route(var('From'), var('To'), [var('From')], anonymous(1), var('Candidate')), var('Bag1')),
        sort(var('Bag1'), var('Costs')),
        min_list(var('Costs'), var('Cost')),
        route(var('From'), var('To'), [var('From')], var('Path'), var('Cost')))).

step(best(a, f, [a, c, b, d, e, f], 13),
     rule(16),
     ['From' = a,
      'To' = f,
      'Path' = [a, c, b, d, e, f],
      'Cost' = 13,
      'Candidate' = _0,
      'Bag1' = [15, 16, 19, 18, 14, 23, 30, 13, 20],
      'Costs' = [13, 14, 15, 16, 18, 19, 20, 23, 30]],
     [findall(_1, route(a, f, [a], _2, _1), [15, 16, 19, 18, 14, 23, 30, 13, 20]),
      sort([15, 16, 19, 18, 14, 23, 30, 13, 20], [13, 14, 15, 16, 18, 19, 20, 23, 30]),
      min_list([13, 14, 15, 16, 18, 19, 20, 23, 30], 13),
      route(a, f, [a], [a, c, b, d, e, f], 13)]).
step(findall(_0, route(a, f, [a], _1, _0), [15, 16, 19, 18, 14, 23, 30, 13, 20]),
     collected,
     [],
     [route(a, f, [a], [a, b, d, f], 15),
      route(a, f, [a], [a, c, d, f], 16),
      route(a, f, [a], [a, b, c, d, f], 19),
      route(a, f, [a], [a, b, c, e, f], 18),
      route(a, f, [a], [a, b, d, e, f], 14),
      route(a, f, [a], [a, b, c, e, d, f], 23),
      route(a, f, [a], [a, b, d, c, e, f], 30),
      route(a, f, [a], [a, c, b, d, e, f], 13),
      route(a, f, [a], [a, c, e, d, f], 20)]).
step(route(a, f, [a], [a, b, d, f], 15),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [b, d, f],
      'Cost' = 15,
      'Next' = b,
      'Step' = 4,
      'Remaining' = 11],
     [connected(a, b, 4), \+member(b, [a]), route(b, f, [b, a], [b, d, f], 11), 15 is 4 + 11]).
step(connected(a, b, 4), rule(11), ['Left' = a, 'Right' = b, 'Weight' = 4], [edge(a, b, 4)]).
step(edge(a, b, 4), fact(1), [], []).
step(\+member(b, [a]), absent, [], []).
step(route(b, f, [b, a], [b, d, f], 11),
     rule(15),
     ['From' = b,
      'Goal' = f,
      'Visited' = [b, a],
      'Path' = [d, f],
      'Cost' = 11,
      'Next' = d,
      'Step' = 5,
      'Remaining' = 6],
     [connected(b, d, 5), \+member(d, [b, a]), route(d, f, [d, b, a], [d, f], 6), 11 is 5 + 6]).
step(connected(b, d, 5), rule(11), ['Left' = b, 'Right' = d, 'Weight' = 5], [edge(b, d, 5)]).
step(edge(b, d, 5), fact(4), [], []).
step(\+member(d, [b, a]), absent, [], []).
step(route(d, f, [d, b, a], [d, f], 6),
     rule(15),
     ['From' = d,
      'Goal' = f,
      'Visited' = [d, b, a],
      'Path' = [f],
      'Cost' = 6,
      'Next' = f,
      'Step' = 6,
      'Remaining' = 0],
     [connected(d, f, 6), \+member(f, [d, b, a]), route(f, f, [f, d, b, a], [f], 0), 6 is 6 + 0]).
step(connected(d, f, 6), rule(11), ['Left' = d, 'Right' = f, 'Weight' = 6], [edge(d, f, 6)]).
step(edge(d, f, 6), fact(8), [], []).
step(\+member(f, [d, b, a]), absent, [], []).
step(route(f, f, [f, d, b, a], [f], 0), fact(14), ['Goal' = f], []).
step(6 is 6 + 0, builtin, [], []).
step(11 is 5 + 6, builtin, [], []).
step(15 is 4 + 11, builtin, [], []).
step(route(a, f, [a], [a, c, d, f], 16),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [c, d, f],
      'Cost' = 16,
      'Next' = c,
      'Step' = 2,
      'Remaining' = 14],
     [connected(a, c, 2), \+member(c, [a]), route(c, f, [c, a], [c, d, f], 14), 16 is 2 + 14]).
step(connected(a, c, 2), rule(11), ['Left' = a, 'Right' = c, 'Weight' = 2], [edge(a, c, 2)]).
step(edge(a, c, 2), fact(2), [], []).
step(\+member(c, [a]), absent, [], []).
step(route(c, f, [c, a], [c, d, f], 14),
     rule(15),
     ['From' = c,
      'Goal' = f,
      'Visited' = [c, a],
      'Path' = [d, f],
      'Cost' = 14,
      'Next' = d,
      'Step' = 8,
      'Remaining' = 6],
     [connected(c, d, 8), \+member(d, [c, a]), route(d, f, [d, c, a], [d, f], 6), 14 is 8 + 6]).
step(connected(c, d, 8), rule(11), ['Left' = c, 'Right' = d, 'Weight' = 8], [edge(c, d, 8)]).
step(edge(c, d, 8), fact(5), [], []).
step(\+member(d, [c, a]), absent, [], []).
step(route(d, f, [d, c, a], [d, f], 6),
     rule(15),
     ['From' = d,
      'Goal' = f,
      'Visited' = [d, c, a],
      'Path' = [f],
      'Cost' = 6,
      'Next' = f,
      'Step' = 6,
      'Remaining' = 0],
     [connected(d, f, 6), \+member(f, [d, c, a]), route(f, f, [f, d, c, a], [f], 0), 6 is 6 + 0]).
step(\+member(f, [d, c, a]), absent, [], []).
step(route(f, f, [f, d, c, a], [f], 0), fact(14), ['Goal' = f], []).
step(14 is 8 + 6, builtin, [], []).
step(16 is 2 + 14, builtin, [], []).
step(route(a, f, [a], [a, b, c, d, f], 19),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [b, c, d, f],
      'Cost' = 19,
      'Next' = b,
      'Step' = 4,
      'Remaining' = 15],
     [connected(a, b, 4), \+member(b, [a]), route(b, f, [b, a], [b, c, d, f], 15), 19 is 4 + 15]).
step(route(b, f, [b, a], [b, c, d, f], 15),
     rule(15),
     ['From' = b,
      'Goal' = f,
      'Visited' = [b, a],
      'Path' = [c, d, f],
      'Cost' = 15,
      'Next' = c,
      'Step' = 1,
      'Remaining' = 14],
     [connected(b, c, 1),
      \+member(c, [b, a]),
      route(c, f, [c, b, a], [c, d, f], 14),
      15 is 1 + 14]).
step(connected(b, c, 1), rule(11), ['Left' = b, 'Right' = c, 'Weight' = 1], [edge(b, c, 1)]).
step(edge(b, c, 1), fact(3), [], []).
step(\+member(c, [b, a]), absent, [], []).
step(route(c, f, [c, b, a], [c, d, f], 14),
     rule(15),
     ['From' = c,
      'Goal' = f,
      'Visited' = [c, b, a],
      'Path' = [d, f],
      'Cost' = 14,
      'Next' = d,
      'Step' = 8,
      'Remaining' = 6],
     [connected(c, d, 8),
      \+member(d, [c, b, a]),
      route(d, f, [d, c, b, a], [d, f], 6),
      14 is 8 + 6]).
step(\+member(d, [c, b, a]), absent, [], []).
step(route(d, f, [d, c, b, a], [d, f], 6),
     rule(15),
     ['From' = d,
      'Goal' = f,
      'Visited' = [d, c, b, a],
      'Path' = [f],
      'Cost' = 6,
      'Next' = f,
      'Step' = 6,
      'Remaining' = 0],
     [connected(d, f, 6),
      \+member(f, [d, c, b, a]),
      route(f, f, [f, d, c, b, a], [f], 0),
      6 is 6 + 0]).
step(\+member(f, [d, c, b, a]), absent, [], []).
step(route(f, f, [f, d, c, b, a], [f], 0), fact(14), ['Goal' = f], []).
step(15 is 1 + 14, builtin, [], []).
step(19 is 4 + 15, builtin, [], []).
step(route(a, f, [a], [a, b, c, e, f], 18),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [b, c, e, f],
      'Cost' = 18,
      'Next' = b,
      'Step' = 4,
      'Remaining' = 14],
     [connected(a, b, 4), \+member(b, [a]), route(b, f, [b, a], [b, c, e, f], 14), 18 is 4 + 14]).
step(route(b, f, [b, a], [b, c, e, f], 14),
     rule(15),
     ['From' = b,
      'Goal' = f,
      'Visited' = [b, a],
      'Path' = [c, e, f],
      'Cost' = 14,
      'Next' = c,
      'Step' = 1,
      'Remaining' = 13],
     [connected(b, c, 1),
      \+member(c, [b, a]),
      route(c, f, [c, b, a], [c, e, f], 13),
      14 is 1 + 13]).
step(route(c, f, [c, b, a], [c, e, f], 13),
     rule(15),
     ['From' = c,
      'Goal' = f,
      'Visited' = [c, b, a],
      'Path' = [e, f],
      'Cost' = 13,
      'Next' = e,
      'Step' = 10,
      'Remaining' = 3],
     [connected(c, e, 10),
      \+member(e, [c, b, a]),
      route(e, f, [e, c, b, a], [e, f], 3),
      13 is 10 + 3]).
step(connected(c, e, 10), rule(11), ['Left' = c, 'Right' = e, 'Weight' = 10], [edge(c, e, 10)]).
step(edge(c, e, 10), fact(6), [], []).
step(\+member(e, [c, b, a]), absent, [], []).
step(route(e, f, [e, c, b, a], [e, f], 3),
     rule(15),
     ['From' = e,
      'Goal' = f,
      'Visited' = [e, c, b, a],
      'Path' = [f],
      'Cost' = 3,
      'Next' = f,
      'Step' = 3,
      'Remaining' = 0],
     [connected(e, f, 3),
      \+member(f, [e, c, b, a]),
      route(f, f, [f, e, c, b, a], [f], 0),
      3 is 3 + 0]).
step(connected(e, f, 3), rule(11), ['Left' = e, 'Right' = f, 'Weight' = 3], [edge(e, f, 3)]).
step(edge(e, f, 3), fact(9), [], []).
step(\+member(f, [e, c, b, a]), absent, [], []).
step(route(f, f, [f, e, c, b, a], [f], 0), fact(14), ['Goal' = f], []).
step(3 is 3 + 0, builtin, [], []).
step(13 is 10 + 3, builtin, [], []).
step(14 is 1 + 13, builtin, [], []).
step(18 is 4 + 14, builtin, [], []).
step(route(a, f, [a], [a, b, d, e, f], 14),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [b, d, e, f],
      'Cost' = 14,
      'Next' = b,
      'Step' = 4,
      'Remaining' = 10],
     [connected(a, b, 4), \+member(b, [a]), route(b, f, [b, a], [b, d, e, f], 10), 14 is 4 + 10]).
step(route(b, f, [b, a], [b, d, e, f], 10),
     rule(15),
     ['From' = b,
      'Goal' = f,
      'Visited' = [b, a],
      'Path' = [d, e, f],
      'Cost' = 10,
      'Next' = d,
      'Step' = 5,
      'Remaining' = 5],
     [connected(b, d, 5),
      \+member(d, [b, a]),
      route(d, f, [d, b, a], [d, e, f], 5),
      10 is 5 + 5]).
step(route(d, f, [d, b, a], [d, e, f], 5),
     rule(15),
     ['From' = d,
      'Goal' = f,
      'Visited' = [d, b, a],
      'Path' = [e, f],
      'Cost' = 5,
      'Next' = e,
      'Step' = 2,
      'Remaining' = 3],
     [connected(d, e, 2),
      \+member(e, [d, b, a]),
      route(e, f, [e, d, b, a], [e, f], 3),
      5 is 2 + 3]).
step(connected(d, e, 2), rule(11), ['Left' = d, 'Right' = e, 'Weight' = 2], [edge(d, e, 2)]).
step(edge(d, e, 2), fact(7), [], []).
step(\+member(e, [d, b, a]), absent, [], []).
step(route(e, f, [e, d, b, a], [e, f], 3),
     rule(15),
     ['From' = e,
      'Goal' = f,
      'Visited' = [e, d, b, a],
      'Path' = [f],
      'Cost' = 3,
      'Next' = f,
      'Step' = 3,
      'Remaining' = 0],
     [connected(e, f, 3),
      \+member(f, [e, d, b, a]),
      route(f, f, [f, e, d, b, a], [f], 0),
      3 is 3 + 0]).
step(\+member(f, [e, d, b, a]), absent, [], []).
step(route(f, f, [f, e, d, b, a], [f], 0), fact(14), ['Goal' = f], []).
step(5 is 2 + 3, builtin, [], []).
step(10 is 5 + 5, builtin, [], []).
step(14 is 4 + 10, builtin, [], []).
step(route(a, f, [a], [a, b, c, e, d, f], 23),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [b, c, e, d, f],
      'Cost' = 23,
      'Next' = b,
      'Step' = 4,
      'Remaining' = 19],
     [connected(a, b, 4),
      \+member(b, [a]),
      route(b, f, [b, a], [b, c, e, d, f], 19),
      23 is 4 + 19]).
step(route(b, f, [b, a], [b, c, e, d, f], 19),
     rule(15),
     ['From' = b,
      'Goal' = f,
      'Visited' = [b, a],
      'Path' = [c, e, d, f],
      'Cost' = 19,
      'Next' = c,
      'Step' = 1,
      'Remaining' = 18],
     [connected(b, c, 1),
      \+member(c, [b, a]),
      route(c, f, [c, b, a], [c, e, d, f], 18),
      19 is 1 + 18]).
step(route(c, f, [c, b, a], [c, e, d, f], 18),
     rule(15),
     ['From' = c,
      'Goal' = f,
      'Visited' = [c, b, a],
      'Path' = [e, d, f],
      'Cost' = 18,
      'Next' = e,
      'Step' = 10,
      'Remaining' = 8],
     [connected(c, e, 10),
      \+member(e, [c, b, a]),
      route(e, f, [e, c, b, a], [e, d, f], 8),
      18 is 10 + 8]).
step(route(e, f, [e, c, b, a], [e, d, f], 8),
     rule(15),
     ['From' = e,
      'Goal' = f,
      'Visited' = [e, c, b, a],
      'Path' = [d, f],
      'Cost' = 8,
      'Next' = d,
      'Step' = 2,
      'Remaining' = 6],
     [connected(e, d, 2),
      \+member(d, [e, c, b, a]),
      route(d, f, [d, e, c, b, a], [d, f], 6),
      8 is 2 + 6]).
step(connected(e, d, 2), rule(10), ['Right' = e, 'Left' = d, 'Weight' = 2], [edge(d, e, 2)]).
step(\+member(d, [e, c, b, a]), absent, [], []).
step(route(d, f, [d, e, c, b, a], [d, f], 6),
     rule(15),
     ['From' = d,
      'Goal' = f,
      'Visited' = [d, e, c, b, a],
      'Path' = [f],
      'Cost' = 6,
      'Next' = f,
      'Step' = 6,
      'Remaining' = 0],
     [connected(d, f, 6),
      \+member(f, [d, e, c, b, a]),
      route(f, f, [f, d, e, c, b, a], [f], 0),
      6 is 6 + 0]).
step(\+member(f, [d, e, c, b, a]), absent, [], []).
step(route(f, f, [f, d, e, c, b, a], [f], 0), fact(14), ['Goal' = f], []).
step(8 is 2 + 6, builtin, [], []).
step(18 is 10 + 8, builtin, [], []).
step(19 is 1 + 18, builtin, [], []).
step(23 is 4 + 19, builtin, [], []).
step(route(a, f, [a], [a, b, d, c, e, f], 30),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [b, d, c, e, f],
      'Cost' = 30,
      'Next' = b,
      'Step' = 4,
      'Remaining' = 26],
     [connected(a, b, 4),
      \+member(b, [a]),
      route(b, f, [b, a], [b, d, c, e, f], 26),
      30 is 4 + 26]).
step(route(b, f, [b, a], [b, d, c, e, f], 26),
     rule(15),
     ['From' = b,
      'Goal' = f,
      'Visited' = [b, a],
      'Path' = [d, c, e, f],
      'Cost' = 26,
      'Next' = d,
      'Step' = 5,
      'Remaining' = 21],
     [connected(b, d, 5),
      \+member(d, [b, a]),
      route(d, f, [d, b, a], [d, c, e, f], 21),
      26 is 5 + 21]).
step(route(d, f, [d, b, a], [d, c, e, f], 21),
     rule(15),
     ['From' = d,
      'Goal' = f,
      'Visited' = [d, b, a],
      'Path' = [c, e, f],
      'Cost' = 21,
      'Next' = c,
      'Step' = 8,
      'Remaining' = 13],
     [connected(d, c, 8),
      \+member(c, [d, b, a]),
      route(c, f, [c, d, b, a], [c, e, f], 13),
      21 is 8 + 13]).
step(connected(d, c, 8), rule(10), ['Right' = d, 'Left' = c, 'Weight' = 8], [edge(c, d, 8)]).
step(\+member(c, [d, b, a]), absent, [], []).
step(route(c, f, [c, d, b, a], [c, e, f], 13),
     rule(15),
     ['From' = c,
      'Goal' = f,
      'Visited' = [c, d, b, a],
      'Path' = [e, f],
      'Cost' = 13,
      'Next' = e,
      'Step' = 10,
      'Remaining' = 3],
     [connected(c, e, 10),
      \+member(e, [c, d, b, a]),
      route(e, f, [e, c, d, b, a], [e, f], 3),
      13 is 10 + 3]).
step(\+member(e, [c, d, b, a]), absent, [], []).
step(route(e, f, [e, c, d, b, a], [e, f], 3),
     rule(15),
     ['From' = e,
      'Goal' = f,
      'Visited' = [e, c, d, b, a],
      'Path' = [f],
      'Cost' = 3,
      'Next' = f,
      'Step' = 3,
      'Remaining' = 0],
     [connected(e, f, 3),
      \+member(f, [e, c, d, b, a]),
      route(f, f, [f, e, c, d, b, a], [f], 0),
      3 is 3 + 0]).
step(\+member(f, [e, c, d, b, a]), absent, [], []).
step(route(f, f, [f, e, c, d, b, a], [f], 0), fact(14), ['Goal' = f], []).
step(21 is 8 + 13, builtin, [], []).
step(26 is 5 + 21, builtin, [], []).
step(30 is 4 + 26, builtin, [], []).
step(route(a, f, [a], [a, c, b, d, e, f], 13),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [c, b, d, e, f],
      'Cost' = 13,
      'Next' = c,
      'Step' = 2,
      'Remaining' = 11],
     [connected(a, c, 2),
      \+member(c, [a]),
      route(c, f, [c, a], [c, b, d, e, f], 11),
      13 is 2 + 11]).
step(route(c, f, [c, a], [c, b, d, e, f], 11),
     rule(15),
     ['From' = c,
      'Goal' = f,
      'Visited' = [c, a],
      'Path' = [b, d, e, f],
      'Cost' = 11,
      'Next' = b,
      'Step' = 1,
      'Remaining' = 10],
     [connected(c, b, 1),
      \+member(b, [c, a]),
      route(b, f, [b, c, a], [b, d, e, f], 10),
      11 is 1 + 10]).
step(connected(c, b, 1), rule(10), ['Right' = c, 'Left' = b, 'Weight' = 1], [edge(b, c, 1)]).
step(\+member(b, [c, a]), absent, [], []).
step(route(b, f, [b, c, a], [b, d, e, f], 10),
     rule(15),
     ['From' = b,
      'Goal' = f,
      'Visited' = [b, c, a],
      'Path' = [d, e, f],
      'Cost' = 10,
      'Next' = d,
      'Step' = 5,
      'Remaining' = 5],
     [connected(b, d, 5),
      \+member(d, [b, c, a]),
      route(d, f, [d, b, c, a], [d, e, f], 5),
      10 is 5 + 5]).
step(\+member(d, [b, c, a]), absent, [], []).
step(route(d, f, [d, b, c, a], [d, e, f], 5),
     rule(15),
     ['From' = d,
      'Goal' = f,
      'Visited' = [d, b, c, a],
      'Path' = [e, f],
      'Cost' = 5,
      'Next' = e,
      'Step' = 2,
      'Remaining' = 3],
     [connected(d, e, 2),
      \+member(e, [d, b, c, a]),
      route(e, f, [e, d, b, c, a], [e, f], 3),
      5 is 2 + 3]).
step(\+member(e, [d, b, c, a]), absent, [], []).
step(route(e, f, [e, d, b, c, a], [e, f], 3),
     rule(15),
     ['From' = e,
      'Goal' = f,
      'Visited' = [e, d, b, c, a],
      'Path' = [f],
      'Cost' = 3,
      'Next' = f,
      'Step' = 3,
      'Remaining' = 0],
     [connected(e, f, 3),
      \+member(f, [e, d, b, c, a]),
      route(f, f, [f, e, d, b, c, a], [f], 0),
      3 is 3 + 0]).
step(\+member(f, [e, d, b, c, a]), absent, [], []).
step(route(f, f, [f, e, d, b, c, a], [f], 0), fact(14), ['Goal' = f], []).
step(11 is 1 + 10, builtin, [], []).
step(13 is 2 + 11, builtin, [], []).
step(route(a, f, [a], [a, c, e, d, f], 20),
     rule(15),
     ['From' = a,
      'Goal' = f,
      'Visited' = [a],
      'Path' = [c, e, d, f],
      'Cost' = 20,
      'Next' = c,
      'Step' = 2,
      'Remaining' = 18],
     [connected(a, c, 2), \+member(c, [a]), route(c, f, [c, a], [c, e, d, f], 18), 20 is 2 + 18]).
step(route(c, f, [c, a], [c, e, d, f], 18),
     rule(15),
     ['From' = c,
      'Goal' = f,
      'Visited' = [c, a],
      'Path' = [e, d, f],
      'Cost' = 18,
      'Next' = e,
      'Step' = 10,
      'Remaining' = 8],
     [connected(c, e, 10),
      \+member(e, [c, a]),
      route(e, f, [e, c, a], [e, d, f], 8),
      18 is 10 + 8]).
step(\+member(e, [c, a]), absent, [], []).
step(route(e, f, [e, c, a], [e, d, f], 8),
     rule(15),
     ['From' = e,
      'Goal' = f,
      'Visited' = [e, c, a],
      'Path' = [d, f],
      'Cost' = 8,
      'Next' = d,
      'Step' = 2,
      'Remaining' = 6],
     [connected(e, d, 2),
      \+member(d, [e, c, a]),
      route(d, f, [d, e, c, a], [d, f], 6),
      8 is 2 + 6]).
step(\+member(d, [e, c, a]), absent, [], []).
step(route(d, f, [d, e, c, a], [d, f], 6),
     rule(15),
     ['From' = d,
      'Goal' = f,
      'Visited' = [d, e, c, a],
      'Path' = [f],
      'Cost' = 6,
      'Next' = f,
      'Step' = 6,
      'Remaining' = 0],
     [connected(d, f, 6),
      \+member(f, [d, e, c, a]),
      route(f, f, [f, d, e, c, a], [f], 0),
      6 is 6 + 0]).
step(\+member(f, [d, e, c, a]), absent, [], []).
step(route(f, f, [f, d, e, c, a], [f], 0), fact(14), ['Goal' = f], []).
step(20 is 2 + 18, builtin, [], []).
step(sort([15, 16, 19, 18, 14, 23, 30, 13, 20], [13, 14, 15, 16, 18, 19, 20, 23, 30]),
     builtin,
     [],
     []).
step(min_list([13, 14, 15, 16, 18, 19, 20, 23, 30], 13), builtin, [], []).
