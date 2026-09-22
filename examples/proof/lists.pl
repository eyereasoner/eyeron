% Prolog result format 4
query(1, append(_0, _1, [a, b]), ['Left' = _0, 'Right' = _1]).
result(1, complete, 3).
answer(1, ['Left' = [], 'Right' = [a, b]]).
why(1, ['Left' = [], 'Right' = [a, b]], [append([], [a, b], [a, b])]).
answer(1, ['Left' = [a], 'Right' = [b]]).
why(1, ['Left' = [a], 'Right' = [b]], [append([a], [b], [a, b])]).
answer(1, ['Left' = [a, b], 'Right' = []]).
why(1, ['Left' = [a, b], 'Right' = []], [append([a, b], [], [a, b])]).
query(2, member(_0, [a, b, a]), ['X' = _0]).
result(2, complete, 2).
answer(2, ['X' = a]).
why(2, ['X' = a], [member(a, [a, b, a])]).
answer(2, ['X' = b]).
why(2, ['X' = b], [member(b, [a, b, a])]).

clause(1, append([], var('Ys'), var('Ys')), true).
clause(2,
       append([var('X')|var('Xs')], var('Ys'), [var('X')|var('Zs')]),
       append(var('Xs'), var('Ys'), var('Zs'))).
clause(3, member(var('X'), [var('X')|anonymous(1)]), true).
clause(4, member(var('X'), [anonymous(1)|var('Xs')]), member(var('X'), var('Xs'))).

step(append([], [a, b], [a, b]), fact(1), ['Ys' = [a, b]], []).
step(append([a], [b], [a, b]),
     rule(2),
     ['X' = a, 'Xs' = [], 'Ys' = [b], 'Zs' = [b]],
     [append([], [b], [b])]).
step(append([], [b], [b]), fact(1), ['Ys' = [b]], []).
step(append([a, b], [], [a, b]),
     rule(2),
     ['X' = a, 'Xs' = [b], 'Ys' = [], 'Zs' = [b]],
     [append([b], [], [b])]).
step(append([b], [], [b]),
     rule(2),
     ['X' = b, 'Xs' = [], 'Ys' = [], 'Zs' = []],
     [append([], [], [])]).
step(append([], [], []), fact(1), ['Ys' = []], []).
step(member(a, [a, b, a]), fact(3), ['X' = a], []).
step(member(b, [a, b, a]), rule(4), ['X' = b, 'Xs' = [b, a]], [member(b, [b, a])]).
step(member(b, [b, a]), fact(3), ['X' = b], []).
