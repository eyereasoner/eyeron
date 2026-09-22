% Prolog example: collection-nesting.
nested(root, [1, node(q), [2]]).
first(First) :-
    nested(root, [First, Second, Third]).
second_property(Value) :-
    nested(root, [First, node(Value), Third]).
third_first(Value) :-
    nested(root, [First, Second, [Value]]).
?- first(Value).
?- second_property(Value).
?- third_first(Value).
