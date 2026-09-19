# Same repeated-squaring algorithm and four showcase results.
# Powers of two used as exponents are computed by rules, with exact integers.

mod_mul(?a, ?b, ?m, ?r) if let ?r = (?a * ?b) % ?m.
mod_pow(?_, 0, ?m, ?r) if ?m > 0, let ?r = 1 % ?m.
mod_pow(?b, 1, ?m, ?r) if ?m > 0, let ?r = ?b % ?m.
mod_pow(?b, ?e, ?m, ?r) if
    ?m > 0, ?e > 1, let ?parity = ?e % 2, ?parity = 0,
    mod_mul(?b, ?b, ?m, ?squared), let ?half = ?e // 2,
    mod_pow(?squared, ?half, ?m, ?r).
mod_pow(?b, ?e, ?m, ?r) if
    ?m > 0, ?e > 1, let ?parity = ?e % 2, ?parity = 1,
    mod_mul(?b, ?b, ?m, ?squared), let ?half = (?e - 1) // 2,
    mod_pow(?squared, ?half, ?m, ?tail), mod_mul(?b, ?tail, ?m, ?r).

power(?_, 0, 1).
power(?base, ?exponent, ?value) if
    ?exponent > 0, let ?previous = ?exponent - 1,
    power(?base, ?previous, ?tail), let ?value = ?base * ?tail.

small_check(?naive, ?fast) if
    power(7, 13, ?power), let ?naive = ?power % 97, mod_pow(7, 13, 97, ?fast).
large_case(seven_power_billion, ?value) if mod_pow(7, 1000000000, 1000000007, ?value).
large_case(three_power_two_power_25, ?value) if
    power(2, 25, ?exponent), mod_pow(3, ?exponent, 1000000007, ?value).
large_case(last_12_digits, ?value) if
    power(2, 20, ?exponent), mod_pow(2, ?exponent, 1000000000000, ?value).

ask small_check(?naive, ?fast).
ask large_case(?case, ?value).
