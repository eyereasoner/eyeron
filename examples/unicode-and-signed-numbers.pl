% Prolog example: unicode-and-signed-numbers.
text(sample, "ABC").
delta(thermo, -12).
unicode_decoded :-
    text(sample, "ABC").
below_zero :-
    delta(thermo, D),
    D < 0.
?- unicode_decoded.
?- below_zero.
