% Prolog example: derived-backward-rule-2.
% Companion to derived-backward-rule-2.n3/.srl: the N3 source generates
% two backward rules (each `<= true`, i.e. unconditional facts) from a
% forward rule's own conclusion, again something with no Prolog
% counterpart. This reifies the same two facts directly, plus the
% ordinary subclass rule that uses them to derive Socrates is Mortal.
type_(socrates, human).
subclass_of(human, mortal).
type_(S, B) :-
    type_(S, A),
    subclass_of(A, B).
test_is(true) :-
    type_(socrates, mortal).
?- test_is(R).
?- type_(S, T).
