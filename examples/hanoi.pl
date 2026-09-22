% Relational formulation: same three-disk problem and ordered seven-move answer.
% Recursive calls build move lists; append is an ordinary relation.

append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :-
    append(Xs, Ys, Zs).

hanoi(0, _, _, _, []).

hanoi(N, From, To, Via, Moves) :-
    N > 0,
    Smaller is N - 1,
    hanoi(Smaller, From, Via, To, Before),
    hanoi(Smaller, Via, To, From, After),
    append(Before, [[From, To]|After], Moves).

?- hanoi(3, left, right, center, Moves).
