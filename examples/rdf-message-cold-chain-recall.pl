% Companion to rdf-message-cold-chain-recall.n3/.srl: the eye source has
% no RDF Message Log/LDES parser (the envelope replay and checkpoint
% bookkeeping over 48 telemetry members are specific to eyeron's N3
% parser level), so this tests the checkpoint classification and
% calibrated-logger repair decision directly. Only 3 representative
% pre-checkpoint members stand in for the N3 source's 42 (the exact
% count is not itself interesting; skipping committed history is), and
% all 6 of the real tail members (sequence 43-48, including the
% genuine batchA conflict and the calibrated logger's repair evidence)
% are kept exactly as in the source's own telemetry log.

member(obs040, 40, 42, 1, "dock-sensor", false).
member(obs041, 41, 43, 1, "warehouse-reader", false).
member(obs042, 42, 44, 1, "truck-gateway", false).
member(obs043, 43, 45, 1, "truck-gateway", false).
member(obs044, 44, 46, 1, "dock-sensor", false).
member(obs045, 45, 47, 1, "warehouse-reader", false).
member(obs046, 46, 121, 2, "truck-gateway", false).
member(obs047, 47, 118, 5, "calibrated-cold-chain-logger", true).
member(obs048, 48, 44, 1, "door-proximity-sensor", false).

bookmark(42).
window_start(43).
limit_tenths_c(80).

already_committed(M) :-
    member(M, Seq, _, _, _, _),
    bookmark(B),
    Seq =< B.
newly_emitted(M) :-
    member(M, Seq, _, _, _, _),
    bookmark(B),
    Seq > B.

in_window(M) :-
    newly_emitted(M),
    member(M, Seq, _, _, _, _),
    window_start(W),
    Seq >= W.

raw_conflict(batchA) :-
    in_window(M1),
    member(M1, _, T1, _, _, _),
    limit_tenths_c(Limit),
    T1 =< Limit,
    in_window(M2),
    member(M2, _, T2, _, _, _),
    T2 > Limit.

preferred_repair(M, Temp, Priority, Source) :-
    in_window(M),
    member(M, _, Temp, Priority, Source, true),
    limit_tenths_c(Limit),
    Temp > Limit.

quarantine_decision("quarantine batchA, notify QA, and hold shipment") :-
    preferred_repair(_, _, _, _).

?- already_committed(M).
?- newly_emitted(M).
?- in_window(M).
?- raw_conflict(Batch).
?- preferred_repair(M, Temp, Priority, Source).
?- quarantine_decision(Text).
