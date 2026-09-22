% Prolog result format 3
query(1, already_committed(_0), ['M' = _0]).
result(1, complete, 2).
answer(1, ['M' = obs033]).
answer(1, ['M' = obs034]).
query(2, newly_emitted(_0), ['M' = _0]).
result(2, complete, 6).
answer(2, ['M' = obs035]).
answer(2, ['M' = obs036]).
answer(2, ['M' = obs037]).
answer(2, ['M' = obs038]).
answer(2, ['M' = obs039]).
answer(2, ['M' = obs040]).
query(3, in_window(_0), ['M' = _0]).
result(3, complete, 6).
answer(3, ['M' = obs035]).
answer(3, ['M' = obs036]).
answer(3, ['M' = obs037]).
answer(3, ['M' = obs038]).
answer(3, ['M' = obs039]).
answer(3, ['M' = obs040]).
query(4, raw_conflict(_0), ['Door' = _0]).
result(4, complete, 1).
answer(4, ['Door' = doorA]).
query(5, preferred_repair(_0, _1, _2, _3), ['M' = _0, 'State' = _1, 'Priority' = _2, 'Source' = _3]).
result(5, complete, 1).
answer(5, ['M' = obs040, 'State' = closed, 'Priority' = 5, 'Source' = "safety-controller"]).
query(6, materialized_action(_0), ['Text' = _0]).
result(6, complete, 1).
answer(6, ['Text' = "keep the compartment sealed and continue monitoring"]).
