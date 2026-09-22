% Prolog result format 4
query(1, indeed_more_interesting(_0, _1), ['X' = _0, 'Y' = _1]).
result(1, complete, 1).
answer(1, ['X' = five, 'Y' = three]).
why(1, ['X' = five, 'Y' = three], [indeed_more_interesting(five, three)]).

clause(1, value(five, 5), true).
clause(2, value(three, 3), true).
clause(3,
       more_interesting(var('X'), var('Y')),
       (value(var('X'), var('Left')), value(var('Y'), var('Right')), var('Left') > var('Right'))).
clause(4, indeed_more_interesting(var('X'), var('Y')), more_interesting(var('X'), var('Y'))).

step(indeed_more_interesting(five, three),
     rule(4),
     ['X' = five, 'Y' = three],
     [more_interesting(five, three)]).
step(more_interesting(five, three),
     rule(3),
     ['X' = five, 'Y' = three, 'Left' = 5, 'Right' = 3],
     [value(five, 5), value(three, 3), 5 > 3]).
step(value(five, 5), fact(1), [], []).
step(value(three, 3), fact(2), [], []).
step(5 > 3, builtin, [], []).
