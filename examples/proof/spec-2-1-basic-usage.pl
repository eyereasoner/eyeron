% Prolog result format 3
query(1, child(_0, _1), ['Child' = _0, 'Parent' = _1]).
result(1, complete, 3).
answer(1, ['Child' = x, 'Parent' = a]).
why(1, ['Child' = x, 'Parent' = a], 7).
answer(1, ['Child' = x, 'Parent' = b]).
why(1, ['Child' = x, 'Parent' = b], 8).
answer(1, ['Child' = a, 'Parent' = c]).
why(1, ['Child' = a, 'Parent' = c], 9).
clause(1, father(a, x), true).
clause(2, mother(b, x), true).
clause(3, mother(c, a), true).
clause(4, child(var('X'), var('Y')), father(var('Y'), var('X'))).
clause(5, child(var('X'), var('Y')), mother(var('Y'), var('X'))).
substitution(1, []).
proof(1, father(a, x), rule(1), []).
substitution(2, []).
proof(2, mother(b, x), rule(2), []).
substitution(3, []).
proof(3, mother(c, a), rule(3), []).
substitution(4, ['X' = x, 'Y' = a]).
proof(4, child(x, a), rule(4), [uses(1, father(a, x))]).
substitution(5, ['X' = x, 'Y' = b]).
proof(5, child(x, b), rule(5), [uses(2, mother(b, x))]).
substitution(6, ['X' = a, 'Y' = c]).
proof(6, child(a, c), rule(5), [uses(3, mother(c, a))]).
substitution(7, ['Child' = x, 'Parent' = a]).
proof(7, solution([x, a]), query, [uses(4, child(x, a))]).
substitution(8, ['Child' = x, 'Parent' = b]).
proof(8, solution([x, b]), query, [uses(5, child(x, b))]).
substitution(9, ['Child' = a, 'Parent' = c]).
proof(9, solution([a, c]), query, [uses(6, child(a, c))]).
