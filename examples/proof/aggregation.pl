% Prolog result format 3
query(1, report(_0, _1), ['Count' = _0, 'Total' = _1]).
result(1, complete, 1).
answer(1, ['Count' = 3, 'Total' = 35]).
why(1, ['Count' = 3, 'Total' = 35], 18).
clause(1, reading(sensor_a, 10), true).
clause(2, reading(sensor_b, 15), true).
clause(3, reading(sensor_c, 10), true).
clause(4, report(var('Count'), var('Total')), (findall(reading(var('Sensor'), var('Value')), reading(var('Sensor'), var('Value')), var('Bag1')), sort(var('Bag1'), var('Readings')), length(var('Readings'), var('Count')), total(var('Readings'), var('Total')))).
clause(5, total([], 0), true).
clause(6, total([reading(anonymous(1), var('Value'))|var('Rest')], var('Total')), (total(var('Rest'), var('Tail')), var('Total') is var('Value') + var('Tail'))).
substitution(1, []).
proof(1, reading(sensor_a, 10), rule(1), []).
substitution(2, []).
proof(2, reading(sensor_b, 15), rule(2), []).
substitution(3, []).
proof(3, reading(sensor_c, 10), rule(3), []).
substitution(4, ['Sensor' = sensor_a, 'Value' = 10]).
proof(4, solution([reading(sensor_a, 10)]), query, [uses(1, reading(sensor_a, 10))]).
substitution(5, ['Sensor' = sensor_b, 'Value' = 15]).
proof(5, solution([reading(sensor_b, 15)]), query, [uses(2, reading(sensor_b, 15))]).
substitution(6, ['Sensor' = sensor_c, 'Value' = 10]).
proof(6, solution([reading(sensor_c, 10)]), query, [uses(3, reading(sensor_c, 10))]).
substitution(7, []).
proof(7, total([], 0), rule(5), []).
substitution(8, ['Value' = 10, 'Rest' = [], 'Total' = 10, 'Tail' = 0]).
proof(8, total([reading(sensor_c, 10)], 10), rule(6), [uses(7, total([], 0)), builtin(10 is 10 + 0)]).
substitution(9, ['Value' = 15, 'Rest' = [reading(sensor_c, 10)], 'Total' = 25, 'Tail' = 10]).
proof(9, total([reading(sensor_b, 15), reading(sensor_c, 10)], 25), rule(6), [uses(8, total([reading(sensor_c, 10)], 10)), builtin(25 is 15 + 10)]).
substitution(10, ['Value' = 10, 'Rest' = [reading(sensor_b, 15), reading(sensor_c, 10)], 'Total' = 35, 'Tail' = 25]).
proof(10, total([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 35), rule(6), [uses(9, total([reading(sensor_b, 15), reading(sensor_c, 10)], 25)), builtin(35 is 10 + 25)]).
substitution(11, []).
proof(11, reading(sensor_a, 10), rule(1), []).
substitution(12, []).
proof(12, reading(sensor_b, 15), rule(2), []).
substitution(13, []).
proof(13, reading(sensor_c, 10), rule(3), []).
substitution(14, ['Sensor' = sensor_a, 'Value' = 10]).
proof(14, solution([reading(sensor_a, 10)]), query, [uses(11, reading(sensor_a, 10))]).
substitution(15, ['Sensor' = sensor_b, 'Value' = 15]).
proof(15, solution([reading(sensor_b, 15)]), query, [uses(12, reading(sensor_b, 15))]).
substitution(16, ['Sensor' = sensor_c, 'Value' = 10]).
proof(16, solution([reading(sensor_c, 10)]), query, [uses(13, reading(sensor_c, 10))]).
substitution(17, ['Count' = 3, 'Total' = 35, 'Sensor' = _0, 'Value' = _1, 'Bag1' = [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 'Readings' = [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)]]).
proof(17, report(3, 35), rule(4), [collected([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], reading(_0, _1), reading(_0, _1), [14, 15, 16], complete), builtin(sort([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)])), builtin(length([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 3)), uses(10, total([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 35))]).
substitution(18, ['Count' = 3, 'Total' = 35]).
proof(18, solution([3, 35]), query, [uses(17, report(3, 35))]).
