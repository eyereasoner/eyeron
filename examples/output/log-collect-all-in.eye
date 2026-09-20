# Eyelang result format 2
query(1, [call(result1(?v0))], [binding("all", ?v0)]).
result(1, complete, 1).
answer(1, [binding("all", ["Dewey", "Huey", "Louie"])]).
query(2, [call(result2(?v0))], [binding("nested", ?v0)]).
result(2, complete, 1).
answer(2, [binding("nested", [["Dewey"], ["Huey"], ["Louie"]])]).
query(3, [call(result3(?v0))], [binding("filtered", ?v0)]).
result(3, complete, 1).
answer(3, [binding("filtered", ["Dewey", "Huey"])]).
