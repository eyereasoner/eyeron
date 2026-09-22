% Prolog result format 3
query(1, descended(_0, _1), ['Person' = _0, 'Ancestor' = _1]).
result(1, complete, 4).
answer(1, ['Person' = x, 'Ancestor' = a]).
why(1, ['Person' = x, 'Ancestor' = a], 10).
answer(1, ['Person' = x, 'Ancestor' = b]).
why(1, ['Person' = x, 'Ancestor' = b], 11).
answer(1, ['Person' = a, 'Ancestor' = c]).
why(1, ['Person' = a, 'Ancestor' = c], 12).
answer(1, ['Person' = x, 'Ancestor' = c]).
why(1, ['Person' = x, 'Ancestor' = c], 17).
clause(1, father(a, x), true).
clause(2, mother(b, x), true).
clause(3, mother(c, a), true).
clause(4, child(var('X'), var('Y')), father(var('Y'), var('X'))).
clause(5, child(var('X'), var('Y')), mother(var('Y'), var('X'))).
clause(6, descended(var('X'), var('Y')), child(var('X'), var('Y'))).
clause(7, descended(var('X'), var('Y')), (child(var('X'), var('Z')), descended(var('Z'), var('Y')))).
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
substitution(7, ['X' = x, 'Y' = a]).
proof(7, descended(x, a), rule(6), [uses(4, child(x, a))]).
substitution(8, ['X' = x, 'Y' = b]).
proof(8, descended(x, b), rule(6), [uses(5, child(x, b))]).
substitution(9, ['X' = a, 'Y' = c]).
proof(9, descended(a, c), rule(6), [uses(6, child(a, c))]).
substitution(10, ['Person' = x, 'Ancestor' = a]).
proof(10, solution([x, a]), query, [uses(7, descended(x, a))]).
substitution(11, ['Person' = x, 'Ancestor' = b]).
proof(11, solution([x, b]), query, [uses(8, descended(x, b))]).
substitution(12, ['Person' = a, 'Ancestor' = c]).
proof(12, solution([a, c]), query, [uses(9, descended(a, c))]).
substitution(13, []).
proof(13, mother(c, a), rule(3), []).
substitution(14, ['X' = a, 'Y' = c]).
proof(14, child(a, c), rule(5), [uses(13, mother(c, a))]).
substitution(15, ['X' = a, 'Y' = c]).
proof(15, descended(a, c), rule(6), [uses(14, child(a, c))]).
substitution(16, ['X' = x, 'Y' = c, 'Z' = a]).
proof(16, descended(x, c), rule(7), [uses(4, child(x, a)), uses(15, descended(a, c))]).
substitution(17, ['Person' = x, 'Ancestor' = c]).
proof(17, solution([x, c]), query, [uses(16, descended(x, c))]).
