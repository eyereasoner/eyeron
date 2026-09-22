% Prolog result format 4
query(1, sentence(_0, [open, door], []), ['Ast' = _0]).
result(1, complete, 1).
answer(1, ['Ast' = command(open, door)]).
why(1, ['Ast' = command(open, door)], [sentence(command(open, door), [open, door], [])]).
query(2, sentence(command(close, window), _0, []), ['Words' = _0]).
result(2, complete, 1).
answer(2, ['Words' = [close, window]]).
why(2, ['Words' = [close, window]], [sentence(command(close, window), [close, window], [])]).

clause(1,
       sentence(command(var('Verb'), var('Object')), var('Input'), var('Rest')),
       (verb(var('Verb'), var('Input'), var('Middle')),
        noun(var('Object'), var('Middle'), var('Rest')))).
clause(2, verb(open, [open|var('Rest')], var('Rest')), true).
clause(3, verb(close, [close|var('Rest')], var('Rest')), true).
clause(4, noun(door, [door|var('Rest')], var('Rest')), true).
clause(5, noun(window, [window|var('Rest')], var('Rest')), true).

step(sentence(command(open, door), [open, door], []),
     rule(1),
     ['Verb' = open, 'Object' = door, 'Input' = [open, door], 'Rest' = [], 'Middle' = [door]],
     [verb(open, [open, door], [door]), noun(door, [door], [])]).
step(verb(open, [open, door], [door]), fact(2), ['Rest' = [door]], []).
step(noun(door, [door], []), fact(4), ['Rest' = []], []).
step(sentence(command(close, window), [close, window], []),
     rule(1),
     ['Verb' = close,
      'Object' = window,
      'Input' = [close, window],
      'Rest' = [],
      'Middle' = [window]],
     [verb(close, [close, window], [window]), noun(window, [window], [])]).
step(verb(close, [close|_0], _0), fact(3), ['Rest' = _0], []).
step(noun(window, [window], []), fact(5), ['Rest' = []], []).
