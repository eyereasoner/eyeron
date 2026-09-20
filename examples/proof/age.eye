# Eyelang result format 2
query(1, [call(test_is(?v0))], [binding("result", ?v0)]).
result(1, complete, 1).
answer(1, [binding("result", true)]).
why(1, [binding("result", true)], 5).
clause(1, birth_year(patH, 1944), []).
clause(2, reference_year(2025), []).
clause(3, age_above(var("person"), var("years")), [call(birth_year(var("person"), var("birthYear"))), call(reference_year(var("now"))), calculate(var("age"), binary("-", value(var("now")), value(var("birthYear")))), compare(">", var("age"), var("years"))]).
clause(4, test_is(true), [call(age_above(patH, 80))]).
substitution(1, []).
proof(1, birth_year(patH, 1944), rule(1), []).
substitution(2, []).
proof(2, reference_year(2025), rule(2), []).
substitution(3, [binding("person", patH), binding("years", 80), binding("birthYear", 1944), binding("now", 2025), binding("age", 81)]).
proof(3, age_above(patH, 80), rule(3), [uses(1, birth_year(patH, 1944)), uses(2, reference_year(2025)), calculated(81, binary("-", value(2025), value(1944))), compared(">", 81, 80)]).
substitution(4, []).
proof(4, test_is(true), rule(4), [uses(3, age_above(patH, 80))]).
substitution(5, [binding("result", true)]).
proof(5, solution([true]), query, [uses(4, test_is(true))]).
