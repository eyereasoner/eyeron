% Prolog result format 3
query(1, type([], app(lam(x, var(x)), int_lit(42)), _0), ['Type' = _0]).
result(1, complete, 1).
answer(1, ['Type' = int]).
query(2, type([], lam(x, var(x)), _0), ['Type' = _0]).
result(2, complete, 1).
answer(2, ['Type' = fun(_0, _0)]).
