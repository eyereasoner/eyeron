% Prolog result format 3
query(1, hanoi(3, left, right, center, _0), ['Moves' = _0]).
result(1, complete, 1).
answer(1, ['Moves' = [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]]).
why(1, ['Moves' = [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]], 21).
clause(1, append([], var('Ys'), var('Ys')), true).
clause(2, append([var('X')|var('Xs')], var('Ys'), [var('X')|var('Zs')]), append(var('Xs'), var('Ys'), var('Zs'))).
clause(3, hanoi(0, anonymous(1), anonymous(2), anonymous(3), []), true).
clause(4, hanoi(var('N'), var('From'), var('To'), var('Via'), var('Moves')), (var('N') > 0, var('Smaller') is var('N') - 1, hanoi(var('Smaller'), var('From'), var('Via'), var('To'), var('Before')), hanoi(var('Smaller'), var('Via'), var('To'), var('From'), var('After')), append(var('Before'), [[var('From'), var('To')]|var('After')], var('Moves')))).
substitution(1, []).
proof(1, hanoi(0, left, center, right, []), rule(3), []).
substitution(2, []).
proof(2, hanoi(0, center, right, left, []), rule(3), []).
substitution(3, ['Ys' = [[left, right]]]).
proof(3, append([], [[left, right]], [[left, right]]), rule(1), []).
substitution(4, ['N' = 1, 'From' = left, 'To' = right, 'Via' = center, 'Moves' = [[left, right]], 'Smaller' = 0, 'Before' = [], 'After' = []]).
proof(4, hanoi(1, left, right, center, [[left, right]]), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(1, hanoi(0, left, center, right, [])), uses(2, hanoi(0, center, right, left, [])), uses(3, append([], [[left, right]], [[left, right]]))]).
substitution(5, []).
proof(5, hanoi(0, right, left, center, []), rule(3), []).
substitution(6, ['Ys' = [[right, center]]]).
proof(6, append([], [[right, center]], [[right, center]]), rule(1), []).
substitution(7, ['N' = 1, 'From' = right, 'To' = center, 'Via' = left, 'Moves' = [[right, center]], 'Smaller' = 0, 'Before' = [], 'After' = []]).
proof(7, hanoi(1, right, center, left, [[right, center]]), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(5, hanoi(0, right, left, center, [])), uses(1, hanoi(0, left, center, right, [])), uses(6, append([], [[right, center]], [[right, center]]))]).
substitution(8, ['Ys' = [[left, center], [right, center]]]).
proof(8, append([], [[left, center], [right, center]], [[left, center], [right, center]]), rule(1), []).
substitution(9, ['X' = [left, right], 'Xs' = [], 'Ys' = [[left, center], [right, center]], 'Zs' = [[left, center], [right, center]]]).
proof(9, append([[left, right]], [[left, center], [right, center]], [[left, right], [left, center], [right, center]]), rule(2), [uses(8, append([], [[left, center], [right, center]], [[left, center], [right, center]]))]).
substitution(10, ['N' = 2, 'From' = left, 'To' = center, 'Via' = right, 'Moves' = [[left, right], [left, center], [right, center]], 'Smaller' = 1, 'Before' = [[left, right]], 'After' = [[right, center]]]).
proof(10, hanoi(2, left, center, right, [[left, right], [left, center], [right, center]]), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(4, hanoi(1, left, right, center, [[left, right]])), uses(7, hanoi(1, right, center, left, [[right, center]])), uses(9, append([[left, right]], [[left, center], [right, center]], [[left, right], [left, center], [right, center]]))]).
substitution(11, ['Ys' = [[center, left]]]).
proof(11, append([], [[center, left]], [[center, left]]), rule(1), []).
substitution(12, ['N' = 1, 'From' = center, 'To' = left, 'Via' = right, 'Moves' = [[center, left]], 'Smaller' = 0, 'Before' = [], 'After' = []]).
proof(12, hanoi(1, center, left, right, [[center, left]]), rule(4), [builtin(1 > 0), builtin(0 is 1 - 1), uses(2, hanoi(0, center, right, left, [])), uses(5, hanoi(0, right, left, center, [])), uses(11, append([], [[center, left]], [[center, left]]))]).
substitution(13, ['Ys' = [[center, right], [left, right]]]).
proof(13, append([], [[center, right], [left, right]], [[center, right], [left, right]]), rule(1), []).
substitution(14, ['X' = [center, left], 'Xs' = [], 'Ys' = [[center, right], [left, right]], 'Zs' = [[center, right], [left, right]]]).
proof(14, append([[center, left]], [[center, right], [left, right]], [[center, left], [center, right], [left, right]]), rule(2), [uses(13, append([], [[center, right], [left, right]], [[center, right], [left, right]]))]).
substitution(15, ['N' = 2, 'From' = center, 'To' = right, 'Via' = left, 'Moves' = [[center, left], [center, right], [left, right]], 'Smaller' = 1, 'Before' = [[center, left]], 'After' = [[left, right]]]).
proof(15, hanoi(2, center, right, left, [[center, left], [center, right], [left, right]]), rule(4), [builtin(2 > 0), builtin(1 is 2 - 1), uses(12, hanoi(1, center, left, right, [[center, left]])), uses(4, hanoi(1, left, right, center, [[left, right]])), uses(14, append([[center, left]], [[center, right], [left, right]], [[center, left], [center, right], [left, right]]))]).
substitution(16, ['Ys' = [[left, right], [center, left], [center, right], [left, right]]]).
proof(16, append([], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [center, left], [center, right], [left, right]]), rule(1), []).
substitution(17, ['X' = [right, center], 'Xs' = [], 'Ys' = [[left, right], [center, left], [center, right], [left, right]], 'Zs' = [[left, right], [center, left], [center, right], [left, right]]]).
proof(17, append([[right, center]], [[left, right], [center, left], [center, right], [left, right]], [[right, center], [left, right], [center, left], [center, right], [left, right]]), rule(2), [uses(16, append([], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [center, left], [center, right], [left, right]]))]).
substitution(18, ['X' = [left, center], 'Xs' = [[right, center]], 'Ys' = [[left, right], [center, left], [center, right], [left, right]], 'Zs' = [[right, center], [left, right], [center, left], [center, right], [left, right]]]).
proof(18, append([[left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]), rule(2), [uses(17, append([[right, center]], [[left, right], [center, left], [center, right], [left, right]], [[right, center], [left, right], [center, left], [center, right], [left, right]]))]).
substitution(19, ['X' = [left, right], 'Xs' = [[left, center], [right, center]], 'Ys' = [[left, right], [center, left], [center, right], [left, right]], 'Zs' = [[left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]]).
proof(19, append([[left, right], [left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]), rule(2), [uses(18, append([[left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]))]).
substitution(20, ['N' = 3, 'From' = left, 'To' = right, 'Via' = center, 'Moves' = [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]], 'Smaller' = 2, 'Before' = [[left, right], [left, center], [right, center]], 'After' = [[center, left], [center, right], [left, right]]]).
proof(20, hanoi(3, left, right, center, [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]), rule(4), [builtin(3 > 0), builtin(2 is 3 - 1), uses(10, hanoi(2, left, center, right, [[left, right], [left, center], [right, center]])), uses(15, hanoi(2, center, right, left, [[center, left], [center, right], [left, right]])), uses(19, append([[left, right], [left, center], [right, center]], [[left, right], [center, left], [center, right], [left, right]], [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]))]).
substitution(21, ['Moves' = [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]]).
proof(21, solution([[[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]]), query, [uses(20, hanoi(3, left, right, center, [[left, right], [left, center], [right, center], [left, right], [center, left], [center, right], [left, right]]))]).
