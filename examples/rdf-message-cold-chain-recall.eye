# Companion to rdf-message-cold-chain-recall.n3/.srl: the eye source has
# no RDF Message Log/LDES parser (the envelope replay and checkpoint
# bookkeeping over 48 telemetry members are specific to eyeron's N3
# parser level), so this tests the checkpoint classification and
# calibrated-logger repair decision directly. Only 3 representative
# pre-checkpoint members stand in for the N3 source's 42 (the exact
# count is not itself interesting; skipping committed history is), and
# all 6 of the real tail members (sequence 43-48, including the
# genuine batchA conflict and the calibrated logger's repair evidence)
# are kept exactly as in the source's own telemetry log.

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

already_committed(?m) if member(?m, ?seq, ?_, ?_, ?_, ?_), bookmark(?b), ?seq <= ?b.
newly_emitted(?m) if member(?m, ?seq, ?_, ?_, ?_, ?_), bookmark(?b), ?seq > ?b.

in_window(?m) if
    newly_emitted(?m), member(?m, ?seq, ?_, ?_, ?_, ?_),
    window_start(?w), ?seq >= ?w.

raw_conflict(batchA) if
    in_window(?m1), member(?m1, ?_, ?t1, ?_, ?_, ?_), limit_tenths_c(?limit), ?t1 <= ?limit,
    in_window(?m2), member(?m2, ?_, ?t2, ?_, ?_, ?_), ?t2 > ?limit.

preferred_repair(?m, ?temp, ?priority, ?source) if
    in_window(?m), member(?m, ?_, ?temp, ?priority, ?source, true),
    limit_tenths_c(?limit), ?temp > ?limit.

quarantine_decision("quarantine batchA, notify QA, and hold shipment") if
    preferred_repair(?_, ?_, ?_, ?_).

ask already_committed(?m).
ask newly_emitted(?m).
ask in_window(?m).
ask raw_conflict(?batch).
ask preferred_repair(?m, ?temp, ?priority, ?source).
ask quarantine_decision(?text).
