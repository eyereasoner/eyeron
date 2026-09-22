% Prolog result format 3
query(1, ancestor(a, _0), ['Who' = _0]).
result(1, complete, 3).
answer(1, ['Who' = b]).
why(1, ['Who' = b], 3).
answer(1, ['Who' = c]).
why(1, ['Who' = c], 7).
answer(1, ['Who' = d]).
why(1, ['Who' = d], 12).
clause(1, parent(a, b), true).
clause(2, parent(b, c), true).
clause(3, parent(c, d), true).
clause(4, ancestor(var('X'), var('Y')), parent(var('X'), var('Y'))).
clause(5, ancestor(var('X'), var('Z')), (parent(var('X'), var('Y')), ancestor(var('Y'), var('Z')))).
substitution(1, []).
proof(1, parent(a, b), rule(1), []).
substitution(2, ['X' = a, 'Y' = b]).
proof(2, ancestor(a, b), rule(4), [uses(1, parent(a, b))]).
substitution(3, ['Who' = b]).
proof(3, solution([b]), query, [uses(2, ancestor(a, b))]).
substitution(4, []).
proof(4, parent(b, c), rule(2), []).
substitution(5, ['X' = b, 'Y' = c]).
proof(5, ancestor(b, c), rule(4), [uses(4, parent(b, c))]).
substitution(6, ['X' = a, 'Z' = c, 'Y' = b]).
proof(6, ancestor(a, c), rule(5), [uses(1, parent(a, b)), uses(5, ancestor(b, c))]).
substitution(7, ['Who' = c]).
proof(7, solution([c]), query, [uses(6, ancestor(a, c))]).
substitution(8, []).
proof(8, parent(c, d), rule(3), []).
substitution(9, ['X' = c, 'Y' = d]).
proof(9, ancestor(c, d), rule(4), [uses(8, parent(c, d))]).
substitution(10, ['X' = b, 'Z' = d, 'Y' = c]).
proof(10, ancestor(b, d), rule(5), [uses(4, parent(b, c)), uses(9, ancestor(c, d))]).
substitution(11, ['X' = a, 'Z' = d, 'Y' = b]).
proof(11, ancestor(a, d), rule(5), [uses(1, parent(a, b)), uses(10, ancestor(b, d))]).
substitution(12, ['Who' = d]).
proof(12, solution([d]), query, [uses(11, ancestor(a, d))]).
