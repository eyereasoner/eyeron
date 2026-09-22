% Prolog result format 3
query(1, path(a, _0), ['Where' = _0]).
result(1, complete, 3).
answer(1, ['Where' = b]).
why(1, ['Where' = b], 3).
answer(1, ['Where' = c]).
why(1, ['Where' = c], 6).
answer(1, ['Where' = a]).
why(1, ['Where' = a], 9).
clause(1, edge(a, b), true).
clause(2, edge(b, c), true).
clause(3, edge(c, a), true).
clause(4, path(var('X'), var('Y')), edge(var('X'), var('Y'))).
clause(5, path(var('X'), var('Z')), (path(var('X'), var('Y')), edge(var('Y'), var('Z')))).
substitution(1, []).
proof(1, edge(a, b), rule(1), []).
substitution(2, ['X' = a, 'Y' = b]).
proof(2, path(a, b), rule(4), [uses(1, edge(a, b))]).
substitution(3, ['Where' = b]).
proof(3, solution([b]), query, [uses(2, path(a, b))]).
substitution(4, []).
proof(4, edge(b, c), rule(2), []).
substitution(5, ['X' = a, 'Z' = c, 'Y' = b]).
proof(5, path(a, c), rule(5), [uses(2, path(a, b)), uses(4, edge(b, c))]).
substitution(6, ['Where' = c]).
proof(6, solution([c]), query, [uses(5, path(a, c))]).
substitution(7, []).
proof(7, edge(c, a), rule(3), []).
substitution(8, ['X' = a, 'Z' = a, 'Y' = c]).
proof(8, path(a, a), rule(5), [uses(5, path(a, c)), uses(7, edge(c, a))]).
substitution(9, ['Where' = a]).
proof(9, solution([a]), query, [uses(8, path(a, a))]).
