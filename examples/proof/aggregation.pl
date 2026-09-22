% Prolog result format 4
query(1, report(_0, _1), ['Count' = _0, 'Total' = _1]).
result(1, complete, 1).
answer(1, ['Count' = 3, 'Total' = 35]).
why(1, ['Count' = 3, 'Total' = 35], [report(3, 35)]).

clause(1, reading(sensor_a, 10), true).
clause(2, reading(sensor_b, 15), true).
clause(3, reading(sensor_c, 10), true).
clause(4,
       report(var('Count'), var('Total')),
       (findall(reading(var('Sensor'), var('Value')), reading(var('Sensor'), var('Value')), var('Bag1')),
        sort(var('Bag1'), var('Readings')),
        length(var('Readings'), var('Count')),
        total(var('Readings'), var('Total')))).
clause(5, total([], 0), true).
clause(6,
       total([reading(anonymous(1), var('Value'))|var('Rest')], var('Total')),
       (total(var('Rest'), var('Tail')), var('Total') is var('Value') + var('Tail'))).

step(report(3, 35),
     rule(4),
     ['Count' = 3,
      'Total' = 35,
      'Sensor' = _0,
      'Value' = _1,
      'Bag1' = [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)],
      'Readings' = [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)]],
     [findall(reading(_2, _3), reading(_2, _3), [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)]),
      sort([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)]),
      length([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 3),
      total([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 35)]).
step(findall(reading(_0, _1), reading(_0, _1), [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)]),
     collected,
     [],
     [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)]).
step(reading(sensor_a, 10), fact(1), [], []).
step(reading(sensor_b, 15), fact(2), [], []).
step(reading(sensor_c, 10), fact(3), [], []).
step(sort([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)]),
     builtin,
     [],
     []).
step(length([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 3),
     builtin,
     [],
     []).
step(total([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 35),
     rule(6),
     ['Value' = 10,
      'Rest' = [reading(sensor_b, 15), reading(sensor_c, 10)],
      'Total' = 35,
      'Tail' = 25],
     [total([reading(sensor_b, 15), reading(sensor_c, 10)], 25), 35 is 10 + 25]).
step(total([reading(sensor_b, 15), reading(sensor_c, 10)], 25),
     rule(6),
     ['Value' = 15, 'Rest' = [reading(sensor_c, 10)], 'Total' = 25, 'Tail' = 10],
     [total([reading(sensor_c, 10)], 10), 25 is 15 + 10]).
step(total([reading(sensor_c, 10)], 10),
     rule(6),
     ['Value' = 10, 'Rest' = [], 'Total' = 10, 'Tail' = 0],
     [total([], 0), 10 is 10 + 0]).
step(total([], 0), fact(5), [], []).
step(10 is 10 + 0, builtin, [], []).
step(25 is 15 + 10, builtin, [], []).
step(35 is 10 + 25, builtin, [], []).
