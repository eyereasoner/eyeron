# Eyelang result format 2
query(1, [call(unique_identity(?v0))], [binding("e2_", ?v0)]).
result(1, complete, 1).
answer(1, [binding("e2_", e2)]).
why(1, [binding("e2_", e2)], 8).
clause(1, in_g(e), []).
clause(2, candidate_identity(e2), []).
clause(3, in_g(e2), []).
clause(4, mul(var("a"), e, var("a")), [call(in_g(var("a")))]).
clause(5, mul(var("e2_"), var("a"), var("a")), [call(candidate_identity(var("e2_"))), call(in_g(var("a")))]).
clause(6, unique_identity(var("e2_")), [call(candidate_identity(var("e2_"))), call(in_g(var("e2_"))), call(in_g(e)), call(mul(var("e2_"), e, var("e2_"))), call(mul(var("e2_"), e, e))]).
substitution(1, []).
proof(1, candidate_identity(e2), rule(2), []).
substitution(2, []).
proof(2, in_g(e2), rule(3), []).
substitution(3, []).
proof(3, in_g(e), rule(1), []).
substitution(4, [binding("a", e2)]).
proof(4, mul(e2, e, e2), rule(4), [uses(2, in_g(e2))]).
substitution(5, []).
proof(5, candidate_identity(e2), rule(2), []).
substitution(6, [binding("e2_", e2), binding("a", e)]).
proof(6, mul(e2, e, e), rule(5), [uses(5, candidate_identity(e2)), uses(3, in_g(e))]).
substitution(7, [binding("e2_", e2)]).
proof(7, unique_identity(e2), rule(6), [uses(1, candidate_identity(e2)), uses(2, in_g(e2)), uses(3, in_g(e)), uses(4, mul(e2, e, e2)), uses(6, mul(e2, e, e))]).
substitution(8, [binding("e2_", e2)]).
proof(8, solution([e2]), query, [uses(7, unique_identity(e2))]).
