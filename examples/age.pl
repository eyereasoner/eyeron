% Prolog example: age.
% Companion to age.n3/.srl: is a person's age above some duration?
% Prolog has no current-time builtin (unlike N3's time:localTime), so
% this uses a fixed reference year in place of "now" -- anyone born in
% 1944 is over 80 in any reference year from 2024 onward, so the answer
% does not depend on which such year is chosen.
birth_year(patH, 1944).
reference_year(2025).

age_above(Person, Years) :-
    birth_year(Person, BirthYear),
    reference_year(Now),
    Age is Now - BirthYear,
    Age > Years.

test_is(true) :-
    age_above(patH, 80).

?- test_is(Result).
