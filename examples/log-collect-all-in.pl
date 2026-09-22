% Prolog example: log-collect-all-in.
% Companion to log-collect-all-in.n3/.srl: the same three collection
% shapes (plain, each item wrapped in its own list, and filtered) via
% Prolog's `collect`. Prolog has no string ordering operator (only
% numeric comparisons), so the filter uses `!=` "Louie" instead of N3's
% `string:lessThan "Louie"` -- equivalent for this data, since every
% other value already sorts before "Louie". `collect` also always
% canonically sorts its result (alphabetical here), unlike N3's
% collectAllIn, which preserves original derivation order.
param("Huey").
param("Dewey").
param("Louie").

result1(All) :-
    findall(P, param(P), Bag1),
    sort(Bag1, All).
result2(Nested) :-
    findall([P], param(P), Bag1),
    sort(Bag1, Nested).
result3(Filtered) :-
    findall(P, (param(P), P \== "Louie"), Bag1),
    sort(Bag1, Filtered).

?- result1(All).
?- result2(Nested).
?- result3(Filtered).
