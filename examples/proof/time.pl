% Prolog result format 4
query(1,
      out(_0, _1, _2, _3, _4, _5),
      ['Y' = _0, 'M' = _1, 'D' = _2, 'Min' = _3, 'Sec' = _4, 'Tz' = _5]).
result(1, complete, 1).
answer(1, ['Y' = 2023, 'M' = 4, 'D' = 1, 'Min' = 6, 'Sec' = 4, 'Tz' = "Z"]).
why(1,
    ['Y' = 2023, 'M' = 4, 'D' = 1, 'Min' = 6, 'Sec' = 4, 'Tz' = "Z"],
    [out(2023, 4, 1, 6, 4, "Z")]).

clause(1, dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")), true).
clause(2,
       out(var('Y'), var('M'), var('D'), var('Min'), var('Sec'), var('Tz')),
       dt(letv, datetime(var('Y'), var('M'), var('D'), var('H'), var('Min'), var('Sec'), var('Tz')))).

step(out(2023, 4, 1, 6, 4, "Z"),
     rule(2),
     ['Y' = 2023, 'M' = 4, 'D' = 1, 'Min' = 6, 'Sec' = 4, 'Tz' = "Z", 'H' = 18],
     [dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z"))]).
step(dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")), fact(1), [], []).
