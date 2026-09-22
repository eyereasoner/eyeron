% Prolog example: family-cousins.
parent(adam, bob).
parent(adam, carol).
parent(bob, dave).
parent(bob, eve).
parent(carol, frank).
parent(carol, grace).
parent(dave, heidi).
parent(eve, ivan).
parent(frank, judy).
branch(dave, b).
branch(eve, b).
branch(frank, c).
branch(grace, c).
different(b, c).
different(c, b).
generation(adam, 0).
generation(Child, Next) :-
    parent(Parent, Child),
    generation(Parent, Current),
    Next is Current + 1.
branch(Child, Branch) :-
    parent(Parent, Child),
    branch(Parent, Branch).
cousin(X, Y) :-
    generation(X, G),
    generation(Y, G),
    branch(X, Bx),
    branch(Y, By),
    different(Bx, By).
?- cousin(Person, Cousin).
