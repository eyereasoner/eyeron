% A monomorphic lambda-calculus type relation, using ordinary unification.
% This is not Hindley-Milner let polymorphism.
lookup(Name, [binding(Name, Type)|_], Type).

lookup(Name, [binding(Other, _)|Rest], Type) :-
    Name \== Other,
    lookup(Name, Rest, Type).

type(_, int_lit(_), int).
type(Env, var(Name), Type) :-
    lookup(Name, Env, Type).

type(Env, lam(Name, Body), fun(Arg, Result)) :-
    type([binding(Name, Arg)|Env], Body, Result).

type(Env, app(Fn, Arg), Result) :-
    type(Env, Fn, fun(Input, Result)),
    type(Env, Arg, Input).

?- type([], app(lam(x, var(x)), int_lit(42)), Type).
?- type([], lam(x, var(x)), Type).
