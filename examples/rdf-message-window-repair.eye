# Companion to rdf-message-window-repair.n3/.srl: the eye source has no
# RDF Message Log parser (the sliding-window/envelope bookkeeping over
# eymsg: replay is specific to eyeron's N3 parser level), so this tests
# the priority-based repair decision directly: given the three door
# readings that fall inside the current three-message window (the
# fourth, oldest reading having already expired out of it), the
# safety-controller's reading (priority 3) should win over the two
# conflicting priority-1 readings, and the door should be materialized
# as closed.

door_reading(reading002, doorA, open, 1, "corridor-camera").
door_reading(reading003, doorA, closed, 1, "hallway-latch").
door_reading(reading004, doorA, closed, 3, "safety-controller").

action_text(open, "send a technician to inspect and close the fire door").
action_text(closed, "mark the fire compartment as sealed").

raw_conflict(?door) if
    door_reading(?r1, ?door, open, ?_, ?_),
    door_reading(?r2, ?door, closed, ?_, ?_).

preferred_repair(?preferred, ?state, ?priority, ?source) if
    door_reading(?preferred, doorA, ?state, ?priority, ?source),
    door_reading(?rejected, doorA, ?rejectedState, ?rejectedPriority, ?_),
    ?state != ?rejectedState, ?priority > ?rejectedPriority.

materialized_action(?text) if
    preferred_repair(?_, ?state, ?_, ?_), action_text(?state, ?text).

ask raw_conflict(?door).
ask preferred_repair(?evidence, ?state, ?priority, ?source).
ask materialized_action(?text).
