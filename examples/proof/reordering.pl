% Prolog result format 4
query(1, test_is(_0), ['R' = _0]).
result(1, complete, 1).
answer(1, ['R' = true]).
why(1, ['R' = true], [test_is(true)]).

clause(1, has(alice, [book, 1]), true).
clause(2, has(bob, [table, 1]), true).
clause(3,
       test_is(true),
       (has(var('W1'), [var('O1'), var('N1')]),
        has(var('W2'), [var('O2'), var('N2')]),
        var('O1') \== var('O2'))).

step(test_is(true),
     rule(3),
     ['W1' = alice, 'O1' = book, 'N1' = 1, 'W2' = bob, 'O2' = table, 'N2' = 1],
     [has(alice, [book, 1]), has(bob, [table, 1]), book \== table]).
step(has(alice, [book, 1]), fact(1), [], []).
step(has(bob, [table, 1]), fact(2), [], []).
step(book \== table, builtin, [], []).
