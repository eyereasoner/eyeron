% Prolog example: equals.
% Companion to equals.n3/.srl (equals-same-as.pl/.srl already port this
% same N3 file under a different name; this one matches equals.n3's own).
same_as(x, y).
test :-
    same_as(x, y).
?- test.
