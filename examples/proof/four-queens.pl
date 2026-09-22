% Prolog result format 4
query(1, place(4, 4, [], _0), ['Rows' = _0]).
result(1, complete, 2).
answer(1, ['Rows' = [3, 1, 4, 2]]).
why(1, ['Rows' = [3, 1, 4, 2]], [place(4, 4, [], [3, 1, 4, 2])]).
answer(1, ['Rows' = [2, 4, 1, 3]]).
why(1, ['Rows' = [2, 4, 1, 3]], [place(4, 4, [], [2, 4, 1, 3])]).

clause(1, safe(anonymous(1), [], anonymous(2)), true).
clause(2,
       safe(var('Row'), [var('Other')|var('Rest')], var('Distance')),
       (var('Row') \== var('Other'),
        var('Delta') is abs(var('Row') - var('Other')),
        var('Delta') \== var('Distance'),
        var('Next') is var('Distance') + 1,
        safe(var('Row'), var('Rest'), var('Next')))).
clause(3, place(0, anonymous(1), var('Placed'), var('Placed')), true).
clause(4,
       place(var('Remaining'), var('Size'), var('Placed'), var('Rows')),
       (var('Remaining') > 0,
        between(1, var('Size'), var('Row')),
        safe(var('Row'), var('Placed'), 1),
        var('Next') is var('Remaining') - 1,
        place(var('Next'), var('Size'), [var('Row')|var('Placed')], var('Rows')))).

step(place(4, 4, [], [3, 1, 4, 2]),
     rule(4),
     ['Remaining' = 4, 'Size' = 4, 'Placed' = [], 'Rows' = [3, 1, 4, 2], 'Row' = 2, 'Next' = 3],
     [4 > 0, between(1, 4, 2), safe(2, [], 1), 3 is 4 - 1, place(3, 4, [2], [3, 1, 4, 2])]).
step(4 > 0, builtin, [], []).
step(between(1, 4, 2), builtin, [], []).
step(safe(2, [], 1), fact(1), [], []).
step(3 is 4 - 1, builtin, [], []).
step(place(3, 4, [2], [3, 1, 4, 2]),
     rule(4),
     ['Remaining' = 3, 'Size' = 4, 'Placed' = [2], 'Rows' = [3, 1, 4, 2], 'Row' = 4, 'Next' = 2],
     [3 > 0, between(1, 4, 4), safe(4, [2], 1), 2 is 3 - 1, place(2, 4, [4, 2], [3, 1, 4, 2])]).
step(3 > 0, builtin, [], []).
step(between(1, 4, 4), builtin, [], []).
step(safe(4, [2], 1),
     rule(2),
     ['Row' = 4, 'Other' = 2, 'Rest' = [], 'Distance' = 1, 'Delta' = 2, 'Next' = 2],
     [4 \== 2, 2 is abs(4 - 2), 2 \== 1, 2 is 1 + 1, safe(4, [], 2)]).
step(4 \== 2, builtin, [], []).
step(2 is abs(4 - 2), builtin, [], []).
step(2 \== 1, builtin, [], []).
step(2 is 1 + 1, builtin, [], []).
step(safe(4, [], 2), fact(1), [], []).
step(2 is 3 - 1, builtin, [], []).
step(place(2, 4, [4, 2], [3, 1, 4, 2]),
     rule(4),
     ['Remaining' = 2,
      'Size' = 4,
      'Placed' = [4, 2],
      'Rows' = [3, 1, 4, 2],
      'Row' = 1,
      'Next' = 1],
     [2 > 0,
      between(1, 4, 1),
      safe(1, [4, 2], 1),
      1 is 2 - 1,
      place(1, 4, [1, 4, 2], [3, 1, 4, 2])]).
step(2 > 0, builtin, [], []).
step(between(1, 4, 1), builtin, [], []).
step(safe(1, [4, 2], 1),
     rule(2),
     ['Row' = 1, 'Other' = 4, 'Rest' = [2], 'Distance' = 1, 'Delta' = 3, 'Next' = 2],
     [1 \== 4, 3 is abs(1 - 4), 3 \== 1, 2 is 1 + 1, safe(1, [2], 2)]).
step(1 \== 4, builtin, [], []).
step(3 is abs(1 - 4), builtin, [], []).
step(3 \== 1, builtin, [], []).
step(safe(1, [2], 2),
     rule(2),
     ['Row' = 1, 'Other' = 2, 'Rest' = [], 'Distance' = 2, 'Delta' = 1, 'Next' = 3],
     [1 \== 2, 1 is abs(1 - 2), 1 \== 2, 3 is 2 + 1, safe(1, [], 3)]).
step(1 \== 2, builtin, [], []).
step(1 is abs(1 - 2), builtin, [], []).
step(3 is 2 + 1, builtin, [], []).
step(safe(1, [], 3), fact(1), [], []).
step(1 is 2 - 1, builtin, [], []).
step(place(1, 4, [1, 4, 2], [3, 1, 4, 2]),
     rule(4),
     ['Remaining' = 1,
      'Size' = 4,
      'Placed' = [1, 4, 2],
      'Rows' = [3, 1, 4, 2],
      'Row' = 3,
      'Next' = 0],
     [1 > 0,
      between(1, 4, 3),
      safe(3, [1, 4, 2], 1),
      0 is 1 - 1,
      place(0, 4, [3, 1, 4, 2], [3, 1, 4, 2])]).
step(1 > 0, builtin, [], []).
step(between(1, 4, 3), builtin, [], []).
step(safe(3, [1, 4, 2], 1),
     rule(2),
     ['Row' = 3, 'Other' = 1, 'Rest' = [4, 2], 'Distance' = 1, 'Delta' = 2, 'Next' = 2],
     [3 \== 1, 2 is abs(3 - 1), 2 \== 1, 2 is 1 + 1, safe(3, [4, 2], 2)]).
step(2 is abs(3 - 1), builtin, [], []).
step(safe(3, [4, 2], 2),
     rule(2),
     ['Row' = 3, 'Other' = 4, 'Rest' = [2], 'Distance' = 2, 'Delta' = 1, 'Next' = 3],
     [3 \== 4, 1 is abs(3 - 4), 1 \== 2, 3 is 2 + 1, safe(3, [2], 3)]).
step(3 \== 4, builtin, [], []).
step(1 is abs(3 - 4), builtin, [], []).
step(safe(3, [2], 3),
     rule(2),
     ['Row' = 3, 'Other' = 2, 'Rest' = [], 'Distance' = 3, 'Delta' = 1, 'Next' = 4],
     [3 \== 2, 1 is abs(3 - 2), 1 \== 3, 4 is 3 + 1, safe(3, [], 4)]).
step(3 \== 2, builtin, [], []).
step(1 is abs(3 - 2), builtin, [], []).
step(1 \== 3, builtin, [], []).
step(4 is 3 + 1, builtin, [], []).
step(safe(3, [], 4), fact(1), [], []).
step(0 is 1 - 1, builtin, [], []).
step(place(0, 4, [3, 1, 4, 2], [3, 1, 4, 2]), fact(3), ['Placed' = [3, 1, 4, 2]], []).
step(place(4, 4, [], [2, 4, 1, 3]),
     rule(4),
     ['Remaining' = 4, 'Size' = 4, 'Placed' = [], 'Rows' = [2, 4, 1, 3], 'Row' = 3, 'Next' = 3],
     [4 > 0, between(1, 4, 3), safe(3, [], 1), 3 is 4 - 1, place(3, 4, [3], [2, 4, 1, 3])]).
step(safe(3, [], 1), fact(1), [], []).
step(place(3, 4, [3], [2, 4, 1, 3]),
     rule(4),
     ['Remaining' = 3, 'Size' = 4, 'Placed' = [3], 'Rows' = [2, 4, 1, 3], 'Row' = 1, 'Next' = 2],
     [3 > 0, between(1, 4, 1), safe(1, [3], 1), 2 is 3 - 1, place(2, 4, [1, 3], [2, 4, 1, 3])]).
step(safe(1, [3], 1),
     rule(2),
     ['Row' = 1, 'Other' = 3, 'Rest' = [], 'Distance' = 1, 'Delta' = 2, 'Next' = 2],
     [1 \== 3, 2 is abs(1 - 3), 2 \== 1, 2 is 1 + 1, safe(1, [], 2)]).
step(2 is abs(1 - 3), builtin, [], []).
step(safe(1, [], 2), fact(1), [], []).
step(place(2, 4, [1, 3], [2, 4, 1, 3]),
     rule(4),
     ['Remaining' = 2,
      'Size' = 4,
      'Placed' = [1, 3],
      'Rows' = [2, 4, 1, 3],
      'Row' = 4,
      'Next' = 1],
     [2 > 0,
      between(1, 4, 4),
      safe(4, [1, 3], 1),
      1 is 2 - 1,
      place(1, 4, [4, 1, 3], [2, 4, 1, 3])]).
step(safe(4, [1, 3], 1),
     rule(2),
     ['Row' = 4, 'Other' = 1, 'Rest' = [3], 'Distance' = 1, 'Delta' = 3, 'Next' = 2],
     [4 \== 1, 3 is abs(4 - 1), 3 \== 1, 2 is 1 + 1, safe(4, [3], 2)]).
step(4 \== 1, builtin, [], []).
step(3 is abs(4 - 1), builtin, [], []).
step(safe(4, [3], 2),
     rule(2),
     ['Row' = 4, 'Other' = 3, 'Rest' = [], 'Distance' = 2, 'Delta' = 1, 'Next' = 3],
     [4 \== 3, 1 is abs(4 - 3), 1 \== 2, 3 is 2 + 1, safe(4, [], 3)]).
step(4 \== 3, builtin, [], []).
step(1 is abs(4 - 3), builtin, [], []).
step(safe(4, [], 3), fact(1), [], []).
step(place(1, 4, [4, 1, 3], [2, 4, 1, 3]),
     rule(4),
     ['Remaining' = 1,
      'Size' = 4,
      'Placed' = [4, 1, 3],
      'Rows' = [2, 4, 1, 3],
      'Row' = 2,
      'Next' = 0],
     [1 > 0,
      between(1, 4, 2),
      safe(2, [4, 1, 3], 1),
      0 is 1 - 1,
      place(0, 4, [2, 4, 1, 3], [2, 4, 1, 3])]).
step(safe(2, [4, 1, 3], 1),
     rule(2),
     ['Row' = 2, 'Other' = 4, 'Rest' = [1, 3], 'Distance' = 1, 'Delta' = 2, 'Next' = 2],
     [2 \== 4, 2 is abs(2 - 4), 2 \== 1, 2 is 1 + 1, safe(2, [1, 3], 2)]).
step(2 \== 4, builtin, [], []).
step(2 is abs(2 - 4), builtin, [], []).
step(safe(2, [1, 3], 2),
     rule(2),
     ['Row' = 2, 'Other' = 1, 'Rest' = [3], 'Distance' = 2, 'Delta' = 1, 'Next' = 3],
     [2 \== 1, 1 is abs(2 - 1), 1 \== 2, 3 is 2 + 1, safe(2, [3], 3)]).
step(1 is abs(2 - 1), builtin, [], []).
step(safe(2, [3], 3),
     rule(2),
     ['Row' = 2, 'Other' = 3, 'Rest' = [], 'Distance' = 3, 'Delta' = 1, 'Next' = 4],
     [2 \== 3, 1 is abs(2 - 3), 1 \== 3, 4 is 3 + 1, safe(2, [], 4)]).
step(2 \== 3, builtin, [], []).
step(1 is abs(2 - 3), builtin, [], []).
step(safe(2, [], 4), fact(1), [], []).
step(place(0, 4, [2, 4, 1, 3], [2, 4, 1, 3]), fact(3), ['Placed' = [2, 4, 1, 3]], []).
