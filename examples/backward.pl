% Prolog example: backward.
value(five, 5).
value(three, 3).
more_interesting(X, Y) :-
    value(X, Left),
    value(Y, Right),
    Left > Right.
indeed_more_interesting(X, Y) :-
    more_interesting(X, Y).
?- indeed_more_interesting(X, Y).
