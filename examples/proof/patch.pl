% Prolog result format 4
query(1, patched(_0, _1, _2), ['S' = _0, 'P' = _1, 'O' = _2]).
result(1, complete, 5).
answer(1, ['S' = alice, 'P' = age, 'O' = 31]).
why(1, ['S' = alice, 'P' = age, 'O' = 31], [patched(alice, age, 31)]).
answer(1, ['S' = alice, 'P' = status, 'O' = activeStatus]).
why(1, ['S' = alice, 'P' = status, 'O' = activeStatus], [patched(alice, status, activeStatus)]).
answer(1, ['S' = alice, 'P' = verified, 'O' = true]).
why(1, ['S' = alice, 'P' = verified, 'O' = true], [patched(alice, verified, true)]).
answer(1, ['S' = alice, 'P' = type, 'O' = person]).
why(1, ['S' = alice, 'P' = type, 'O' = person], [patched(alice, type, person)]).
answer(1, ['S' = bob, 'P' = type, 'O' = person]).
why(1, ['S' = bob, 'P' = type, 'O' = person], [patched(bob, type, person)]).

clause(1, source(alice, type, person), true).
clause(5, source(bob, type, person), true).
clause(9, insert_(alice, age, 31), true).
clause(10, insert_(alice, status, activeStatus), true).
clause(11, insert_(alice, verified, true), true).
clause(12,
       kept(var('S'), var('P'), var('O')),
       (source(var('S'), var('P'), var('O')), \+delete_(var('S'), var('P'), var('O')))).
clause(13, patched(var('S'), var('P'), var('O')), kept(var('S'), var('P'), var('O'))).
clause(14, patched(var('S'), var('P'), var('O')), insert_(var('S'), var('P'), var('O'))).

step(patched(alice, age, 31),
     rule(14),
     ['S' = alice, 'P' = age, 'O' = 31],
     [insert_(alice, age, 31)]).
step(insert_(alice, age, 31), fact(9), [], []).
step(patched(alice, status, activeStatus),
     rule(14),
     ['S' = alice, 'P' = status, 'O' = activeStatus],
     [insert_(alice, status, activeStatus)]).
step(insert_(alice, status, activeStatus), fact(10), [], []).
step(patched(alice, verified, true),
     rule(14),
     ['S' = alice, 'P' = verified, 'O' = true],
     [insert_(alice, verified, true)]).
step(insert_(alice, verified, true), fact(11), [], []).
step(patched(alice, type, person),
     rule(13),
     ['S' = alice, 'P' = type, 'O' = person],
     [kept(alice, type, person)]).
step(kept(alice, type, person),
     rule(12),
     ['S' = alice, 'P' = type, 'O' = person],
     [source(alice, type, person), \+delete_(alice, type, person)]).
step(source(alice, type, person), fact(1), [], []).
step(\+delete_(alice, type, person), absent, [], []).
step(patched(bob, type, person),
     rule(13),
     ['S' = bob, 'P' = type, 'O' = person],
     [kept(bob, type, person)]).
step(kept(bob, type, person),
     rule(12),
     ['S' = bob, 'P' = type, 'O' = person],
     [source(bob, type, person), \+delete_(bob, type, person)]).
step(source(bob, type, person), fact(5), [], []).
step(\+delete_(bob, type, person), absent, [], []).
