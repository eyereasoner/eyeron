% Prolog result format 3
query(1, becomes_from(_0, _1), ['Later' = _0, 'Earlier' = _1]).
result(1, complete, 2).
answer(1, ['Later' = o2, 'Earlier' = o1]).
answer(1, ['Later' = o3, 'Earlier' = o2]).
query(2, inherits(_0, _1), ['O' = _0, 'Form' = _1]).
result(2, complete, 5).
answer(2, ['O' = o2, 'Form' = red]).
answer(2, ['O' = o2, 'Form' = warm]).
answer(2, ['O' = o3, 'Form' = red]).
answer(2, ['O' = o3, 'Form' = warm]).
answer(2, ['O' = o3, 'Form' = bright]).
query(3, may_realize(_0, _1), ['O' = _0, 'Form' = _1]).
result(3, complete, 2).
answer(3, ['O' = o2, 'Form' = bright]).
answer(3, ['O' = o3, 'Form' = dark]).
query(4, integrates(_0, _1), ['O' = _0, 'Form' = _1]).
result(4, complete, 7).
answer(4, ['O' = o2, 'Form' = red]).
answer(4, ['O' = o2, 'Form' = warm]).
answer(4, ['O' = o2, 'Form' = bright]).
answer(4, ['O' = o3, 'Form' = red]).
answer(4, ['O' = o3, 'Form' = warm]).
answer(4, ['O' = o3, 'Form' = bright]).
answer(4, ['O' = o3, 'Form' = dark]).
query(5, realizes(_0, _1), ['O' = _0, 'Form' = _1]).
result(5, complete, 9).
answer(5, ['O' = o1, 'Form' = red]).
answer(5, ['O' = o1, 'Form' = warm]).
answer(5, ['O' = o2, 'Form' = red]).
answer(5, ['O' = o2, 'Form' = warm]).
answer(5, ['O' = o2, 'Form' = bright]).
answer(5, ['O' = o3, 'Form' = red]).
answer(5, ['O' = o3, 'Form' = warm]).
answer(5, ['O' = o3, 'Form' = bright]).
answer(5, ['O' = o3, 'Form' = dark]).
query(6, ingresses(_0, _1), ['O' = _0, 'Form' = _1]).
result(6, complete, 9).
answer(6, ['O' = o1, 'Form' = red]).
answer(6, ['O' = o1, 'Form' = warm]).
answer(6, ['O' = o2, 'Form' = red]).
answer(6, ['O' = o2, 'Form' = warm]).
answer(6, ['O' = o2, 'Form' = bright]).
answer(6, ['O' = o3, 'Form' = red]).
answer(6, ['O' = o3, 'Form' = warm]).
answer(6, ['O' = o3, 'Form' = bright]).
answer(6, ['O' = o3, 'Form' = dark]).
query(7, status(_0, _1), ['O' = _0, 'S' = _1]).
result(7, complete, 3).
answer(7, ['O' = o1, 'S' = objectivelyAvailable]).
answer(7, ['O' = o2, 'S' = objectivelyAvailable]).
answer(7, ['O' = o3, 'S' = objectivelyAvailable]).
