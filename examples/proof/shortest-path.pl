best(a, d, [a, b, c, d], 5).

clause(1, edge(a, b, 2), true).
clause(2, edge(a, c, 5), true).
clause(3, edge(b, c, 1), true).
clause(4, edge(b, d, 7), true).
clause(5, edge(c, d, 2), true).
clause(9, route(var('Goal'), var('Goal'), anonymous(1), [var('Goal')], 0), true).
clause(10,
       route(var('From'), var('Goal'), var('Visited'), [var('From')|var('Path')], var('Cost')),
       (edge(var('From'), var('Next'), var('Step')),
        \+member(var('Next'), var('Visited')),
        route(var('Next'), var('Goal'), [var('Next')|var('Visited')], var('Path'), var('Remaining')),
        var('Cost') is var('Step') + var('Remaining'))).
clause(11,
       best(var('From'), var('To'), var('Path'), var('Cost')),
       (findall(var('Candidate'), route(var('From'), var('To'), [var('From')], anonymous(1), var('Candidate')), var('Bag1')),
        sort(var('Bag1'), var('Costs')),
        min_list(var('Costs'), var('Cost')),
        route(var('From'), var('To'), [var('From')], var('Path'), var('Cost')))).

step(best(a, d, [a, b, c, d], 5),
     rule(11),
     ['From' = a,
      'To' = d,
      'Path' = [a, b, c, d],
      'Cost' = 5,
      'Candidate' = _0,
      'Bag1' = [9, 7, 5],
      'Costs' = [5, 7, 9]],
     [findall(_1, route(a, d, [a], _2, _1), [9, 7, 5]),
      sort([9, 7, 5], [5, 7, 9]),
      min_list([5, 7, 9], 5),
      route(a, d, [a], [a, b, c, d], 5)]).
step(findall(_0, route(a, d, [a], _1, _0), [9, 7, 5]),
     collected,
     [],
     [route(a, d, [a], [a, b, d], 9),
      route(a, d, [a], [a, c, d], 7),
      route(a, d, [a], [a, b, c, d], 5)]).
step(route(a, d, [a], [a, b, d], 9),
     rule(10),
     ['From' = a,
      'Goal' = d,
      'Visited' = [a],
      'Path' = [b, d],
      'Cost' = 9,
      'Next' = b,
      'Step' = 2,
      'Remaining' = 7],
     [edge(a, b, 2), \+member(b, [a]), route(b, d, [b, a], [b, d], 7), 9 is 2 + 7]).
step(edge(a, b, 2), fact(1), [], []).
step(\+member(b, [a]), absent, [], []).
step(route(b, d, [b, a], [b, d], 7),
     rule(10),
     ['From' = b,
      'Goal' = d,
      'Visited' = [b, a],
      'Path' = [d],
      'Cost' = 7,
      'Next' = d,
      'Step' = 7,
      'Remaining' = 0],
     [edge(b, d, 7), \+member(d, [b, a]), route(d, d, [d, b, a], [d], 0), 7 is 7 + 0]).
step(edge(b, d, 7), fact(4), [], []).
step(\+member(d, [b, a]), absent, [], []).
step(route(d, d, [d, b, a], [d], 0), fact(9), ['Goal' = d], []).
step(7 is 7 + 0, builtin, [], []).
step(9 is 2 + 7, builtin, [], []).
step(route(a, d, [a], [a, c, d], 7),
     rule(10),
     ['From' = a,
      'Goal' = d,
      'Visited' = [a],
      'Path' = [c, d],
      'Cost' = 7,
      'Next' = c,
      'Step' = 5,
      'Remaining' = 2],
     [edge(a, c, 5), \+member(c, [a]), route(c, d, [c, a], [c, d], 2), 7 is 5 + 2]).
step(edge(a, c, 5), fact(2), [], []).
step(\+member(c, [a]), absent, [], []).
step(route(c, d, [c, a], [c, d], 2),
     rule(10),
     ['From' = c,
      'Goal' = d,
      'Visited' = [c, a],
      'Path' = [d],
      'Cost' = 2,
      'Next' = d,
      'Step' = 2,
      'Remaining' = 0],
     [edge(c, d, 2), \+member(d, [c, a]), route(d, d, [d, c, a], [d], 0), 2 is 2 + 0]).
step(edge(c, d, 2), fact(5), [], []).
step(\+member(d, [c, a]), absent, [], []).
step(route(d, d, [d, c, a], [d], 0), fact(9), ['Goal' = d], []).
step(2 is 2 + 0, builtin, [], []).
step(7 is 5 + 2, builtin, [], []).
step(route(a, d, [a], [a, b, c, d], 5),
     rule(10),
     ['From' = a,
      'Goal' = d,
      'Visited' = [a],
      'Path' = [b, c, d],
      'Cost' = 5,
      'Next' = b,
      'Step' = 2,
      'Remaining' = 3],
     [edge(a, b, 2), \+member(b, [a]), route(b, d, [b, a], [b, c, d], 3), 5 is 2 + 3]).
step(route(b, d, [b, a], [b, c, d], 3),
     rule(10),
     ['From' = b,
      'Goal' = d,
      'Visited' = [b, a],
      'Path' = [c, d],
      'Cost' = 3,
      'Next' = c,
      'Step' = 1,
      'Remaining' = 2],
     [edge(b, c, 1), \+member(c, [b, a]), route(c, d, [c, b, a], [c, d], 2), 3 is 1 + 2]).
step(edge(b, c, 1), fact(3), [], []).
step(\+member(c, [b, a]), absent, [], []).
step(route(c, d, [c, b, a], [c, d], 2),
     rule(10),
     ['From' = c,
      'Goal' = d,
      'Visited' = [c, b, a],
      'Path' = [d],
      'Cost' = 2,
      'Next' = d,
      'Step' = 2,
      'Remaining' = 0],
     [edge(c, d, 2), \+member(d, [c, b, a]), route(d, d, [d, c, b, a], [d], 0), 2 is 2 + 0]).
step(\+member(d, [c, b, a]), absent, [], []).
step(route(d, d, [d, c, b, a], [d], 0), fact(9), ['Goal' = d], []).
step(3 is 1 + 2, builtin, [], []).
step(5 is 2 + 3, builtin, [], []).
step(sort([9, 7, 5], [5, 7, 9]), builtin, [], []).
step(min_list([5, 7, 9], 5), builtin, [], []).
