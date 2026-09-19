# A monomorphic lambda-calculus type relation, using ordinary unification.
# This is not Hindley-Milner let polymorphism.
lookup(?name, [binding(?name, ?type) | ?_], ?type).
lookup(?name, [binding(?other, ?_) | ?rest], ?type) if
    ?name != ?other, lookup(?name, ?rest, ?type).
type(?_, int_lit(?_), int).
type(?env, var(?name), ?type) if lookup(?name, ?env, ?type).
type(?env, lam(?name, ?body), fun(?arg, ?result)) if
    type([binding(?name, ?arg) | ?env], ?body, ?result).
type(?env, app(?fn, ?arg), ?result) if
    type(?env, ?fn, fun(?input, ?result)), type(?env, ?arg, ?input).
ask type([], app(lam(x, var(x)), int_lit(42)), ?type).
ask type([], lam(x, var(x)), ?type).
