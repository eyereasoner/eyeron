# Eyelang result format 2
query(1, [call(sentence(?v0, [open, door], []))], [binding("ast", ?v0)]).
result(1, complete, 1).
answer(1, [binding("ast", command(open, door))]).
query(2, [call(sentence(command(close, window), ?v0, []))], [binding("words", ?v0)]).
result(2, complete, 1).
answer(2, [binding("words", [close, window])]).
