% Prolog example: if-then.
man(socrates).
mortal(X) :-
    man(X).
?- mortal(socrates).
