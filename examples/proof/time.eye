# Eyelang result format 2
query(1, [call(out(?v0, ?v1, ?v2, ?v3, ?v4, ?v5))], [binding("y", ?v0), binding("m", ?v1), binding("d", ?v2), binding("min", ?v3), binding("sec", ?v4), binding("tz", ?v5)]).
result(1, complete, 1).
answer(1, [binding("y", 2023), binding("m", 4), binding("d", 1), binding("min", 6), binding("sec", 4), binding("tz", "Z")]).
why(1, [binding("y", 2023), binding("m", 4), binding("d", 1), binding("min", 6), binding("sec", 4), binding("tz", "Z")], 3).
clause(1, dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")), []).
clause(2, out(var("y"), var("m"), var("d"), var("min"), var("sec"), var("tz")), [call(dt(letv, datetime(var("y"), var("m"), var("d"), var("h"), var("min"), var("sec"), var("tz"))))]).
substitution(1, []).
proof(1, dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")), rule(1), []).
substitution(2, [binding("y", 2023), binding("m", 4), binding("d", 1), binding("min", 6), binding("sec", 4), binding("tz", "Z"), binding("h", 18)]).
proof(2, out(2023, 4, 1, 6, 4, "Z"), rule(2), [uses(1, dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")))]).
substitution(3, [binding("y", 2023), binding("m", 4), binding("d", 1), binding("min", 6), binding("sec", 4), binding("tz", "Z")]).
proof(3, solution([2023, 4, 1, 6, 4, "Z"]), query, [uses(2, out(2023, 4, 1, 6, 4, "Z"))]).
