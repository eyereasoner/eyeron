% Relational formulation: [person, wolf, goat, cabbage] occupy west/east banks w/e.
% Enumerate safe paths without revisiting states, then select seven crossings.

member(X, [X|_]).
member(X, [_|Rest]) :-
    member(X, Rest).
change(e, w).
change(w, e).

move([X, X, Goat, Cabbage], wolf, [Y, Y, Goat, Cabbage]) :-
    change(X, Y).
move([X, Wolf, X, Cabbage], goat, [Y, Wolf, Y, Cabbage]) :-
    change(X, Y).
move([X, Wolf, Goat, X], cabbage, [Y, Wolf, Goat, Y]) :-
    change(X, Y).
move([X, Wolf, Goat, Cabbage], nothing, [Y, Wolf, Goat, Cabbage]) :-
    change(X, Y).

one_equal(X, X, _).
one_equal(X, _, X).

safe([Person, Wolf, Goat, Cabbage]) :-
    one_equal(Person, Goat, Wolf),
    one_equal(Person, Goat, Cabbage).

solve(Goal, Goal, _, []).

solve(State, Goal, Visited, [Move|Rest]) :-
    move(State, Move, Next),
    safe(Next),
    \+ member(Next, Visited),
    solve(Next, Goal, [Next|Visited], Rest).

solution(Moves) :-
    solve([w, w, w, w], [e, e, e, e], [[w, w, w, w]], Moves),
    length(Moves, 7).

?- solution(Moves).
