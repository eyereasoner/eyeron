% Prolog result format 4
query(1, sentence(_0, [open, door], []), ['Ast' = _0]).
result(1, complete, 1).
answer(1, ['Ast' = command(open, door)]).
query(2, sentence(command(close, window), _0, []), ['Words' = _0]).
result(2, complete, 1).
answer(2, ['Words' = [close, window]]).
