% A relational grammar written with explicit input and remainder lists.
sentence(command(Verb, Object), Input, Rest) :-
    verb(Verb, Input, Middle),
    noun(Object, Middle, Rest).

verb(open, [open|Rest], Rest).
verb(close, [close|Rest], Rest).
noun(door, [door|Rest], Rest).
noun(window, [window|Rest], Rest).
?- sentence(Ast, [open, door], []).
?- sentence(command(close, window), Words, []).
