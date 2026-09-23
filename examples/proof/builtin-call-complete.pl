summary(3.7, 3.0, 3, [-3.7, 2, 7]).

clause(1, numbers([-3.7, 7, 2]), true).
clause(2,
       summary(var('Absolute'), var('Root'), var('Count'), var('Sorted')),
       (numbers(var('Values')),
        var('Absolute') is abs(- 3.7),
        var('Root') is sqrt(9),
        length(var('Values'), var('Count')),
        sort(var('Values'), var('Sorted')))).

step(summary(3.7, 3.0, 3, [-3.7, 2, 7]),
     rule(2),
     ['Absolute' = 3.7,
      'Root' = 3.0,
      'Count' = 3,
      'Sorted' = [-3.7, 2, 7],
      'Values' = [-3.7, 7, 2]],
     [numbers([-3.7, 7, 2]),
      3.7 is abs(- 3.7),
      3.0 is sqrt(9),
      length([-3.7, 7, 2], 3),
      sort([-3.7, 7, 2], [-3.7, 2, 7])]).
step(numbers([-3.7, 7, 2]), fact(1), [], []).
step(3.7 is abs(- 3.7), builtin, [], []).
step(3.0 is sqrt(9), builtin, [], []).
step(length([-3.7, 7, 2], 3), builtin, [], []).
step(sort([-3.7, 7, 2], [-3.7, 2, 7]), builtin, [], []).
