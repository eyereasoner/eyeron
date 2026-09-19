# Eyelang result format 2
query(1, [call(has_statement())], []).
result(1, complete, 1).
answer(1, []).
query(2, [call(named_statement(?v0))], [binding("statement", ?v0)]).
result(2, complete, 1).
answer(2, [binding("statement", claim)]).
query(3, [call(statement_author(?v0))], [binding("who", ?v0)]).
result(3, complete, 1).
answer(3, [binding("who", bob)]).
query(4, [call(statement_date(?v0))], [binding("date", ?v0)]).
result(4, complete, 1).
answer(4, [binding("date", date(2021, 7, 7))]).
