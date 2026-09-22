% Prolog result format 4
query(1, raw_conflict(_0), ['Door' = _0]).
result(1, complete, 1).
answer(1, ['Door' = doorA]).
query(2,
      preferred_repair(_0, _1, _2, _3),
      ['Evidence' = _0, 'State' = _1, 'Priority' = _2, 'Source' = _3]).
result(2, complete, 1).
answer(2,
       ['Evidence' = reading004,
        'State' = closed,
        'Priority' = 3,
        'Source' = "safety-controller"]).
query(3, materialized_action(_0), ['Text' = _0]).
result(3, complete, 1).
answer(3, ['Text' = "mark the fire compartment as sealed"]).
