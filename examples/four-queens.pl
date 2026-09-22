% Genuine finite search using a general range relation, no puzzle built-in.
safe(_, [], _).

safe(Row, [Other|Rest], Distance) :-
    Row \== Other,
    Delta is abs(Row - Other),
    Delta \== Distance,
    Next is Distance + 1,
    safe(Row, Rest, Next).

place(0, _, Placed, Placed).

place(Remaining, Size, Placed, Rows) :-
    Remaining > 0,
    between(1, Size, Row),
    safe(Row, Placed, 1),
    Next is Remaining - 1,
    place(Next, Size, [Row|Placed], Rows).

?- place(4, 4, [], Rows).
