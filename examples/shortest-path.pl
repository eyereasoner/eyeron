% Enumerate simple directed paths, then select the minimum cost.
% This preserves the problem, not Dijkstra's algorithm or its complexity.
edge(a, b, 2).
edge(a, c, 5).
edge(b, c, 1).
edge(b, d, 7).
edge(c, d, 2).
edge(c, a, 1).
member(X, [X|_]).
member(X, [_|Rest]) :-
    member(X, Rest).
route(Goal, Goal, _, [Goal], 0).

route(From, Goal, Visited, [From|Path], Cost) :-
    edge(From, Next, Step),
    \+ member(Next, Visited),
    route(Next, Goal, [Next|Visited], Path, Remaining),
    Cost is Step + Remaining.

best(From, To, Path, Cost) :-
    findall(Candidate, route(From, To, [From], _, Candidate), Bag1),
    sort(Bag1, Costs),
    min_list(Costs, Cost),
    route(From, To, [From], Path, Cost).

?- best(a, d, Path, Cost).
