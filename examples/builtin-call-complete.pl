% Prolog example: builtin-call-complete.
numbers([-3.7, 7, 2]).
summary(Absolute, Root, Count, Sorted) :-
    numbers(Values),
    Absolute is abs(-(3.7)),
    Root is sqrt(9),
    length(Values, Count),
    sort(Values, Sorted).
?- summary(Absolute, Root, Count, Sorted).
