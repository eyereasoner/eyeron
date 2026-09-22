% Companion to rdf-message-ldes-incremental.n3/.srl: the eye source has
% no RDF Message Log/LDES parser (the envelope replay and checkpoint
% bookkeeping over 40 LDES members are specific to eyeron's N3 parser
% level), so this tests the checkpoint classification and
% priority-repair decision directly. Only 2 representative
% pre-checkpoint members stand in for the N3 source's 34 (the exact
% count is not itself interesting; skipping committed history is), and
% all 6 of the real tail members (sequence 35-40, including the
% genuine doorA open/closed conflict and the safety-controller's
% repair evidence) are kept exactly as in the source's own log.

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

already_committed(M) :-
    member(M, Seq, _, _, _),
    bookmark(B),
    Seq =< B.
newly_emitted(M) :-
    member(M, Seq, _, _, _),
    bookmark(B),
    Seq > B.

in_window(M) :-
    newly_emitted(M),
    member(M, Seq, _, _, _),
    window_start(W),
    Seq >= W.

raw_conflict(doorA) :-
    in_window(M1),
    member(M1, _, open, _, _),
    in_window(M2),
    member(M2, _, closed, _, _).

preferred_repair(M, State, Priority, Source) :-
    in_window(M),
    member(M, _, State, Priority, Source),
    in_window(Other),
    member(Other, _, OtherState, OtherPriority, _),
    State \== OtherState,
    Priority > OtherPriority.

materialized_action(Text) :-
    preferred_repair(_, State, _, _),
    action_text(State, Text).

?- already_committed(M).
?- newly_emitted(M).
?- in_window(M).
?- raw_conflict(Door).
?- preferred_repair(M, State, Priority, Source).
?- materialized_action(Text).
