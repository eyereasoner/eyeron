% Derive a shortest path over the weighted graph used by the source example.
% This reference formulation enumerates simple paths and selects the minimum;
% it has Dijkstra's result, though not its priority-queue complexity.
edge(a, b, 4).
edge(a, c, 2).
edge(b, c, 1).
edge(b, d, 5).
edge(c, d, 8).
edge(c, e, 10).
edge(d, e, 2).
edge(d, f, 6).
edge(e, f, 3).
connected(Right, Left, Weight) :-
    edge(Left, Right, Weight).
connected(Left, Right, Weight) :-
    edge(Left, Right, Weight).

member(X, [X|_]).
member(X, [_|Rest]) :-
    member(X, Rest).
route(Goal, Goal, _, [Goal], 0).

route(From, Goal, Visited, [From|Path], Cost) :-
    connected(From, Next, Step),
    \+ member(Next, Visited),
    route(Next, Goal, [Next|Visited], Path, Remaining),
    Cost is Step + Remaining.

best(From, To, Path, Cost) :-
    findall(Candidate, route(From, To, [From], _, Candidate), Bag1),
    sort(Bag1, Costs),
    min_list(Costs, Cost),
    route(From, To, [From], Path, Cost).

?- best(a, f, Path, Cost).
