# Eyelang result format 2
query(1, [call(statement_source(?v0, ?v1))], [binding("speaker", ?v0), binding("source", ?v1)]).
result(1, complete, 2).
answer(1, [binding("speaker", alice), binding("source", chat)]).
answer(1, [binding("speaker", bob), binding("source", email)]).
query(2, [call(statement(bob, says, hi))], []).
result(2, complete, 0).
query(3, [call(certainty(blank(claim1), ?v0))], [binding("certainty", ?v0)]).
result(3, complete, 1).
answer(3, [binding("certainty", 0.9)]).
