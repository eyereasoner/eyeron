raw_conflict(doorA).
preferred_repair(reading004, closed, 3, "safety-controller").
materialized_action("mark the fire compartment as sealed").

clause(1, door_reading(reading002, doorA, open, 1, "corridor-camera"), true).
clause(2, door_reading(reading003, doorA, closed, 1, "hallway-latch"), true).
clause(3, door_reading(reading004, doorA, closed, 3, "safety-controller"), true).
clause(5, action_text(closed, "mark the fire compartment as sealed"), true).
clause(6,
       raw_conflict(var('Door')),
       (door_reading(var('R1'), var('Door'), open, anonymous(1), anonymous(2)),
        door_reading(var('R2'), var('Door'), closed, anonymous(3), anonymous(4)))).
clause(7,
       preferred_repair(var('Preferred'), var('State'), var('Priority'), var('Source')),
       (door_reading(var('Preferred'), doorA, var('State'), var('Priority'), var('Source')),
        door_reading(var('Rejected'), doorA, var('RejectedState'), var('RejectedPriority'), anonymous(1)),
        var('State') \== var('RejectedState'),
        var('Priority') > var('RejectedPriority'))).
clause(8,
       materialized_action(var('Text')),
       (preferred_repair(anonymous(1), var('State'), anonymous(2), anonymous(3)),
        action_text(var('State'), var('Text')))).

step(raw_conflict(doorA),
     rule(6),
     ['Door' = doorA, 'R1' = reading002, 'R2' = reading003],
     [door_reading(reading002, doorA, open, 1, "corridor-camera"),
      door_reading(reading003, doorA, closed, 1, "hallway-latch")]).
step(door_reading(reading002, doorA, open, 1, "corridor-camera"), fact(1), [], []).
step(door_reading(reading003, doorA, closed, 1, "hallway-latch"), fact(2), [], []).
step(preferred_repair(reading004, closed, 3, "safety-controller"),
     rule(7),
     ['Preferred' = reading004,
      'State' = closed,
      'Priority' = 3,
      'Source' = "safety-controller",
      'Rejected' = reading002,
      'RejectedState' = open,
      'RejectedPriority' = 1],
     [door_reading(reading004, doorA, closed, 3, "safety-controller"),
      door_reading(reading002, doorA, open, 1, "corridor-camera"),
      closed \== open,
      3 > 1]).
step(door_reading(reading004, doorA, closed, 3, "safety-controller"), fact(3), [], []).
step(closed \== open, builtin, [], []).
step(3 > 1, builtin, [], []).
step(materialized_action("mark the fire compartment as sealed"),
     rule(8),
     ['Text' = "mark the fire compartment as sealed", 'State' = closed],
     [preferred_repair(reading004, closed, 3, "safety-controller"),
      action_text(closed, "mark the fire compartment as sealed")]).
step(action_text(closed, "mark the fire compartment as sealed"), fact(5), [], []).
