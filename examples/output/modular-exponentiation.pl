% Prolog result format 3
query(1, small_check(_0, _1), ['Naive' = _0, 'Fast' = _1]).
result(1, complete, 1).
answer(1, ['Naive' = 38, 'Fast' = 38]).
query(2, large_case(_0, _1), ['Case' = _0, 'Value' = _1]).
result(2, complete, 3).
answer(2, ['Case' = last_12_digits, 'Value' = 940335579136]).
answer(2, ['Case' = seven_power_billion, 'Value' = 312556845]).
answer(2, ['Case' = three_power_two_power_25, 'Value' = 849572438]).
