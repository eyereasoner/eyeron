priority(alice).
priority(carol).
ordinary(bob).

clause(1, level(alice, gold), true).
clause(2, level(bob, bronze), true).
clause(3, level(carol, platinum), true).
clause(4, priority(var('X')), level(var('X'), gold)).
clause(5, priority(var('X')), level(var('X'), platinum)).
clause(6, ordinary(var('X')), (level(var('X'), var('Level')), \+priority(var('X')))).

step(priority(alice), rule(4), ['X' = alice], [level(alice, gold)]).
step(level(alice, gold), fact(1), [], []).
step(priority(carol), rule(5), ['X' = carol], [level(carol, platinum)]).
step(level(carol, platinum), fact(3), [], []).
step(ordinary(bob),
     rule(6),
     ['X' = bob, 'Level' = bronze],
     [level(bob, bronze), \+priority(bob)]).
step(level(bob, bronze), fact(2), [], []).
step(\+priority(bob), absent, [], []).
