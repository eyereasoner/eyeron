% Prolog result format 4
query(1, type([], app(lam(x, var(x)), int_lit(42)), _0), ['Type' = _0]).
result(1, complete, 1).
answer(1, ['Type' = int]).
why(1, ['Type' = int], [type([], app(lam(x, var(x)), int_lit(42)), int)]).
query(2, type([], lam(x, var(x)), _0), ['Type' = _0]).
result(2, complete, 1).
answer(2, ['Type' = fun(_0, _0)]).
why(2, ['Type' = fun(_0, _0)], [type([], lam(x, var(x)), fun(_0, _0))]).

clause(1,
       lookup(var('Name'), [binding(var('Name'), var('Type'))|anonymous(1)], var('Type')),
       true).
clause(3, type(anonymous(1), int_lit(anonymous(2)), int), true).
clause(4,
       type(var('Env'), var(var('Name')), var('Type')),
       lookup(var('Name'), var('Env'), var('Type'))).
clause(5,
       type(var('Env'), lam(var('Name'), var('Body')), fun(var('Arg'), var('Result'))),
       type([binding(var('Name'), var('Arg'))|var('Env')], var('Body'), var('Result'))).
clause(6,
       type(var('Env'), app(var('Fn'), var('Arg')), var('Result')),
       (type(var('Env'), var('Fn'), fun(var('Input'), var('Result'))),
        type(var('Env'), var('Arg'), var('Input')))).

step(type([], app(lam(x, var(x)), int_lit(42)), int),
     rule(6),
     ['Env' = [], 'Fn' = lam(x, var(x)), 'Arg' = int_lit(42), 'Result' = int, 'Input' = int],
     [type([], lam(x, var(x)), fun(int, int)), type([], int_lit(42), int)]).
step(type([], lam(x, var(x)), fun(_0, _0)),
     rule(5),
     ['Env' = [], 'Name' = x, 'Body' = var(x), 'Arg' = _0, 'Result' = _0],
     [type([binding(x, _0)], var(x), _0)]).
step(type([binding(x, _0)], var(x), _0),
     rule(4),
     ['Env' = [binding(x, _0)], 'Name' = x, 'Type' = _0],
     [lookup(x, [binding(x, _0)], _0)]).
step(lookup(x, [binding(x, _0)], _0), fact(1), ['Name' = x, 'Type' = _0], []).
step(type([], int_lit(42), int), fact(3), [], []).
