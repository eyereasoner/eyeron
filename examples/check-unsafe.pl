% Prolog example: check-unsafe.
knows(alice, bob).

% Like the source warning, ?someone is deliberately not bound by the body.
seen(Someone) :-
    knows(alice, bob).
?- seen(Someone).
