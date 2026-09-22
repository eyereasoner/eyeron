% Companion to rdf-message-window-repair.n3/.srl: the eye source has no
% RDF Message Log parser (the sliding-window/envelope bookkeeping over
% eymsg: replay is specific to eyeron's N3 parser level), so this tests
% the priority-based repair decision directly: given the three door
% readings that fall inside the current three-message window (the
% fourth, oldest reading having already expired out of it), the
% safety-controller's reading (priority 3) should win over the two
% conflicting priority-1 readings, and the door should be materialized
% as closed.

door_reading(reading002, doorA, open, 1, "corridor-camera").
door_reading(reading003, doorA, closed, 1, "hallway-latch").
door_reading(reading004, doorA, closed, 3, "safety-controller").

action_text(open, "send a technician to inspect and close the fire door").
action_text(closed, "mark the fire compartment as sealed").

raw_conflict(Door) :-
    door_reading(R1, Door, open, _, _),
    door_reading(R2, Door, closed, _, _).

preferred_repair(Preferred, State, Priority, Source) :-
    door_reading(Preferred, doorA, State, Priority, Source),
    door_reading(Rejected, doorA, RejectedState, RejectedPriority, _),
    State \== RejectedState,
    Priority > RejectedPriority.

materialized_action(Text) :-
    preferred_repair(_, State, _, _),
    action_text(State, Text).

?- raw_conflict(Door).
?- preferred_repair(Evidence, State, Priority, Source).
?- materialized_action(Text).
