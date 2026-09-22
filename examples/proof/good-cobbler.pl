% Prolog result format 4
query(1, report(_0), ['Statement' = _0]).
result(1, complete, 1).
answer(1, ['Statement' = quoted(triple(joe, is_a, [good, cobbler]))]).
why(1,
    ['Statement' = quoted(triple(joe, is_a, [good, cobbler]))],
    [report(quoted(triple(joe, is_a, [good, cobbler])))]).
query(2, is_a(joe, good), []).
result(2, complete, 0).

clause(1, is_a(joe, [good, cobbler]), true).
clause(2,
       report(quoted(triple(var('Person'), is_a, [good, var('Occupation')]))),
       is_a(var('Person'), [good, var('Occupation')])).

step(report(quoted(triple(joe, is_a, [good, cobbler]))),
     rule(2),
     ['Person' = joe, 'Occupation' = cobbler],
     [is_a(joe, [good, cobbler])]).
step(is_a(joe, [good, cobbler]), fact(1), [], []).
