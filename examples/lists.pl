% Unit clauses with variables are universally quantified definitions.
append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :-
    append(Xs, Ys, Zs).
member(X, [X|_]).
member(X, [_|Xs]) :-
    member(X, Xs).
?- append(Left, Right, [a, b]).
?- member(X, [a, b, a]).
