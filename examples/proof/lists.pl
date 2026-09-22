% Prolog result format 3
query(1, append(_0, _1, [a, b]), ['Left' = _0, 'Right' = _1]).
result(1, complete, 3).
answer(1, ['Left' = [], 'Right' = [a, b]]).
why(1, ['Left' = [], 'Right' = [a, b]], 2).
answer(1, ['Left' = [a], 'Right' = [b]]).
why(1, ['Left' = [a], 'Right' = [b]], 6).
answer(1, ['Left' = [a, b], 'Right' = []]).
why(1, ['Left' = [a, b], 'Right' = []], 9).
query(2, member(_0, [a, b, a]), ['X' = _0]).
result(2, complete, 2).
answer(2, ['X' = a]).
why(2, ['X' = a], 11).
answer(2, ['X' = b]).
why(2, ['X' = b], 15).
clause(1, append([], var('Ys'), var('Ys')), true).
clause(2, append([var('X')|var('Xs')], var('Ys'), [var('X')|var('Zs')]), append(var('Xs'), var('Ys'), var('Zs'))).
clause(3, member(var('X'), [var('X')|anonymous(1)]), true).
clause(4, member(var('X'), [anonymous(1)|var('Xs')]), member(var('X'), var('Xs'))).
substitution(1, ['Ys' = [a, b]]).
proof(1, append([], [a, b], [a, b]), rule(1), []).
substitution(2, ['Left' = [], 'Right' = [a, b]]).
proof(2, solution([[], [a, b]]), query, [uses(1, append([], [a, b], [a, b]))]).
substitution(3, ['Ys' = [b]]).
proof(3, append([], [b], [b]), rule(1), []).
substitution(4, ['X' = a, 'Xs' = [], 'Ys' = [b], 'Zs' = [b]]).
proof(4, append([a], [b], [a, b]), rule(2), [uses(3, append([], [b], [b]))]).
substitution(5, ['Ys' = []]).
proof(5, append([], [], []), rule(1), []).
substitution(6, ['Left' = [a], 'Right' = [b]]).
proof(6, solution([[a], [b]]), query, [uses(4, append([a], [b], [a, b]))]).
substitution(7, ['X' = b, 'Xs' = [], 'Ys' = [], 'Zs' = []]).
proof(7, append([b], [], [b]), rule(2), [uses(5, append([], [], []))]).
substitution(8, ['X' = a, 'Xs' = [b], 'Ys' = [], 'Zs' = [b]]).
proof(8, append([a, b], [], [a, b]), rule(2), [uses(7, append([b], [], [b]))]).
substitution(9, ['Left' = [a, b], 'Right' = []]).
proof(9, solution([[a, b], []]), query, [uses(8, append([a, b], [], [a, b]))]).
substitution(10, ['X' = a]).
proof(10, member(a, [a, b, a]), rule(3), []).
substitution(11, ['X' = a]).
proof(11, solution([a]), query, [uses(10, member(a, [a, b, a]))]).
substitution(12, ['X' = b]).
proof(12, member(b, [b, a]), rule(3), []).
substitution(13, ['X' = b, 'Xs' = [b, a]]).
proof(13, member(b, [a, b, a]), rule(4), [uses(12, member(b, [b, a]))]).
substitution(14, ['X' = a]).
proof(14, member(a, [a]), rule(3), []).
substitution(15, ['X' = b]).
proof(15, solution([b]), query, [uses(13, member(b, [a, b, a]))]).
substitution(16, ['X' = a, 'Xs' = [a]]).
proof(16, member(a, [b, a]), rule(4), [uses(14, member(a, [a]))]).
