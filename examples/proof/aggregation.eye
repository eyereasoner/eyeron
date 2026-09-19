# Eyelang result format 2
query(1, [call(report(?v0, ?v1))], [binding("count", ?v0), binding("total", ?v1)]).
result(1, complete, 1).
answer(1, [binding("count", 3), binding("total", 35)]).
why(1, [binding("count", 3), binding("total", 35)], 18).
clause(1, reading(sensor_a, 10), []).
clause(2, reading(sensor_b, 15), []).
clause(3, reading(sensor_c, 10), []).
clause(4, report(var("count"), var("total")), [collect(var("readings"), reading(var("sensor"), var("value")), [call(reading(var("sensor"), var("value")))]), calculate(var("count"), function("count", [value(var("readings"))])), call(total(var("readings"), var("total")))]).
clause(5, total([], 0), []).
clause(6, total([reading(anonymous(1), var("value")) | var("rest")], var("total")), [call(total(var("rest"), var("tail"))), calculate(var("total"), binary("+", value(var("value")), value(var("tail"))))]).
substitution(1, []).
proof(1, reading(sensor_a, 10), rule(1), []).
substitution(2, []).
proof(2, reading(sensor_b, 15), rule(2), []).
substitution(3, []).
proof(3, reading(sensor_c, 10), rule(3), []).
substitution(4, [binding("sensor", sensor_a), binding("value", 10)]).
proof(4, solution([reading(sensor_a, 10)]), query, [uses(1, reading(sensor_a, 10))]).
substitution(5, [binding("sensor", sensor_b), binding("value", 15)]).
proof(5, solution([reading(sensor_b, 15)]), query, [uses(2, reading(sensor_b, 15))]).
substitution(6, [binding("sensor", sensor_c), binding("value", 10)]).
proof(6, solution([reading(sensor_c, 10)]), query, [uses(3, reading(sensor_c, 10))]).
substitution(7, []).
proof(7, total([], 0), rule(5), []).
substitution(8, [binding("value", 10), binding("rest", []), binding("total", 10), binding("tail", 0)]).
proof(8, total([reading(sensor_c, 10)], 10), rule(6), [uses(7, total([], 0)), calculated(10, binary("+", value(10), value(0)))]).
substitution(9, [binding("value", 15), binding("rest", [reading(sensor_c, 10)]), binding("total", 25), binding("tail", 10)]).
proof(9, total([reading(sensor_b, 15), reading(sensor_c, 10)], 25), rule(6), [uses(8, total([reading(sensor_c, 10)], 10)), calculated(25, binary("+", value(15), value(10)))]).
substitution(10, [binding("value", 10), binding("rest", [reading(sensor_b, 15), reading(sensor_c, 10)]), binding("total", 35), binding("tail", 25)]).
proof(10, total([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 35), rule(6), [uses(9, total([reading(sensor_b, 15), reading(sensor_c, 10)], 25)), calculated(35, binary("+", value(10), value(25)))]).
substitution(11, []).
proof(11, reading(sensor_a, 10), rule(1), []).
substitution(12, []).
proof(12, reading(sensor_b, 15), rule(2), []).
substitution(13, []).
proof(13, reading(sensor_c, 10), rule(3), []).
substitution(14, [binding("sensor", sensor_a), binding("value", 10)]).
proof(14, solution([reading(sensor_a, 10)]), query, [uses(11, reading(sensor_a, 10))]).
substitution(15, [binding("sensor", sensor_b), binding("value", 15)]).
proof(15, solution([reading(sensor_b, 15)]), query, [uses(12, reading(sensor_b, 15))]).
substitution(16, [binding("sensor", sensor_c), binding("value", 10)]).
proof(16, solution([reading(sensor_c, 10)]), query, [uses(13, reading(sensor_c, 10))]).
substitution(17, [binding("count", 3), binding("total", 35), binding("readings", [reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)]), binding("sensor", ?v0), binding("value", ?v1)]).
proof(17, report(3, 35), rule(4), [collected([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], reading(?v0, ?v1), [call(reading(?v0, ?v1))], [14, 15, 16], complete), calculated(3, function("count", [value([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)])])), uses(10, total([reading(sensor_a, 10), reading(sensor_b, 15), reading(sensor_c, 10)], 35))]).
substitution(18, [binding("count", 3), binding("total", 35)]).
proof(18, solution([3, 35]), query, [uses(17, report(3, 35))]).
