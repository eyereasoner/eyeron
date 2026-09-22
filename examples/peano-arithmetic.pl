% Compute (1 * 2 + 3)! structurally with 0 and s(...).
% The result is the actual successor term for 120, not a stored numeric answer.

peano_add(A, 0, A).
peano_add(A, s(B), s(C)) :-
    peano_add(A, B, C).
peano_multiply(_, 0, 0).

peano_multiply(A, s(B), C) :-
    peano_multiply(A, B, D),
    peano_add(A, D, C).

factorial_value(A, B) :-
    fac(A, s(0), B).
fac(0, A, A).
fac(s(A), B, C) :-
    peano_multiply(B, s(A), D),
    fac(A, D, C).

factorial(Five, Result) :-
    peano_multiply(s(0), s(s(0)), Two),
    peano_add(Two, s(s(s(0))), Five),
    factorial_value(Five, Result).

?- factorial(Five, Result).
