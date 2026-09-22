% Prolog example: witch.
% Companion to witch.n3/.srl: the classic "burn the witch" syllogism chain
% (floating implies made of wood, made of wood implies it burns, burning
% plus being a woman implies witch), including the same-weight inference
% that makes the girl float because she weighs the same as the duck.
burns(X) :-
    is_made_of_wood(X).
is_made_of_wood(X) :-
    floats(X).
floats(duck).
floats(Y) :-
    floats(X),
    same_weight(X, Y).
same_weight(duck, girl).
woman(girl).
witch(X) :-
    burns(X),
    woman(X).
?- witch(X).
