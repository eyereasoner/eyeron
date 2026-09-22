% Same repeated-squaring algorithm and four showcase results.
% Powers of two used as exponents are computed by rules, with exact integers.

mod_mul(A, B, M, R) :-
    R is A * B rem M.
mod_pow(_, 0, M, R) :-
    M > 0,
    R is 1 rem M.
mod_pow(B, 1, M, R) :-
    M > 0,
    R is B rem M.

mod_pow(B, E, M, R) :-
    M > 0,
    E > 1,
    Parity is E rem 2,
    Parity = 0,
    mod_mul(B, B, M, Squared),
    Half is E // 2,
    mod_pow(Squared, Half, M, R).

mod_pow(B, E, M, R) :-
    M > 0,
    E > 1,
    Parity is E rem 2,
    Parity = 1,
    mod_mul(B, B, M, Squared),
    Half is (E - 1) // 2,
    mod_pow(Squared, Half, M, Tail),
    mod_mul(B, Tail, M, R).

power(_, 0, 1).

power(Base, Exponent, Value) :-
    Exponent > 0,
    Previous is Exponent - 1,
    power(Base, Previous, Tail),
    Value is Base * Tail.

small_check(Naive, Fast) :-
    power(7, 13, Power),
    Naive is Power rem 97,
    mod_pow(7, 13, 97, Fast).

large_case(seven_power_billion, Value) :-
    mod_pow(7, 1000000000, 1000000007, Value).

large_case(three_power_two_power_25, Value) :-
    power(2, 25, Exponent),
    mod_pow(3, Exponent, 1000000007, Value).

large_case(last_12_digits, Value) :-
    power(2, 20, Exponent),
    mod_pow(2, Exponent, 1000000000000, Value).

?- small_check(Naive, Fast).
?- large_case(Case, Value).
