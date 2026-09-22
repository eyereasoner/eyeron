% Prolog result format 4
query(1, solve(ancestor(ann, _0)), ['Descendant' = _0]).
result(1, complete, 2).
answer(1, ['Descendant' = bob]).
answer(1, ['Descendant' = cid]).
query(2, steps(ancestor(ann, cid), _0), ['Clauses' = _0]).
result(2, complete, 1).
answer(2, ['Clauses' = 4]).
query(3, clause(ancestor(_0, _1), _2), ['Older' = _0, 'Younger' = _1, 'Body' = _2]).
result(3, complete, 2).
answer(3, ['Older' = _0, 'Younger' = _1, 'Body' = parent(_0, _1)]).
answer(3, ['Older' = _0, 'Younger' = _1, 'Body' = (parent(_0, _2), ancestor(_2, _1))]).
