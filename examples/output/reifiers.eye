# Eyelang result format 2
query(1, [call(statement_source(?v0, ?v1))], [binding("speaker", ?v0), binding("source", ?v1)]).
result(1, complete, 2).
answer(1, [binding("speaker", alice), binding("source", chat)]).
answer(1, [binding("speaker", bob), binding("source", email)]).
query(2, [call(reifies(?v0, ?v1))], [binding("claim", ?v0), binding("statement", ?v1)]).
result(2, complete, 2).
answer(2, [binding("claim", claim1), binding("statement", triple(alice, says, hello))]).
answer(2, [binding("claim", claim2), binding("statement", triple(bob, says, hi))]).
