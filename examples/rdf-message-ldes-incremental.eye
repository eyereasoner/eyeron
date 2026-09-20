# Companion to rdf-message-ldes-incremental.n3/.srl: the eye source has
# no RDF Message Log/LDES parser (the envelope replay and checkpoint
# bookkeeping over 40 LDES members are specific to eyeron's N3 parser
# level), so this tests the checkpoint classification and
# priority-repair decision directly. Only 2 representative
# pre-checkpoint members stand in for the N3 source's 34 (the exact
# count is not itself interesting; skipping committed history is), and
# all 6 of the real tail members (sequence 35-40, including the
# genuine doorA open/closed conflict and the safety-controller's
# repair evidence) are kept exactly as in the source's own log.

member(obs033, 33, closed, 1, "hallway-latch").
member(obs034, 34, closed, 1, "hallway-latch").
member(obs035, 35, closed, 1, "hallway-latch").
member(obs036, 36, closed, 1, "hallway-latch").
member(obs037, 37, open, 1, "corridor-camera").
member(obs038, 38, open, 1, "thermal-edge-camera").
member(obs039, 39, closed, 1, "hallway-latch").
member(obs040, 40, closed, 5, "safety-controller").

action_text(open, "dispatch an operator to inspect and close the door").
action_text(closed, "keep the compartment sealed and continue monitoring").

bookmark(34).
window_start(35).

already_committed(?m) if member(?m, ?seq, ?_, ?_, ?_), bookmark(?b), ?seq <= ?b.
newly_emitted(?m) if member(?m, ?seq, ?_, ?_, ?_), bookmark(?b), ?seq > ?b.
in_window(?m) if
    newly_emitted(?m), member(?m, ?seq, ?_, ?_, ?_),
    window_start(?w), ?seq >= ?w.

raw_conflict(doorA) if
    in_window(?m1), member(?m1, ?_, open, ?_, ?_),
    in_window(?m2), member(?m2, ?_, closed, ?_, ?_).

preferred_repair(?m, ?state, ?priority, ?source) if
    in_window(?m), member(?m, ?_, ?state, ?priority, ?source),
    in_window(?other), member(?other, ?_, ?otherState, ?otherPriority, ?_),
    ?state != ?otherState, ?priority > ?otherPriority.

materialized_action(?text) if
    preferred_repair(?_, ?state, ?_, ?_), action_text(?state, ?text).

ask already_committed(?m).
ask newly_emitted(?m).
ask in_window(?m).
ask raw_conflict(?door).
ask preferred_repair(?m, ?state, ?priority, ?source).
ask materialized_action(?text).
