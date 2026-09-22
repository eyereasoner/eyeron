% Exact integers, computed only for calls demanded by the question.
fib(0, 0).
fib(1, 1).

fib(N, F) :-
    N > 1,
    Previous is N - 1,
    Earlier is N - 2,
    fib(Previous, A),
    fib(Earlier, B),
    F is A + B.

?- fib(100, Value).
