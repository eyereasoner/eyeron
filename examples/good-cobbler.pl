% Keep the compound property: being a good cobbler does not imply being
% good. `quoted(...)` represents the selected statement as data. It does
% not implement N3 formula entailment, quantifier scopes, or rule
% activation.
%
% The relation is named `is_a` rather than `is`, because `is/2` is the
% standard's arithmetic evaluation and a program may not redefine it.

is_a(joe, [good, cobbler]).

report(quoted(triple(Person, is_a, [good, Occupation]))) :-
    is_a(Person, [good, Occupation]).

?- report(Statement).
?- is_a(joe, good).
