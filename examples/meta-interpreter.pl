% Prolog is homoiconic: a clause is a term, and a body is a term too. So
% `clause/2` hands a clause back in the very notation the program was
% written in, and the vanilla meta-interpreter needs no notation of its
% own -- just `true`, `,`/2 and ordinary unification.

% The object program: nothing about it is special.
parent(ann, bob).
parent(bob, cid).
ancestor(Older, Younger) :- parent(Older, Younger).
ancestor(Older, Younger) :- parent(Older, Middle), ancestor(Middle, Younger).

% The interpreter, in three clauses.
solve(true).
solve((A, B)) :- solve(A), solve(B).
solve(Head) :- clause(Head, Body), solve(Body).

% The same interpreter, now also counting the clauses each answer used --
% a measurement the object program says nothing about and does not know is
% being taken.
steps(true, 0).
steps((A, B), Count) :- steps(A, Left), steps(B, Right), Count is Left + Right.
steps(Goal, Count) :- clause(Goal, Body), steps(Body, Inner), Count is Inner + 1.

?- solve(ancestor(ann, Descendant)).
?- steps(ancestor(ann, cid), Clauses).
?- clause(ancestor(Older, Younger), Body).
