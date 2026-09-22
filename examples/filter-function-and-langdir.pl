% Prolog example: filter-function-and-langdir.
value(n1, -3.5).
value(n2, 7).
directed_text(msg, literal("bonjour", fr, ltr)).
negative(X) :-
    value(X, V),
    V < 0.
language_direction(Message, Direction) :-
    directed_text(Message, literal(Text, Lang, Direction)).
?- negative(X).
?- language_direction(msg, Direction).
