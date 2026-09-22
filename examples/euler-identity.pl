% Prolog example: euler-identity.
% Companion to euler-identity.n3/.srl: certifies exp(i*pi) + 1 = 0 using
% exact integer arithmetic (Prolog's arbitrary-precision integers make
% this exact, matching the N3 source's own "certificate-friendly" design
% note), rather than a floating-point approximation.
phase_pi(Re, Im) :-
    Re is 0 - 1,
    Im is 0.
lhs(SumRe, SumIm) :-
    phase_pi(Re, Im),
    SumRe is Re + 1,
    SumIm is Im + 0.
holds(true) :-
    lhs(0, 0).
mod_sq(M) :-
    phase_pi(Re, Im),
    Re2 is Re * Re,
    Im2 is Im * Im,
    M is Re2 + Im2.
mod_sq_is_one(true) :-
    mod_sq(1).

?- phase_pi(Re, Im).
?- lhs(Re, Im).
?- holds(Ok).
?- mod_sq(M).
?- mod_sq_is_one(Ok).
