% Prolog result format 3
query(1, out(_0, _1, _2, _3, _4, _5), ['Y' = _0, 'M' = _1, 'D' = _2, 'Min' = _3, 'Sec' = _4, 'Tz' = _5]).
result(1, complete, 1).
answer(1, ['Y' = 2023, 'M' = 4, 'D' = 1, 'Min' = 6, 'Sec' = 4, 'Tz' = "Z"]).
why(1, ['Y' = 2023, 'M' = 4, 'D' = 1, 'Min' = 6, 'Sec' = 4, 'Tz' = "Z"], 3).
clause(1, dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")), true).
clause(2, out(var('Y'), var('M'), var('D'), var('Min'), var('Sec'), var('Tz')), dt(letv, datetime(var('Y'), var('M'), var('D'), var('H'), var('Min'), var('Sec'), var('Tz')))).
substitution(1, []).
proof(1, dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")), rule(1), []).
substitution(2, ['Y' = 2023, 'M' = 4, 'D' = 1, 'Min' = 6, 'Sec' = 4, 'Tz' = "Z", 'H' = 18]).
proof(2, out(2023, 4, 1, 6, 4, "Z"), rule(2), [uses(1, dt(letv, datetime(2023, 4, 1, 18, 6, 4, "Z")))]).
substitution(3, ['Y' = 2023, 'M' = 4, 'D' = 1, 'Min' = 6, 'Sec' = 4, 'Tz' = "Z"]).
proof(3, solution([2023, 4, 1, 6, 4, "Z"]), query, [uses(2, out(2023, 4, 1, 6, 4, "Z"))]).
