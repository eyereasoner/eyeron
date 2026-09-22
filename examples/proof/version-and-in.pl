% Prolog result format 4
query(1, priority(_0), ['Person' = _0]).
result(1, complete, 2).
answer(1, ['Person' = alice]).
why(1, ['Person' = alice], [priority(alice)]).
answer(1, ['Person' = carol]).
why(1, ['Person' = carol], [priority(carol)]).
query(2, ordinary(_0), ['Person' = _0]).
result(2, complete, 1).
answer(2, ['Person' = bob]).
why(2, ['Person' = bob], [ordinary(bob)]).

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
