# Eyelang result format 2
query(1, [call(result1(?v0))], [binding("all", ?v0)]).
result(1, complete, 1).
answer(1, [binding("all", ["Dewey", "Huey", "Louie"])]).
why(1, [binding("all", ["Dewey", "Huey", "Louie"])], 8).
query(2, [call(result2(?v0))], [binding("nested", ?v0)]).
result(2, complete, 1).
answer(2, [binding("nested", [["Dewey"], ["Huey"], ["Louie"]])]).
why(2, [binding("nested", [["Dewey"], ["Huey"], ["Louie"]])], 16).
query(3, [call(result3(?v0))], [binding("filtered", ?v0)]).
result(3, complete, 1).
answer(3, [binding("filtered", ["Dewey", "Huey"])]).
why(3, [binding("filtered", ["Dewey", "Huey"])], 23).
clause(1, param("Huey"), []).
clause(2, param("Dewey"), []).
clause(3, param("Louie"), []).
clause(4, result1(var("all")), [collect(var("all"), var("p"), [call(param(var("p")))])]).
clause(5, result2(var("nested")), [collect(var("nested"), [var("p")], [call(param(var("p")))])]).
clause(6, result3(var("filtered")), [collect(var("filtered"), var("p"), [call(param(var("p"))), compare("!=", var("p"), "Louie")])]).
substitution(1, []).
proof(1, param("Huey"), rule(1), []).
substitution(2, []).
proof(2, param("Dewey"), rule(2), []).
substitution(3, []).
proof(3, param("Louie"), rule(3), []).
substitution(4, [binding("p", "Huey")]).
proof(4, solution(["Huey"]), query, [uses(1, param("Huey"))]).
substitution(5, [binding("p", "Dewey")]).
proof(5, solution(["Dewey"]), query, [uses(2, param("Dewey"))]).
substitution(6, [binding("p", "Louie")]).
proof(6, solution(["Louie"]), query, [uses(3, param("Louie"))]).
substitution(7, [binding("all", ["Dewey", "Huey", "Louie"]), binding("p", ?v0)]).
proof(7, result1(["Dewey", "Huey", "Louie"]), rule(4), [collected(["Dewey", "Huey", "Louie"], ?v0, [call(param(?v0))], [4, 5, 6], complete)]).
substitution(8, [binding("all", ["Dewey", "Huey", "Louie"])]).
proof(8, solution([["Dewey", "Huey", "Louie"]]), query, [uses(7, result1(["Dewey", "Huey", "Louie"]))]).
substitution(9, []).
proof(9, param("Huey"), rule(1), []).
substitution(10, []).
proof(10, param("Dewey"), rule(2), []).
substitution(11, []).
proof(11, param("Louie"), rule(3), []).
substitution(12, [binding("p", "Huey")]).
proof(12, solution([["Huey"]]), query, [uses(9, param("Huey"))]).
substitution(13, [binding("p", "Dewey")]).
proof(13, solution([["Dewey"]]), query, [uses(10, param("Dewey"))]).
substitution(14, [binding("p", "Louie")]).
proof(14, solution([["Louie"]]), query, [uses(11, param("Louie"))]).
substitution(15, [binding("nested", [["Dewey"], ["Huey"], ["Louie"]]), binding("p", ?v0)]).
proof(15, result2([["Dewey"], ["Huey"], ["Louie"]]), rule(5), [collected([["Dewey"], ["Huey"], ["Louie"]], [?v0], [call(param(?v0))], [12, 13, 14], complete)]).
substitution(16, [binding("nested", [["Dewey"], ["Huey"], ["Louie"]])]).
proof(16, solution([[["Dewey"], ["Huey"], ["Louie"]]]), query, [uses(15, result2([["Dewey"], ["Huey"], ["Louie"]]))]).
substitution(17, []).
proof(17, param("Huey"), rule(1), []).
substitution(18, []).
proof(18, param("Dewey"), rule(2), []).
substitution(19, []).
proof(19, param("Louie"), rule(3), []).
substitution(20, [binding("p", "Huey")]).
proof(20, solution(["Huey"]), query, [uses(17, param("Huey")), compared("!=", "Huey", "Louie")]).
substitution(21, [binding("p", "Dewey")]).
proof(21, solution(["Dewey"]), query, [uses(18, param("Dewey")), compared("!=", "Dewey", "Louie")]).
substitution(22, [binding("filtered", ["Dewey", "Huey"]), binding("p", ?v0)]).
proof(22, result3(["Dewey", "Huey"]), rule(6), [collected(["Dewey", "Huey"], ?v0, [call(param(?v0)), compare("!=", ?v0, "Louie")], [20, 21], complete)]).
substitution(23, [binding("filtered", ["Dewey", "Huey"])]).
proof(23, solution([["Dewey", "Huey"]]), query, [uses(22, result3(["Dewey", "Huey"]))]).
