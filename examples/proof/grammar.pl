% Prolog result format 3
query(1, sentence(_0, [open, door], []), ['Ast' = _0]).
result(1, complete, 1).
answer(1, ['Ast' = command(open, door)]).
why(1, ['Ast' = command(open, door)], 4).
query(2, sentence(command(close, window), _0, []), ['Words' = _0]).
result(2, complete, 1).
answer(2, ['Words' = [close, window]]).
why(2, ['Words' = [close, window]], 8).
clause(1, sentence(command(var('Verb'), var('Object')), var('Input'), var('Rest')), (verb(var('Verb'), var('Input'), var('Middle')), noun(var('Object'), var('Middle'), var('Rest')))).
clause(2, verb(open, [open|var('Rest')], var('Rest')), true).
clause(3, verb(close, [close|var('Rest')], var('Rest')), true).
clause(4, noun(door, [door|var('Rest')], var('Rest')), true).
clause(5, noun(window, [window|var('Rest')], var('Rest')), true).
substitution(1, ['Rest' = [door]]).
proof(1, verb(open, [open, door], [door]), rule(2), []).
substitution(2, ['Rest' = []]).
proof(2, noun(door, [door], []), rule(4), []).
substitution(3, ['Verb' = open, 'Object' = door, 'Input' = [open, door], 'Rest' = [], 'Middle' = [door]]).
proof(3, sentence(command(open, door), [open, door], []), rule(1), [uses(1, verb(open, [open, door], [door])), uses(2, noun(door, [door], []))]).
substitution(4, ['Ast' = command(open, door)]).
proof(4, solution([command(open, door)]), query, [uses(3, sentence(command(open, door), [open, door], []))]).
substitution(5, ['Rest' = _0]).
proof(5, verb(close, [close|_0], _0), rule(3), []).
substitution(6, ['Rest' = []]).
proof(6, noun(window, [window], []), rule(5), []).
substitution(7, ['Verb' = close, 'Object' = window, 'Input' = [close, window], 'Rest' = [], 'Middle' = [window]]).
proof(7, sentence(command(close, window), [close, window], []), rule(1), [uses(5, verb(close, [close, window], [window])), uses(6, noun(window, [window], []))]).
substitution(8, ['Words' = [close, window]]).
proof(8, solution([[close, window]]), query, [uses(7, sentence(command(close, window), [close, window], []))]).
