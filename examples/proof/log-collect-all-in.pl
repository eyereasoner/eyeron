% Prolog result format 3
query(1, result1(_0), ['All' = _0]).
result(1, complete, 1).
answer(1, ['All' = ["Dewey", "Huey", "Louie"]]).
why(1, ['All' = ["Dewey", "Huey", "Louie"]], 8).
query(2, result2(_0), ['Nested' = _0]).
result(2, complete, 1).
answer(2, ['Nested' = [["Dewey"], ["Huey"], ["Louie"]]]).
why(2, ['Nested' = [["Dewey"], ["Huey"], ["Louie"]]], 16).
query(3, result3(_0), ['Filtered' = _0]).
result(3, complete, 1).
answer(3, ['Filtered' = ["Dewey", "Huey"]]).
why(3, ['Filtered' = ["Dewey", "Huey"]], 23).
clause(1, param("Huey"), true).
clause(2, param("Dewey"), true).
clause(3, param("Louie"), true).
clause(4, result1(var('All')), (findall(var('P'), param(var('P')), var('Bag1')), sort(var('Bag1'), var('All')))).
clause(5, result2(var('Nested')), (findall([var('P')], param(var('P')), var('Bag1')), sort(var('Bag1'), var('Nested')))).
clause(6, result3(var('Filtered')), (findall(var('P'), (param(var('P')), var('P') \== "Louie"), var('Bag1')), sort(var('Bag1'), var('Filtered')))).
substitution(1, []).
proof(1, param("Huey"), rule(1), []).
substitution(2, []).
proof(2, param("Dewey"), rule(2), []).
substitution(3, []).
proof(3, param("Louie"), rule(3), []).
substitution(4, ['P' = "Huey"]).
proof(4, solution(["Huey"]), query, [uses(1, param("Huey"))]).
substitution(5, ['P' = "Dewey"]).
proof(5, solution(["Dewey"]), query, [uses(2, param("Dewey"))]).
substitution(6, ['P' = "Louie"]).
proof(6, solution(["Louie"]), query, [uses(3, param("Louie"))]).
substitution(7, ['All' = ["Dewey", "Huey", "Louie"], 'P' = _0, 'Bag1' = ["Huey", "Dewey", "Louie"]]).
proof(7, result1(["Dewey", "Huey", "Louie"]), rule(4), [collected(["Huey", "Dewey", "Louie"], _0, param(_0), [4, 5, 6], complete), builtin(sort(["Huey", "Dewey", "Louie"], ["Dewey", "Huey", "Louie"]))]).
substitution(8, ['All' = ["Dewey", "Huey", "Louie"]]).
proof(8, solution([["Dewey", "Huey", "Louie"]]), query, [uses(7, result1(["Dewey", "Huey", "Louie"]))]).
substitution(9, []).
proof(9, param("Huey"), rule(1), []).
substitution(10, []).
proof(10, param("Dewey"), rule(2), []).
substitution(11, []).
proof(11, param("Louie"), rule(3), []).
substitution(12, ['P' = "Huey"]).
proof(12, solution([["Huey"]]), query, [uses(9, param("Huey"))]).
substitution(13, ['P' = "Dewey"]).
proof(13, solution([["Dewey"]]), query, [uses(10, param("Dewey"))]).
substitution(14, ['P' = "Louie"]).
proof(14, solution([["Louie"]]), query, [uses(11, param("Louie"))]).
substitution(15, ['Nested' = [["Dewey"], ["Huey"], ["Louie"]], 'P' = _0, 'Bag1' = [["Huey"], ["Dewey"], ["Louie"]]]).
proof(15, result2([["Dewey"], ["Huey"], ["Louie"]]), rule(5), [collected([["Huey"], ["Dewey"], ["Louie"]], [_0], param(_0), [12, 13, 14], complete), builtin(sort([["Huey"], ["Dewey"], ["Louie"]], [["Dewey"], ["Huey"], ["Louie"]]))]).
substitution(16, ['Nested' = [["Dewey"], ["Huey"], ["Louie"]]]).
proof(16, solution([[["Dewey"], ["Huey"], ["Louie"]]]), query, [uses(15, result2([["Dewey"], ["Huey"], ["Louie"]]))]).
substitution(17, []).
proof(17, param("Huey"), rule(1), []).
substitution(18, []).
proof(18, param("Dewey"), rule(2), []).
substitution(19, []).
proof(19, param("Louie"), rule(3), []).
substitution(20, ['P' = "Huey"]).
proof(20, solution(["Huey"]), query, [uses(17, param("Huey")), builtin("Huey" \== "Louie")]).
substitution(21, ['P' = "Dewey"]).
proof(21, solution(["Dewey"]), query, [uses(18, param("Dewey")), builtin("Dewey" \== "Louie")]).
substitution(22, ['Filtered' = ["Dewey", "Huey"], 'P' = _0, 'Bag1' = ["Huey", "Dewey"]]).
proof(22, result3(["Dewey", "Huey"]), rule(6), [collected(["Huey", "Dewey"], _0, (param(_0), _0 \== "Louie"), [20, 21], complete), builtin(sort(["Huey", "Dewey"], ["Dewey", "Huey"]))]).
substitution(23, ['Filtered' = ["Dewey", "Huey"]]).
proof(23, solution([["Dewey", "Huey"]]), query, [uses(22, result3(["Dewey", "Huey"]))]).
