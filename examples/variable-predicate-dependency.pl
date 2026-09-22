% Prolog example: variable-predicate-dependency.
% Prolog has fixed relation names, so the equivalent negative cycle is explicit.
source(a, blocked).
derived(X) :-
    source(X, blocked),
    \+ blocked(X).
blocked(X) :-
    derived(X).
?- derived(a).
