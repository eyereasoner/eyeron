% Prolog result format 3
query(1, unique_identity(_0), ['E2_' = _0]).
result(1, complete, 1).
answer(1, ['E2_' = e2]).
why(1, ['E2_' = e2], 8).
clause(1, in_g(e), true).
clause(2, candidate_identity(e2), true).
clause(3, in_g(e2), true).
clause(4, mul(var('A'), e, var('A')), in_g(var('A'))).
clause(5, mul(var('E2_'), var('A'), var('A')), (candidate_identity(var('E2_')), in_g(var('A')))).
clause(6, unique_identity(var('E2_')), (candidate_identity(var('E2_')), in_g(var('E2_')), in_g(e), mul(var('E2_'), e, var('E2_')), mul(var('E2_'), e, e))).
substitution(1, []).
proof(1, candidate_identity(e2), rule(2), []).
substitution(2, []).
proof(2, in_g(e2), rule(3), []).
substitution(3, []).
proof(3, in_g(e), rule(1), []).
substitution(4, ['A' = e2]).
proof(4, mul(e2, e, e2), rule(4), [uses(2, in_g(e2))]).
substitution(5, []).
proof(5, candidate_identity(e2), rule(2), []).
substitution(6, ['E2_' = e2, 'A' = e]).
proof(6, mul(e2, e, e), rule(5), [uses(5, candidate_identity(e2)), uses(3, in_g(e))]).
substitution(7, ['E2_' = e2]).
proof(7, unique_identity(e2), rule(6), [uses(1, candidate_identity(e2)), uses(2, in_g(e2)), uses(3, in_g(e)), uses(4, mul(e2, e, e2)), uses(6, mul(e2, e, e))]).
substitution(8, ['E2_' = e2]).
proof(8, solution([e2]), query, [uses(7, unique_identity(e2))]).
