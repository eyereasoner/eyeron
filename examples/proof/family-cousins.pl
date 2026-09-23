cousin(dave, frank).
cousin(dave, grace).
cousin(eve, frank).
cousin(eve, grace).
cousin(frank, dave).
cousin(frank, eve).
cousin(grace, dave).
cousin(grace, eve).
cousin(heidi, judy).
cousin(ivan, judy).
cousin(judy, heidi).
cousin(judy, ivan).

clause(1, parent(adam, bob), true).
clause(2, parent(adam, carol), true).
clause(3, parent(bob, dave), true).
clause(4, parent(bob, eve), true).
clause(5, parent(carol, frank), true).
clause(6, parent(carol, grace), true).
clause(7, parent(dave, heidi), true).
clause(8, parent(eve, ivan), true).
clause(9, parent(frank, judy), true).
clause(10, branch(dave, b), true).
clause(11, branch(eve, b), true).
clause(12, branch(frank, c), true).
clause(13, branch(grace, c), true).
clause(14, different(b, c), true).
clause(15, different(c, b), true).
clause(16, generation(adam, 0), true).
clause(17,
       generation(var('Child'), var('Next')),
       (parent(var('Parent'), var('Child')),
        generation(var('Parent'), var('Current')),
        var('Next') is var('Current') + 1)).
clause(18,
       branch(var('Child'), var('Branch')),
       (parent(var('Parent'), var('Child')), branch(var('Parent'), var('Branch')))).
clause(19,
       cousin(var('X'), var('Y')),
       (generation(var('X'), var('G')),
        generation(var('Y'), var('G')),
        branch(var('X'), var('Bx')),
        branch(var('Y'), var('By')),
        different(var('Bx'), var('By')))).

step(cousin(dave, frank),
     rule(19),
     ['X' = dave, 'Y' = frank, 'G' = 2, 'Bx' = b, 'By' = c],
     [generation(dave, 2),
      generation(frank, 2),
      branch(dave, b),
      branch(frank, c),
      different(b, c)]).
step(generation(dave, 2),
     rule(17),
     ['Child' = dave, 'Next' = 2, 'Parent' = bob, 'Current' = 1],
     [parent(bob, dave), generation(bob, 1), 2 is 1 + 1]).
step(parent(bob, dave), fact(3), [], []).
step(generation(bob, 1),
     rule(17),
     ['Child' = bob, 'Next' = 1, 'Parent' = adam, 'Current' = 0],
     [parent(adam, bob), generation(adam, 0), 1 is 0 + 1]).
step(parent(adam, bob), fact(1), [], []).
step(generation(adam, 0), fact(16), [], []).
step(1 is 0 + 1, builtin, [], []).
step(2 is 1 + 1, builtin, [], []).
step(generation(frank, 2),
     rule(17),
     ['Child' = frank, 'Next' = 2, 'Parent' = carol, 'Current' = 1],
     [parent(carol, frank), generation(carol, 1), 2 is 1 + 1]).
step(parent(carol, frank), fact(5), [], []).
step(generation(carol, 1),
     rule(17),
     ['Child' = carol, 'Next' = 1, 'Parent' = adam, 'Current' = 0],
     [parent(adam, carol), generation(adam, 0), 1 is 0 + 1]).
step(parent(adam, carol), fact(2), [], []).
step(branch(dave, b), fact(10), [], []).
step(branch(frank, c), fact(12), [], []).
step(different(b, c), fact(14), [], []).
step(cousin(dave, grace),
     rule(19),
     ['X' = dave, 'Y' = grace, 'G' = 2, 'Bx' = b, 'By' = c],
     [generation(dave, 2),
      generation(grace, 2),
      branch(dave, b),
      branch(grace, c),
      different(b, c)]).
step(generation(grace, 2),
     rule(17),
     ['Child' = grace, 'Next' = 2, 'Parent' = carol, 'Current' = 1],
     [parent(carol, grace), generation(carol, 1), 2 is 1 + 1]).
step(parent(carol, grace), fact(6), [], []).
step(branch(grace, c), fact(13), [], []).
step(cousin(eve, frank),
     rule(19),
     ['X' = eve, 'Y' = frank, 'G' = 2, 'Bx' = b, 'By' = c],
     [generation(eve, 2),
      generation(frank, 2),
      branch(eve, b),
      branch(frank, c),
      different(b, c)]).
step(generation(eve, 2),
     rule(17),
     ['Child' = eve, 'Next' = 2, 'Parent' = bob, 'Current' = 1],
     [parent(bob, eve), generation(bob, 1), 2 is 1 + 1]).
step(parent(bob, eve), fact(4), [], []).
step(branch(eve, b), fact(11), [], []).
step(cousin(eve, grace),
     rule(19),
     ['X' = eve, 'Y' = grace, 'G' = 2, 'Bx' = b, 'By' = c],
     [generation(eve, 2),
      generation(grace, 2),
      branch(eve, b),
      branch(grace, c),
      different(b, c)]).
step(cousin(frank, dave),
     rule(19),
     ['X' = frank, 'Y' = dave, 'G' = 2, 'Bx' = c, 'By' = b],
     [generation(frank, 2),
      generation(dave, 2),
      branch(frank, c),
      branch(dave, b),
      different(c, b)]).
step(different(c, b), fact(15), [], []).
step(cousin(frank, eve),
     rule(19),
     ['X' = frank, 'Y' = eve, 'G' = 2, 'Bx' = c, 'By' = b],
     [generation(frank, 2),
      generation(eve, 2),
      branch(frank, c),
      branch(eve, b),
      different(c, b)]).
step(cousin(grace, dave),
     rule(19),
     ['X' = grace, 'Y' = dave, 'G' = 2, 'Bx' = c, 'By' = b],
     [generation(grace, 2),
      generation(dave, 2),
      branch(grace, c),
      branch(dave, b),
      different(c, b)]).
step(cousin(grace, eve),
     rule(19),
     ['X' = grace, 'Y' = eve, 'G' = 2, 'Bx' = c, 'By' = b],
     [generation(grace, 2),
      generation(eve, 2),
      branch(grace, c),
      branch(eve, b),
      different(c, b)]).
step(cousin(heidi, judy),
     rule(19),
     ['X' = heidi, 'Y' = judy, 'G' = 3, 'Bx' = b, 'By' = c],
     [generation(heidi, 3),
      generation(judy, 3),
      branch(heidi, b),
      branch(judy, c),
      different(b, c)]).
step(generation(heidi, 3),
     rule(17),
     ['Child' = heidi, 'Next' = 3, 'Parent' = dave, 'Current' = 2],
     [parent(dave, heidi), generation(dave, 2), 3 is 2 + 1]).
step(parent(dave, heidi), fact(7), [], []).
step(3 is 2 + 1, builtin, [], []).
step(generation(judy, 3),
     rule(17),
     ['Child' = judy, 'Next' = 3, 'Parent' = frank, 'Current' = 2],
     [parent(frank, judy), generation(frank, 2), 3 is 2 + 1]).
step(parent(frank, judy), fact(9), [], []).
step(branch(heidi, b),
     rule(18),
     ['Child' = heidi, 'Branch' = b, 'Parent' = dave],
     [parent(dave, heidi), branch(dave, b)]).
step(branch(judy, c),
     rule(18),
     ['Child' = judy, 'Branch' = c, 'Parent' = frank],
     [parent(frank, judy), branch(frank, c)]).
step(cousin(ivan, judy),
     rule(19),
     ['X' = ivan, 'Y' = judy, 'G' = 3, 'Bx' = b, 'By' = c],
     [generation(ivan, 3),
      generation(judy, 3),
      branch(ivan, b),
      branch(judy, c),
      different(b, c)]).
step(generation(ivan, 3),
     rule(17),
     ['Child' = ivan, 'Next' = 3, 'Parent' = eve, 'Current' = 2],
     [parent(eve, ivan), generation(eve, 2), 3 is 2 + 1]).
step(parent(eve, ivan), fact(8), [], []).
step(branch(ivan, b),
     rule(18),
     ['Child' = ivan, 'Branch' = b, 'Parent' = eve],
     [parent(eve, ivan), branch(eve, b)]).
step(cousin(judy, heidi),
     rule(19),
     ['X' = judy, 'Y' = heidi, 'G' = 3, 'Bx' = c, 'By' = b],
     [generation(judy, 3),
      generation(heidi, 3),
      branch(judy, c),
      branch(heidi, b),
      different(c, b)]).
step(cousin(judy, ivan),
     rule(19),
     ['X' = judy, 'Y' = ivan, 'G' = 3, 'Bx' = c, 'By' = b],
     [generation(judy, 3),
      generation(ivan, 3),
      branch(judy, c),
      branch(ivan, b),
      different(c, b)]).
