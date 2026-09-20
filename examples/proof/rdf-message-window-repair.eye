# Eyelang result format 2
query(1, [call(raw_conflict(?v0))], [binding("door", ?v0)]).
result(1, complete, 1).
answer(1, [binding("door", doorA)]).
why(1, [binding("door", doorA)], 5).
query(2, [call(preferred_repair(?v0, ?v1, ?v2, ?v3))], [binding("evidence", ?v0), binding("state", ?v1), binding("priority", ?v2), binding("source", ?v3)]).
result(2, complete, 1).
answer(2, [binding("evidence", reading004), binding("state", closed), binding("priority", 3), binding("source", "safety-controller")]).
why(2, [binding("evidence", reading004), binding("state", closed), binding("priority", 3), binding("source", "safety-controller")], 10).
query(3, [call(materialized_action(?v0))], [binding("text", ?v0)]).
result(3, complete, 1).
answer(3, [binding("text", "mark the fire compartment as sealed")]).
why(3, [binding("text", "mark the fire compartment as sealed")], 17).
clause(1, door_reading(reading002, doorA, open, 1, "corridor-camera"), []).
clause(2, door_reading(reading003, doorA, closed, 1, "hallway-latch"), []).
clause(3, door_reading(reading004, doorA, closed, 3, "safety-controller"), []).
clause(5, action_text(closed, "mark the fire compartment as sealed"), []).
clause(6, raw_conflict(var("door")), [call(door_reading(var("r1"), var("door"), open, anonymous(1), anonymous(2))), call(door_reading(var("r2"), var("door"), closed, anonymous(3), anonymous(4)))]).
clause(7, preferred_repair(var("preferred"), var("state"), var("priority"), var("source")), [call(door_reading(var("preferred"), doorA, var("state"), var("priority"), var("source"))), call(door_reading(var("rejected"), doorA, var("rejectedState"), var("rejectedPriority"), anonymous(1))), compare("!=", var("state"), var("rejectedState")), compare(">", var("priority"), var("rejectedPriority"))]).
clause(8, materialized_action(var("text")), [call(preferred_repair(anonymous(1), var("state"), anonymous(2), anonymous(3))), call(action_text(var("state"), var("text")))]).
substitution(1, []).
proof(1, door_reading(reading002, doorA, open, 1, "corridor-camera"), rule(1), []).
substitution(2, []).
proof(2, door_reading(reading003, doorA, closed, 1, "hallway-latch"), rule(2), []).
substitution(3, []).
proof(3, door_reading(reading004, doorA, closed, 3, "safety-controller"), rule(3), []).
substitution(4, [binding("door", doorA), binding("r1", reading002), binding("r2", reading003)]).
proof(4, raw_conflict(doorA), rule(6), [uses(1, door_reading(reading002, doorA, open, 1, "corridor-camera")), uses(2, door_reading(reading003, doorA, closed, 1, "hallway-latch"))]).
substitution(5, [binding("door", doorA)]).
proof(5, solution([doorA]), query, [uses(4, raw_conflict(doorA))]).
substitution(6, []).
proof(6, door_reading(reading002, doorA, open, 1, "corridor-camera"), rule(1), []).
substitution(7, []).
proof(7, door_reading(reading003, doorA, closed, 1, "hallway-latch"), rule(2), []).
substitution(8, []).
proof(8, door_reading(reading004, doorA, closed, 3, "safety-controller"), rule(3), []).
substitution(9, [binding("preferred", reading004), binding("state", closed), binding("priority", 3), binding("source", "safety-controller"), binding("rejected", reading002), binding("rejectedState", open), binding("rejectedPriority", 1)]).
proof(9, preferred_repair(reading004, closed, 3, "safety-controller"), rule(7), [uses(8, door_reading(reading004, doorA, closed, 3, "safety-controller")), uses(6, door_reading(reading002, doorA, open, 1, "corridor-camera")), compared("!=", closed, open), compared(">", 3, 1)]).
substitution(10, [binding("evidence", reading004), binding("state", closed), binding("priority", 3), binding("source", "safety-controller")]).
proof(10, solution([reading004, closed, 3, "safety-controller"]), query, [uses(9, preferred_repair(reading004, closed, 3, "safety-controller"))]).
substitution(11, []).
proof(11, door_reading(reading002, doorA, open, 1, "corridor-camera"), rule(1), []).
substitution(12, []).
proof(12, door_reading(reading003, doorA, closed, 1, "hallway-latch"), rule(2), []).
substitution(13, []).
proof(13, door_reading(reading004, doorA, closed, 3, "safety-controller"), rule(3), []).
substitution(14, [binding("preferred", reading004), binding("state", closed), binding("priority", 3), binding("source", "safety-controller"), binding("rejected", reading002), binding("rejectedState", open), binding("rejectedPriority", 1)]).
proof(14, preferred_repair(reading004, closed, 3, "safety-controller"), rule(7), [uses(13, door_reading(reading004, doorA, closed, 3, "safety-controller")), uses(11, door_reading(reading002, doorA, open, 1, "corridor-camera")), compared("!=", closed, open), compared(">", 3, 1)]).
substitution(15, []).
proof(15, action_text(closed, "mark the fire compartment as sealed"), rule(5), []).
substitution(16, [binding("text", "mark the fire compartment as sealed"), binding("state", closed)]).
proof(16, materialized_action("mark the fire compartment as sealed"), rule(8), [uses(14, preferred_repair(reading004, closed, 3, "safety-controller")), uses(15, action_text(closed, "mark the fire compartment as sealed"))]).
substitution(17, [binding("text", "mark the fire compartment as sealed")]).
proof(17, solution(["mark the fire compartment as sealed"]), query, [uses(16, materialized_action("mark the fire compartment as sealed"))]).
