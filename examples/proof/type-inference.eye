# Eyelang result format 2
query(1, [call(type([], app(lam(x, var(x)), int_lit(42)), ?v0))], [binding("type", ?v0)]).
result(1, complete, 1).
answer(1, [binding("type", int)]).
why(1, [binding("type", int)], 6).
query(2, [call(type([], lam(x, var(x)), ?v0))], [binding("type", ?v0)]).
result(2, complete, 1).
answer(2, [binding("type", fun(?v0, ?v0))]).
why(2, [binding("type", fun(?v0, ?v0))], 10).
clause(1, lookup(var("name"), [binding(var("name"), var("type")) | anonymous(1)], var("type")), []).
clause(3, type(anonymous(1), int_lit(anonymous(2)), int), []).
clause(4, type(var("env"), var(var("name")), var("type")), [call(lookup(var("name"), var("env"), var("type")))]).
clause(5, type(var("env"), lam(var("name"), var("body")), fun(var("arg"), var("result"))), [call(type([binding(var("name"), var("arg")) | var("env")], var("body"), var("result")))]).
clause(6, type(var("env"), app(var("fn"), var("arg")), var("result")), [call(type(var("env"), var("fn"), fun(var("input"), var("result")))), call(type(var("env"), var("arg"), var("input")))]).
substitution(1, [binding("name", x), binding("type", ?v0)]).
proof(1, lookup(x, [binding(x, ?v0)], ?v0), rule(1), []).
substitution(2, [binding("env", [binding(x, ?v0)]), binding("name", x), binding("type", ?v0)]).
proof(2, type([binding(x, ?v0)], var(x), ?v0), rule(4), [uses(1, lookup(x, [binding(x, ?v0)], ?v0))]).
substitution(3, [binding("env", []), binding("name", x), binding("body", var(x)), binding("arg", ?v0), binding("result", ?v0)]).
proof(3, type([], lam(x, var(x)), fun(?v0, ?v0)), rule(5), [uses(2, type([binding(x, ?v0)], var(x), ?v0))]).
substitution(4, []).
proof(4, type([], int_lit(42), int), rule(3), []).
substitution(5, [binding("env", []), binding("fn", lam(x, var(x))), binding("arg", int_lit(42)), binding("result", int), binding("input", int)]).
proof(5, type([], app(lam(x, var(x)), int_lit(42)), int), rule(6), [uses(3, type([], lam(x, var(x)), fun(int, int))), uses(4, type([], int_lit(42), int))]).
substitution(6, [binding("type", int)]).
proof(6, solution([int]), query, [uses(5, type([], app(lam(x, var(x)), int_lit(42)), int))]).
substitution(7, [binding("name", x), binding("type", ?v0)]).
proof(7, lookup(x, [binding(x, ?v0)], ?v0), rule(1), []).
substitution(8, [binding("env", [binding(x, ?v0)]), binding("name", x), binding("type", ?v0)]).
proof(8, type([binding(x, ?v0)], var(x), ?v0), rule(4), [uses(7, lookup(x, [binding(x, ?v0)], ?v0))]).
substitution(9, [binding("env", []), binding("name", x), binding("body", var(x)), binding("arg", ?v0), binding("result", ?v0)]).
proof(9, type([], lam(x, var(x)), fun(?v0, ?v0)), rule(5), [uses(8, type([binding(x, ?v0)], var(x), ?v0))]).
substitution(10, [binding("type", fun(?v0, ?v0))]).
proof(10, solution([fun(?v0, ?v0)]), query, [uses(9, type([], lam(x, var(x)), fun(?v0, ?v0)))]).
