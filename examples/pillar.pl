% Prolog example: pillar.
% Companion to pillar.n3/.srl: a small mutually-recursive pair of rules
% (each direction of :to around :Pillar implies the other) that
% ultimately re-derives the original fact from the other direction.
to(post, pillar).
to(pillar, What) :-
    to(What, pillar).
to(What, pillar) :-
    to(pillar, What).
result_is(What) :-
    to(pillar, What).
test_is(true) :-
    result_is(post).
?- test_is(R).
