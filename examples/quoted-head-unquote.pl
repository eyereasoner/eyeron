% Prolog example: quoted-head-unquote.
% Companion to quoted-head-unquote.n3/.srl: the N3 source stores a rule
% as a quoted formula and activates it by using a term (rather than a
% literal `{...}` block) as a rule's right-hand side -- a reflective
% capability with no Prolog counterpart (Prolog rules are not
% first-class data the way an N3 formula is; compare rule-matching.pl's
% own note on this). This reifies the outcome the activated rule would
% produce directly: a cat is an animal.
cat(c).
animal(X) :-
    cat(X).
test_is(true) :-
    animal(c).
?- test_is(R).
