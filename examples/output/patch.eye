# Eyelang result format 2
query(1, [call(patched(?v0, ?v1, ?v2))], [binding("s", ?v0), binding("p", ?v1), binding("o", ?v2)]).
result(1, complete, 5).
answer(1, [binding("s", alice), binding("p", age), binding("o", 31)]).
answer(1, [binding("s", alice), binding("p", status), binding("o", activeStatus)]).
answer(1, [binding("s", alice), binding("p", verified), binding("o", true)]).
answer(1, [binding("s", alice), binding("p", type), binding("o", person)]).
answer(1, [binding("s", bob), binding("p", type), binding("o", person)]).
