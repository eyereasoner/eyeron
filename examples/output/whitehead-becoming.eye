# Eyelang result format 2
query(1, [call(becomes_from(?v0, ?v1))], [binding("later", ?v0), binding("earlier", ?v1)]).
result(1, complete, 2).
answer(1, [binding("later", o2), binding("earlier", o1)]).
answer(1, [binding("later", o3), binding("earlier", o2)]).
query(2, [call(inherits(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(2, complete, 5).
answer(2, [binding("o", o2), binding("form", red)]).
answer(2, [binding("o", o2), binding("form", warm)]).
answer(2, [binding("o", o3), binding("form", red)]).
answer(2, [binding("o", o3), binding("form", warm)]).
answer(2, [binding("o", o3), binding("form", bright)]).
query(3, [call(may_realize(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(3, complete, 2).
answer(3, [binding("o", o2), binding("form", bright)]).
answer(3, [binding("o", o3), binding("form", dark)]).
query(4, [call(integrates(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(4, complete, 7).
answer(4, [binding("o", o2), binding("form", red)]).
answer(4, [binding("o", o2), binding("form", warm)]).
answer(4, [binding("o", o2), binding("form", bright)]).
answer(4, [binding("o", o3), binding("form", red)]).
answer(4, [binding("o", o3), binding("form", warm)]).
answer(4, [binding("o", o3), binding("form", bright)]).
answer(4, [binding("o", o3), binding("form", dark)]).
query(5, [call(realizes(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(5, complete, 9).
answer(5, [binding("o", o1), binding("form", red)]).
answer(5, [binding("o", o1), binding("form", warm)]).
answer(5, [binding("o", o2), binding("form", red)]).
answer(5, [binding("o", o2), binding("form", warm)]).
answer(5, [binding("o", o2), binding("form", bright)]).
answer(5, [binding("o", o3), binding("form", red)]).
answer(5, [binding("o", o3), binding("form", warm)]).
answer(5, [binding("o", o3), binding("form", bright)]).
answer(5, [binding("o", o3), binding("form", dark)]).
query(6, [call(ingresses(?v0, ?v1))], [binding("o", ?v0), binding("form", ?v1)]).
result(6, complete, 9).
answer(6, [binding("o", o1), binding("form", red)]).
answer(6, [binding("o", o1), binding("form", warm)]).
answer(6, [binding("o", o2), binding("form", red)]).
answer(6, [binding("o", o2), binding("form", warm)]).
answer(6, [binding("o", o2), binding("form", bright)]).
answer(6, [binding("o", o3), binding("form", red)]).
answer(6, [binding("o", o3), binding("form", warm)]).
answer(6, [binding("o", o3), binding("form", bright)]).
answer(6, [binding("o", o3), binding("form", dark)]).
query(7, [call(status(?v0, ?v1))], [binding("o", ?v0), binding("s", ?v1)]).
result(7, complete, 3).
answer(7, [binding("o", o1), binding("s", objectivelyAvailable)]).
answer(7, [binding("o", o2), binding("s", objectivelyAvailable)]).
answer(7, [binding("o", o3), binding("s", objectivelyAvailable)]).
