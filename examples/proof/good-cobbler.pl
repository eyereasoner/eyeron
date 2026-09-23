report(quoted(triple(joe, is_a, [good, cobbler]))).

clause(1, is_a(joe, [good, cobbler]), true).
clause(2,
       report(quoted(triple(var('Person'), is_a, [good, var('Occupation')]))),
       is_a(var('Person'), [good, var('Occupation')])).

step(report(quoted(triple(joe, is_a, [good, cobbler]))),
     rule(2),
     ['Person' = joe, 'Occupation' = cobbler],
     [is_a(joe, [good, cobbler])]).
step(is_a(joe, [good, cobbler]), fact(1), [], []).
