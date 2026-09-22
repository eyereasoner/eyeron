% Prolog example: patch.
% Companion to patch.n3/.srl: N3's graph patch operates on quoted formula
% terms (log:collectAllIn/log:conjunction/log:notIncludes), which Prolog
% has no counterpart for. This reifies the same three triple sets
% (source, delete, insert) as ordinary `fact/3`-shaped relations and
% computes the same patched result -- kept facts (source minus delete)
% plus every inserted fact -- with plain negation and union.
source(alice, type, person).
source(alice, age, 30).
source(alice, status, oldStatus).
source(alice, email, "alice@example.org").
source(bob, type, person).

delete_(alice, age, 30).
delete_(alice, status, oldStatus).
delete_(alice, email, "alice@example.org").

insert_(alice, age, 31).
insert_(alice, status, activeStatus).
insert_(alice, verified, true).

kept(S, P, O) :-
    source(S, P, O),
    \+ delete_(S, P, O).
patched(S, P, O) :-
    kept(S, P, O).
patched(S, P, O) :-
    insert_(S, P, O).

?- patched(S, P, O).
