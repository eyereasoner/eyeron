# Eyelang result format 2
query(1, [call(phase_pi(?v0, ?v1))], [binding("re", ?v0), binding("im", ?v1)]).
result(1, complete, 1).
answer(1, [binding("re", -1), binding("im", 0)]).
why(1, [binding("re", -1), binding("im", 0)], 2).
query(2, [call(lhs(?v0, ?v1))], [binding("re", ?v0), binding("im", ?v1)]).
result(2, complete, 1).
answer(2, [binding("re", 0), binding("im", 0)]).
why(2, [binding("re", 0), binding("im", 0)], 5).
query(3, [call(holds(?v0))], [binding("ok", ?v0)]).
result(3, complete, 1).
answer(3, [binding("ok", true)]).
why(3, [binding("ok", true)], 9).
query(4, [call(mod_sq(?v0))], [binding("m", ?v0)]).
result(4, complete, 1).
answer(4, [binding("m", 1)]).
why(4, [binding("m", 1)], 12).
query(5, [call(mod_sq_is_one(?v0))], [binding("ok", ?v0)]).
result(5, complete, 1).
answer(5, [binding("ok", true)]).
why(5, [binding("ok", true)], 16).
clause(1, phase_pi(var("re"), var("im")), [calculate(var("re"), binary("-", value(0), value(1))), calculate(var("im"), value(0))]).
clause(2, lhs(var("sumRe"), var("sumIm")), [call(phase_pi(var("re"), var("im"))), calculate(var("sumRe"), binary("+", value(var("re")), value(1))), calculate(var("sumIm"), binary("+", value(var("im")), value(0)))]).
clause(3, holds(true), [call(lhs(0, 0))]).
clause(4, mod_sq(var("m")), [call(phase_pi(var("re"), var("im"))), calculate(var("re2"), binary("*", value(var("re")), value(var("re")))), calculate(var("im2"), binary("*", value(var("im")), value(var("im")))), calculate(var("m"), binary("+", value(var("re2")), value(var("im2"))))]).
clause(5, mod_sq_is_one(true), [call(mod_sq(1))]).
substitution(1, [binding("re", -1), binding("im", 0)]).
proof(1, phase_pi(-1, 0), rule(1), [calculated(-1, binary("-", value(0), value(1))), calculated(0, value(0))]).
substitution(2, [binding("re", -1), binding("im", 0)]).
proof(2, solution([-1, 0]), query, [uses(1, phase_pi(-1, 0))]).
substitution(3, [binding("re", -1), binding("im", 0)]).
proof(3, phase_pi(-1, 0), rule(1), [calculated(-1, binary("-", value(0), value(1))), calculated(0, value(0))]).
substitution(4, [binding("sumRe", 0), binding("sumIm", 0), binding("re", -1), binding("im", 0)]).
proof(4, lhs(0, 0), rule(2), [uses(3, phase_pi(-1, 0)), calculated(0, binary("+", value(-1), value(1))), calculated(0, binary("+", value(0), value(0)))]).
substitution(5, [binding("re", 0), binding("im", 0)]).
proof(5, solution([0, 0]), query, [uses(4, lhs(0, 0))]).
substitution(6, [binding("re", -1), binding("im", 0)]).
proof(6, phase_pi(-1, 0), rule(1), [calculated(-1, binary("-", value(0), value(1))), calculated(0, value(0))]).
substitution(7, [binding("sumRe", 0), binding("sumIm", 0), binding("re", -1), binding("im", 0)]).
proof(7, lhs(0, 0), rule(2), [uses(6, phase_pi(-1, 0)), calculated(0, binary("+", value(-1), value(1))), calculated(0, binary("+", value(0), value(0)))]).
substitution(8, []).
proof(8, holds(true), rule(3), [uses(7, lhs(0, 0))]).
substitution(9, [binding("ok", true)]).
proof(9, solution([true]), query, [uses(8, holds(true))]).
substitution(10, [binding("re", -1), binding("im", 0)]).
proof(10, phase_pi(-1, 0), rule(1), [calculated(-1, binary("-", value(0), value(1))), calculated(0, value(0))]).
substitution(11, [binding("m", 1), binding("re", -1), binding("im", 0), binding("re2", 1), binding("im2", 0)]).
proof(11, mod_sq(1), rule(4), [uses(10, phase_pi(-1, 0)), calculated(1, binary("*", value(-1), value(-1))), calculated(0, binary("*", value(0), value(0))), calculated(1, binary("+", value(1), value(0)))]).
substitution(12, [binding("m", 1)]).
proof(12, solution([1]), query, [uses(11, mod_sq(1))]).
substitution(13, [binding("re", -1), binding("im", 0)]).
proof(13, phase_pi(-1, 0), rule(1), [calculated(-1, binary("-", value(0), value(1))), calculated(0, value(0))]).
substitution(14, [binding("m", 1), binding("re", -1), binding("im", 0), binding("re2", 1), binding("im2", 0)]).
proof(14, mod_sq(1), rule(4), [uses(13, phase_pi(-1, 0)), calculated(1, binary("*", value(-1), value(-1))), calculated(0, binary("*", value(0), value(0))), calculated(1, binary("+", value(1), value(0)))]).
substitution(15, []).
proof(15, mod_sq_is_one(true), rule(5), [uses(14, mod_sq(1))]).
substitution(16, [binding("ok", true)]).
proof(16, solution([true]), query, [uses(15, mod_sq_is_one(true))]).
