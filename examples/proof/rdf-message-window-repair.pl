% Prolog result format 3
query(1, raw_conflict(_0), ['Door' = _0]).
result(1, complete, 1).
answer(1, ['Door' = doorA]).
why(1, ['Door' = doorA], 5).
query(2, preferred_repair(_0, _1, _2, _3), ['Evidence' = _0, 'State' = _1, 'Priority' = _2, 'Source' = _3]).
result(2, complete, 1).
answer(2, ['Evidence' = reading004, 'State' = closed, 'Priority' = 3, 'Source' = "safety-controller"]).
why(2, ['Evidence' = reading004, 'State' = closed, 'Priority' = 3, 'Source' = "safety-controller"], 10).
query(3, materialized_action(_0), ['Text' = _0]).
result(3, complete, 1).
answer(3, ['Text' = "mark the fire compartment as sealed"]).
why(3, ['Text' = "mark the fire compartment as sealed"], 17).
clause(1, door_reading(reading002, doorA, open, 1, "corridor-camera"), true).
clause(2, door_reading(reading003, doorA, closed, 1, "hallway-latch"), true).
clause(3, door_reading(reading004, doorA, closed, 3, "safety-controller"), true).
clause(5, action_text(closed, "mark the fire compartment as sealed"), true).
clause(6, raw_conflict(var('Door')), (door_reading(var('R1'), var('Door'), open, anonymous(1), anonymous(2)), door_reading(var('R2'), var('Door'), closed, anonymous(3), anonymous(4)))).
clause(7, preferred_repair(var('Preferred'), var('State'), var('Priority'), var('Source')), (door_reading(var('Preferred'), doorA, var('State'), var('Priority'), var('Source')), door_reading(var('Rejected'), doorA, var('RejectedState'), var('RejectedPriority'), anonymous(1)), var('State') \== var('RejectedState'), var('Priority') > var('RejectedPriority'))).
clause(8, materialized_action(var('Text')), (preferred_repair(anonymous(1), var('State'), anonymous(2), anonymous(3)), action_text(var('State'), var('Text')))).
substitution(1, []).
proof(1, door_reading(reading002, doorA, open, 1, "corridor-camera"), rule(1), []).
substitution(2, []).
proof(2, door_reading(reading003, doorA, closed, 1, "hallway-latch"), rule(2), []).
substitution(3, []).
proof(3, door_reading(reading004, doorA, closed, 3, "safety-controller"), rule(3), []).
substitution(4, ['Door' = doorA, 'R1' = reading002, 'R2' = reading003]).
proof(4, raw_conflict(doorA), rule(6), [uses(1, door_reading(reading002, doorA, open, 1, "corridor-camera")), uses(2, door_reading(reading003, doorA, closed, 1, "hallway-latch"))]).
substitution(5, ['Door' = doorA]).
proof(5, solution([doorA]), query, [uses(4, raw_conflict(doorA))]).
substitution(6, []).
proof(6, door_reading(reading002, doorA, open, 1, "corridor-camera"), rule(1), []).
substitution(7, []).
proof(7, door_reading(reading003, doorA, closed, 1, "hallway-latch"), rule(2), []).
substitution(8, []).
proof(8, door_reading(reading004, doorA, closed, 3, "safety-controller"), rule(3), []).
substitution(9, ['Preferred' = reading004, 'State' = closed, 'Priority' = 3, 'Source' = "safety-controller", 'Rejected' = reading002, 'RejectedState' = open, 'RejectedPriority' = 1]).
proof(9, preferred_repair(reading004, closed, 3, "safety-controller"), rule(7), [uses(8, door_reading(reading004, doorA, closed, 3, "safety-controller")), uses(6, door_reading(reading002, doorA, open, 1, "corridor-camera")), builtin(closed \== open), builtin(3 > 1)]).
substitution(10, ['Evidence' = reading004, 'State' = closed, 'Priority' = 3, 'Source' = "safety-controller"]).
proof(10, solution([reading004, closed, 3, "safety-controller"]), query, [uses(9, preferred_repair(reading004, closed, 3, "safety-controller"))]).
substitution(11, []).
proof(11, door_reading(reading002, doorA, open, 1, "corridor-camera"), rule(1), []).
substitution(12, []).
proof(12, door_reading(reading003, doorA, closed, 1, "hallway-latch"), rule(2), []).
substitution(13, []).
proof(13, door_reading(reading004, doorA, closed, 3, "safety-controller"), rule(3), []).
substitution(14, ['Preferred' = reading004, 'State' = closed, 'Priority' = 3, 'Source' = "safety-controller", 'Rejected' = reading002, 'RejectedState' = open, 'RejectedPriority' = 1]).
proof(14, preferred_repair(reading004, closed, 3, "safety-controller"), rule(7), [uses(13, door_reading(reading004, doorA, closed, 3, "safety-controller")), uses(11, door_reading(reading002, doorA, open, 1, "corridor-camera")), builtin(closed \== open), builtin(3 > 1)]).
substitution(15, []).
proof(15, action_text(closed, "mark the fire compartment as sealed"), rule(5), []).
substitution(16, ['Text' = "mark the fire compartment as sealed", 'State' = closed]).
proof(16, materialized_action("mark the fire compartment as sealed"), rule(8), [uses(14, preferred_repair(reading004, closed, 3, "safety-controller")), uses(15, action_text(closed, "mark the fire compartment as sealed"))]).
substitution(17, ['Text' = "mark the fire compartment as sealed"]).
proof(17, solution(["mark the fire compartment as sealed"]), query, [uses(16, materialized_action("mark the fire compartment as sealed"))]).
