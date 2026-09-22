% Prolog result format 4
query(1, hanoi(3, left, right, center, _0), ['Moves' = _0]).
result(1, complete, 1).
answer(1,
       ['Moves' = [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]]).
