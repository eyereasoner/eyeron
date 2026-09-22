% Prolog result format 3
query(1, already_committed(_0), ['M' = _0]).
result(1, complete, 3).
answer(1, ['M' = obs040]).
answer(1, ['M' = obs041]).
answer(1, ['M' = obs042]).
query(2, newly_emitted(_0), ['M' = _0]).
result(2, complete, 6).
answer(2, ['M' = obs043]).
answer(2, ['M' = obs044]).
answer(2, ['M' = obs045]).
answer(2, ['M' = obs046]).
answer(2, ['M' = obs047]).
answer(2, ['M' = obs048]).
query(3, in_window(_0), ['M' = _0]).
result(3, complete, 6).
answer(3, ['M' = obs043]).
answer(3, ['M' = obs044]).
answer(3, ['M' = obs045]).
answer(3, ['M' = obs046]).
answer(3, ['M' = obs047]).
answer(3, ['M' = obs048]).
query(4, raw_conflict(_0), ['Batch' = _0]).
result(4, complete, 1).
answer(4, ['Batch' = batchA]).
query(5, preferred_repair(_0, _1, _2, _3), ['M' = _0, 'Temp' = _1, 'Priority' = _2, 'Source' = _3]).
result(5, complete, 1).
answer(5, ['M' = obs047, 'Temp' = 118, 'Priority' = 5, 'Source' = "calibrated-cold-chain-logger"]).
query(6, quarantine_decision(_0), ['Text' = _0]).
result(6, complete, 1).
answer(6, ['Text' = "quarantine batchA, notify QA, and hold shipment"]).
