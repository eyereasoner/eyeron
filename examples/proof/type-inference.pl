% Prolog result format 3
query(1, type([], app(lam(x, var(x)), int_lit(42)), _0), ['Type' = _0]).
result(1, complete, 1).
answer(1, ['Type' = int]).
why(1, ['Type' = int], 6).
query(2, type([], lam(x, var(x)), _0), ['Type' = _0]).
result(2, complete, 1).
answer(2, ['Type' = fun(_0, _0)]).
why(2, ['Type' = fun(_0, _0)], 10).
clause(1, lookup(var('Name'), [binding(var('Name'), var('Type'))|anonymous(1)], var('Type')), true).
clause(3, type(anonymous(1), int_lit(anonymous(2)), int), true).
clause(4, type(var('Env'), var(var('Name')), var('Type')), lookup(var('Name'), var('Env'), var('Type'))).
clause(5, type(var('Env'), lam(var('Name'), var('Body')), fun(var('Arg'), var('Result'))), type([binding(var('Name'), var('Arg'))|var('Env')], var('Body'), var('Result'))).
clause(6, type(var('Env'), app(var('Fn'), var('Arg')), var('Result')), (type(var('Env'), var('Fn'), fun(var('Input'), var('Result'))), type(var('Env'), var('Arg'), var('Input')))).
substitution(1, ['Name' = x, 'Type' = _0]).
proof(1, lookup(x, [binding(x, _0)], _0), rule(1), []).
substitution(2, ['Env' = [binding(x, _0)], 'Name' = x, 'Type' = _0]).
proof(2, type([binding(x, _0)], var(x), _0), rule(4), [uses(1, lookup(x, [binding(x, _0)], _0))]).
substitution(3, ['Env' = [], 'Name' = x, 'Body' = var(x), 'Arg' = _0, 'Result' = _0]).
proof(3, type([], lam(x, var(x)), fun(_0, _0)), rule(5), [uses(2, type([binding(x, _0)], var(x), _0))]).
substitution(4, []).
proof(4, type([], int_lit(42), int), rule(3), []).
substitution(5, ['Env' = [], 'Fn' = lam(x, var(x)), 'Arg' = int_lit(42), 'Result' = int, 'Input' = int]).
proof(5, type([], app(lam(x, var(x)), int_lit(42)), int), rule(6), [uses(3, type([], lam(x, var(x)), fun(int, int))), uses(4, type([], int_lit(42), int))]).
substitution(6, ['Type' = int]).
proof(6, solution([int]), query, [uses(5, type([], app(lam(x, var(x)), int_lit(42)), int))]).
substitution(7, ['Name' = x, 'Type' = _0]).
proof(7, lookup(x, [binding(x, _0)], _0), rule(1), []).
substitution(8, ['Env' = [binding(x, _0)], 'Name' = x, 'Type' = _0]).
proof(8, type([binding(x, _0)], var(x), _0), rule(4), [uses(7, lookup(x, [binding(x, _0)], _0))]).
substitution(9, ['Env' = [], 'Name' = x, 'Body' = var(x), 'Arg' = _0, 'Result' = _0]).
proof(9, type([], lam(x, var(x)), fun(_0, _0)), rule(5), [uses(8, type([binding(x, _0)], var(x), _0))]).
substitution(10, ['Type' = fun(_0, _0)]).
proof(10, solution([fun(_0, _0)]), query, [uses(9, type([], lam(x, var(x)), fun(_0, _0)))]).
